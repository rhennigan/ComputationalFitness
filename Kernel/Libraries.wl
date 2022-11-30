(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`" ];

Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Definitions*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$thisPacletLocation*)
$thisPacletLocation := $thisPacletLocation =
    PacletObject[ "RH/ComputationalFitness" ][ "Location" ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$libraryFile*)
$libraryFile :=
    If[ FileExistsQ @ $libraryFile0,
        $libraryFile0,
        compileOnDemand[ ]
    ];

$libraryFile0 := $libraryFile0 = FileNameJoin @ {
    $thisPacletLocation,
    "LibraryResources",
    $SystemID,
    "ComputationalFitness." <> Internal`DynamicLibraryExtension[ ]
};

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$sourceDir*)
$sourceDir := $sourceDir = FileNameJoin @ { $thisPacletLocation, "Source" };

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*compileOnDemand*)
compileOnDemand // beginDefinition;

compileOnDemand[ ] := compileOnDemand[ $SystemID, $libraryFile0 ];

compileOnDemand[ id_, file_ ] :=
    Module[ { files, tgt, built },
        messageFailure[ FITImport::CompileOnDemand, id ];
        Needs[ "CCompilerDriver`" -> None ];
        files = FileNames[
            {
                "fit_import.c",
                "fit.c",
                "fit_crc.c",
                "fit_example.c",
                "fit_convert.c"
            },
            $sourceDir
        ];
        tgt   = DirectoryName @ file;
        built = CCompilerDriver`CreateLibrary[
            files,
            "ComputationalFitness",
            "TargetDirectory"   -> tgt,
            "CleanIntermediate" -> True
        ];
        If[ FileExistsQ @ built,
            built,
            throwFailure[ FITImport::CompileFailure, id ]
        ]
    ];

compileOnDemand // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
