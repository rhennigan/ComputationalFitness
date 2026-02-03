(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RickHennigan`ComputationalFitness`" ];
Needs[ "RickHennigan`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*General Messages*)
ComputationalFitness::Internal =
"An unexpected error occurred. `1`";

ComputationalFitness::InternalFormatting =
"An unexpected error occurred during formatting. `1`";

ComputationalFitness::Unfinished =
"Definition warning: Starting definition for `1` without ending the current one.";

ComputationalFitness::IndexTranslation =
"Definition error: Index translation failed for `1` part \"`2`\" in `3`.";

ComputationalFitness::UnusedIndices =
"Definition warning: Unused indices in `1`: `2`.";

ComputationalFitness::KeysMissingDefinitions =
"The following \"`1`\" keys are missing definitions in `2`: `3`.";

ComputationalFitness::DefinitionsMissingKeys =
"The following \"`1`\" keys are defined in `2` but not declared: `3`.";

ComputationalFitness::UnsupportedMessageTypes =
"The following message types are defined in the SDK but not handled at \
top-level: `1`.";

ComputationalFitness::InvalidFile =
"First argument `1` is not a valid file, directory, or URL specification.";

ComputationalFitness::CopyTemporaryFailed =
"Failed to copy source to a temporary file.";

ComputationalFitness::InvalidXML =
"Cannot import data as XML format.";

ComputationalFitness::InvalidArguments =
"Invalid arguments given for `1` in `2`.";

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
$inDef           = False;
$internalFailure = None;
$debug           = TrueQ @ $debug;
$mxExclusions    = Internal`Bag[ ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*optimizeEnclosures*)
optimizeEnclosures // ClearAll;
optimizeEnclosures // Attributes = { HoldFirst };
optimizeEnclosures[ s_Symbol ] := DownValues[ s ] = expandThrowInternalFailures @ optimizeEnclosures0 @ DownValues @ s;

optimizeEnclosures0 // ClearAll;
optimizeEnclosures0[ expr_ ] :=
    ReplaceAll[
        expr,
        HoldPattern[ e: Enclose[ _ ] | Enclose[ _, _ ] ] :>
            With[ { new = addEnclosureTags[ e, $ConditionHold ] },
                RuleCondition[ new, True ]
            ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*expandThrowInternalFailures*)
expandThrowInternalFailures // beginDefinition;

expandThrowInternalFailures[ expr_ ] :=
    ReplaceAll[
        expr,
        HoldPattern[ Verbatim[ HoldPattern ][ lhs_ ] :> rhs_ ] /;
            ! FreeQ[ HoldComplete @ rhs, HoldPattern @ Enclose[ _, throwInternalFailure, $enclosure ] ] :>
                ReplaceAll[
                    HoldPattern[ e$: lhs ] :> rhs,
                    HoldPattern @ Enclose[ eval_, throwInternalFailure, $enclosure ] :>
                        Enclose[ eval, throwInternalFailure[ e$, ##1 ] &, $enclosure ]
                ]
    ];

expandThrowInternalFailures // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*addEnclosureTags*)
addEnclosureTags // ClearAll;
addEnclosureTags // Attributes = { HoldFirst };

addEnclosureTags[ Enclose[ expr_ ], wrapper_ ] :=
    addEnclosureTags[ Enclose[ expr, #1 & ], wrapper ];

addEnclosureTags[ Enclose[ expr_, func_ ], wrapper_ ] :=
    Module[ { held, replaced },
        held = HoldComplete @ expr;
        replaced = held /. $enclosureTagRules;
        Replace[ replaced, HoldComplete[ e_ ] :> wrapper @ Enclose[ e, func, $enclosure ] ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$enclosureTagRules*)
$enclosureTagRules // ClearAll;
(* :!CodeAnalysis::BeginBlock:: *)
(* :!CodeAnalysis::Disable::NoSurroundingEnclose:: *)
$enclosureTagRules := $enclosureTagRules = Dispatch @ {
    expr_Enclose                                      :> expr,

    HoldPattern @ Confirm[ expr_ ]                    :> Confirm[ expr, Null, $enclosure ],
    HoldPattern @ Confirm[ expr_, info_ ]             :> Confirm[ expr, info, $enclosure ],

    HoldPattern @ ConfirmBy[ expr_, f_ ]              :> ConfirmBy[ expr, f, Null, $enclosure ],
    HoldPattern @ ConfirmBy[ expr_, f_, info_ ]       :> ConfirmBy[ expr, f, info, $enclosure ],

    HoldPattern @ ConfirmMatch[ expr_, patt_ ]        :> ConfirmMatch[ expr, patt, Null, $enclosure ],
    HoldPattern @ ConfirmMatch[ expr_, patt_, info_ ] :> ConfirmMatch[ expr, patt, info, $enclosure ],

    HoldPattern @ ConfirmQuiet[ expr_ ]               :> ConfirmQuiet[ expr, All, Null, $enclosure ],
    HoldPattern @ ConfirmQuiet[ expr_, patt_ ]        :> ConfirmQuiet[ expr, patt, Null, $enclosure ],
    HoldPattern @ ConfirmQuiet[ expr_, patt_, info_ ] :> ConfirmQuiet[ expr, patt, info, $enclosure ],

    HoldPattern @ ConfirmAssert[ expr_ ]              :> ConfirmAssert[ expr, Null, $enclosure ],
    HoldPattern @ ConfirmAssert[ expr_, info_ ]       :> ConfirmAssert[ expr, info, $enclosure ]
};
(* :!CodeAnalysis::EndBlock:: *)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*excludeFromMX*)
excludeFromMX // ClearAll;
excludeFromMX // Attributes = { HoldFirst };
excludeFromMX[ s_Symbol ] := Internal`StuffBag[ $mxExclusions, Hold @ s ];
excludeFromMX // excludeFromMX;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*beginDefinition*)
beginDefinition // ClearAll;
beginDefinition // Attributes = { HoldFirst };

(* :!CodeAnalysis::BeginBlock:: *)
(* :!CodeAnalysis::Disable::SuspiciousSessionSymbol:: *)
beginDefinition[ s_Symbol ] /; $debug && $inDef :=
    WithCleanup[
        $inDef = False
        ,
        Print @ TemplateApply[ ComputationalFitness::Unfinished, HoldForm @ s ];
        beginDefinition @ s
        ,
        $inDef = True
    ];
(* :!CodeAnalysis::EndBlock:: *)

beginDefinition[ s_Symbol ] := WithCleanup[ Unprotect @ s; ClearAll @ s, $inDef = True ];

beginDefinition // excludeFromMX;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*appendFallthroughError*)
appendFallthroughError // ClearAll;
appendFallthroughError // Attributes = { HoldFirst };

appendFallthroughError[ s_Symbol, values: DownValues|UpValues ] :=
    Module[ { block = Internal`InheritedBlock, before, after },
        block[ { s },
            before = values @ s;
            appendFallthroughError0[ s, values ];
            after = values @ s;
        ];

        If[ TrueQ[ Length @ after > Length @ before ],
            values[ s ] = after,
            values[ s ]
        ]
    ];

appendFallthroughError0 // ClearAll;

appendFallthroughError0[ s_Symbol, OwnValues ] :=
    e: HoldPattern @ s :=
        throwInternalFailure[ e, "UnhandledOwnValues", HoldForm @ s ];

appendFallthroughError0[ s_Symbol, DownValues ] :=
    e: HoldPattern @ s[ ___ ] :=
        throwInternalFailure[ e, "UnhandledDownValues", HoldForm @ s ];

appendFallthroughError0[ s_Symbol, UpValues ] :=
    e: HoldPattern @ s[ ___ ][ ___ ] :=
        throwInternalFailure[ e, "UnhandledUpValues", HoldForm @ s ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*endDefinition*)
endDefinition // beginDefinition;
endDefinition // Attributes = { HoldFirst };

endDefinition[ s_Symbol ] := endDefinition[ s, DownValues ];

endDefinition[ s_Symbol, None ] := $inDef = False;

endDefinition[ s_Symbol, values: DownValues|UpValues ] :=
    WithCleanup[
        optimizeEnclosures @ s;
        appendFallthroughError[ s, values ],
        $inDef = False
    ];

endDefinition[ s_Symbol, list_List ] := (endDefinition[ s, #1 ] &) /@ list;

endDefinition // endDefinition;
endDefinition // excludeFromMX;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*endExportedDefinition*)
endExportedDefinition // beginDefinition;
endExportedDefinition // Attributes = { HoldFirst };

endExportedDefinition[ s_Symbol ] :=
    WithCleanup[
        optimizeEnclosures @ s;
        appendExportedFallthroughError @ s,
        $inDef = False
    ];

endExportedDefinition // endDefinition;
endExportedDefinition // excludeFromMX;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*appendExportedFallthroughError*)
appendExportedFallthroughError // ClearAll;
appendExportedFallthroughError // Attributes = { HoldFirst };

appendExportedFallthroughError[ s_Symbol ] :=
    Module[ { block = Internal`InheritedBlock, before, after },
        block[ { s },
            before = DownValues @ s;
            appendExportedFallthroughError0 @ s;
            after = DownValues @ s;
        ];

        If[ TrueQ[ Length @ after > Length @ before ],
            DownValues[ s ] = after,
            DownValues[ s ]
        ]
    ];

appendExportedFallthroughError0 // ClearAll;
appendExportedFallthroughError0[ f_Symbol ] := f[ a___ ] :=
    catchTop[ throwFailure[ "InvalidArguments", f, HoldForm @ f @ a ], f ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*endDefinition*)
endDefinition // beginDefinition;
endDefinition // Attributes = { HoldFirst };

endDefinition[ s_Symbol ] := endDefinition[ s, DownValues ];

endDefinition[ s_Symbol, None ] := $inDef = False;

endDefinition[ s_Symbol, values: DownValues|UpValues ] :=
    WithCleanup[
        optimizeEnclosures @ s;
        appendFallthroughError[ s, values ],
        $inDef = False
    ];

endDefinition[ s_Symbol, list_List ] := (endDefinition[ s, #1 ] &) /@ list;

endDefinition // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*setIfUndefined*)
setIfUndefined // beginDefinition;
setIfUndefined // Attributes = { HoldAll };
setIfUndefined[ sym_Symbol? ValueQ, value_ ] := Null;
setIfUndefined[ sym_Symbol, value_ ] := sym = value;
setIfUndefined // endDefinition;
setIfUndefined // excludeFromMX;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Caching*)
$blockCache = <| |>;
$cacheBlock = False;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*cacheBlock*)
cacheBlock // beginDefinition;
cacheBlock // Attributes = { HoldFirst };

cacheBlock[ eval_ ] :=
    Block[
        {
            cacheBlock  = #1 &,
            $cacheBlock = True,
            $blockCache = <| |>
        },
        eval
    ];

cacheBlock // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*cached*)
cached // Attributes = { HoldFirst };

cached[ eval_ ] /; $cacheBlock :=
    With[ { key = HoldComplete @ eval },
        Lookup[ $blockCache,
                key,
                $blockCache[ key ] = eval
        ]
    ];

cached[ eval_ ] := cacheBlock @ eval;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*clearCache*)
clearCache // beginDefinition;
clearCache[ ] := $blockCache = <| |>;
clearCache // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Error handling*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*catchTop*)
catchTop // beginDefinition;
catchTop // Attributes = { HoldFirst };

catchTop[ eval_ ] :=
    catchTop[ eval, ComputationalFitness ];

catchTop[ eval_, sym_Symbol ] :=
    Block[
        {
            $messageSymbol = Replace[ $messageSymbol, ComputationalFitness -> sym ],
            $catching      = True,
            $failed        = False,
            catchTop       = # &,
            catchTopAs     = (#1 &) &
        },
        cacheBlock @ Catch[ eval, $top ]
    ];

catchTop // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*catchTopAs*)
catchTopAs // beginDefinition;
catchTopAs[ sym_Symbol ] := Function[ eval, catchTop[ eval, sym ], { HoldAllComplete } ];
catchTopAs // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*catchFormattingTop*)
catchFormattingTop // beginDefinition;
catchFormattingTop // Attributes = { HoldFirst };

catchFormattingTop[ eval_, fmt_, sym_Symbol ] :=
    Block[
        {
            $messageSymbol     = Replace[ $messageSymbol, ComputationalFitness -> sym ],
            $catching          = True,
            $failed            = False,
            $formatting        = True,
            catchFormattingTop = #1 &,
            catchTop           = #1 &,
            catchTopAs         = (#1 &) &
        },
        cacheBlock @ Catch[ eval, $top, formatFailure @ fmt ]
    ];

catchFormattingTop // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*formatFailure*)
formatFailure // ClearAll;
formatFailure[ fmt_ ][ failure_, tag_ ] := formatFailure[ failure, fmt ];
formatFailure[ failure_, InputForm  ] := Format[ failure, InputForm  ];
formatFailure[ failure_, OutputForm ] := Format[ failure, OutputForm ];
formatFailure[ failure_, fmt_ ] := MakeBoxes[ failure, fmt ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*catchMine*)
catchMine // beginDefinition;
catchMine // Attributes = { HoldFirst };

catchMine /: HoldPattern[ f_Symbol[ args___ ] := catchMine[ rhs_ ] ] :=
    f[ args ] := catchTop[ rhs, f ];

catchMine[ eval_ ] := catchTop @ eval;

catchMine // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*throwFailure*)
throwFailure // beginDefinition;
throwFailure // Attributes = { HoldFirst };

throwFailure[ msg_, args___ ] :=
    Module[ { failure },
        failure = messageFailure[ msg, Sequence @@ Flatten[ HoldForm /@ { args } ] ];
        If[ TrueQ @ $catching,
            Throw[ failure, $top ],
            failure
        ]
    ];

throwFailure // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$messageSymbol*)
$messageSymbol := ComputationalFitness;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*messageFailure*)
messageFailure // beginDefinition;
messageFailure // Attributes = { HoldFirst };

messageFailure[ t_String, args___ ] :=
    With[ { s = $messageSymbol },
        If[ StringQ @ MessageName[ s, t ],
            messageFailure[ MessageName[ s, t ], args ],
            If[ StringQ @ MessageName[ ComputationalFitness, t ],
                blockProtected[ { s }, MessageName[ s, t ] = MessageName[ ComputationalFitness, t ] ];
                messageFailure[ MessageName[ s, t ], args ],
                throwInternalFailure @ messageFailure[ t, args ]
            ]
        ]
    ];

messageFailure[ args___ ] :=
    Module[ { quiet, message },
        quiet   = If[ TrueQ @ $failed, Quiet, Identity ];
        message = messageFailure0;
        WithCleanup[
            StackInhibit @ quiet @ message @ args,
            $failed = True
        ]
    ];

messageFailure // endDefinition;

messageFailure0 := messageFailure0 =
    Block[ { PrintTemporary },
        ResourceFunction[ "MessageFailure", "Function" ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*messagePrint*)
messagePrint // beginDefinition;
messagePrint // Attributes = { HoldFirst };

messagePrint[ args___ ] := WithCleanup[
    $failed = False,
    messageFailure @ args,
    $failed = False
];

messagePrint // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*blockProtected*)
blockProtected // beginDefinition;
blockProtected // Attributes = { HoldAll };

blockProtected[ { symbols___Symbol }, evaluation_ ] :=
    Module[ { protected },
        WithCleanup[
            protected = Unprotect @ symbols,
            evaluation,
            Protect @@ protected
        ]
    ];

blockProtected[ symbol_Symbol, evaluation_ ] :=
    blockProtected[ { symbol }, evaluation ];

blockProtected // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*throwInternalFailure*)
throwInternalFailure // beginDefinition;
throwInternalFailure // Attributes = { HoldFirst };

throwInternalFailure[ HoldForm[ eval_ ], a___ ] := throwInternalFailure[ eval, a ];

throwInternalFailure[ eval_, a___ ] :=
    Block[ { $internalFailure = $lastInternalFailure = makeInternalFailureData[ eval, a ] },
        throwFailure[ ComputationalFitness::Internal, $bugReportLink, $internalFailure ]
    ];

throwInternalFailure // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*makeInternalFailureData*)
makeInternalFailureData // Attributes = { HoldFirst };

makeInternalFailureData[ eval_, Failure[ tag_, as_Association ], args___ ] :=
    StackInhibit @ Module[ { $stack = Stack[ _ ] },
        DeleteMissing @ <|
            "Evaluation"  :> eval,
            KeyTake[ as, $priorityFailureKeys ],
            "Stack"       :> $stack,
            "Failure"     -> Failure[ tag, Association[ KeyDrop[ as, $priorityFailureKeys ], as ] ],
            "Arguments"   -> { args }
        |>
    ];

makeInternalFailureData[ eval_, args___ ] :=
    StackInhibit @ Module[ { $stack = Stack[ _ ] },
        <|
            "Evaluation" :> eval,
            "Stack"      :> $stack,
            "Arguments"  -> { args }
        |>
    ];

$priorityFailureKeys = { "Information", "ConfirmationType", "Expression", "Function", "Pattern", "Test" };

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Bug Report Link Generation*)

$issuesURL = "https://github.com/rhennigan/ComputationalFitness/issues/new";

$maxBugReportURLSize = 7000;
(*
    RFC 7230 recommends clients support 8000: https://www.rfc-editor.org/rfc/rfc7230#section-3.1.1
    Long bug report links might not work in old versions of IE,
    but using IE these days should probably be considered user error.
*)

$maxPartLength = 500;

$thisPaclet    := PacletObject[ "RickHennigan/ComputationalFitness" ];
$pacletVersion := $thisPaclet[ "Version" ];
$debugData     := debugData @ $thisPaclet[ "PacletInfo" ];
$releaseID     := $releaseID = getReleaseID @ $thisPaclet;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*getReleaseID*)
getReleaseID[ paclet_PacletObject ] :=
    getReleaseID[ paclet, paclet[ "ReleaseID" ] ];

getReleaseID[ paclet_PacletObject, "$RELEASE_ID$" | "None" | Except[ _String ] ] :=
    getReleaseID0 @ paclet[ "Location" ];

getReleaseID[ paclet_, id_String ] := id;


getReleaseID0[ dir_? DirectoryQ ] :=
    Module[ { stdOut, id },
        stdOut = Quiet @ RunProcess[ { "git", "rev-parse", "HEAD" }, "StandardOutput", ProcessDirectory -> dir ];
        id = If[ StringQ @ stdOut, StringTrim @ stdOut, "" ];
        If[ StringMatchQ[ id, Repeated[ HexadecimalCharacter, { 40 } ] ],
            id,
            "None"
        ]
    ];

getReleaseID0[ ___ ] := "None";

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*debugData*)
debugData // beginDefinition;

debugData[ as_Association? AssociationQ ] := <|
    KeyTake[ as, { "Name", "Version" } ],
    "ReleaseID"             -> $releaseID,
    "EvaluationEnvironment" -> $EvaluationEnvironment,
    "FrontEndVersion"       -> $frontEndVersion,
    "KernelVersion"         -> SystemInformation[ "Kernel", "Version" ],
    "SystemID"              -> $SystemID,
    "Notebooks"             -> $Notebooks,
    "DynamicEvaluation"     -> $DynamicEvaluation,
    "SynchronousEvaluation" -> $SynchronousEvaluation,
    "TaskEvaluation"        -> MatchQ[ $CurrentTask, _TaskObject ]
|>;

debugData // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$bugReportLink*)
$bugReportLink := Hyperlink[
    "Report this issue \[RightGuillemet]",
    trimURL @ URLBuild[ $issuesURL, { "title" -> "Insert Title Here", "labels" -> "bug", "body" -> bugReportBody[ ] } ]
];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*bugReportBody*)
bugReportBody[ ] := bugReportBody @ $thisPaclet[ "PacletInfo" ];

