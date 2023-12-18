(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RickHennigan`ComputationalFitness`FIT`" ];
Needs[ "RickHennigan`ComputationalFitness`" ];
Needs[ "RickHennigan`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*FITFormatQ*)
FITFormatQ[ file_String? FileExistsQ ] := fitFormatQ @ file;
FITFormatQ[ file_String? FileExistsQ, type_ ] := FITFileType @ file === type;

(* TODO: define for $$source *)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitFormatQ*)
fitFormatQ // beginDefinition;

fitFormatQ[ file_String ] :=
    fitFormatQ[ file, Streams @ ExpandFileName @ file ];

fitFormatQ[ file_, { } ] :=
    fitFormatQ0 @ file;

fitFormatQ[ file_, { stream_InputStream } ] :=
    Module[ { pos, bytes },
        PreemptProtect @ WithCleanup[
            pos = StreamPosition @ stream;
            SetStreamPosition[ stream, 0 ]
            ,
            bytes = ReadByteArray[ file, 12 ]
            ,
            SetStreamPosition[ stream, pos ]
        ];
        fitFormatBytesQ @ bytes
    ];

fitFormatQ // endDefinition;


fitFormatQ0 // beginDefinition;

fitFormatQ0[ file_ ] :=
    fitFormatBytesQ @ WithCleanup[ ReadByteArray[ file, 12 ], Close @ file ];

fitFormatQ0 // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFormatBytesQ*)
fitFormatBytesQ // beginDefinition;

fitFormatBytesQ[ bytes_ByteArray ] :=
    Length @ bytes >= 12 && Normal @ bytes[[ 9;;12 ]] === { 46, 70, 73, 84 };

fitFormatBytesQ[ _ ] := False;

fitFormatBytesQ // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*FITFileType*)
FITFileType[ FitnessData[ KeyValuePattern[ "Type" -> type_ ] ] ] := type;
FITFileType[ file: $$source, opts: OptionsPattern[ ] ] := catchMine @ sourceFileApply[ fitFileType, file ];
FITFileType[ ___ ] := $Failed; (* TODO *)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitFileType*)
fitFileType // beginDefinition;

fitFileType[ source_, file_String ] :=
    fitFileType[
        source,
        file,
        Quiet[ fitFileTypeLibFunction @ file, LibraryFunction::rterr ]
    ];

fitFileType[ source_, file_, type_Integer ] :=
    Replace[ fitFile @ type, _Missing :> Missing[ "UnknownType", type ] ];

fitFileType[ source_, file_, err_LibraryFunctionError ] :=
    libraryError[ source, file, err ];

fitFileType // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
