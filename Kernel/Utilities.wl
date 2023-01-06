(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
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

ComputationalFitness::InvalidXML =
"Cannot import data as XML format.";

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
$inDef        = False;
$debug        = TrueQ @ $debug;
$mxExclusions = Internal`Bag[ ];

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

beginDefinition[ s_Symbol ] :=
    WithCleanup[ Unprotect @ s; ClearAll @ s, $inDef = True ];

beginDefinition // excludeFromMX;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*endDefinition*)
endDefinition // beginDefinition;
endDefinition // Attributes = { HoldFirst };

endDefinition[ s_Symbol ] := endDefinition[ s, DownValues ];

endDefinition[ s_Symbol, None ] := $inDef = False;

endDefinition[ s_Symbol, DownValues ] :=
    WithCleanup[
        AppendTo[ DownValues @ s,
                  e: HoldPattern @ s[ ___ ] :>
                      throwInternalFailure @ HoldForm @ e
        ],
        $inDef = False
    ];

endDefinition[ s_Symbol, SubValues  ] :=
    WithCleanup[
        AppendTo[ SubValues @ s,
                  e: HoldPattern @ s[ ___ ][ ___ ] :>
                      throwInternalFailure @ HoldForm @ e
        ],
        $inDef = False
    ];

endDefinition[ s_Symbol, list_List ] :=
    endDefinition[ s, # ] & /@ list;

endDefinition // endDefinition;
endDefinition // excludeFromMX;

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
            $messageSymbol = sym,
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
            $messageSymbol     = sym,
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
        failure = messageFailure[ msg, Sequence @@ HoldForm /@ { args } ];
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
                MessageName[ s, t ] = MessageName[ ComputationalFitness, t ];
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
(*throwInternalFailure*)
throwInternalFailure // beginDefinition;
throwInternalFailure // Attributes = { HoldFirst };

throwInternalFailure[ eval: h_Symbol[ ___ ], a___ ] /; $formatting :=
    With[ { msg = h::InternalFormatting },
        throwFailure[ h::InternalFormatting, $bugReportLink, HoldForm @ eval, a ] /;
            StringQ @ msg
    ];

throwInternalFailure[ eval: h_Symbol[ ___ ], a___ ] :=
    With[ { msg = h::Internal },
        throwFailure[ h::Internal, $bugReportLink, HoldForm @ eval, a ] /;
            StringQ @ msg
    ];

throwInternalFailure[ eval_, a___ ] /; $formatting :=
    throwFailure[
        ComputationalFitness::InternalFormatting,
        $bugReportLink,
        HoldForm @ eval,
        a
    ];

throwInternalFailure[ eval_, a___ ] :=
    throwFailure[
        ComputationalFitness::Internal,
        $bugReportLink,
        HoldForm @ eval,
        a
    ];

throwInternalFailure // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$bugReportLink*)
$bugReportLink := $bugReportLink = Hyperlink[
    "Report this issue \[RightGuillemet]",
    URLBuild @ <|
        "Scheme" -> "https",
        "Domain" -> "github.com",
        "Path"   -> { "rhennigan", "ComputationalFitness", "issues", "new" }
    |>
];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Misc*)

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
importXML[ file_ ] := importXML[ file, ReadString @ file ];
importXML[ file_, xml_String ] := importXML[ file, ImportString[ StringTrim @ xml, "XML" ] ];
importXML[ file_, xml: XMLObject[ _ ][ ___ ] ] := xml;
importXML[ file_, bad_ ] := throwFailure[ "InvalidXML", file ];
importXML // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
