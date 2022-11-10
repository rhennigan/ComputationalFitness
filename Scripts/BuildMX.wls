#!/usr/bin/env wolframscript

(* :!CodeAnalysis::BeginBlock:: *)
(* :!CodeAnalysis::Disable::SuspiciousSessionSymbol:: *)

PacletInstall[ "Wolfram/PacletCICD" ];

Needs[ "Wolfram`PacletCICD`" -> "cicd`" ];

$inputFileName = Replace[ $InputFileName, "" :> NotebookFileName[ ] ];
$pacletDir     = DirectoryName[ $inputFileName, 2 ];
$mxFile        = FileNameJoin @ {
                     $pacletDir,
                     "Kernel",
                     ToString @ $SystemWordLength <> "Bit",
                     "FitnessData.mx"
                 };


If[ FileExistsQ @ $mxFile,
    cicd`ConsoleLog[ "Removing existing MX file..." ];
    DeleteFile @ $mxFile
];

cicd`ConsoleLog[ "Loading paclet..." ];
PacletDirectoryLoad @ $pacletDir;
Needs[ "RH`FitnessData`" ];

$mxDir = GeneralUtilities`EnsureDirectory @ DirectoryName @ $mxFile;
cicd`ConsoleLog[ "MX target directory: ", $mxDir  ];
cicd`ConsoleLog[ "Building MX file: "   , $mxFile ];

DumpSave[
    $mxFile,
    {
        "RH`FitnessData`",
        "RH`FitnessData`Private`"
    },
    "SymbolAttributes" -> False
];

If[ ! FileExistsQ @ $mxFile,
    cicd`ConsoleError[ "Failed to build MX file!", "Fatal" -> True ],
    $mxFile
]

(* :!CodeAnalysis::EndBlock:: *)