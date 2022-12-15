#!/usr/bin/env wolframscript

(* :!CodeAnalysis::BeginBlock:: *)
(* :!CodeAnalysis::Disable::SuspiciousSessionSymbol:: *)

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Config*)
$pacletCICD    = "https://github.com/WolframResearch/PacletCICD/releases/download/v0.34.0/Wolfram__PacletCICD-0.34.0.paclet";
$sdkURL        = "https://developer.garmin.com/downloads/fit/sdk/FitSDKRelease_21.94.00.zip";
$fitUseSTDINT  = True;
$forceDownload = False;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
If[ ! PacletObjectQ @ PacletObject[ "Wolfram/PacletCICD" ], PacletInstall @ $pacletCICD ];
Needs[ "Wolfram`PacletCICD`" -> "cicd`" ];

cFile = cicd`ScriptConfirmBy[ #, FileExistsQ ] &;
cDir  = cicd`ScriptConfirmBy[ #, DirectoryQ  ] &;
cStr  = cicd`ScriptConfirmBy[ #, StringQ     ] &;

cicd`ScriptConfirmAssert[ $OperatingSystem === "Windows" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Paths*)
$inputFileName = cFile @ Replace[ $InputFileName, "" :> NotebookFileName[ ] ];
$pacletDir     = cDir @ DirectoryName[ $inputFileName, 2 ];
$sourceDir     = cStr @ FileNameJoin @ { $pacletDir, "Source" };
$sdkDir        = cDir @ FileNameJoin @ { $pacletDir, "SDK" };
$fitGen        = cStr @ FileNameJoin @ { $sdkDir, "FitGen.exe" };

cicd`ConsoleLog[ "Source directory: " <> $sourceDir ];
cicd`ConsoleLog[ "SDK directory: "    <> $sdkDir    ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Load Paclet Definitions*)
PacletDirectoryLoad @ $pacletDir;
Needs[ "RH`ComputationalFitness`" -> None ];
Needs[ "RH`ComputationalFitness`Package`" -> "cf`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Definitions*)

niceMessageName // ClearAll;
niceMessageName[ type_String ] :=
    cf`toNiceCamelCase @ StringDelete[
        type,
        { StartOfString ~~ "FIT_", "_MESG" ~~ EndOfString }
    ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fetchFitGen*)
fetchFitGen // ClearAll;
fetchFitGen[ sdkZipFile_, targetFile_ ] :=
    Module[ { tmp },
        WithCleanup[
            tmp = CreateDirectory[ ],
            cicd`ConsoleLog @ SequenceForm[ "Extracting FitGen.exe from ", sdkZipFile ];
            ExtractArchive[ sdkZipFile, tmp, "FitGen.exe" ];
            cFile @ CopyFile[
                FileNameJoin @ { tmp, "FitGen.exe" },
                targetFile,
                OverwriteTarget -> True
            ],
            DeleteDirectory[ tmp, DeleteContents -> True ]
        ]
    ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitGen*)
fitGen // ClearAll;
fitGen[ ] :=
    Module[ { tmp, config, string, files },
        WithCleanup[
            tmp = CreateDirectory[ ]
            ,

            RunProcess[
                { $fitGen, "-c", tmp },
                ProcessDirectory -> DirectoryName @ $fitGen
            ];

            configureSTDINT @ tmp;

            files = Select[ FileNames[ All, tmp, Infinity ], Not@*DirectoryQ ];

            Map[
                Function[
                    CopyFile[
                        #1,
                        FileNameJoin @ {
                            $sourceDir,
                            ResourceFunction[ "RelativePath" ][ tmp, #1 ]
                        },
                        OverwriteTarget -> True
                    ]
                ],
                files
            ]
            ,
            DeleteDirectory[ tmp, DeleteContents -> True ]
        ]
    ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*configureSTDINT*)
configureSTDINT // ClearAll;

configureSTDINT[ outputDir_ ] /; $fitUseSTDINT :=
    Module[ { config, string },
        config = cFile @ FileNameJoin @ { outputDir, "fit_config.h" };
        string = StringReplace[
            cStr @ ReadString @ config,
            {
                "\r\n" -> "\n",
                "//#define FIT_USE_STDINT_H" -> "#define FIT_USE_STDINT_H"
            }
        ];
        cFile @ Export[ config, string, "String" ]
    ];

configureSTDINT[ outputDir_ ] :=
    cFile @ FileNameJoin @ { outputDir, "fit_config.h" };

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Data Formatting*)

$indent     = 1;
$indentSize = 4;

$currentIndentSize := $indentSize * $indent;
$currentIndent     := StringJoin @ ConstantArray[ " ", $currentIndentSize ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*formatWithNotice*)
formatWithNotice // ClearAll;
formatWithNotice[ expr_ ] :=
    StringJoin[
        "(* This file is auto-generated. Do not edit manually. *)\n",
        format @ expr
    ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*format*)
format // ClearAll;

format[ value_ ] := format[ value, 1 ];

format[ value_, indent_ ] := Block[ { $indent = indent }, format0 @ value ];

format0 // ClearAll;

