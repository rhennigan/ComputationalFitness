#!/usr/bin/env wolframscript

(* :!CodeAnalysis::BeginBlock:: *)
(* :!CodeAnalysis::Disable::SuspiciousSessionSymbol:: *)

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
If[ ! PacletObjectQ @ PacletObject[ "Wolfram/PacletCICD" ],
    PacletInstall @ ResourceObject[ "Wolfram/PacletCICD" ]
];

Needs[ "Wolfram`PacletCICD`" -> "cicd`" ];

cFile = cicd`ScriptConfirmBy[ #, FileExistsQ ] &;
cDir  = cicd`ScriptConfirmBy[ #, DirectoryQ  ] &;
cStr  = cicd`ScriptConfirmBy[ #, StringQ     ] &;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Paths*)
$inputFileName  = cFile @ Replace[ $InputFileName, "" :> NotebookFileName[ ] ];
$pacletDir      = cDir @ DirectoryName[ $inputFileName, 2 ];
$pacletInfoFile = cFile @ FileNameJoin @ { $pacletDir, "PacletInfo.wl" };

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Set paclet info*)
$actionURL = Module[ { domain, repo, runID },
    domain = cStr @ Environment[ "GITHUB_SERVER_URL" ];
    repo   = cStr @ Environment[ "GITHUB_REPOSITORY" ];
    runID  = cStr @ Environment[ "GITHUB_RUN_ID"     ];
    cStr @ URLBuild @ { domain, repo, "actions", "runs", runID }
];

cFile @ Export[
    $pacletInfoFile,
    cStr @ StringReplace[
        cStr @ ReadString @ $pacletInfoFile,
        {
            "$ActionURL$" -> $actionURL,
            "$BuildDate$" -> DateString[ "ISODateTime", TimeZone -> 0 ] <> "Z"
        }
    ],
    "String"
]

(* :!CodeAnalysis::EndBlock:: *)