bugReportBody[ as_Association? AssociationQ ] :=
    Module[ { debugData, stack, internalFailure, bugReportText, file, data },

        debugData        = $debugData;
        stack            = $bugReportStack;
        internalFailure  = $internalFailure;

        bugReportText = TemplateApply[
            $bugReportBodyTemplate,
            TemplateVerbatim /@ <|
                "DebugData"       -> associationMarkdown @ debugData,
                "Stack"           -> stack,
                "InternalFailure" -> markdownCodeBlock @ internalFailure,
                "SourceLink"      -> sourceLink @ internalFailure
            |>
        ];

        data = <|
            "ReportText"      -> bugReportText,
            "PacletInfo"      -> as,
            "DebugData"       -> debugData,
            "Stack"           -> stack,
            "InternalFailure" -> internalFailure
        |>;

        file = File @ Export[
            FileNameJoin @ { $UserBaseDirectory, "Logs", "ComputationalFitness", "LastInternalFailureData.mx" },
            data,
            "MX"
        ];

        WithCleanup[
            Unprotect[ $LastComputationalFitnessFailure, $LastComputationalFitnessFailureText ]
            ,
            $LastComputationalFitnessFailure     = file;
            $LastComputationalFitnessFailureText = bugReportText;
            ,
            Protect[ $LastComputationalFitnessFailure, $LastComputationalFitnessFailureText ]
        ];

        bugReportText
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*sourceLink*)
sourceLink[ KeyValuePattern[ "Information" -> info_String ] ] := sourceLink @ info;
sourceLink[ info_String ] := sourceLink @ StringSplit[ info, "@@" ];
sourceLink[ { tag_String, source_String } ] := sourceLink @ { tag, StringSplit[ source, ":" ] };
sourceLink[ { tag_String, { file_String, pos_String } } ] := sourceLink @ { tag, file, StringSplit[ pos, "-" ] };