format0[ as_Association ] /; AllTrue[ as, AssociationQ ] :=
    StringJoin[
        "<|\n",
        StringRiffle[
            KeyValueMap[ formatTopKV, as ],
            "\n" <> $currentIndent <> ",\n"
        ],
        "\n",
        StringDelete[
            $currentIndent,
            StartOfString ~~ StringJoin @ ConstantArray[ " ", $indentSize ]
        ],
        "|>"
    ];

format0[ as_Association ] :=
    Module[ { keySize },
        keySize = Max[ StringLength@*keyToString /@ Keys @ as ];
        StringJoin[
            "<|\n",
            StringRiffle[ KeyValueMap[ formatKV @ keySize, as ], ",\n" ],
            "\n",
            StringDelete[
                $currentIndent,
                StartOfString ~~ StringJoin @ ConstantArray[ " ", $indentSize ]
            ],
            "|>"
        ]
    ];

format0[ expr_ ] := ToString @ ResourceFunction[ "ReadableForm" ][
    expr,
    PageWidth -> Infinity
];


keyToString // ClearAll;
keyToString[ key_ ] := ToString[ key, InputForm ];


(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*formatTopKV*)
formatTopKV // ClearAll;

formatTopKV[ key_, value_ ] :=
    StringJoin[
        $currentIndent,
        keyToString @ key,
        " -> ",
        format[ value, $indent + 1 ]
    ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*formatKV*)
formatKV // ClearAll;

formatKV[ (keySize_) ][ key_, value_ ] :=
    StringJoin[
        $currentIndent,
        StringPadRight[ keyToString @ key, keySize ],
        " -> ",
        format[ value, $indent + 1 ]
    ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Generate FIT Source Files*)
$fitGen = If[ TrueQ[ $forceDownload || ! FileExistsQ @ $fitGen ],
              fetchFitGen[ $sdkURL, $fitGen ],
              $fitGen
          ];

generated = cicd`ScriptConfirmMatch[ fitGen[ ], { __? FileExistsQ } ];

cicd`ConsoleLog[ "Generated FIT SDK source files: " ];
cicd`ConsoleLog[ "    " <> # ] & /@ generated;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Generate Import Functions*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*String Patterns*)
$space      = " " ..;
$type       = (LetterCharacter | DigitCharacter | "_") ..;
$name       = (LetterCharacter | DigitCharacter | "_" | "[" | "]") ..;
$structLine = $space~~$type~~" "~~$name~~";"~~Except[ "\n" ]..~~"\n";
$structHead = "typedef struct\n{\n";
$structFoot = "} " ~~ $name ~~ ";";
$struct     = $structHead ~~ $structLine .. ~~ $structFoot;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Type Definitions*)
header = StringReplace[
    ReadString @ FileNameJoin @ { $sourceDir, "fit_example.h" },
    "\r\n" -> "\n"
];

mesgStructs = Select[ StringCases[ header, $struct ], StringEndsQ[ "_MESG;" ] ];

sizes = Association @ StringCases[
    header,
    StringExpression[
        "#define ",
        name: (LetterCharacter | DigitCharacter | "_")..,
        WhitespaceCharacter...,
        size: DigitCharacter..,
        "\n"
    ] :> (name -> ToExpression @ size)
];

bits = ToString /@ (2^Range[3, 5]);

$intTypes = Union[
    ("FIT_SINT" <> # &) /@ bits,
    ("FIT_UINT" <> # &) /@ bits,
    ("FIT_SINT" <> # <> "Z" &) /@ bits,
    ("FIT_UINT" <> # <> "Z" &) /@ bits,
    {
        "FIT_BYTE",
        "FIT_MESG_NUM",
        "FIT_BOOL",
        "FIT_WEIGHT",
        "FIT_MESSAGE_INDEX",
        "FIT_FILE"
    }
];

$$integerType = Alternatives @@ $intTypes;
$$dateType = "FIT_DATE_TIME" | "FIT_LOCAL_DATE_TIME";

$enumTypes =
    StringCases[
        header,
        StringExpression[
            "typedef ",
            $$integerType | "FIT_ENUM",
            " ",
            type: ("_" | LetterCharacter | DigitCharacter)..,
            ";"
        ] :> type
    ];

$$enumType = Alternatives @@ $enumTypes;

$importTimestampTemplate       = "ImportInteger(`Index`, libData, data, pos, WLTimestamp(mesg->`Name`));";
$importIntegerTemplate         = "ImportInteger(`Index`, libData, data, pos, mesg->`Name`);";
$importIntegerSequenceTemplate = "ImportIntegerSequence(`Index`, libData, data, pos, mesg->`Name`, `Count`);";
$importFloat32Template         = "ImportFloat(`Index`, libData, data, pos, mesg->`Name`);";
$importFloat64Template         = "ImportFloat(`Index`, libData, data, pos, mesg->`Name`);";
$importFloat32SequenceTemplate = "ImportFloatSequence(`Index`, libData, data, pos, mesg->`Name`, `Count`);";
$importFloat64SequenceTemplate = "ImportFloatSequence(`Index`, libData, data, pos, mesg->`Name`, `Count`);";
$importStringTemplate          = "ImportString(`Index`, libData, data, pos, mesg->`Name`, `Count`);";
$importDoneTemplate            = "ImportFinish(`Index`, libData, data, pos);";
$importHeaderTemplate          = "static void `Name`(WolframLibraryData libData, MTensor data, int idx, const `Type` *mesg)";

$exportTimestampTemplate       = "ExportTimestamp(`Index`, libData, data, pos, mesg.`Name`);";
$exportIntegerTemplate         = "ExportInteger(`Index`, libData, data, pos, mesg.`Name`);";
$exportIntegerSequenceTemplate = "ExportIntegerSequence(`Index`, libData, data, pos, mesg.`Name`, `Count`);";
$exportFloat32Template         = "ExportFloat32(`Index`, libData, data, pos, mesg.`Name`);";
$exportFloat64Template         = "ExportFloat64(`Index`, libData, data, pos, mesg.`Name`);";
$exportFloat32SequenceTemplate = "ExportFloat32Sequence(`Index`, libData, data, pos, mesg.`Name`, `Count`);";
$exportFloat64SequenceTemplate = "ExportFloat64Sequence(`Index`, libData, data, pos, mesg.`Name`, `Count`);";
$exportStringTemplate          = "ExportString(`Index`, libData, data, pos, mesg.`Name`, `Count`);";
$exportDoneTemplate            = "ExportFinish(`Index`, libData, data, pos);";
$exportHeaderTemplate          = "static void `Name`(WolframLibraryData libData, MTensor data, int idx, FILE *fp )";

$importCaseTemplate = "\
                    case `MessageNumber`:
                    {
                        const `Type` *new = (`Type` *) mesg;
                        idx++;
                        `ImportFunctionName`(libData, data, idx, new);
                        break;
                    }";

$exportCaseTemplate = "\
            case `MessageNumber`:
            {
                `ExportFunctionName`(libData, data, idx, fp);
                break;
            }";

$importCountTemplate = "\
                    case `MessageNumber`:
                    {
                        mesg_count++;
                        break;
                    }";


$index        = 0;
$maxIndex     = 0;
$indexedNames = Internal`Bag[ ];


