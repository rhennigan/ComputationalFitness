(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`FIT`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Main definition*)
FITFileType[ file_, opts: OptionsPattern[ ] ] :=
    catchTopAs[ FITFileType ] @ fitFileType @ file;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitFileType*)
fitFileType // beginDefinition;

fitFileType[ source: $$source ] :=
    Block[ { $tempFiles = Internal`Bag[ ] },
        WithCleanup[
            fitFileType[ source, toFileString @ source ],
            DeleteFile /@ Internal`BagPart[ $tempFiles, All ]
        ]
    ];

fitFileType[ source_, file_String ] :=
    fitFileType[
        source,
        file,
        Quiet[ fitFileTypeLibFunction @ file, LibraryFunction::rterr ]
    ];

fitFileType[ source_, file_, type_Integer ] := fitFile @ type;

fitFileType[ source_, file_, err_LibraryFunctionError ] :=
    libraryError[ source, file, err ];

fitFileType // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
