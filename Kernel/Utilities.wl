(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*General Messages*)
ComputationalFitness::Internal =
"An unexpected error occurred. `1`";

ComputationalFitness::Unfinished =
"Starting definition for `1` without ending the current one.";

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
$inDef = False;
$debug = False;

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*setIfUndefined*)
setIfUndefined // beginDefinition;
setIfUndefined // Attributes = { HoldAll };
setIfUndefined[ sym_Symbol? ValueQ, value_ ] := Null;
setIfUndefined[ sym_Symbol, value_ ] := sym = value;
setIfUndefined // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Caching*)
$blockCache = <| |>;
$cacheBlock = False;

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Error handling*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*catchTop*)
catchTop // beginDefinition;
catchTop // Attributes = { HoldFirst };

catchTop[ eval_ ] :=
    Block[ { $catching = True, $failed = False, catchTop = # &, $start },
        cacheBlock @ Catch[ eval, $top ]
    ];

catchTop // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*catchTopAs*)
catchTopAs // beginDefinition;

catchTopAs[ sym_Symbol ] :=
    Function[
        eval,
        Block[ { $messageSymbol = sym, catchTopAs = (#1 &) & },
            catchTop @ eval
        ],
        { HoldAllComplete }
    ];

catchTopAs // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*catchMine*)
catchMine // beginDefinition;

catchMine // Attributes = { HoldFirst };

catchMine /: HoldPattern[ f_Symbol[ args___ ] := catchMine[ rhs_ ] ] :=
    f[ args ] := Block[ { $messageSymbol = f }, catchTop @ rhs ];

catchMine[ eval_ ] := catchTop @ eval;

catchMine // endDefinition;

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$messageSymbol*)
$messageSymbol := ComputationalFitness;

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*throwInternalFailure*)
throwInternalFailure // beginDefinition;
throwInternalFailure // Attributes = { HoldFirst };

throwInternalFailure[ eval: h_Symbol[ ___ ], a___ ] :=
    With[ { msg = h::Internal },
        throwFailure[ h::Internal, $bugReportLink, HoldForm @ eval, a ] /;
            StringQ @ msg
    ];

throwInternalFailure[ eval_, a___ ] :=
    throwFailure[
        ComputationalFitness::Internal,
        $bugReportLink,
        HoldForm @ eval,
        a
    ];

throwInternalFailure // endDefinition;

(* ::**********************************************************************:: *)
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

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Misc*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*findFile*)
findFile // beginDefinition;
findFile[ file_ ] := Quiet @ FindFile @ file;
findFile // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