nextIndex // ClearAll;
nextIndex[ ] := nextIndex[ 1 ];
nextIndex[ n_ ] :=
    With[ { current = $index },
        $index += n;
        $maxIndex = Max[ $maxIndex, $index ];
        current + 1
    ];


nextNamedIndex // ClearAll;

nextNamedIndex[ part_ ] :=
    With[ { idx = nextIndex @ 1 },
        Internal`StuffBag[ $indexedNames, part -> <| "offset" -> idx, "list" -> False |> ];
        idx
    ];

nextNamedIndex[ part_, n_ ] :=
    With[ { idx = nextIndex @ n },
        Internal`StuffBag[ $indexedNames, part -> <| "offset" -> idx, "list" -> True, "length" -> n |> ];
        idx
    ];


makeImportIntegerStringN // ClearAll;

makeImportIntegerStringN[ str_String ] :=
    makeImportIntegerStringN @ StringSplit[ str, " " ];

makeImportIntegerStringN[ { type_String, val_ } ] :=
    makeImportIntegerStringN[ type, StringSplit[ val, "[" | "]" ] ];

makeImportIntegerStringN[ $$dateType, { name_String } ] :=
    TemplateApply[
        $importTimestampTemplate,
        <|
            "Name"  -> name,
            "Index" -> nextNamedIndex[ name ]
        |>
    ];

makeImportIntegerStringN[ $$integerType | $$enumType, { name_String } ] :=
    TemplateApply[
        $importIntegerTemplate,
        <|
            "Name"  -> name,
            "Index" -> nextNamedIndex[ name ]
        |>
    ];

makeImportIntegerStringN[
    $$integerType | $$enumType,
    { name_String, count_String }
] :=
    With[ { s = sizes @ count },
        TemplateApply[
            $importIntegerSequenceTemplate,
            <|
                "Name"  -> name,
                "Index" -> nextNamedIndex[ name, s ],
                "Count" -> count
            |>
        ] /;
            IntegerQ @ s
    ];

makeImportIntegerStringN[ "FIT_FLOAT32", { name_String } ] :=
    TemplateApply[
        $importFloat32Template,
        <|
            "Name"  -> name,
            "Index" -> nextNamedIndex[ name ]
        |>
    ];

makeImportIntegerStringN[ "FIT_FLOAT32", { name_String, count_String } ] :=
    With[ { s = sizes @ count },
        TemplateApply[
            $importFloat32SequenceTemplate,
            <|
                "Name"  -> name,
                "Index" -> nextNamedIndex[ name, s ],
                "Count" -> count
            |>
        ] /; IntegerQ @ s
    ];

makeImportIntegerStringN[ "FIT_FLOAT64", { name_String } ] :=
    TemplateApply[
        $importFloat64Template,
        <|
            "Name"  -> name,
            "Index" -> nextNamedIndex[ name ]
        |>
    ];

makeImportIntegerStringN[ "FIT_FLOAT64", { name_String, count_String } ] :=
    With[ { s = sizes @ count },
        TemplateApply[
            $importFloat64SequenceTemplate,
            <|
                "Name"  -> name,
                "Index" -> nextNamedIndex[ name, s ],
                "Count" -> count
            |>
        ] /; IntegerQ @ s
    ];