sourceLink[ { tag_String, file_String, { lc1_String, lc2_String } } ] :=
    sourceLink @ { tag, file, StringSplit[ lc1, "," ], StringSplit[ lc2, "," ] };

sourceLink[ { tag_String, file_String, { l1_String, c1_String }, { l2_String, c2_String } } ] :=
    Module[ { id },
        id = Replace[ $releaseID, { "$RELEASE_ID$" | "None" | Except[ _String ] -> "main" } ];
        "\n\nhttps://github.com/rhennigan/ComputationalFitness/blob/"<>id<>"/"<>file<>"#L"<>l1<>"-L"<>l2
    ];

sourceLink[ ___ ] := "";

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$bugReportBodyTemplate*)
$bugReportBodyTemplate = StringTemplate[ "\
Describe the issue in detail here. Attach any relevant screenshots or files. \
The section below was automatically generated. \
Remove any information that you do not wish to include in the report.\
\
%%SourceLink%%

<details>
<summary>Debug Data</summary>

%%DebugData%%

## Failure Data

%%InternalFailure%%

## Stack Data
```
%%Stack%%
```

</details>",
Delimiters -> "%%"
];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$frontEndVersion*)
$frontEndVersion :=
    If[ TrueQ @ $CloudEvaluation && $EvaluationEnvironment === "Session",
        StringJoin[ "Cloud: ", ToString @ $CloudVersion ],
        StringJoin[ "Desktop: ", ToString @ UsingFrontEnd @ SystemInformation[ "FrontEnd", "Version" ] ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$bugReportStack*)
$bugReportStack := StringRiffle[
    Reverse @ Replace[
        DeleteAdjacentDuplicates @ Cases[
            Stack[ _ ],
            HoldForm[ (s_Symbol) | (s_Symbol)[ ___ ] | (s_Symbol)[ ___ ][ ___ ] ] /;
                AtomQ @ Unevaluated @ s && StringStartsQ[ Context @ s, "RickHennigan`ComputationalFitness`" ] :>
                    SymbolName @ Unevaluated @ s
        ],
        { a___, "throwInternalFailure", ___ } :> { a, "throwInternalFailure" }
    ],
    "\n"
];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*trimURL*)
trimURL[ url_String ] := trimURL[ url, $maxBugReportURLSize ];

