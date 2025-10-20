(* TODO:
    * move this file to main context
    * create a MaximalMeanPowerCurve function that uses meanMaximalPowerCurveLibFunction
*)

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RickHennigan`ComputationalFitness`" ];
Needs[ "RickHennigan`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
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

ComputationalFitness::LibraryErrorNoFileID =
"No FileID message found in `1`.";

ComputationalFitness::CompiledCodeFunctionRecompileFile =
"Could not recompile the library file at `1` due to a privilege violation. \
Try restarting the kernel and try again.";

ComputationalFitness::CompiledCodeFunctionFileFailure =
"Could not load the compiled code function \"`1`\" from `2`. Attempting to recompile...";

ComputationalFitness::CompiledCodeFunctionFailure =
"Could not load the compiled code function \"`1`\".";

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Library Functions*)
$$libraryFunction      = HoldPattern[ _LibraryFunction      ];
$$compiledCodeFunction = HoldPattern[ _CompiledCodeFunction ];
$$compiledFunction     = $$libraryFunction|$$compiledCodeFunction|_CompiledFunction;

$compiledFunctions = <|
    "FITExport"             :> fitExportLibFunction,
    "FITFileType"           :> fitFileTypeLibFunction,
    "FITImport"             :> fitImportLibFunction,
    "FITMessageTypes"       :> fitMessageTypesLibFunction,
    "FITUsableColumns"      :> usableFITColumnsLibFunction,
    "MaximalMeanPowerCurve" :> meanMaximalPowerCurveLibFunction,
    "PairwiseMax"           :> pairwiseMaxLibFunction
|>;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*compiledFunction*)
compiledFunction // beginDefinition;
compiledFunction[ name_String ] := compiledFunction @ Lookup[ $compiledFunctions, name ];
compiledFunction[ cf: $$compiledFunction ] := cf;
compiledFunction // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*libraryFunctionUnload*)
libraryFunctionUnload // beginDefinition;
libraryFunctionUnload[ ] := libraryFunctionUnload @ All;
libraryFunctionUnload[ All ] := libraryFunctionUnload @ $loadedLibraryFunctions;
libraryFunctionUnload[ HoldPattern[ $loadedLibraryFunctions ] ] := Null;
libraryFunctionUnload[ bag_Internal`Bag ] := libraryFunctionUnload /@ Internal`BagPart[ bag, All ];
libraryFunctionUnload[ ccf: $$compiledCodeFunction ] := libraryFunctionUnload0 @ ccf;
libraryFunctionUnload[ lf:  $$libraryFunction      ] := libraryFunctionUnload0 @ lf;
libraryFunctionUnload[ HoldPattern[ CompiledFunction ][ __, lf: $$libraryFunction ] ] := libraryFunctionUnload0 @ lf;
libraryFunctionUnload[ _CompiledFunction ] := Null;
libraryFunctionUnload // endDefinition;


libraryFunctionUnload0 // beginDefinition;

libraryFunctionUnload0[ func: $$compiledCodeFunction|$$libraryFunction ] :=
    Quiet[ LibraryFunctionUnload @ func, LibraryFunction::nofun ];

libraryFunctionUnload0 // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Unload Existing Functions*)
If[ MatchQ[ $loadedLibraryFunctions, _Internal`Bag ],
    libraryFunctionUnload /@ Internal`BagPart[ $loadedLibraryFunctions, All ]
];

$loadedLibraryFunctions // ClearAll;
$loadedLibraryFunctions := $loadedLibraryFunctions = Internal`Bag[ ];

tagLoadedLibraryFunction // ClearAll;
tagLoadedLibraryFunction[ f: $$compiledFunction ] := (Internal`StuffBag[ $loadedLibraryFunctions, f ]; f);
tagLoadedLibraryFunction[ f_ ] := f;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitImportLibFunction*)
fitImportLibFunction // ClearAll;
fitImportLibFunction := libraryFunctionLoad[
    $fitLibraryFile,
    "FITImport",
    { String },
    { Integer, 2 }
];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitExportLibFunction*)
fitExportLibFunction // ClearAll;
fitExportLibFunction := libraryFunctionLoad[
    $fitLibraryFile,
    "FITExport",
    { String, { Integer, 2 } },
    { Integer }
];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitMessageTypesLibFunction*)
fitMessageTypesLibFunction // ClearAll;
fitMessageTypesLibFunction := libraryFunctionLoad[
    $fitLibraryFile,
    "FITMessageTypes",
    { String },
    { Integer, 2 }
];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitFileTypeLibFunction*)
fitFileTypeLibFunction // ClearAll;
fitFileTypeLibFunction := libraryFunctionLoad[
    $fitLibraryFile,
    "FITFileType",
    { String },
    { Integer }
];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*usableFITColumnsLibFunction*)
usableFITColumnsLibFunction // ClearAll;
usableFITColumnsLibFunction := loadCompiledCodeFunction[ "FITUsableColumns" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*meanMaximalPowerCurveLibFunction*)
meanMaximalPowerCurveLibFunction // ClearAll;
meanMaximalPowerCurveLibFunction := loadCompiledCodeFunction[ "MeanMaximalPowerCurve" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*pairwiseMaxLibFunction*)
pairwiseMaxLibFunction // ClearAll;
pairwiseMaxLibFunction := loadCompiledCodeFunction[ "PairwiseMax" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*CompiledCodeFunctions*)
$compiledCodeFunctions // ClearAll;
$compiledCodeFunctions = <|
    "FITUsableColumns"      -> usableFITColumnsF,
    "MeanMaximalPowerCurve" -> meanMaximalPowerCurveF,
    "PairwiseMax"           -> pairwiseMaxF
