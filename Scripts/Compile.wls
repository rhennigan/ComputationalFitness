#!/usr/bin/env wolframscript

(* :!CodeAnalysis::BeginBlock:: *)
(* :!CodeAnalysis::Disable::SuspiciousSessionSymbol:: *)

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
PacletInstall[ "Wolfram/PacletCICD" ];
Needs[ "Wolfram`PacletCICD`" -> "cicd`" ];
Needs[ "CCompilerDriver`"    -> "ccd`"  ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Paths*)
$pacletDir = DirectoryName[ $InputFileName, 2 ];
$sourceDir = FileNameJoin @ { $pacletDir, "Source" };
$targetDir = FileNameJoin @ { $pacletDir, "LibraryResources", $SystemID };

cicd`ConsoleLog[ "Build source directory: " <> $sourceDir ];
cicd`ConsoleLog[ "Build target directory: " <> $targetDir ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Compile*)
$sourceFiles = FileNames[
    {
        "fit_import.c",
        "fit.c",
        "fit_crc.c",
        "fit_example.c",
        "fit_convert.c"
    },
    $sourceDir
];

$built = ccd`CreateLibrary[
    $sourceFiles,
    "FitnessData",
    "TargetDirectory"     -> $targetDir,
    "CleanIntermediate"   -> True,
    "ShellOutputFunction" -> Print
];

If[ FileExistsQ @ $built,
    $built,
    cicd`ConsoleError[ "Failed to build the library.", "Fatal" -> True ]
]

(* :!CodeAnalysis::EndBlock:: *)