makeImportIntegerStringN[ "FIT_STRING", { name_String, count_String } ] :=
    With[ { s = sizes @ count },
        TemplateApply[
            $importStringTemplate,
            <|
                "Name"  -> name,
                "Index" -> nextNamedIndex[ name, s ],
                "Count" -> count
            |>
        ]
    ];






makeExportIntegerStringN // ClearAll;

makeExportIntegerStringN[ str_String ] :=
    makeExportIntegerStringN @ StringSplit[ str, " " ];

makeExportIntegerStringN[ { type_String, val_ } ] :=
    makeExportIntegerStringN[ type, StringSplit[ val, "[" | "]" ] ];

makeExportIntegerStringN[ $$dateType, { name_String } ] :=
    TemplateApply[
        $exportTimestampTemplate,
        <|
            "Name"  -> name,
            "Index" -> nextIndex[ ]
        |>
    ];

makeExportIntegerStringN[ $$integerType | $$enumType, { name_String } ] :=
    TemplateApply[
        $exportIntegerTemplate,
        <|
            "Name"  -> name,
            "Index" -> nextIndex[ ]
        |>
    ];

makeExportIntegerStringN[
    $$integerType | $$enumType,
    { name_String, count_String }
] :=
    With[ { s = sizes @ count },
        TemplateApply[
            $exportIntegerSequenceTemplate,
            <|
                "Name"  -> name,
                "Index" -> nextIndex @ s,
                "Count" -> count
            |>
        ] /;
            IntegerQ @ s
    ];

makeExportIntegerStringN[ "FIT_FLOAT32", { name_String } ] :=
    TemplateApply[
        $exportFloat32Template,
        <|
            "Name"  -> name,
            "Index" -> nextIndex[ ]
        |>
    ];

makeExportIntegerStringN[ "FIT_FLOAT32", { name_String, count_String } ] :=
    With[ { s = sizes @ count },
        TemplateApply[
            $exportFloat32SequenceTemplate,
            <|
                "Name"  -> name,
                "Index" -> nextIndex @ s,
                "Count" -> count
            |>
        ] /; IntegerQ @ s
    ];

makeExportIntegerStringN[ "FIT_FLOAT64", { name_String } ] :=
    TemplateApply[
        $exportFloat64Template,
        <|
            "Name"  -> name,
            "Index" -> nextIndex[ ]
        |>
    ];

makeExportIntegerStringN[ "FIT_FLOAT64", { name_String, count_String } ] :=
    With[ { s = sizes @ count },
        TemplateApply[
            $exportFloat64SequenceTemplate,
            <|
                "Name"  -> name,
                "Index" -> nextIndex @ s,
                "Count" -> count
            |>
        ] /; IntegerQ @ s
    ];

makeExportIntegerStringN[ "FIT_STRING", { name_String, count_String } ] :=
    With[ { s = sizes @ count },
        TemplateApply[
            $exportStringTemplate,
            <|
                "Name"  -> name,
                "Index" -> nextIndex @ s,
                "Count" -> count
            |>
        ]
    ];




$exportFuncDefTemplate = "\
static void `FunctionName`(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    `MessageType` mesg;
    Fit_InitMesg(fit_mesg_defs[`MessageID`], &mesg);

`ExportCodeBlock`

    WriteMessageDefinition(`MessageNumber`, local_mesg_number, fit_mesg_defs[`MessageID`], `MessageType`_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, `MessageType`_SIZE, fp);
}";