|>;

$compiledCodeFunctionsBag // ClearAll;
$compiledCodeFunctionsBag := $compiledCodeFunctionsBag = Internal`Bag[ ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*autoCompileCodeFunctions*)
autoCompileCodeFunctions // beginDefinition;

autoCompileCodeFunctions[ ] := Enclose[
    ConfirmMatch[
        autoCompileCodeFunction /@ Keys @ $compiledCodeFunctions,
        { $$compiledFunction... }
    ];
    ConfirmMatch[
        Internal`BagPart[ $compiledCodeFunctionsBag, All ],
        { __? FileExistsQ }
    ]
];

autoCompileCodeFunctions // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*loadCompiledCodeFunction*)
loadCompiledCodeFunction // beginDefinition;

loadCompiledCodeFunction[ id_String ] := loadCompiledCodeFunction[ $SessionID, id ];

loadCompiledCodeFunction[ session_, id_String ] := loadCompiledCodeFunction[ session, id ] =
    Module[ { file, loaded },
        file   = compiledCodeFunctionFile @ id;
        loaded = If[ FileExistsQ @ file, libraryFunctionLoad @ file, autoCompileCodeFunction[ id, file ] ];
        loadCompiledCodeFunction0[ id, file, loaded ]
    ];

loadCompiledCodeFunction // endDefinition;


loadCompiledCodeFunction0 // beginDefinition;
loadCompiledCodeFunction0[ id_, file_, cf: _CompiledCodeFunction|_CompiledFunction ] := cf;

loadCompiledCodeFunction0[ id_, file_? FileExistsQ, _ ] :=
    Module[ { loaded },
        messageFailure[ "CompiledCodeFunctionFileFailure", id, file ];
        loaded = autoCompileCodeFunction[ id, file ];
        If[ MatchQ[ loaded, _CompiledCodeFunction|_CompiledFunction ],
            loaded,
            throwFailure[ "CompiledCodeFunctionFailure", id ]
        ]
    ];

loadCompiledCodeFunction0[ id_, file_, _ ] := throwFailure[ "CompiledCodeFunctionFailure", id ];
loadCompiledCodeFunction0 // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*autoCompileCodeFunction*)
autoCompileCodeFunction // beginDefinition;

autoCompileCodeFunction[ id_String ] :=
    autoCompileCodeFunction[ id, compiledCodeFunctionFile @ id ];

autoCompileCodeFunction[ id_String, file_String ] :=
    autoCompileCodeFunction[ id, file, Lookup[ $compiledCodeFunctions, id ] ];

autoCompileCodeFunction[ id_String, file_String, function_Function ] := Enclose[
    Module[ { compiled },
        GeneralUtilities`EnsureDirectory @ DirectoryName @ file;
        compiled = ConfirmBy[ functionCompileExportLibrary[ file, function ], FileExistsQ ];
        Internal`StuffBag[ $compiledCodeFunctionsBag, id -> compiled ];
        ConfirmMatch[ libraryFunctionLoad @ compiled, _CompiledCodeFunction ]
    ],
    compileLegacyCompiledFunction[ id, file, function ] &
];

autoCompileCodeFunction // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*functionCompileExportLibrary*)
functionCompileExportLibrary // beginDefinition;

