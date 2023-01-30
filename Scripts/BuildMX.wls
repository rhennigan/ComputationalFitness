#!/usr/bin/env wolframscript

(* :!CodeAnalysis::BeginBlock:: *)
(* :!CodeAnalysis::Disable::SuspiciousSessionSymbol:: *)

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
If[ ! PacletObjectQ @ PacletObject[ "Wolfram/PacletCICD" ],
    PacletInstall[ "https://github.com/WolframResearch/PacletCICD/releases/download/v0.34.0/Wolfram__PacletCICD-0.34.0.paclet" ]
];

Needs[ "Wolfram`PacletCICD`" -> "cicd`" ];
Needs[ "GeneralUtilities`"   -> "gu`"   ];
$ContextAliases[ "package`" ] = "RH`ComputationalFitness`Package`";

cFile = cicd`ScriptConfirmBy[ #, FileExistsQ ] &;
cDir  = cicd`ScriptConfirmBy[ #, DirectoryQ  ] &;
cStr  = cicd`ScriptConfirmBy[ #, StringQ     ] &;

RH`ComputationalFitnessLoader`$BuildingMX = True;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Paths*)
$inputFileName = cFile @ Replace[ $InputFileName, "" :> NotebookFileName[ ] ];
$pacletDir     = cDir @ DirectoryName[ $inputFileName, 2 ];
$dataDir       = cDir @ FileNameJoin @ { $pacletDir, "Data" };
$mxFile        = cStr @ FileNameJoin @ {
                     $pacletDir,
                     "Kernel",
                     ToString @ $SystemWordLength <> "Bit",
                     "ComputationalFitness.mx"
                 };

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Create WXF Data Files*)

buildWXFData[ source_ ] := Module[
    { target, data },
    target = StringReplace[ cStr @ source, ".wl"~~EndOfString -> ".wxf" ];
    data   = cicd`ScriptConfirmBy[ Get @ source, AssociationQ ];
    cicd`ConsoleLog @ SequenceForm[ "Building WXF file: ", target ];
    cFile @ Developer`WriteWXFFile[ target, data ]
];

buildWXFData /@ FileNames[ "*.wl", $dataDir ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Build MX*)
If[ FileExistsQ @ $mxFile,
    cicd`ConsoleLog[ "Removing existing MX file..." ];
    cicd`ScriptConfirm @ DeleteFile @ $mxFile
];

cicd`ConsoleLog[ "Loading paclet..." ];
cicd`ScriptConfirmBy[ PacletDirectoryLoad @ $pacletDir, MemberQ @ $pacletDir ];
cicd`ScriptConfirm @ Get[ "RH`ComputationalFitness`" ];

$mxDir = cDir @ gu`EnsureDirectory @ DirectoryName @ $mxFile;
cicd`ConsoleLog @ SequenceForm[ "MX target directory: ", $mxDir  ];
cicd`ConsoleLog @ SequenceForm[ "Building MX file: "   , $mxFile ];

(* TODO: remove mx exclusions *)
package`$debug = False;
package`$thisPacletLocation // ClearAll;
DumpSave[
    $mxFile,
    {
        "RH`ComputationalFitness`",
        "RH`ComputationalFitness`Private`"
    },
    "SymbolAttributes" -> False
];

If[ ! FileExistsQ @ $mxFile,
    cicd`ConsoleError[ "Failed to build MX file!", "Fatal" -> True ],
    $mxFile
]

(* :!CodeAnalysis::EndBlock:: *)