(* cSpell: ignore samevers *)

(* :!CodeAnalysis::BeginBlock:: *)
(* :!CodeAnalysis::Disable::BadInternalDefinition:: *)
(* :!CodeAnalysis::Disable::PrivateContextSymbol:: *)

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
Wolfram`PacletCICD`$Debug = True;

Off[ General::shdw           ];
Off[ PacletInstall::samevers ];

If[ ! PacletObjectQ @ PacletObject[ "Wolfram/PacletCICD" ],
    PacletInstall[ "https://github.com/WolframResearch/PacletCICD/releases/download/v0.36.2/Wolfram__PacletCICD-0.36.2.paclet" ]
];

Needs[ "Wolfram`PacletCICD`" -> "cicd`" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*PacletTools Overrides*)
PacletInstall[ "PacletTools" ];
Needs[ "PacletTools`" -> None ];

If[ ListQ @ PacletTools`Utils`Private`$extensionsAllowedAtPacletRoot,
    PacletTools`Utils`Private`$extensionsAllowedAtPacletRoot =
        DeleteDuplicates @ Append[ PacletTools`Utils`Private`$extensionsAllowedAtPacletRoot, "Path" ]
];

PacletTools`$PacletExtensionHandlers[ "Path", "Files" ] = { } &;
PacletTools`$PacletExtensionHandlers[ "Path", "Build" ] = { } &;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*DefinitionNotebookClient Overrides*)

(* Increase code inspector timeout: *)
DefinitionNotebookClient`LoadDefinitionNotebook[ "Paclet" ];
DefinitionNotebookClient`PackageScope`$InspectionFunctions[ "Paclet", "PacletManifest", "CodeInspectionIssues" ] =
    ReplaceAll[
        DefinitionNotebookClient`PackageScope`$InspectionFunctions[ "Paclet", "PacletManifest", "CodeInspectionIssues" ],
        HoldPattern[ "TimeConstraint" -> 60 ] -> "TimeConstraint" -> 300
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Common Definitions*)
cFile = cicd`ScriptConfirmBy[ #, FileExistsQ ] &;
cDir  = cicd`ScriptConfirmBy[ #, DirectoryQ  ] &;
cStr  = cicd`ScriptConfirmBy[ #, StringQ     ] &;

$messageHistoryLength = 10;
$messageNumber        = 0;
$messageHistory       = <| |>;
$stackHistory         = <| |>;
$inputFileName        = cFile @ Replace[ $InputFileName, "" :> NotebookFileName[ ] ];
$pacletDir            = cDir @ DirectoryName[ $inputFileName, 2 ];
$pacletInfoFile       = cFile @ FileNameJoin @ { $pacletDir, "PacletInfo.wl" };

Internal`AddHandler[ "Message", messageHandler ];

$testingHeads = HoldPattern @ Alternatives[
    TestReport,
    VerificationTest,
    Testing`Private`extractUnevaluated
];

$testStack = With[ { h = $testingHeads }, (HoldForm|System`HoldCompleteForm)[ h[ ___ ] ] ];

messageHandler[
    Hold @ Message[ Wolfram`PacletCICD`TestPaclet::Failures, ___ ],
    _
] := Null;

messageHandler[ Hold[ msg_, True ] ] /; $messageNumber < $messageHistoryLength :=
    StackInhibit @ Module[ { stack, keys, limit, drop },
        stack = Stack[ _ ];
        If[ MemberQ[ stack, $testStack ], Throw[ Null, $tag ] ];

        $messageNumber += 1;
        $messageHistory[ $messageNumber ] = HoldForm @ msg;
        $stackHistory[   $messageNumber ] = stack;

        keys  = Union[ Keys @ $messageHistory, Keys @ $stackHistory ];
        limit = $messageNumber - $messageHistoryLength;
        drop  = Select[ keys, ! TrueQ[ # > limit ] & ];

        KeyDropFrom[ $messageHistory, drop ];
        KeyDropFrom[ $stackHistory  , drop ];

        messagePrint @ msg;
    ] ~Catch~ $tag;


messagePrint // Attributes = { HoldFirst };

messagePrint[ Message[ msg_, args___ ] ] :=
    messagePrint[ msg, args ];

messagePrint[ msg_MessageName, args___ ] :=
    cicd`ConsoleWarning[ ToString @ Unevaluated @ msg <> ": " <> messageString[ msg, args ] ];

messageString[ template_String, args___ ] :=
    ToString[ StringForm[ template, Sequence @@ Short /@ { args } ],
              OutputForm,
              PageWidth -> 80
    ];

messageString[ HoldPattern @ MessageName[ f_, tag_ ], args___ ] :=
    With[ { template = MessageName[ General, tag ] },
        messageString[ template, args ] /; StringQ @ template
    ];

messageString[ ___ ] := "-- Message text not found --";

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*logPrint*)
logPrint // ClearAll;
logPrint[ args___ ] := With[ { t = $logTimeStamp }, WriteLine[ "stderr", sequenceString[ t, " ", args ] ] ];

$logTimeStamp := DateString[
    {
        "Year", "-", "Month", "-", "Day",
        "T",
        "Hour", ":", "Minute", ":", "Second", ".", "Millisecond",
        "Z"
    },
    TimeZone -> 0
];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*sequenceString*)
sequenceString // ClearAll;
sequenceString // Attributes = { HoldAll };
sequenceString[ args___ ] := ToString @ Unevaluated @ SequenceForm @ args;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Publisher ID*)
Needs[ "ResourceSystemClient`" -> None ];
$PublisherID = PacletObject[ File @ $pacletDir ][ "PublisherID" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Command Line Arguments*)
$scriptCommandLine := Select[ Flatten @ { Replace[ $ScriptCommandLine, { } :> $CommandLine ] }, StringQ ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*getBooleanArgument*)
getBooleanArgument // Attributes = { HoldRest };

getBooleanArgument[ name_ ] :=
    getBooleanArgument[ name, False ];

getBooleanArgument[ name_String, default_ ] :=
    getBooleanArgument[ { name, name }, default ];

getBooleanArgument[ { short_String, full_String }, default_ ] := Catch[
    Module[ { named, interpreted, res },
        If[ MemberQ[ $scriptCommandLine, "-"<>short | "--"<>full ], Throw[ True, $booleanTag ] ];
        named = getNamedArgument @ full;
        If[ ! StringQ @ named, Throw[ default, $booleanTag ] ];
        interpreted = Interpreter[ "Boolean" ][ named ];
        If[ BooleanQ @ interpreted,
            interpreted,
            res = default;
            cicd`ConsoleError @ TemplateApply[
                "The value \"`1`\" specified for \"`2`\" is not a valid boolean value. Using default value: \"`3`\".",
                { named, full, res }
            ];
            res
        ]
    ],
    $booleanTag
];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*getNamedArgument*)
getNamedArgument // Attributes = { HoldRest };

getNamedArgument[ name_ ] :=
    getNamedArgument[ name, Missing[ "NotSpecified" ] ];

getNamedArgument[ name_String, default_ ] :=
    Module[ { arg },
        arg = SelectFirst[ $scriptCommandLine, StringQ @ # && StringStartsQ[ #, "--"<>name<>"=" ] & ];
        If[ StringQ @ arg,
            StringDelete[ arg, StartOfString ~~ "--"<>name<>"=" ],
            default
        ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Definitions*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*gitCommand*)
gitCommand[ { cmd__String }, dir_ ] :=
    Enclose @ Module[ { res },
        res = RunProcess[ { "git", cmd }, ProcessDirectory -> dir ];
        ConfirmAssert[ res[ "ExitCode" ] === 0 ];
        StringTrim @ ConfirmBy[ res[ "StandardOutput" ], StringQ ]
    ];

gitCommand[ cmd_String, dir_ ] := gitCommand[ { cmd }, dir ];

gitCommand[ cmd_ ] := gitCommand[ cmd, Directory[ ] ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*releaseID*)
releaseID[ dir_ ] :=
    With[ { sha = Environment[ "GITHUB_SHA" ] },
        If[ StringQ @ sha,
            sha,
            gitCommand[ { "rev-parse", "HEAD" }, dir ]
        ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*releaseURL*)
releaseURL[ file_ ] :=
    Enclose @ Module[ { pac, repo, ver },
        pac  = PacletObject @ Flatten @ File @ file;
        repo = ConfirmBy[ Environment[ "GITHUB_REPOSITORY" ], StringQ ];
        ver  = ConfirmBy[ pac[ "Version" ], StringQ ];
        TemplateApply[ "https://github.com/`1`/releases/tag/v`2`", { repo, ver } ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*actionURL*)
actionURL[ ] := Enclose[
    Module[ { cs, domain, repo, runID },
        cs     = ConfirmBy[ #, StringQ ] &;
        domain = cs @ Environment[ "GITHUB_SERVER_URL" ];
        repo   = cs @ Environment[ "GITHUB_REPOSITORY" ];
        runID  = cs @ Environment[ "GITHUB_RUN_ID"     ];
        cs @ URLBuild @ { domain, repo, "actions", "runs", runID }
    ],
    "$ACTION_URL$" &
];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*updatePacletInfo*)
updatePacletInfo[ dir_ ] /; StringQ @ Environment[ "GITHUB_ACTION" ] := Enclose[
    Module[
        { cs, file, string, id, date, url, run, cmt, new },

        cs     = ConfirmBy[ #, StringQ ] &;
        file   = cs @ FileNameJoin @ { dir, "PacletInfo.wl" };
        string = cs @ ReadString @ file;
        id     = cs @ releaseID @ dir;
        date   = cs @ DateString[ "ISODateTime", TimeZone -> 0 ];
        date   = StringTrim[ date, "Z" ] <> "Z";
        url    = cs @ releaseURL @ file;
        run    = cs @ actionURL[ ];
        cmt    = cs @ commitURL @ id;

        new = cs @ StringReplace[
            string,
            {
                "\r\n"           -> "\n",
                "$RELEASE_ID$"   -> id,
                "$RELEASE_DATE$" -> date,
                "$RELEASE_URL$"  -> url,
                "$ACTION_URL$"   -> run
            }
        ];

        cicd`ConsoleLog[ "Updating PacletInfo"       ];
        cicd`ConsoleLog[ "    ReleaseID:   " <> id   ];
        cicd`ConsoleLog[ "    ReleaseDate: " <> date ];
        cicd`ConsoleLog[ "    ReleaseURL:  " <> url  ];
        cicd`ConsoleLog[ "    ActionURL:   " <> run  ];

        Confirm @ WithCleanup[ BinaryWrite[ file, new ],
                               Close @ file
                  ];

        updateReleaseInfoCell[ dir, url, cmt, run ]
    ],
    cicd`ConsoleError[ "Failed to update PacletInfo template parameters.", "Fatal" -> True ] &
];



updateReleaseInfoCell[ dir_, url_, cmt_, run_ ] /;
    Environment[ "GITHUB_WORKFLOW" ] === "Release" :=
    Enclose @ Module[ { cells, nbFile, nb, rule },

        cells  = ConfirmMatch[ releaseInfoCell[ url, cmt, run ], { __Cell } ];
        nbFile = FileNameJoin @ { dir, "ResourceDefinition.nb" };
        nb     = ConfirmMatch[ Import[ nbFile, "NB" ], _Notebook ];
        rule   = Cell[ ___, CellTags -> { ___, "ReleaseInfoTag", ___ }, ___ ] :>
                     Sequence @@ cells;

        Export[ nbFile, nb /. rule, "NB" ]
    ];


commitURL[ sha_String ] := Enclose @ URLBuild @ {
    "https://github.com",
    ConfirmBy[ Environment[ "GITHUB_REPOSITORY" ], StringQ ],
    "commit",
    sha
};


releaseInfoCell[ release_, commit_, run_ ] := Enclose[
    Module[ { environment },
        environment = ConfirmBy[ Environment[ #1 ], StringQ ] &;
        {
            Cell[
                TextData @ {
                    getIcon[ "Tag" ],
                    " ",
                    ButtonBox[
                        FileNameTake @ release,
                        BaseStyle  -> "Hyperlink",
                        ButtonData -> { URL @ release, None },
                        ButtonNote -> release
                    ]
                },
                "Text"
            ],
            Cell[
                TextData @ {
                    getIcon[ "Commit" ],
                    " ",
                    ButtonBox[
                        StringTake[ FileNameTake @ commit, 7 ],
                        BaseStyle  -> "Hyperlink",
                        ButtonData -> { URL @ commit, None },
                        ButtonNote -> commit
                    ]
                },
                "Text"
            ],
            Cell[
                TextData @ {
                    getIcon[ "Action" ],
                    " ",
                    ButtonBox[
                        StringJoin[
                            environment[ "GITHUB_WORKFLOW" ],
                            "/",
                            environment[ "GITHUB_JOB" ]
                        ],
                        BaseStyle  -> "Hyperlink",
                        ButtonData -> { URL @ run, None },
                        ButtonNote -> run
                    ]
                },
                "Text"
            ]
        }
    ],
    None &
];


getIcon[ name_String ] := getIcon[ name ] =
    Get @ FileNameJoin @ { DirectoryName @ $inputFileName, "Resources", "Icons", name<>".wl" };

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*setResourceSystemBase*)
setResourceSystemBase[ ] := (
    Needs[ "ResourceSystemClient`" -> None ];
    $ResourceSystemBase =
        With[ { rsBase = Environment[ "RESOURCE_SYSTEM_BASE" ] },
            If[ StringQ @ rsBase, rsBase, $ResourceSystemBase ]
        ]
);

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*checkResult*)
checkResult // Attributes = { HoldFirst };

checkResult[ eval: (sym_Symbol)[ args___ ] ] :=
    Module[ { result, ctx, name, stacks, stackName, full },

        result = noExit @ eval;
        ctx    = Context @ Unevaluated @ sym;
        name   = SymbolName @ Unevaluated @ sym;
        full   = ctx <> name;

        checkMessages @ name;

        If[ MatchQ[ Head @ result, HoldPattern @ sym ]
            ,
            cicd`ConsoleError[ full <> " not defined", "Fatal" -> True ]
        ];

        If[ FailureQ @ result,
            cicd`ConsoleError[ full <> " failed", "Fatal" -> True ]
        ]
    ];

noExit    := Wolfram`PacletCICD`Private`noExit;
setOutput := Wolfram`PacletCICD`Private`setOutput;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*checkMessages*)
checkMessages[ name_String ] :=
    Module[ { stackName, stacks },
        If[ $messageNumber > 0,
            stackName = name<>"StackHistory";
            stacks = ExpandFileName[ stackName<>".wxf" ];
            cicd`ConsoleNotice @ SequenceForm[ "Exporting stack data: ", stacks ];
            Export[ stacks, $stackHistory, "WXF", PerformanceGoal -> "Size" ];
            setOutput[ "PACLET_STACK_HISTORY", stacks ];
            setOutput[ "PACLET_STACK_NAME", stackName ];
        ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Setup*)
cicd`ConsoleLog @ SequenceForm[ "Paclet Directory: ", $pacletDir ];

updatePacletInfo @ $pacletDir;

setResourceSystemBase[ ];
cicd`ConsoleLog @ SequenceForm[ "ResourceSystemBase: ", $ResourceSystemBase ];

$defNB = File @ FileNameJoin @ { $pacletDir, "ResourceDefinition.nb" };
cicd`ConsoleLog @ SequenceForm[ "Definition Notebook: ", $defNB ];


$loadedDefinitions = True;

(* :!CodeAnalysis::EndBlock:: *)