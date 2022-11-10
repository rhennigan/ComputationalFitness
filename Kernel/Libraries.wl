(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`FitnessData`" ];

Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Definitions*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$thisPacletLocation*)
$thisPacletLocation := $thisPacletLocation =
    PacletObject[ "RH/FitnessData" ][ "Location" ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$libraryFile*)
$libraryFile := $libraryFile = FileNameJoin @ {
    $thisPacletLocation,
    "LibraryResources",
    $SystemID,
    "FitnessData." <> Internal`DynamicLibraryExtension[ ]
};

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
