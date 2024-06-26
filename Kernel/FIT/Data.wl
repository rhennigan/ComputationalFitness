(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RickHennigan`ComputationalFitness`FIT`" ];
Needs[ "RickHennigan`ComputationalFitness`" ];
Needs[ "RickHennigan`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*$FITMessageDefinitions*)
$FITMessageDefinitions = getDataFile[ "FITMessageDefinitions" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Other Data*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$fitConfig*)
$fitConfig     = getDataFile[ "FITConfig" ];
$fitInitValues = $fitConfig[ "InitializationValues" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$fitIndex*)

fieldPosition // beginDefinition;
fieldPosition[ KeyValuePattern[ "Index" -> idx_ ] ] := fieldPosition @ idx;
fieldPosition[ a_ ;; ___ ] := a;
fieldPosition[ a_ ] := a;
fieldPosition // endDefinition;
fieldPosition // excludeFromMX;

$fitIndex = SortBy[ fieldPosition ] /@ $FITMessageDefinitions[[ All, "Fields", All, "Index" ]];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$enumTypeData*)
$enumTypeData  = getDataFile[ "FITEnumData" ];
$iEnumTypeData = AssociationMap @ Reverse /@ $enumTypeData;

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