trimURL[ url_String, limit_Integer ] /; StringLength @ url <= limit := url;

trimURL[ url_String, limit_Integer ] :=
    Module[ { sp, bt, nl, before, after, base, take },
        sp     = ("+"|"%20")...;
        bt     = URLEncode[ "```" ];
        nl     = (URLEncode[ "\r\n" ] | URLEncode[ "\n" ])...;
        before = Longest[ "%23%23"~~sp~~"Failure"~~sp~~"Data"~~nl~~bt~~nl ];
        after  = Longest[ nl~~bt~~nl~~"%3C%2F"~~"details"~~"%3E" ];
        base   = StringLength @ StringReplace[ url, a: before ~~ ___ ~~ b: after :> a <> "\n" <> b ];
        take   = UpTo @ Max[ limit - base, 80 ];

        With[ { t = take },
            StringReplace[
                StringReplace[ url, a: before ~~ b__ ~~ c: after :> a <> StringTake[ b, t ] <> "\n" <> c ],
                "%%0A" | ("%"~~HexadecimalCharacter~~"%0A") :> "%0A"
            ]
        ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*associationMarkdown*)
associationMarkdown[ data_Association? AssociationQ ] := StringJoin[
    "| Property | Value |\n| --- | --- |\n",
    StringRiffle[
        KeyValueMap[
            Function[
                { k, v },
                StringJoin @ StringJoin[
                    "| ",
                    ToString @ ToString[ Unevaluated @ k, CharacterEncoding -> "UTF-8" ],
                    " | ``",
                    escapePipes @ truncatePartString @ ToString[
                        Unevaluated @ v,
                        InputForm,
                        CharacterEncoding -> "UTF-8"
                    ],
                    "`` |"
                ],
                HoldAllComplete
            ],
            data
        ],
        "\n"
    ]
];

associationMarkdown[ rules___ ] := With[ { as = Association @ rules }, associationMarkdown @ as /; AssociationQ @ as ];
associationMarkdown[ other_   ] := markdownCodeBlock @ other;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*markdownCodeBlock*)
markdownCodeBlock[ as_Association? AssociationQ ] :=
    "```\n<|\n" <> StringRiffle[ ruleToString /@ Normal[ as, Association ], ",\n" ] <> "\n|>\n```\n";

