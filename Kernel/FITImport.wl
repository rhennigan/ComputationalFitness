(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`FitnessData`" ];

Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*FITImport*)
FITImport[ file_? FileExistsQ ] := fitImport @ ExpandFileName @ file;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitImport*)
fitImport := fitImport = LibraryFunctionLoad[
    $libraryFile,
    "FITImport",
    { String },
    { Integer, 2 }
];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
