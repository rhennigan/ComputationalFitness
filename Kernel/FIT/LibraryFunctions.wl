(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`FIT`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Messages*)

ComputationalFitness::CompileOnDemand =
"ComputationalFitness does not include compiled libraries for the system ID \
\"`1`\". Attempting to compile a library from sources...";

ComputationalFitness::CompileFailure =
"Unable to compile a library for the system ID \"`1`\".";

ComputationalFitness::CloudLibraryFunction =
"ComputationalFitness is not supported in the cloud.";

ComputationalFitness::LibraryFunctionLoadFail =
"Could not load the library function \"`1`\".";

ComputationalFitness::LibraryError =
"Encountered an internal library error: `1`";

ComputationalFitness::LibraryErrorConversion =
"Invalid FIT format: `1`";

ComputationalFitness::LibraryErrorUnexpectedEOF =
"Encountered an unexpected end of file in `1`.";

ComputationalFitness::LibraryErrorUnsupportedProtocol =
"Library error: FIT_IMPORT_ERROR_UNSUPPORTED_PROTOCOL (`1`).";

ComputationalFitness::LibraryErrorInternal =
"Library error: FIT_IMPORT_ERROR_INTERNAL (`1`). `4`";

ComputationalFitness::LibraryErrorOpenFile =
"Cannot read from file `2`. Check permissions and try again.";

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Library Functions*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitImportLibFunction*)
If[ MatchQ[ fitImportLibFunction, _LibraryFunction ],
    Quiet[ LibraryFunctionUnload @ fitImportLibFunction,
           LibraryFunction::nofun
    ]
];

fitImportLibFunction // ClearAll;
fitImportLibFunction := libraryFunctionLoad[
    $libraryFile,
    "FITImport",
    { String },
    { Integer, 2 }
];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitExportLibFunction*)
If[ MatchQ[ fitExportLibFunction, _LibraryFunction ],
    Quiet[ LibraryFunctionUnload @ fitExportLibFunction,
           LibraryFunction::nofun
    ]
];

fitExportLibFunction // ClearAll;
fitExportLibFunction := libraryFunctionLoad[
    $libraryFile,
    "FITExport",
    { String, { Integer, 2 } },
    { Integer }
];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitMessageTypesLibFunction*)
If[ MatchQ[ fitMessageTypesLibFunction, _LibraryFunction ],
    Quiet[ LibraryFunctionUnload @ fitMessageTypesLibFunction,
           LibraryFunction::nofun
    ]
];

fitMessageTypesLibFunction // ClearAll;
fitMessageTypesLibFunction := libraryFunctionLoad[
    $libraryFile,
    "FITMessageTypes",
    { String },
    { Integer, 2 }
];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitFileTypeLibFunction*)
If[ MatchQ[ fitFileTypeLibFunction, _LibraryFunction ],
    Quiet[ LibraryFunctionUnload @ fitFileTypeLibFunction,
           LibraryFunction::nofun
    ]
];

fitFileTypeLibFunction // ClearAll;
fitFileTypeLibFunction := libraryFunctionLoad[
    $libraryFile,
    "FITFileType",
    { String },
    { Integer }
];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Utilities*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*libraryFunctionLoad*)
libraryFunctionLoad // ClearAll;
libraryFunctionLoad[ args___ ] := libraryFunctionLoad0[ $SessionID, args ];


libraryFunctionLoad0 // beginDefinition;

libraryFunctionLoad0[ id_Integer, file_, a___ ] :=
    libraryFunctionLoad0[ id, file, a ] =
        Quiet[
            Check[
                LibraryFunctionLoad[ file, a ],
                If[ $CloudEvaluation,
                    throwFailure[ "CloudLibraryFunction" ],
                    throwFailure[ "LibraryFunctionLoadFail", file ]
                ],
                LibraryFunction::noopen
            ],
            LibraryFunction::noopen
        ];

libraryFunctionLoad0 // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*libraryError*)
libraryError // beginDefinition;

libraryError[
    source_,
    file_,
    LibraryFunctionError[ "LIBRARY_USER_ERROR", code_ ]
] := libraryUserError[ source, file, code ];

libraryError[ source_, file_, err_LibraryFunctionError ] :=
    throwFailure[ "LibraryError", err ];

libraryError // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*libraryUserError*)
libraryUserError // beginDefinition;

libraryUserError[ source_, file_, n_Integer ] :=
    With[ { tag = Lookup[ $libraryErrorCodes, n ] },
        throwFailure[
            tag,
            source,
            file,
            n,
            $bugReportLink
        ] /; IntegerQ @ n
    ];

libraryUserError // endDefinition;

$libraryErrorCodes = <|
    8  -> "LibraryErrorConversion",
    9  -> "LibraryErrorUnexpectedEOF",
    10 -> "LibraryErrorConversion",
    11 -> "LibraryErrorUnsupportedProtocol",
    12 -> "LibraryErrorInternal",
    13 -> "LibraryErrorOpenFile"
|>;

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
        messageFailure[ "CompileOnDemand", id ];
        Needs[ "CCompilerDriver`" -> None ];
        files = FileNames[
            {
                "fit_import.c",
                "fit_export.c",
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
            throwFailure[ "CompileFailure", id ]
        ]
    ];

compileOnDemand // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
