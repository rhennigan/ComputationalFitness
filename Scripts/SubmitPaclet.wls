#!/usr/bin/env wolframscript

If[ ! TrueQ @ $loadedDefinitions, Get @ FileNameJoin @ { DirectoryName @ $InputFileName, "Common.wl" } ];

Needs[ "PacletResource`" -> None ];
SetOptions[ PacletResource`Notebooks`ProcessNotebookForEmbedding, "EmbeddedHTMLImages" -> True ];

Print[
    "::notice::", "Build files: \n\t",
    StringRiffle[ FileNames[ All, FileNameJoin @ { $pacletDir, "build" }, Infinity ], "\n\t" ]
];

(* Temporarily disabled for testing *)
(* checkResult @ cicd`SubmitPaclet[ $defNB, "ExitOnFail" -> True ] *)