markdownCodeBlock[ expr_ ] := StringJoin[
    "```\n",
    StringTake[ ToString[ expr, InputForm, PageWidth -> $maxPartLength ], UpTo @ $maxBugReportURLSize ],
    "\n```\n"
];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*ruleToString*)
ruleToString[ a_ -> b_ ] := StringJoin[
    "  ",
    ToString[ Unevaluated @ a, InputForm ],
    " -> ",
    truncatePartString @ ToString[ Unevaluated @ b, InputForm ]
];

ruleToString[ a_ :> b_ ] := StringJoin[
    "  ",
    ToString[ Unevaluated @ a, InputForm ],
    " :> ",
    truncatePartString @ ToString[ Unevaluated @ b, InputForm ]
];

ruleToString[ other_ ] := truncatePartString @ ToString[ Unevaluated @ other, InputForm ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*truncatePartString*)
truncatePartString[ string_ ] := truncatePartString[ string, $maxPartLength ];

truncatePartString[ string_String, max_Integer ] :=
    If[ StringLength @ string > max, StringTake[ string, UpTo @ max ] <> "...", string ];

truncatePartString[ other_, max_Integer ] := truncatePartString[ ToString[ Unevaluated @ other, InputForm ], max ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*escapePipes*)
escapePipes[ string_String ] := StringReplace[ string, "|" -> "\\|" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Files*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*sourceFileApply*)
sourceFileApply // beginDefinition;

