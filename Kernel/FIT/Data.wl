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
(* ::Subsection::Closed:: *)
(*$fileTypes*)
$fileTypes = Keys @ KeyDrop[
    $iEnumTypeData[ "File" ],
    {
        "ManufacturerRangeMinimum",
        "ManufacturerRangeMaximum",
        Missing[ "Invalid" ]
    }
];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
