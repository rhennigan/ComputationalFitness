(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RickHennigan`ComputationalFitness`FIT`" ];
Needs[ "RickHennigan`ComputationalFitness`" ];
Needs[ "RickHennigan`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*File Types*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitFileTypeQ*)
fitFileTypeQ // ClearAll;
fitFileTypeQ[ type_String ] := MemberQ[ $fileTypes, type ];
fitFileTypeQ[ ___ ] := False;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Raw Message Data*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*rawDataQ*)
rawDataQ // ClearAll;
rawDataQ[ { { } }  ] := False;
rawDataQ[ raw_List ] := MatrixQ[ raw, IntegerQ ];
rawDataQ[ ___      ] := False;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*selectMessageType*)
selectMessageType // beginDefinition;

selectMessageType[ data_, type_String ] :=
    selectMessageType[ data, fitMessageTypeNumber @ type ];

selectMessageType[ data_, type_Integer ] :=
    Developer`ToPackedArray @ Select[ data, #[[ 1 ]] === type & ];

selectMessageType[ data_, type_ ] :=
    With[ { p = type /. s_String :> RuleCondition @ fitMessageTypeNumber @ s },
        Developer`ToPackedArray @ Select[ data, MatchQ[ #[[ 1 ]], p ] & ]
    ];

selectMessageType // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*selectFirstMessageType*)
selectFirstMessageType // beginDefinition;

selectFirstMessageType[ data_, type_String ] :=
    selectFirstMessageType[ data, fitMessageTypeNumber @ type ];

selectFirstMessageType[ data_, type_Integer ] :=
    FirstCase[ data, { type, ___ } ];

selectFirstMessageType // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Message Types*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitMessageType*)
fitMessageType // beginDefinition;
fitMessageType[ v_List ] := fitMessageType @ v[[ 1 ]];
fitMessageType[ n_Integer ] := Lookup[ $fitMessageTypes, n, "UNKNOWN" ];
fitMessageType // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$fitMessageTypes*)
$fitMessageTypes = Association[
    $enumTypeData[ "MessageNumber" ],
    65535      -> "Invalid",
    1768842863 -> "MessageInformation"
];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*unsupportedMessageTypeQ*)
unsupportedMessageTypeQ[ type_ ] := MemberQ[ $unsupportedMessageTypes, type ];
unsupportedMessageTypeQ[ ___ ] := False;

$unsupportedMessageTypes = Complement[ Values @ $fitMessageTypes, $supportedMessageTypes ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMessageTypeNumber*)
fitMessageTypeNumber // beginDefinition;

fitMessageTypeNumber[ "Events"  ] := fitMessageTypeNumber[ "Event"  ];
fitMessageTypeNumber[ "Records" ] := fitMessageTypeNumber[ "Record" ];
fitMessageTypeNumber[ "Laps"    ] := fitMessageTypeNumber[ "Lap"    ];

fitMessageTypeNumber[ type_String ] :=
    With[ { n = $fitMessageTypeNumbers[ type ] }, n /; IntegerQ @ n ];

fitMessageTypeNumber // endDefinition;

$fitMessageTypeNumbers = AssociationMap[ Reverse, $fitMessageTypes ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