sourceFileApply[ function_, source_ ] :=
    Block[ { $tempFiles = Internal`Bag[ ] },
        WithCleanup[
            function[ source, toFileString @ source ],
            DeleteFile /@ Internal`BagPart[ $tempFiles, All ]
        ]
    ];

sourceFileApply // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*toFileString*)
toFileString // beginDefinition;

toFileString[ file_ ] :=
    With[ { str = toFileString0 @ file },
        If[ StringQ @ str,
            str,
            throwFailure[ ComputationalFitness::InvalidFile, file ]
        ]
    ];

toFileString // endDefinition;


toFileString0 // beginDefinition;

toFileString0[ source_ ] := Switch[
    source,
    $$string, ExpandFileName @ source,
    $$file,   ExpandFileName @ source,
    $$url,    createTemporary @ source,
    $$co,     createTemporary @ source,
    $$lo,     createTemporary @ source,
    $$resp,   createTemporary @ source,
    ___,      throwFailure[ ComputationalFitness::InvalidFile, source ]
];

toFileString0 // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*createTemporary*)
createTemporary // beginDefinition;

createTemporary[ source_ ] := Switch[
    source,
    $$url,   addTempFile @ URLDownload[ source, $tempFile ],
    $$co,    addTempFile @ CopyFile[ source, $tempFile ],
    $$lo,    addTempFile @ CopyFile[ source, $tempFile ],
    $$resp,  addTempFile @ With[ { file = $tempFile },
                    WithCleanup[
                        BinaryWrite[ file, First @ source ],
                        Close @ file
                    ]
                ],
    ___,     throwFailure[ ComputationalFitness::InvalidFile, source ]
];

