(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`TCX`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Config*)

(* ::**************************************************************************************************************:: *)
(* ::Section:: *)
(*Messages*)
TCXImport::Internal =
"An unexpected error occurred. `1`";

TCXImport::InvalidXML =
"Cannot import data as TCX format.";

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Options*)
TCXImport // Options = { UnitSystem :> $UnitSystem };

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Main Definition*)
TCXImport[ file_, opts: OptionsPattern[ ] ] :=
    tcxOptionsBlock[ tcxImport @ file, opts ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*tcxImport*)
tcxImport // beginDefinition;
tcxImport[ file_? FileExistsQ ] := parseTCXDataset[ file, importXML @ file ];
tcxImport // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*parseTCXDataset*)
parseTCXDataset // beginDefinition;

parseTCXDataset[ file_, xml: XMLObject[ _ ][ ___ ] ] :=
    Module[ { tp },
        tp = parseTrackpoints @ xml;
        If[ MatchQ[ tp, { __Association } ],
            Dataset @ tp,
            throwFailure[ TCXImport::InvalidTCX, file ]
        ]
    ];

parseTCXDataset // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Dependencies*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*parseTrackpoints*)
parseTrackpoints // beginDefinition;

parseTrackpoints[ xml_ ] :=
    Cases[
        xml,
        XMLElement[ "Trackpoint", _, tp_ ] :>
            Association @ Flatten[ parseTPElement /@ Flatten @ { tp } ],
        Infinity
    ];

parseTrackpoints // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*parseTPElement*)
parseTPElement // beginDefinition;

parseTPElement[ XMLElement[ "Time", _, { time_String } ] ] :=
    "Timestamp" -> DateObject @ time;

parseTPElement[ XMLElement[ "DistanceMeters", _, { meters_String } ] ] :=
    "Distance" -> tpMeters @ ToExpression @ meters;

parseTPElement[ XMLElement[ "HeartRateBpm", _, { XMLElement[ "Value", _, { bpm_String } ] } ] ] :=
    "HeartRate" -> Quantity[ ToExpression @ bpm, "Beats" / "Minutes" ];

parseTPElement[ XMLElement[ "Cadence", { }, { cad_String } ] ] :=
    "Cadence" -> Quantity[ ToExpression @ cad, "Revolutions" / "Minutes" ];

parseTPElement[ XMLElement[ "Extensions", _, extensions_ ] ] :=
    parseTPExtensions @ extensions;

parseTPElement // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*parseTPExtensions*)
parseTPExtensions // beginDefinition;
parseTPExtensions[ ext_List ] := parseTPExtension /@ ext;
parseTPExtensions // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*parseTPExtension*)
parseTPExtension // beginDefinition;
parseTPExtension[ XMLElement[ "TPX", attr_, tpx_ ] ] := parseTPX @ tpx;
parseTPExtension // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*parseTPX*)
parseTPX // beginDefinition;
parseTPX[ tpx_List ] := parseTPXElement /@ tpx;
parseTPX // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*parseTPXElement*)
parseTPXElement // beginDefinition;

parseTPXElement[ XMLElement[ "Speed", { }, { s_String } ] ] :=
    "Speed" -> tpMetersPerSeconds @ ToExpression @ s;

parseTPXElement[ XMLElement[ "Watts", { }, { s_String } ] ] :=
    "Power" -> Quantity[ ToExpression @ s, "Watts" ];

parseTPXElement[ XMLElement[ "Resistance", { }, { s_String } ] ] :=
    "Resistance" -> ToExpression @ s;

parseTPXElement[ xml: XMLElement[ name_String, { }, { s_String } ] ] := name -> s;

parseTPXElement[ xml: XMLElement[ name_String, __ ] ] := name -> xml;

parseTPXElement // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*tpMeters*)
tpMeters // beginDefinition;
tpMeters[ m: _Real|_Integer ] := tpMeters[ m, $UnitSystem ];
tpMeters[ m_, "Imperial"    ] := Quantity[ 0.000621371 m, "Miles"  ];
tpMeters[ m_, _             ] := Quantity[ 1.0 * m      , "Meters" ];
tpMeters // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*tpMetersPerSeconds*)
tpMetersPerSeconds // beginDefinition;
tpMetersPerSeconds[ m: _Real|_Integer ] := tpMetersPerSeconds[ m, $UnitSystem ];
tpMetersPerSeconds[ m_, "Imperial"    ] := Quantity[ 2.23694 m, "Miles"/"Hours"    ];
tpMetersPerSeconds[ m_, _             ] := Quantity[ 1.0 * m  , "Meters"/"Seconds" ];
tpMetersPerSeconds // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*tcxOptionsBlock*)
tcxOptionsBlock // beginDefinition;

tcxOptionsBlock[ eval_, opts: OptionsPattern[ TCXImport ] ] :=
    catchTopAs[ TCXImport ] @ Block[
        {
            $UnitSystem     = OptionValue @ UnitSystem,
            tcxOptionsBlock = # &
        },
        eval
    ];

tcxOptionsBlock // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
