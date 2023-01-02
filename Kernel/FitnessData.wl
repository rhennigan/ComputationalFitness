(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* TODO: store import options for delayed interpretations *)

$ContextAliases[ "sp`" ] = "System`Private`";

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Argument Patterns*)
$$fitnessDataStaticProperty = Alternatives[
    "Count",
    "DataFormat",
    "Format",
    "Options", \
    "SummaryData",
    "Type",
    "UUID"
];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Main Definition*)
FitnessData[ data_Association ]? sp`HoldNotValidQ :=
    catchMine @ With[ { valid = validateFitnessData @ data },
        If[ AssociationQ @ valid,
            sp`HoldSetValid @ FitnessData @ valid,
            throwFailure[ "InvalidFitnessData", data ]
        ]
    ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*validateFitnessData*)
validateFitnessData // beginDefinition;
validateFitnessData[ as_Association ] := validateFitnessData[ as[ "DataFormat" ], as ];
validateFitnessData[ "FITCompact", as_ ] := validateFITCompact @ as;
validateFitnessData // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*validateFITCompact*)
validateFITCompact // beginDefinition;

validateFITCompact[ as: KeyValuePattern[ "Data" -> data_String ] ] :=
    validateFITCompact @ Append[ as, "Data" -> unsmooshData @ data ];

validateFITCompact[ as_Association? fitCompactQ ] :=
    Append[ as, "UUID" -> CreateUUID[ ] ];

validateFITCompact // endDefinition;


fitCompactQ // ClearAll;
fitCompactQ[ as_Association ] := AllTrue[
    as[ "Data" ],
    MatchQ @ KeyValuePattern @ {
        "Fields" -> { ___String },
        "Data"   -> _? MatrixQ
    }
];

fitCompactQ[ ___ ] := False;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Properties*)
(fd_FitnessData? FitnessDataQ)[ prop_ ] := catchTop @ fitnessDataProperty[ fd, prop ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitnessDataProperty*)
fitnessDataProperty // beginDefinition;

fitnessDataProperty[ fd_, prop: $$fitnessDataStaticProperty ] :=
    fitnessDataStaticProperty[ fd, prop ];

fitnessDataProperty[ fd_? compactFitFitnessDataQ, prop_ ] :=
    FITImport[ fd, prop, fitnessDataOptions[ FITImport, fd ] ];

fitnessDataProperty // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitnessDataOptions*)
fitnessDataOptions // beginDefinition;

fitnessDataOptions[ head_Symbol, fd_ ] :=
    fitnessDataOptions[ head, fd, fitnessDataStaticProperty[ fd, "Options" ] ];

fitnessDataOptions[ head_Symbol, fd_, opts_Association ] :=
    Sequence @@ FilterRules[ Normal[ opts, Association ], Options @ head ];

fitnessDataOptions // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitnessDataStaticProperty*)
fitnessDataStaticProperty // beginDefinition;
fitnessDataStaticProperty[ FitnessData[ KeyValuePattern[ prop_ -> val_ ] ], prop_ ] := val;
fitnessDataStaticProperty // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*UpValues*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Normal*)
FitnessData /: HoldPattern @ Normal[ fd_FitnessData? FitnessDataQ ] :=
    catchTop @ fd[ "Messages" ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Options*)
FitnessData /: HoldPattern @ Options[ fd_FitnessData? FitnessDataQ ] :=
    catchTop @ fd[ "Options" ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*GeoGraphics*)
FitnessData /: HoldPattern @ GeoGraphics[
    fd_FitnessData? FitnessDataQ,
    opts: OptionsPattern[ ]
] := catchTop @ fitnessDataGeoGraphics[ fd, opts ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitnessDataGeoGraphics*)
fitnessDataGeoGraphics // beginDefinition;

fitnessDataGeoGraphics[ fd_, opts: OptionsPattern[ ] ] :=
    fitnessDataGeoGraphics[ fd, GeoPosition @ fd, opts ];

fitnessDataGeoGraphics[ fd_, _Missing, opts: OptionsPattern[ ] ] :=
    Missing[ "NotAvailable" ];

fitnessDataGeoGraphics[ fd_, pos_GeoPosition, opts: OptionsPattern[ ] ] :=
    GeoGraphics[ { Thick, Red, Line @ pos }, opts ];

fitnessDataGeoGraphics // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*GeoPosition*)
FitnessData /: HoldPattern @ GeoPosition[ fd_FitnessData? FitnessDataQ ] :=
    catchTop @ fitnessDataGeoPosition @ fd;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitnessDataGeoPosition*)
fitnessDataGeoPosition // beginDefinition;

fitnessDataGeoPosition[ fd_ ] :=
    fitnessDataGeoPosition[ fd, fd[ "GeoPosition" ] ];

fitnessDataGeoPosition[ fd_, _Missing ] :=
    Missing[ "NotAvailable" ];

fitnessDataGeoPosition[ fd_, ts: _TemporalData|_TimeSeries ] :=
    Module[ { values },
        values = DeleteMissing @ Values @ ts;
        GeoPosition @ values /; MatchQ[ values, { __GeoPosition } ]
    ];

