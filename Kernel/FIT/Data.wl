(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`FIT`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*$FITMessageDefinitions*)
$FITMessageDefinitions = Get @ FileNameJoin @ {
    DirectoryName[ $InputFileName, 3 ],
    "Data",
    "FITMessageDefinitions.wl"
};

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Other Data*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$fitConfig*)
$fitConfig = Get @ FileNameJoin @ {
    DirectoryName[ $InputFileName, 3 ],
    "Data",
    "FITConfig.wl"
};

$fitInitValues = $fitConfig[ "InitializationValues" ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$fitIndex*)

fieldPosition // beginDefinition;
fieldPosition[ KeyValuePattern[ "Index" -> idx_ ] ] := fieldPosition @ idx;
fieldPosition[ a_ ;; ___ ] := a;
fieldPosition[ a_ ] := a;
fieldPosition // endDefinition;

$fitIndex = SortBy[ fieldPosition ] /@ $FITMessageDefinitions[[ All, "Fields", All, "Index" ]];

If[ $debug,
    Module[ { names, unsupported },
        names       = Keys @ $fitIndex;
        unsupported = Complement[ names, $supportedMessageTypes ];
        If[ MatchQ[ unsupported, { __ } ],
            messagePrint[
                "UnsupportedMessageTypes",
                HoldForm @ Evaluate @ unsupported
            ]
        ]
    ]
];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$enumTypeData*)
$enumTypeData = Get @ FileNameJoin @ {
    DirectoryName[ $InputFileName, 3 ],
    "Data",
    "FITEnumData.wl"
};

$iEnumTypeData = AssociationMap @ Reverse /@ $enumTypeData;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