makeImportData[ struct_ ] :=
    Block[ { $index = 0, $indexedNames = Internal`Bag[ ] },
        Module[
            {
                structLines,
                importCodeBlock,
                exportCodeBlock,
                type,
                importFuncName,
                exportFuncName,
                importFuncHeader,
                exportFuncHeader,
                mesgNum,
                messageID,
                importFuncDef,
                exportFuncDef,
                lastIndex
            },

            structLines =
                StringTrim @ StringDelete[
                    struct,
                    { StartOfString ~~ $structHead, $structFoot ~~ EndOfString }
                ];

            $index = 1;

            importCodeBlock =
                StringJoin[
                    "    ",
                    StringRiffle[
                        Map[
                            makeImportIntegerStringN,
                            StringDelete[
                                StringTrim @ StringSplit[ structLines, "\n" ],
                                ";" ~~ ___ ~~ EndOfString
                            ]
                        ],
                        "\n    "
                    ]
                ];

            lastIndex = nextIndex[ ];

            $index = 1;

            exportCodeBlock =
                StringJoin[
                    "    ",
                    StringRiffle[
                        Map[
                            makeExportIntegerStringN,
                            StringDelete[
                                StringTrim @ StringSplit[ structLines, "\n" ],
                                ";" ~~ ___ ~~ EndOfString
                            ]
                        ],
                        "\n    "
                    ]
                ];

            type =
                StringTrim[
                    StringDelete[ struct, $structHead ~~ $structLine.. ~~ "} " ],
                    ";"
                ];


            importFuncName =
                StringJoin[
                    "import_",
                    ToLowerCase @ StringDelete[
                        type,
                        { StartOfString ~~ "FIT_", "_MESG" ~~ EndOfString }
                    ]
                ];

            exportFuncName =
                StringJoin[
                    "export_",
                    ToLowerCase @ StringDelete[
                        type,
                        { StartOfString ~~ "FIT_", "_MESG" ~~ EndOfString }
                    ]
                ];


            importFuncHeader =
                TemplateApply[
                    $importHeaderTemplate,
                    <|
                        "Name" -> importFuncName,
                        "Type" -> type
                    |>
                ];

            exportFuncHeader =
                TemplateApply[
                    $exportHeaderTemplate,
                    <|
                        "Name" -> exportFuncName,
                        "Type" -> type
                    |>
                ];

            mesgNum = StringReplace[
                type,
                "FIT_" ~~ base__ ~~ "_MESG" :> "FIT_MESG_NUM_" <> base
            ];

            messageID = StringReplace[
                type,
                "FIT_" ~~ base__ ~~ "_MESG" :> "FIT_MESG_" <> base
            ];

            importFuncDef =
                StringJoin[
                    importFuncHeader,
                    "\n",
                    "{\n",
                    "    mint pos[2] = {idx, 0};\n",
                    StringJoin[
                        "    ImportInteger(1, libData, data, pos, ",
                        mesgNum,
                        ");\n"
                    ],
                    importCodeBlock,
                    "\n    ",
                    TemplateApply[
                        $importDoneTemplate,
                        <|
                            "Index" -> lastIndex
                        |>
                    ],
                    "\n",
                    "}"
                ];

            exportFuncDef =
                TemplateApply[
                    $exportFuncDefTemplate,
                    <|
                        "FunctionName"    -> exportFuncName,
                        "MessageType"     -> type,
                        "MessageNumber"   -> mesgNum,
                        "MessageID"       -> messageID,
                        "ExportCodeBlock" -> exportCodeBlock
                    |>
                ];

            <|
                "Name"                     -> niceMessageName @ type,
                "Type"                     -> type,
                "ImportFunctionName"       -> importFuncName,
                "ExportFunctionName"       -> exportFuncName,
                "ImportFunctionHeader"     -> importFuncHeader,
                "ExportFunctionHeader"     -> exportFuncHeader,
                "LastIndex"                -> lastIndex,
                "ImportFunctionDefinition" -> importFuncDef,
                "ExportFunctionDefinition" -> exportFuncDef,
                "MessageNumber"            -> mesgNum,
                "MessageID"                -> messageID,
                "Indices"                  -> Association @ Internal`BagPart[ $indexedNames, All ],
                "StructLines"              -> structLines
            |>
        ]
    ];


autoGeneratedPattern[ label_ ] :=
    StringExpression[
        "\n// --- START " <> label <> " ---\n",
        ___,
        "\n// --- END " <> label <> " ---"
    ];

autoGeneratedSection[ label_, stuff_ ] :=
    StringJoin[
        "\n// --- START " <> label <> " ---\n",
        "// This section is auto-generated. Do not edit manually.\n",
        stuff,
        "\n// --- END " <> label <> " ---"
    ];

autoGeneratedSectionRule[ label_, stuff_ ] :=
    autoGeneratedPattern @ label :> autoGeneratedSection[ label, stuff ];

replaceAutoGeneratedSection[ string_String, label_, stuff_ ] :=
    StringReplace[ string, autoGeneratedSectionRule[ label, stuff ] ];



$functionData = makeImportData /@ mesgStructs;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Struct Index*)
makeIndex // ClearAll;
makeIndex[ KeyValuePattern @ { "offset" -> idx_, "list" -> False } ] := idx;
makeIndex[ KeyValuePattern @ { "offset" -> idx_, "list" -> True, "length" -> n_ } ] := idx;;idx + n - 1;