fitnessDataGeoPosition // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Formatting*)
FitnessData /: MakeBoxes[ FitnessData[ info_Association ]? sp`HoldValidQ, fmt_ ] :=
    catchFormattingTop[ makeFitnessDataBoxes[ info, fmt ], fmt ];

FitnessData /: Format[ FitnessData[ info_Association ]? sp`HoldValidQ, InputForm ] :=
    catchFormattingTop[
        OutputForm @ StringJoin[
            ToString @ FitnessData,
            "[",
            ToString[ smooshDataForBoxes @ info, InputForm ],
            "]"
        ],
        InputForm
    ];

FitnessData /: Format[ FitnessData[ info_Association ]? sp`HoldValidQ, OutputForm ] /; ! smooshedDataQ @ info :=
    catchFormattingTop[ makeFitnessDataOutputForm @ info, OutputForm ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*makeFitnessDataBoxes*)
makeFitnessDataBoxes // beginDefinition;

makeFitnessDataBoxes[ info_, fmt_ ] :=
    With[
        {
            summary  = getSummaryDataForBoxes @ info,
            smooshed = smooshDataForBoxes @ info,
            type     = info[ "Type" ]
        },
        BoxForm`ArrangeSummaryBox[
            FitnessData,
            Unevaluated @ FitnessData @ smooshed,
            makeFitnessIcon[ type, info ],
            makeSummaryRows[ type, info, summary, fmt ],
            makeHiddenSummaryRows[ type, info, summary, fmt ],
            fmt
        ]
    ];

makeFitnessDataBoxes // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*getSummaryDataForBoxes*)
getSummaryDataForBoxes // beginDefinition;
getSummaryDataForBoxes[ KeyValuePattern[ "SummaryData" -> data_Association ] ] := getSummaryDataForBoxes0 @ data;
getSummaryDataForBoxes[ _Association ] := <| |>;
getSummaryDataForBoxes // endDefinition;

getSummaryDataForBoxes0 // beginDefinition;

getSummaryDataForBoxes0[
    as: KeyValuePattern @ { "Sport" -> sport_String, "SubSport" -> sub_String }
] := getSummaryDataForBoxes0 @ KeyDrop[
    Insert[ as, "Sport" -> sportString[ sport, sub ], Key[ "Sport" ] ],
    "SubSport"
];

getSummaryDataForBoxes0[ data_Association ] :=
    Select[ KeyDrop[ data, $nonSummaryKeys ], nonZeroValueQ ];

getSummaryDataForBoxes0 // endDefinition;



$nonSummaryKeys = { "Course" };


sportString // beginDefinition;
sportString[ sport_String, "Generic"|"All"|"None" ] := sport;
sportString[ sport_String, "VirtualActivity" ] := sport <> " (Virtual)";
sportString[ sport_String, sub_String ] := sport <> " ("<>StringDelete[sub, sport~~EndOfString]<>")";
sportString // endDefinition;



nonZeroValueQ // ClearAll;
nonZeroValueQ[ 0 | 0.0 ] := False;
nonZeroValueQ[ Quantity[ m_, _ ] ] := nonZeroValueQ @ m;
nonZeroValueQ[ ___ ] := True;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*makeSummaryRows*)
makeSummaryRows // beginDefinition;

makeSummaryRows[ type_, info_, summary_Association, fmt_ ] := Flatten @ {
    summaryItem[ "Type", type ],
    KeyValueMap[ summaryItem, Take[ summary, UpTo[ 1 ] ] ]
};

makeSummaryRows // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*makeHiddenSummaryRows*)
makeHiddenSummaryRows // beginDefinition;

makeHiddenSummaryRows[ type_, info_Association, summary_Association, fmt_ ] /; Length @ summary < 2 :=
    Flatten @ {
        KeyValueMap[ summaryItem, Drop[ summary, UpTo[ 1 ] ] ],
        summaryItem[ "MessageCount", info[ "Count" ] ],
        summaryItem[ "DataSize", bytesToQuantity @ ByteCount @ info[ "Data" ] ]
    };

makeHiddenSummaryRows[ type_, info_Association, summary_Association, fmt_ ] :=
    KeyValueMap[ summaryItem, Drop[ summary, UpTo[ 1 ] ] ];

