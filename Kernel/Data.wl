(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Definitions*)
$dataDirectory = FileNameJoin @ { DirectoryName[ $InputFileName, 2 ], "Data" };

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*getDataFile*)
getDataFile // beginDefinition;

getDataFile[ name_String ] :=
    With[ { wxf = FileNameJoin @ { $dataDirectory, name <> ".wxf" } },
        If[ FileExistsQ @ wxf,
            Developer`ReadWXFFile @ wxf,
            Get @ FileNameJoin @ { $dataDirectory, name <> ".wl" }
        ]
    ];

getDataFile // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
