(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RickHennigan`ComputationalFitness`" ];
Needs[ "RickHennigan`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Definitions*)
$dataDirectory = FileNameJoin @ { DirectoryName[ $InputFileName, 2 ], "Data" };
$dataDirectory // excludeFromMX;

(* ::**************************************************************************************************************:: *)
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
getDataFile // excludeFromMX;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
