#!/usr/bin/env wolframscript

(* :!CodeAnalysis::BeginBlock:: *)
(* :!CodeAnalysis::Disable::SuspiciousSessionSymbol:: *)

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
If[ ! TrueQ @ $loadedDefinitions, Get @ FileNameJoin @ { DirectoryName @ $InputFileName, "Common.wl" } ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Get Release Directory*)
$releaseDir = FileNameJoin @ { $pacletDir, "build" };

If[ ! DirectoryQ @ $releaseDir,
    Print[ "::error::Release directory ", $releaseDir, " does not exist!" ];
    Exit[ 1 ],
    Print @ StringJoin[
        "Release Files: \n\t",
        StringRiffle[ FileNames[ All, $releaseDir, Infinity ], "\n\t" ]
    ]
];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Get Paclet Archive*)
$releasePaclet = First[ FileNames[ "*.paclet", $releaseDir ], $Failed ];

If[ ! FileExistsQ @ $releasePaclet,
    Print[ "::error::Release paclet file not found!" ];
    Exit[ 1 ]
];

$releaseFile = FileNameTake @ $releasePaclet;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Get Release Version*)
$paclet = PacletObject @ File @ $pacletDir;
If[ ! PacletObjectQ @ $paclet,
    Print[ "::error::Paclet directory failure: " <> ToString @ $pacletDir ];
    Exit[ 1 ]
];

$version = $paclet[ "Version" ];

If[ ! StringQ @ $version && ! StringMatchQ[ $version, (DigitCharacter|".").. ],
    Print[ "::error::Paclet version failure: " <> ToString @ $version ];
    Exit[ 1 ]
];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Set Parameters*)
setOutput[ "PACLET_BUILD_DIR"  , $releaseDir    ];
setOutput[ "PACLET_PATH"       , $releasePaclet ];
setOutput[ "PACLET_FILE"       , $releaseFile   ];
setOutput[ "PACLET_RELEASE_TAG", "v"<>$version  ];

(* :!CodeAnalysis::EndBlock:: *)