functionCompileExportLibrary[ file_, function_ ] :=
    functionCompileExportLibrary[
        file,
        function,
        Check[
            FunctionCompileExportLibrary[ file, function ],
            Failure[
                "CompilerException",
                <|
                    "MessageTemplate" -> FunctionCompileExportLibrary::privv0,
                    "File"            -> File @ file
                |>
            ],
            { FunctionCompileExportLibrary::pathw, CopyFile::privv0 }
        ]
    ];

functionCompileExportLibrary[ file_, function_, compiled_? FileExistsQ ] :=
    compiled;

functionCompileExportLibrary[
    file_? FileExistsQ,
    function_,
    failure: Failure[
        "CompilerException",
        KeyValuePattern[ "MessageTemplate" -> FunctionCompileExportLibrary::privv0 ]
    ]
] := (
    (* warning/failure for bug(431466) *)
    If[ $recompileStrict, throwFailure[ "CompiledCodeFunctionRecompileFile", file ] ];
    If[ $debug, messagePrint[ "CompiledCodeFunctionRecompileFile", file ] ];
    file
);

functionCompileExportLibrary // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*compiledCodeFunctionFile*)
compiledCodeFunctionFile // beginDefinition;

compiledCodeFunctionFile[ id_String ] := FileNameJoin @ {
    $thisPacletLocation,
    "LibraryResources",
    $SystemID,
    id <> "." <> Internal`DynamicLibraryExtension[ ]
};

compiledCodeFunctionFile // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*compileLegacyCompiledFunction*)
compileLegacyCompiledFunction // beginDefinition;

compileLegacyCompiledFunction[ HoldPattern @ Function[ args_, body_ ] ] :=
    compileLegacyCompiledFunction[ makeCFArgs @ args, HoldComplete @ body ];

compileLegacyCompiledFunction[ Hold[ args___ ], HoldComplete[ body_ ] ] :=
    Compile[
        { args },
        body,
        Parallelization   -> True,
        RuntimeAttributes -> { Listable },
        RuntimeOptions    -> "Speed",
        CompilationTarget :> $legacyCompilationTarget
    ];

compileLegacyCompiledFunction // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*$legacyCompilationTarget*)
$legacyCompilationTarget // ClearAll;
$legacyCompilationTarget := $legacyCompilationTarget =
    If[ TrueQ @ $cCompilerAvailable,
        "C",
        "WVM"
    ];

$cCompilerAvailable // ClearAll;
$cCompilerAvailable := $cCompilerAvailable = Quiet @ MatchQ[
    Compile[ { }, 1, CompilationTarget -> "C" ],
    HoldPattern @ CompiledFunction[ __, _LibraryFunction ]
];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*makeCFArgs*)
makeCFArgs // beginDefinition;
makeCFArgs // Attributes = { HoldAllComplete };
makeCFArgs[ { args___ } ] := Flatten[ Hold @@ Evaluate[ makeCFArg /@ Unevaluated @ { args } ] ];
makeCFArgs[ arg_ ] := makeCFArgs @ { arg };
makeCFArgs // endDefinition;

makeCFArg // beginDefinition;
makeCFArg // Attributes = { HoldAllComplete };
makeCFArg[ Typed[ arg_, TypeSpecifier[ "PackedArray" ][ "MachineInteger", n_ ] ] ] := Hold @ { arg, _Integer, n };
makeCFArg[ Typed[ arg_, "MachineInteger" ] ] := Hold @ { arg, _Integer };
makeCFArg // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*usableFITColumnsF*)
usableFITColumnsF = Function[
    { Typed[ messages, TypeSpecifier[ "PackedArray" ][ "MachineInteger", 2 ] ] },
    Block[ { columns, col, len, j, first },
        If[ Length @ messages < 2,
            Table[ i, { i, Length @ messages[[ 1 ]] } ],
            columns = Transpose @ messages;
            Select[
                Table[
                    col   = columns[[ i ]];
                    len   = Length @ col;
                    j     = 2;
                    first = col[[ 1 ]];
                    While[ j <= len && Equal[ col[[ j ]], first ], j++ ];
                    If[ Equal[ j, len + 1 ], 0, i ],
                    { i, Length @ columns }
                ],
                #1 > 0 &
            ]
        ]
    ]
];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*meanMaximalPowerCurveF*)
meanMaximalPowerCurveF = Function[
    { Typed[ wattValues, "PackedArray"[ "Real64", 1 ] ] },
    Block[ { n, prefixSum, powerCurve },

        n = Length @ wattValues;
        prefixSum = Prepend[ Accumulate @ wattValues, 0.0 ];
        powerCurve = ConstantArray[ 0.0, n ];

        Do[
            Block[ { maxAvg = -1.0, sum, avg },

                Do[
                    sum = prefixSum[[ i + k + 1 ]] - prefixSum[[ i + 1 ]];
                    avg = sum / k;
                    If[ avg > maxAvg, maxAvg = avg ],
                    { i, 0, n - k }
                ];

                powerCurve[[ k ]] = maxAvg
            ],
            { k, 1, n }
        ];

        powerCurve
    ]
];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*pairwiseMaxF*)
pairwiseMaxF = Function[
    {
        Typed[ data1, "PackedArray"[ "Real64", 1 ] ],
        Typed[ data2, "PackedArray"[ "Real64", 1 ] ]
    },
    Block[ { len1, len2, min, max, data },
        len1 = Length @ data1;
        len2 = Length @ data2;
        min  = Min[ len1, len2 ];
        max  = Max[ len1, len2 ];
        data = ConstantArray[ 0.0, max ];
        Do[ data[[ i ]] = Max[ data1[[ i ]], data2[[ i ]] ], { i, min } ];
        If[ len1 > len2, Do[ data[[ i ]] = data1[[ i ]], { i, min + 1, max } ] ];
        If[ len2 > len1, Do[ data[[ i ]] = data2[[ i ]], { i, min + 1, max } ] ];
        data
    ]
];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Utilities*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*libraryFunctionLoad*)
libraryFunctionLoad // ClearAll;
libraryFunctionLoad[ args___ ] := libraryFunctionLoad0[ $SessionID, args ];


libraryFunctionLoad0 // beginDefinition;

libraryFunctionLoad0[ id_Integer, file_, a___ ] :=
    libraryFunctionLoad0[ id, file, a ] =
        Quiet[
            Check[
                tagLoadedLibraryFunction @ LibraryFunctionLoad[ file, a ],
                If[ $CloudEvaluation,
                    throwFailure[ "CloudLibraryFunction" ],
                    throwFailure[ "LibraryFunctionLoadFail", file ]
                ],
                LibraryFunction::noopen
            ],
            LibraryFunction::noopen
        ];

libraryFunctionLoad0 // endDefinition;

(* ::**************************************************************************************************************:: *)
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

(* ::**************************************************************************************************************:: *)
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
    13 -> "LibraryErrorOpenFile",
    14 -> "LibraryErrorNoFileID"
|>;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$fitLibraryFile*)
$fitLibraryFile :=
    If[ FileExistsQ @ $libraryFile0,
        $libraryFile0,
        compileOnDemand[ ]
    ];

$libraryFile0 := $libraryFile0 = FileNameJoin @ {
    $thisPacletLocation,
    "LibraryResources",
    $SystemID,
    "FITImportExport." <> Internal`DynamicLibraryExtension[ ]
};

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$sourceDir*)
$sourceDir := $sourceDir = FileNameJoin @ { $thisPacletLocation, "Source" };