createTemporary // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*addTempFile*)
addTempFile // beginDefinition;

addTempFile[ file_? FileExistsQ ] :=
    addTempFile[ ExpandFileName @ file, $tempFiles ];

addTempFile[ file_String, files_Internal`Bag ] := (
    Internal`StuffBag[ files, file ];
    file
);

addTempFile[ other_ ] := throwFailure[ ComputationalFitness::CopyTemporaryFailed, other ];

addTempFile // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$tempFile*)
$tempFile // ClearAll;
$tempFile := FileNameJoin @ {
    GeneralUtilities`EnsureDirectory @ { $TemporaryDirectory, "RickHennigan", "ComputationalFitness" },
    CreateUUID[ ]
};

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*findFile*)
findFile // beginDefinition;
findFile[ file_ ] := Quiet @ FindFile @ file;
findFile // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*optionsAssociation*)
optionsAssociation // beginDefinition;

optionsAssociation[ f_Symbol, opts: OptionsPattern[ ] ] := Association[
    KeyMap[ ToString, Association @ Options @ f ],
    KeyMap[ ToString, Association @ Reverse @ { opts } ]
];

optionsAssociation // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*importXML*)
importXML // beginDefinition;
importXML[ bytes_ByteArray ] := importXML[ bytes, ByteArrayToString @ bytes ];
importXML[ file_? FileExistsQ ] := importXML[ file, ReadString @ file ];
importXML[ file_, xml_String ] := importXML[ file, ImportString[ StringTrim @ xml, "XML" ] ];
importXML[ file_, xml: XMLObject[ _ ][ ___ ] ] := xml;
importXML[ file_, bad_ ] := throwFailure[ "InvalidXML", file ];
importXML // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