$fitIndex = KeySort[ KeySort /@ KeyMap[
    niceMessageName,
    Association[ (#Type -> KeyMap[ cf`toNiceCamelCase, makeIndex /@ #Indices ] &) /@ $functionData ]
] ];
indexFile = FileNameJoin @ { $pacletDir, "Data", "FITStructIndex.wl" };
GeneralUtilities`EnsureDirectory @ DirectoryName @ indexFile;
$exportedIndex = Export[ indexFile, formatWithNotice @ $fitIndex, "String" ];
cicd`ConsoleLog[ "Updated FIT struct index data: " <> $exportedIndex ];


(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Enumerable Types*)
fitH = StringReplace[
    ReadString @ FileNameJoin @ { $sourceDir, "fit.h" },
    "\r\n" -> "\n"
];


toExpression // ClearAll;

toExpression[ type_String, val_String ] /;
    StringMatchQ[ val, "((" ~~ type ~~ ")" ~~ __ ~~ ")" ] :=
    toExpression @ val;

toExpression[ _, name_String ] :=
    With[ { new = $defines @ name }, new /; IntegerQ @ new ];

toExpression[ val_String ] /; StringMatchQ[ val, DigitCharacter.. ] :=
    ToExpression @ val;

toExpression[ val_String ] :=
    With[ { new = StringReplace[ val, "((" ~~ __ ~~ ")" ~~ v__ ~~ ")" :> v ] },
        toExpression @ new /; new =!= val
    ];

toExpression[ val_String ] :=
    With[ { new = StringDelete[ val, StartOfString ~~ "0x" ] },
        FromDigits[ new, 16 ] /; new =!= val
    ];



makeDefineData // ClearAll;

makeDefineData[ headers__String ] :=
    Module[ { defineData, defineValues },

        defineData =
            Flatten[
                Map[
                    Function[
                        StringCases[
                            #1,
                            StringExpression[
                                "#define ",
                                name: (WordCharacter | "_")..,
                                WhitespaceCharacter...,
                                v: Except[ WhitespaceCharacter ]..,
                                WhitespaceCharacter
                            ] :> { name, v }
                        ]
                    ],
                    { headers }
                ],
                1
            ];


        defineValues = Association @ Cases[
            defineData,
            { name_String, v_String } :>
                With[ { new = toExpression @ v },
                    (name -> new) /; IntegerQ @ new
                ]
        ];

        expandDefineValues[
            defineValues,
            DeleteCases[
                defineData,
                { Alternatives @@ Keys @ defineValues, _ }
            ]
        ]
    ];



expandDefineValues // ClearAll;

expandDefineValues[ defineValues_Association, defineData_List ] :=
    Module[ { found, newValues, newData },

        found = Association @ Cases[
            defineData,
            { name_, v_String } :>
                With[ { new = Lookup[ defineValues, v ] },
                    (name -> new) /; IntegerQ @ new
                ]
        ];

        newValues = Join[ defineValues, found ];
        newData = DeleteCases[ defineData, { Alternatives @@ Keys @ found, _ } ];
        If[ newValues === defineValues,
            newValues,
            expandDefineValues[ newValues, newData ]
        ]
    ];



makeTypeRule // ClearAll;

makeTypeRule[ type_ ] :=
    Module[ { content, rules },

        content =
            StringCases[
                header,
                StringExpression[
                    "#define ",
                    (WordCharacter | "_")...,
                    type,
                    "_",
                    name: (WordCharacter | "_")..,
                    WhitespaceCharacter...,
                    val: Except[ WhitespaceCharacter | "\n" ]..,
                    WhitespaceCharacter | "\n"
                ] :> { name, type, toExpression[ type, val ] }
            ];


        rules =
            KeySort @ Association @ Cases[
                content,
                { name_String, prefix_String, value_Integer } :>
                    (value ->
                        cf`toNiceCamelCase @ StringDelete[ name, StartOfString ~~ prefix ~~ "_" ]
)
            ];

        enumTypeName @ type -> rules
    ];



enumTypeName // ClearAll;

enumTypeName[ str_String ] :=
    cf`toNiceCamelCase @ StringDelete[ str, StartOfString ~~ "FIT_" ];

$defines = makeDefineData[ header, fitH ];



Export[
    FileNameJoin @ { $pacletDir, "SDK", "Defines.wxf" },
    $defines,
    "WXF"
];



types = Select[
    StringCases[
        header,
        StringExpression[
            "typedef ",
            (WordCharacter | "_")..,
            " ",
            type: (WordCharacter | "_")..,
            ";"
        ] :> type
    ],
    Not @* StringEndsQ[ "_FIELD_NUM" ]
];


$enumTypeData = KeySort @ Replace[
    Association[ makeTypeRule /@ types ],
    "Invalid" -> Missing[ "Invalid" ],
    { 2 }
];


enumFile = FileNameJoin @ { $pacletDir, "Data", "FITEnumData.wl" };
GeneralUtilities`EnsureDirectory @ DirectoryName @ enumFile;
$exportedEnumData = Export[ enumFile, formatWithNotice @ $enumTypeData, "String" ];
cicd`ConsoleLog[ "Updated FIT enum data: " <> $exportedEnumData ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*SDK Data*)
Export[
    FileNameJoin @ { $pacletDir, "SDK", "Data.wxf" },
    $functionData,
    "WXF"
];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Import Functions*)

$importFunctions = StringRiffle[ $functionData[[ All, "ImportFunctionDefinition" ]], "\n\n" ];

fitImportSrcFile = cFile @ FileNameJoin @ { $sourceDir, "fit_import.c" };
fitImportString  = StringReplace[ cStr @ ReadString @ fitImportSrcFile, "\r\n" -> "\n" ];
importCases = StringRiffle[
    Map[
        TemplateApply[ $importCaseTemplate, #1 ] &,
        DeleteCases[
            $functionData,
            KeyValuePattern[ "MessageNumber" -> "FIT_MESG_NUM_ACTIVITY" ]
        ]
    ],
    "\n"
];

importCounts =
    StringRiffle[
        (TemplateApply[ $importCountTemplate, #1 ] &) /@ $functionData,
        "\n"
    ];

fitImportUpdated =
    cFile @ Export[
        fitImportSrcFile,
        replaceAutoGeneratedSection[
            replaceAutoGeneratedSection[
                replaceAutoGeneratedSection[
                    fitImportString,
                    "MESSAGE IMPORT FUNCTIONS",
                    $importFunctions
                ],
                "MESSAGE IMPORT CASES",
                importCases
            ],
            "MESSAGE COUNT CASES",
            importCounts
        ],
        "String"
    ];

cicd`ConsoleLog[ "Updated import functions in :" <> fitImportSrcFile ];

$importH = cFile @ FileNameJoin @ { $sourceDir, "fit_import.h" };

fitImportHFile = cFile @ FileNameJoin @ { $sourceDir, "fit_import.h" };
fitImportHString  = StringReplace[ cStr @ ReadString @ fitImportHFile, "\r\n" -> "\n" ];

$importFunctionDeclarations = StringRiffle[ (#ImportFunctionHeader <> ";" &) /@ $functionData, "\n" ];

fitImportHUpdated =
    cFile @ Export[
        fitImportHFile,
        replaceAutoGeneratedSection[
            StringReplace[
                fitImportHString,
                "#define MESSAGE_TENSOR_ROW_WIDTH " ~~ DigitCharacter.. ~~ "\n" :>
                    StringJoin[
                        "#define MESSAGE_TENSOR_ROW_WIDTH ",
                        ToString @ $maxIndex,
                        "\n"
                    ]
            ],
            "MESSAGE IMPORT DECLARATIONS",
            $importFunctionDeclarations
        ],
        "String"
    ];

cicd`ConsoleLog[ "Updated import header file:" <> fitImportHFile ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Export Functions*)

$exportFunctions = StringRiffle[ $functionData[[ All, "ExportFunctionDefinition" ]], "\n\n" ];

fitExportSrcFile = cFile @ FileNameJoin @ { $sourceDir, "fit_export.c" };
fitExportString  = StringReplace[ cStr @ ReadString @ fitExportSrcFile, "\r\n" -> "\n" ];
exportCases = StringRiffle[
    Map[
        TemplateApply[ $exportCaseTemplate, #1 ] &,
        $functionData
    ],
    "\n"
];


fitExportUpdated =
    cFile @ Export[
        fitExportSrcFile,
        replaceAutoGeneratedSection[
            replaceAutoGeneratedSection[
                fitExportString,
                "MESSAGE EXPORT FUNCTIONS",
                $exportFunctions
            ],
            "MESSAGE EXPORT CASES",
            exportCases
        ],
        "String"
    ];

cicd`ConsoleLog[ "Updated export functions in :" <> fitExportSrcFile ];

$exportH = cFile @ FileNameJoin @ { $sourceDir, "fit_export.h" };

fitExportHFile = cFile @ FileNameJoin @ { $sourceDir, "fit_export.h" };
fitExportHString  = StringReplace[ cStr @ ReadString @ fitExportHFile, "\r\n" -> "\n" ];

$exportFunctionDeclarations = StringRiffle[ (#ExportFunctionHeader <> ";" &) /@ $functionData, "\n" ];

fitExportHUpdated =
    cFile @ Export[
        fitExportHFile,
        replaceAutoGeneratedSection[
            fitExportHString,
            "MESSAGE EXPORT DECLARATIONS",
            $exportFunctionDeclarations
        ],
        "String"
    ];

cicd`ConsoleLog[ "Updated export header file:" <> fitExportHFile ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Type Data*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Definitions*)

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*parseType*)
parseType // ClearAll;

parseType[ line_String ] := parseType @ StringSplit[ line, " " ];

parseType[ { type_String, name_String, ___ } ] :=
    parseType[ type, StringSplit[ StringTrim[ name, ";" ], "[" | "]" ] ];

parseType[ type_String, { name_String, length_String } ] :=
    parseType[ type, name, length, toExpression[ type, length ] ];

parseType[ type_String, _String, _String, length_Integer ] := Association[
    niceType @ type,
    "NativeType" -> type,
    "Dimensions" -> { length }
];

parseType[ type_String, { _String } ] := Association[
    niceType @ type,
    "NativeType" -> type,
    "Dimensions" -> { }
];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*niceType*)
niceType // ClearAll;

niceType[ type_String ] :=
    niceType0[
        type,
        cf`toNiceCamelCase @ StringDelete[ type, StartOfString ~~ "FIT_" ]
    ];

niceType0 // ClearAll;

niceType0[ type_String, nice_String ] :=
    niceType0[ type, nice, $enumTypeData @ type ];

niceType0[ type_String, nice_String, as_Association ] :=
    DeleteMissing @ <|
        "Type"    -> nice,
        "Invalid" -> Lookup[ as, "Invalid" ]
    |>;

niceType0[ type_String, nice_String, _Missing ] :=
    DeleteMissing @ <|
        "Type"    -> nice,
        "Invalid" -> Lookup[ $defines, type <> "_INVALID" ]
    |>;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*parseName*)
parseName // ClearAll;
parseName[ line_String ] := parseName @ StringSplit[ line, " " | "[" | "]" | ";" ];
parseName[ { _, name_String, __ } ] := <|
    "FieldName"       -> cf`toNiceCamelCase @ name,
    "NativeFieldName" -> name
|>;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*parseComment*)
parseComment // ClearAll;
parseComment[ line_String ] := parseComment @ StringSplit[ line, "//" ];
parseComment[ { _, comment_String } ] := <| "Comment" -> StringTrim[ comment, (","|WhitespaceCharacter).. ] |>;
parseComment[ ___ ] := <| |>;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*parseLine*)
parseLine // ClearAll;
parseLine[ line_String ] := addDefaultFunction @ Association[ parseName @ line, parseType @ line, parseComment @ line ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*addDefaultFunction*)
addDefaultFunction // ClearAll;
addDefaultFunction[ as_ ] := DeleteMissing @ Append[ as, "Interpreter" -> defaultFunction @ as ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*defaultFunction*)
defaultFunction // ClearAll;
defaultFunction[ as_Association ] := defaultFunction[ as[ "Type" ], as[ "Dimensions" ] ];

defaultFunction[ "Bool"              , {   } ] := "fitBool";
defaultFunction[ "Bool"              , { _ } ] := "fitBoolA";
defaultFunction[ "Byte"              , {   } ] := "fitByte";
defaultFunction[ "Byte"              , { _ } ] := "fitByteA";
defaultFunction[ "Real32"            , {   } ] := "fitFloat32";
defaultFunction[ "Real32"            , { _ } ] := "fitFloat32A";
defaultFunction[ "Real64"            , {   } ] := "fitFloat64";
defaultFunction[ "Real64"            , { _ } ] := "fitFloat64A";
defaultFunction[ "SignedInteger8"    , {   } ] := "fitSINT8";
defaultFunction[ "SignedInteger8"    , { _ } ] := "fitSINT8A";
defaultFunction[ "SignedInteger16"   , {   } ] := "fitSINT16";
defaultFunction[ "SignedInteger16"   , { _ } ] := "fitSINT16A";
defaultFunction[ "SignedInteger32"   , {   } ] := "fitSINT32";
defaultFunction[ "SignedInteger32"   , { _ } ] := "fitSINT32A";
defaultFunction[ "SignedInteger64"   , {   } ] := "fitSINT64";
defaultFunction[ "SignedInteger64"   , { _ } ] := "fitSINT64A";
defaultFunction[ "UnsignedInteger8"  , {   } ] := "fitUINT8";
defaultFunction[ "UnsignedInteger8"  , { _ } ] := "fitUINT8A";
defaultFunction[ "UnsignedInteger8z" , {   } ] := "fitUINT8Z";
defaultFunction[ "UnsignedInteger8z" , { _ } ] := "fitUINT8ZA";
defaultFunction[ "UnsignedInteger16" , {   } ] := "fitUINT16";
defaultFunction[ "UnsignedInteger16" , { _ } ] := "fitUINT16A";
defaultFunction[ "UnsignedInteger16z", {   } ] := "fitUINT16Z";
defaultFunction[ "UnsignedInteger16z", { _ } ] := "fitUINT16ZA";
defaultFunction[ "UnsignedInteger32" , {   } ] := "fitUINT32";
defaultFunction[ "UnsignedInteger32" , { _ } ] := "fitUINT32A";
defaultFunction[ "UnsignedInteger32z", {   } ] := "fitUINT32Z";
defaultFunction[ "UnsignedInteger32z", { _ } ] := "fitUINT32ZA";
defaultFunction[ "UnsignedInteger64" , {   } ] := "fitUINT64";
defaultFunction[ "UnsignedInteger64" , { _ } ] := "fitUINT64A";
defaultFunction[ "DateTime"          , {   } ] := "fitDateTime";
defaultFunction[ "String"            , { _ } ] := "fitString";

defaultFunction[ type_String, _ ] :=
    With[ { enum = $enumTypeData @ type },
        { "fitEnum", type } /; AssociationQ @ enum
    ];

defaultFunction[ type_String, _ ] := { "fitMissing", type      };
defaultFunction[ ___            ] := { "fitMissing", "Unknown" };

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*makeTypeData*)
makeTypeData // ClearAll;
makeTypeData[ as_ ] :=
    Module[ { index, typeData, res },
        index = makeIndex /@ KeyMap[ niceMessageName, as[ "Indices" ] ];
        typeData = parseLine /@ StringTrim @ StringSplit[ as[ "StructLines" ], "\n" ];


        res =
            Merge[
                {
                    (<| "Index" -> #1 |> &) /@ index,
                    Association[
                        Map[
                            #FieldName -> KeyDrop[ #1, "FieldName" ] &,
                            typeData
                        ]
                    ]
                },
                Composition[ KeySort, Association ]
            ];

        as[ "Name" ] -> res
    ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Make Type Data*)
$fitTypeData = KeySort /@ KeySort @ Association[ makeTypeData /@ $functionData ];

typeFile = FileNameJoin @ { $pacletDir, "Data", "FITMessageDefinitions.wl" };
GeneralUtilities`EnsureDirectory @ DirectoryName @ typeFile;
$exportedTypeData = Export[ typeFile, formatWithNotice @ $fitTypeData, "String" ];
cicd`ConsoleLog[ "Updated FIT message data: " <> $exportedTypeData ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Exit*)

Exit[ 0 ];

(* :!CodeAnalysis::EndBlock:: *)