(* ::**************************************************************************************************************:: *)
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
                "fit_sdk.c",
                "fit_convert.c"
            },
            $sourceDir
        ];
        tgt   = DirectoryName @ file;
        built = CCompilerDriver`CreateLibrary[
            files,
            "FITImportExport",
            "TargetDirectory"   -> tgt,
            "CleanIntermediate" -> True
        ];
        If[ FileExistsQ @ built,
            built,
            throwFailure[ "CompileFailure", id ]
        ]
    ];

compileOnDemand // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*recompileLibraries*)
recompileLibraries[ ] := catchTop @ recompileLibraries @ False;

recompileLibraries[ strict_ ] := catchTop @ recompileLibraries[ strict, $SystemID, $libraryFile0 ];

recompileLibraries[ strict_, id_, file_ ] :=
    Block[ { $compiledCodeFunctionsBag = Internal`Bag[ ], $debug = True, $recompileStrict = strict },
        libraryFunctionUnload[ ];
        autoCompileCodeFunctions[ ];
        Quiet[
            <|
                "CodeFunctions"   -> Association @ Internal`BagPart[ $compiledCodeFunctionsBag, All ],
                "FITImportExport" -> compileOnDemand[ id, file ]
            |>,
            ComputationalFitness::CompileOnDemand
        ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