makeHiddenSummaryRows // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*summaryItem*)
summaryItem // beginDefinition;
summaryItem[ label_, Missing[ "UnknownType", n_Integer ] ] := summaryItem[ label, "Unknown (" <> ToString @ n <> ")" ];
summaryItem[ _, _Missing ] := Nothing;
summaryItem[ label_, value_ ] := { BoxForm`SummaryItem @ { niceLabel @ label, niceValue @ value } };
summaryItem // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*niceLabel*)
niceLabel // beginDefinition;
niceLabel[ label_String ] := StringJoin[ niceValue @ label, ": " ];
niceLabel // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*niceValue*)
niceValue // beginDefinition;

niceValue[ Quantity[ MixedMagnitude[ { m1_, m2_, __ } ], MixedUnit[ { u1_, u2_, __ } ] ] ] :=
    niceValue @ Quantity[ MixedMagnitude @ { m1, m2 }, MixedUnit @ { u1, u2 } ];

niceValue[ Quantity[ MixedMagnitude[ { m1_, m2_ } ], MixedUnit[ { u_, _ } ] ] ] /; m2 < 0.01 :=
    niceValue @ Quantity[ m1, u ];

niceValue[ q: Quantity[ _, _MixedUnit ] ] := TextString @ Round @ q;
niceValue[ q: Quantity[ m_Real, _ ] ] /; Abs[ IntegerPart @ m - m ] < 0.01 := TextString @ Round @ q;
niceValue[ q: Quantity[ m_Real, _ ] ] /; m < 1 := TextString @ Round[ q, .001 ];
niceValue[ q: Quantity[ m_Real, _ ] ] /; m > 100 := TextString @ Round @ q;
niceValue[ q: Quantity[ m_Real, _ ] ] := TextString @ Round[ q, .1 ];
niceValue[ q: Quantity[ _Integer, _ ] ] := TextString @ q;
niceValue[ q: Quantity[ m_, _ ] ] := TextString @ Round[ q, .1 ];
niceValue[ date_DateObject ] := DateString @ date;
niceValue[ m_Real ] /; Abs[ IntegerPart @ m - m ] < 0.01 := TextString @ Round @ m;
niceValue[ m_Real ] /; m < 1 := TextString @ Round[ m, .001 ];
niceValue[ m_Real ] /; m > 100 := TextString @ Round @ m;
niceValue[ m_Real ] := TextString @ Round[ m, .1 ];

niceValue[ pos_GeoPosition ] := TextString @ pos;

niceValue[ str_String ] :=
    FixedPoint[
        StringReplace @ {
            "  " -> " ",
            a: $upperCaseLetters ~~ " " ~~ b: $upperCaseLetters :> a <> b,
            "( " ~~ a: $upperCaseLetters :> "("<>a
        },
        StringTrim @ StringReplace[ str, x: $upperCaseLetters :> " " <> x ]
    ];

niceValue[ other_ ] := other;

niceValue // endDefinition;


$upperCaseLetters = CharacterRange[ "A", "Z" ];
$lowerCaseLetters = CharacterRange[ "a", "z" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*makeFitnessIcon*)
makeFitnessIcon // beginDefinition;

makeFitnessIcon[ "Course", info_ ] :=
    With[ { icon = makeCourseIcon @ info },
        icon /; ! MissingQ @ icon
    ];

makeFitnessIcon[ type_, info_ ] :=
    makeFitnessIcon[
        type,
        info,
        info[ "SummaryData", "Sport" ],
        info[ "SummaryData", "SubSport" ]
    ];

makeFitnessIcon[ type_, info_, sport_String, sub_ ] :=
    With[ { icon = $fitIcons[ "Sport", sport ] },
        icon /; ! MissingQ @ icon
    ];

makeFitnessIcon[ type_, info_, sport_, sub_ ] :=
    With[ { icon = $fitIcons[ "Type", type ] },
        icon /; ! MissingQ @ icon
    ];

makeFitnessIcon[ Missing[ "UnknownType", _Integer ], info_, sport_, sub_ ] :=
    $fitIcons[ "Type", None ];

makeFitnessIcon[ type_, info_, sport_, sub_ ] :=
    $fitIcons[ "Sport", "All" ];

makeFitnessIcon // endDefinition;


makeCourseIcon // ClearAll;

makeCourseIcon[ as_Association ] := makeCourseIcon[ as, as[ "SummaryData", "Course" ] ];

makeCourseIcon[ as_, course: GeoPosition[ pos_ ] ] /; Length @ pos > 1 :=
    GeoGraphics[ { Gray, Line @ course }, GeoBackground -> None ];

makeCourseIcon[ ___ ] := Missing[ "NotAvailable" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*smooshDataForBoxes*)
smooshDataForBoxes // beginDefinition;

smooshDataForBoxes[ as: KeyValuePattern[ "Data" -> _String ] ] := as;

smooshDataForBoxes[ as: KeyValuePattern[ "Data" -> data_ ] ] := Append[
    as,
    "Data" -> BaseEncode @ BinarySerialize[ data, PerformanceGoal -> "Size" ]
];

smooshDataForBoxes // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*unsmooshData*)
unsmooshData // beginDefinition;
unsmooshData[ data_String ] := BinaryDeserialize @ BaseDecode @ data;
unsmooshData // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*makeFitnessDataInputForm*)
makeFitnessDataInputForm // beginDefinition;
makeFitnessDataInputForm[ as_ ] := smooshDataForBoxes @ as;
makeFitnessDataInputForm // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*bytesToQuantity*)
bytesToQuantity // ClearAll;
bytesToQuantity := bytesToQuantity = ResourceFunction[ "BytesToQuantity", "Function" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*FitnessDataQ*)
FitnessDataQ // beginDefinition;
FitnessDataQ[ _FitnessData? sp`HoldValidQ ] := True;
FitnessDataQ[ ___ ] := False;
FitnessDataQ // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
