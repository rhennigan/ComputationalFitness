#!/usr/bin/env wolframscript


(* FIXME: this whole thing needs to be cleaned up *)

(* :!CodeAnalysis::BeginBlock:: *)
(* :!CodeAnalysis::Disable::SuspiciousSessionSymbol:: *)

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Config*)
$pacletCICD    = "https://github.com/WolframResearch/PacletCICD/releases/download/v0.34.0/Wolfram__PacletCICD-0.34.0.paclet";
$sdkURL        = "https://developer.garmin.com/downloads/fit/sdk/FitSDKRelease_21.94.00.zip";
$fitUseSTDINT  = True;
$forceDownload = False;

$productNumber      = 0;
$manufacturerID     = 31337;
$manufacturerString = "https://github.com/rhennigan";

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
(*Paclet Metadata*)
$thisPaclet         = PacletObject @ File @ $pacletDir;
$thisPacletName     = $thisPaclet[ "Name" ];
$thisPacletVersion  = $thisPaclet[ "Version" ];
$pacletSerialNumber = FromDigits[ ToExpression @ StringSplit[ $thisPacletVersion, "." ], 255 ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Definitions*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Enum Entity Processing*)

processEnum // ClearAll;

processEnum[ "Language"     , enum_Association ] := toLanguage /@ enum;
processEnum[ "LanguageBits0", enum_Association ] := toLanguage /@ enum;
processEnum[ "LanguageBits1", enum_Association ] := toLanguage /@ enum;
processEnum[ "LanguageBits2", enum_Association ] := toLanguage /@ enum;
processEnum[ "LanguageBits3", enum_Association ] := toLanguage /@ enum;
processEnum[ "LanguageBits4", enum_Association ] := toLanguage /@ enum;

processEnum[ "Manufacturer", enum_Association ] :=
    KeySort @ Append[ enum, $manufacturerID -> $manufacturerString ];

processEnum[ _, enum_ ] := enum;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*toLanguage*)
toLanguage // ClearAll;

toLanguage[ "Taiwanese"           ] := Entity[ "Language", "ChineseMinNan" ];
toLanguage[ "Farsi"               ] := Entity[ "Language", "Dari"          ];
toLanguage[ "Slovakian"           ] := Entity[ "Language", "Slovak"        ];
toLanguage[ "BrazilianPortuguese" ] := Entity[ "Language", "Portuguese"    ];
toLanguage[ "Malaysian"           ] := Entity[ "Language", "MalayStandard" ];

toLanguage[ name_String ] := With[ { entity = LanguageData @ name }, standardizeEntityName @ entity /; entityQ @ entity ];
toLanguage[ other_ ] := other;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*standardizeEntityName*)
standardizeEntityName // ClearAll;

standardizeEntityName[ Entity[ type_, name_String ] ] :=
    With[ { entity = Entity[ type, First @ StringSplit[ name, "::" ] ] },
        entity /; entityQ @ entity
    ];

standardizeEntityName[ other_ ] := other;

entityQ[ entity_Entity ] := ListQ @ entity[ "Properties" ];
entityQ[ ___ ] := False;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*niceMessageName*)
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
    Module[ { tmp, run, config, string, files },
        WithCleanup[
            tmp = CreateDirectory[ ]
            ,

            run = RunProcess[
                { $fitGen, "-messages", "messages.csv", "-types", "types.csv", "-c", tmp },
                ProcessDirectory -> DirectoryName @ $fitGen
            ];

            cicd`ConsoleNotice[ "Generating FIT Source Files..." ];
            cicd`ConsoleLog @ run[ "StandardOutput" ];
            cicd`ConsoleError @ run[ "StandardError" ];

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
    ReadString @ FileNameJoin @ { $sourceDir, "fit_sdk.h" },
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

$importPositionTemplate        = "ImportInteger(`Index`, libData, data, pos, idx);";
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
                exported++;
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

            $index = 2;

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
                    StringJoin[ "    ImportInteger(1, libData, data, pos, ", mesgNum, ");\n" ],
                    StringJoin[ "    ImportInteger(2, libData, data, pos, idx);\n" ],
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
(* indexFile = FileNameJoin @ { $pacletDir, "Data", "FITStructIndex.wl" };
GeneralUtilities`EnsureDirectory @ DirectoryName @ indexFile;
$exportedIndex = Export[ indexFile, formatWithNotice @ $fitIndex, "String" ];
cicd`ConsoleLog[ "Updated FIT struct index data: " <> $exportedIndex ]; *)


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
    With[ { new = StringDelete[ val, { StartOfString ~~ "0x", "L" ~~ EndOfString } ] },
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



$definedTypeList = StringCases[
    header,
    StringExpression[
        "typedef ",
        (WordCharacter | "_")..,
        " ",
        type: (WordCharacter | "_")..,
        ";"
    ] :> type
];

otherTypePrefixQ // ClearAll;

otherTypePrefixQ[ type_String, name_String ] := ContainsAny[
    $definedTypeList,
    Rest @ FoldList[ #1 <> "_" <> #2 &, type, StringSplit[ name, "_" ] ]
];

otherTypePrefixQ[ ___ ] := False;


typePrefixQ // ClearAll;
typePrefixQ[ type_String, name_, val_ ] :=
    And[ ! TrueQ @ otherTypePrefixQ[ type, name ],
         ! partialTypeNameQ @ name,
         ! partialTypeNameQ @ val
    ];

typePrefixQ[ ___ ] := False;

partialTypeNameQ // ClearAll;
partialTypeNameQ[ name_String ] := Or[ StringStartsQ[ name, "_" ], StringEndsQ[ name, "_" ] ];
partialTypeNameQ[ ___ ] := False;


makeTypeRule // ClearAll;

makeTypeRule[ type_ ] :=
    Module[ { content, rules },

        content = StringCases[
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
            ] /; typePrefixQ[ type, name, val ] :>
                { name, type, toExpression[ type, val ] }
        ];

        rules = KeySort @ Association @ Cases[
            content,
            { name_String, prefix_String, value_Integer } :>
                (value -> cf`toNiceCamelCase @ StringDelete[ name, StartOfString ~~ prefix ~~ "_" ])
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

$processedEnumData = Association @ KeyValueMap[
    #1 -> processEnum[ #1, #2 ] &,
    $enumTypeData
];


enumFile = FileNameJoin @ { $pacletDir, "Data", "FITEnumData.wl" };
GeneralUtilities`EnsureDirectory @ DirectoryName @ enumFile;
$exportedEnumData = Export[ enumFile, formatWithNotice @ $processedEnumData, "String" ];
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

$customInvalidValues = <|
    "DateTime"    -> Lookup[ $defines, "FIT_DATE_TIME_INVALID" ] + 2840036400,
    "Real32"      -> -9223372036854775808,
    "Real64"      -> -9223372036854775808
|>;

$baseInvalidValues = KeyMap[
    Composition[
        cf`toNiceCamelCase,
        StringDelete @ { StartOfString ~~ "FIT_", "_INVALID" ~~ EndOfString }
    ],
    KeySelect[ $defines, StringMatchQ[ "FIT_" ~~ __ ~~ "_INVALID" ] ]
];

$invalidValues = KeySort @ Association[
    $baseInvalidValues,
    $customInvalidValues
];

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

niceType0[ type_, nice_ ] :=
    With[ { invalid = Lookup[ $invalidValues, nice ] },
        <|
            "Type"    -> nice,
            "Invalid" -> invalid
        |> /; IntegerQ @ invalid
    ];

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
defaultFunction[ as_Association ] :=
    defaultFunction[
        typeFunction[ as[ "Type" ], as[ "Dimensions" ] ],
        commentFormula @ as[ "Comment" ]
    ];

defaultFunction[ enum_List    , _ ] := enum;
defaultFunction[ "fitMissing" , _ ] := "fitMissing";
defaultFunction[ "fitDateTime", _ ] := "fitDateTime";

(* Special Function Types *)
defaultFunction[ tf_, "0.7111111 * degrees + 0"    ] := { "fitQuantity", tf, "AngularDegrees"           , 0.7111111 , 0    };
defaultFunction[ tf_, "1 * semicircles + 0"        ] := { "fitQuantity", tf, "AngularDegrees"           , 11930464.7, 0    };
defaultFunction[ tf_, "1 * bpm + 0"                ] := { "fitQuantity", tf, "Beats"/"Minutes"          , 1         , 0    };
defaultFunction[ tf_, "1 * cycles + 0"             ] := { "fitQuantity", tf, "Cycles"                   , 1         , 0    };
defaultFunction[ tf_, "2 * cycles + 0"             ] := { "fitQuantity", tf, "Cycles"                   , 2         , 0    };
defaultFunction[ tf_, "1 * 2 * cycles (steps) + 0" ] := { "fitQuantity", tf, "Steps"                    , 2         , 0    };
defaultFunction[ tf_, "100 * C + 0"                ] := { "fitQuantity", tf, "DegreesCelsius"           , 100       , 0    };
defaultFunction[ tf_, "1 * C + 0"                  ] := { "fitQuantity", tf, "DegreesCelsius"           , 1         , 0    };
defaultFunction[ tf_, "1 * kcal + 0"               ] := { "fitQuantity", tf, "DietaryCalories"          , 1         , 0    };
defaultFunction[ tf_, "10 * kcal / min + 0"        ] := { "fitQuantity", tf, "DietaryCalories"/"Minutes", 1         , 0    };
defaultFunction[ tf_, "10 * kg + 0"                ] := { "fitQuantity", tf, "Grams"                    , 0.01      , 0    };
defaultFunction[ tf_, "100 * g/dL + 0"             ] := { "fitQuantity", tf, "Grams"/"Deciliters"       , 100       , 0    };
defaultFunction[ tf_, "1 * J + 0"                  ] := { "fitQuantity", tf, "Joules"                   , 1         , 0    };
defaultFunction[ tf_, "1 * m + 0"                  ] := { "fitQuantity", tf, "Meters"                   , 1         , 0    };
defaultFunction[ tf_, "5 * m + 500"                ] := { "fitQuantity", tf, "Meters"                   , 5         , 500  };
defaultFunction[ tf_, "100 * m + 0"                ] := { "fitQuantity", tf, "Meters"                   , 100       , 0    };
defaultFunction[ tf_, "1000 * m + 0"               ] := { "fitQuantity", tf, "Meters"                   , 1000      , 0    };
defaultFunction[ tf_, "1 * km + 0"                 ] := { "fitQuantity", tf, "Meters"                   , 0.001     , 0    };
defaultFunction[ tf_, "1 * mm + 0"                 ] := { "fitQuantity", tf, "Meters"                   , 1000      , 0    };
defaultFunction[ tf_, "10 * mm + 0"                ] := { "fitQuantity", tf, "Meters"                   , 100       , 0    };
defaultFunction[ tf_, "2 * mm + -110"              ] := { "fitQuantity", tf, "Meters"                   , 2000      , -110 };
defaultFunction[ tf_, "1000 * m/s + 0"             ] := { "fitQuantity", tf, "MetersPerSecond"          , 1000      , 0    };
defaultFunction[ tf_, "100 * m/s + 0"              ] := { "fitQuantity", tf, "MetersPerSecond"          , 100       , 0    };
defaultFunction[ tf_, "16 * m/s + 0"               ] := { "fitQuantity", tf, "MetersPerSecond"          , 16        , 0    };
defaultFunction[ tf_, "1 * Pa + 0"                 ] := { "fitQuantity", tf, "Pascals"                  , 1         , 0    };
defaultFunction[ tf_, "1 * percent + 0"            ] := { "fitQuantity", tf, "Percent"                  , 1         , 0    };
defaultFunction[ tf_, "2 * percent + 0"            ] := { "fitQuantity", tf, "Percent"                  , 2         , 0    };
defaultFunction[ tf_, "10 * percent + 0"           ] := { "fitQuantity", tf, "Percent"                  , 10        , 0    };
defaultFunction[ tf_, "100 * percent + 0"          ] := { "fitQuantity", tf, "Percent"                  , 100       , 0    };
defaultFunction[ tf_, "1 * % + 0"                  ] := { "fitQuantity", tf, "Percent"                  , 1         , 0    };
defaultFunction[ tf_, "2 * % + 0"                  ] := { "fitQuantity", tf, "Percent"                  , 2         , 0    };
defaultFunction[ tf_, "10 * % + 0"                 ] := { "fitQuantity", tf, "Percent"                  , 10        , 0    };
defaultFunction[ tf_, "100 * % + 0"                ] := { "fitQuantity", tf, "Percent"                  , 100       , 0    };
defaultFunction[ tf_, "256 * rpm + 0"              ] := { "fitQuantity", tf, "RevolutionsPerMinute"     , 256       , 0    };
defaultFunction[ tf_, "128 * rpm + 0"              ] := { "fitQuantity", tf, "RevolutionsPerMinute"     , 128       , 0    };
defaultFunction[ tf_, "1 * rpm + 0"                ] := { "fitQuantity", tf, "RevolutionsPerMinute"     , 1         , 0    };
defaultFunction[ tf_, "1000 * s + 0"               ] := { "fitQuantity", tf, "Seconds"                  , 1000      , 0    };
defaultFunction[ tf_, "128 * s + 0"                ] := { "fitQuantity", tf, "Seconds"                  , 128       , 0    };
defaultFunction[ tf_, "1 * s + 0"                  ] := { "fitQuantity", tf, "Seconds"                  , 1         , 0    };
defaultFunction[ tf_, "1 * ms + 0"                 ] := { "fitQuantity", tf, "Seconds"                  , 1000      , 0    };
defaultFunction[ tf_, "10 * ms + 0"                ] := { "fitQuantity", tf, "Seconds"                  , 10000     , 0    };
defaultFunction[ tf_, "1 * minutes + 0"            ] := { "fitQuantity", tf, "Seconds"                  , 1/60      , 0    };
defaultFunction[ tf_, "256 * V + 0"                ] := { "fitQuantity", tf, "Volts"                    , 256       , 0    };
defaultFunction[ tf_, "1 * watts + 0"              ] := { "fitQuantity", tf, "Watts"                    , 1         , 0    };
defaultFunction[ tf_, "1 * years + 0"              ] := { "fitQuantity", tf, "Years"                    , 1         , 0    };

(* Defaults *)
defaultFunction[ typeFunc_, _ ] := typeFunc;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*typeFunction*)
typeFunction // ClearAll;

typeFunction[ "ByteArray"       , { _ } ] := "fitByteArray";
typeFunction[ "UUID"            , { 4 } ] := "fitUUID";
typeFunction[ "Language"        , {   } ] := "fitLanguage";
typeFunction[ "MessageIndex"    , {   } ] := "fitUINT16";
typeFunction[ "MessageIndex"    , { _ } ] := "fitUINT16A";
typeFunction[ "LocalTimeIntoDay", {   } ] := "fitTimeOfDay";
typeFunction[ "LocalDateTime"   , {   } ] := "fitLocalTimestamp";

typeFunction[ type_String, _ ] :=
    With[ { enum = $enumTypeData @ type },
        { "fitEnum", type } /; AssociationQ @ enum
    ];

typeFunction[ "Boolean"           , {   } ] := "fitBool";
typeFunction[ "Boolean"           , { _ } ] := "fitBoolA";
typeFunction[ "Byte"              , {   } ] := "fitByte";
typeFunction[ "Byte"              , { _ } ] := "fitByteA";
typeFunction[ "Real32"            , {   } ] := "fitFloat32";
typeFunction[ "Real32"            , { _ } ] := "fitFloat32A";
typeFunction[ "Real64"            , {   } ] := "fitFloat64";
typeFunction[ "Real64"            , { _ } ] := "fitFloat64A";
typeFunction[ "SignedInteger8"    , {   } ] := "fitSINT8";
typeFunction[ "SignedInteger8"    , { _ } ] := "fitSINT8A";
typeFunction[ "SignedInteger16"   , {   } ] := "fitSINT16";
typeFunction[ "SignedInteger16"   , { _ } ] := "fitSINT16A";
typeFunction[ "SignedInteger32"   , {   } ] := "fitSINT32";
typeFunction[ "SignedInteger32"   , { _ } ] := "fitSINT32A";
typeFunction[ "SignedInteger64"   , {   } ] := "fitSINT64";
typeFunction[ "SignedInteger64"   , { _ } ] := "fitSINT64A";
typeFunction[ "UnsignedInteger8"  , {   } ] := "fitUINT8";
typeFunction[ "UnsignedInteger8"  , { _ } ] := "fitUINT8A";
typeFunction[ "UnsignedInteger8Z" , {   } ] := "fitUINT8Z";
typeFunction[ "UnsignedInteger8Z" , { _ } ] := "fitUINT8ZA";
typeFunction[ "UnsignedInteger16" , {   } ] := "fitUINT16";
typeFunction[ "UnsignedInteger16" , { _ } ] := "fitUINT16A";
typeFunction[ "UnsignedInteger16Z", {   } ] := "fitUINT16Z";
typeFunction[ "UnsignedInteger16Z", { _ } ] := "fitUINT16ZA";
typeFunction[ "UnsignedInteger32" , {   } ] := "fitUINT32";
typeFunction[ "UnsignedInteger32" , { _ } ] := "fitUINT32A";
typeFunction[ "UnsignedInteger32Z", {   } ] := "fitUINT32Z";
typeFunction[ "UnsignedInteger32Z", { _ } ] := "fitUINT32ZA";
typeFunction[ "UnsignedInteger64" , {   } ] := "fitUINT64";
typeFunction[ "UnsignedInteger64" , { _ } ] := "fitUINT64A";
typeFunction[ "DateTime"          , {   } ] := "fitDateTime";
typeFunction[ "String"            , { _ } ] := "fitString";
typeFunction[ ___                         ] := "fitMissing";

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*commentFormula*)
commentFormula // ClearAll;
commentFormula[ c_String ] := First @ StringTrim @ StringSplit[ c, "," ];
commentFormula[ ___      ] := Missing[ "NotAvailable" ];

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
                            #FieldName -> # &,
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
$messageNumbers = AssociationMap[ Reverse, $enumTypeData[ "MessageNumber" ] ];
$fitTypeData = KeySort /@ KeySort @ Association[ makeTypeData /@ $functionData ];

messageSize[ m_ ] := Max[ m[[ All, "Index" ]] /. HoldPattern[ __;;(n_) ] :> n ];

$messageDefinitions = Association @ KeyValueMap[
    #1 -> <|
        "MessageName"   -> #1,
        "MessageNumber" -> $messageNumbers[ #1 ],
        "Size"          -> messageSize[ #2 ],
        "Fields"        -> #2
    |> &,
    $fitTypeData
];


typeFile = FileNameJoin @ { $pacletDir, "Data", "FITMessageDefinitions.wl" };
GeneralUtilities`EnsureDirectory @ DirectoryName @ typeFile;
$exportedTypeData = Export[ typeFile, formatWithNotice @ $messageDefinitions, "String" ];
cicd`ConsoleLog[ "Updated FIT message data: " <> $exportedTypeData ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Configuration*)
$fullInvalidValues = Association[
    Union @ Cases[
        $messageDefinitions,
        KeyValuePattern @ { "Type" -> type_, "Invalid" -> inv_ } :>
            (type -> inv),
        { 3 }
    ],
    $invalidValues
];

$config = <|
    "PacletName"            -> $thisPacletName,
    "PacletVersion"         -> $thisPacletVersion,
    "SerialNumber"          -> $pacletSerialNumber,
    "ManufacturerID"        -> $manufacturerID,
    "ManufacturerString"    -> $manufacturerString,
    "ProductID"             -> $productNumber,
    "MessageTensorRowWidth" -> $maxIndex,
    "InitializationValues"  -> KeySort @ $fullInvalidValues
|>;

configFile = FileNameJoin @ { $pacletDir, "Data", "FITConfig.wl" };
GeneralUtilities`EnsureDirectory @ DirectoryName @ configFile;
$exportedConfigData = Export[ configFile, formatWithNotice @ $config, "String" ];
cicd`ConsoleLog[ "Updated FIT config data: " <> $exportedConfigData ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Icons*)
recolorIcon // ClearAll;
recolorIcon[ Graphics[ gfx_, opts___ ] ] := Graphics[ { Gray, gfx }, opts ];
recolorIcon[ other_ ] := other;


$iconData = <|
    "Type" -> <|
        None                           -> Entity[ "Icon", "Information"             ][ "Image" ],
        "Device"                       -> Entity[ "Icon", "SmartPhone"              ][ "Image" ],
        "Settings"                     -> Entity[ "Icon", "HardwareStore"           ][ "Image" ],
        "Sport"                        -> Entity[ "Icon", "SportsAndRecreation"     ][ "Image" ],
        "Activity"                     -> Entity[ "Icon", "Athletics"               ][ "Image" ],
        "Workout"                      -> Entity[ "Icon", "Weightlifting"           ][ "Image" ],
        "Course"                       -> Entity[ "Icon", "SelfGuidingTrail"        ][ "Image" ],
        "Schedules"                    -> Entity[ "Icon", "Watches"                 ][ "Image" ],
        "Weight"                       -> Entity[ "Icon", "WeighStation"            ][ "Image" ],
        "Totals"                       -> Entity[ "Icon", "ExerciseAndFitness"      ][ "Image" ],
        "Goals"                        -> Entity[ "Icon", "AstronomicalObservatory" ][ "Image" ],
        "BloodPressure"                -> Entity[ "Icon", "FirstAid"                ][ "Image" ],
        "MonitoringA"                  -> Entity[ "Icon", "Earthquake"              ][ "Image" ],
        "ActivitySummary"              -> Entity[ "Icon", "Athletics"               ][ "Image" ],
        "MonitoringDaily"              -> Entity[ "Icon", "Earthquake"              ][ "Image" ],
        "MonitoringB"                  -> Entity[ "Icon", "Earthquake"              ][ "Image" ],
        "Segment"                      -> Entity[ "Icon", "Highway"                 ][ "Image" ],
        "SegmentList"                  -> Entity[ "Icon", "Highway"                 ][ "Image" ],
        "ExtendedDisplayConfiguration" -> Entity[ "Icon", "ComputerMonitor"         ][ "Image" ]
    |>,
    "Sport" -> <|
        "All"                   -> Entity[ "Icon", "Athletics"             ][ "Image" ],
        "AlpineSkiing"          -> Entity[ "Icon", "DownhillSkiing"        ][ "Image" ],
        "AmericanFootball"      -> Entity[ "Icon", "AmericanFootballField" ][ "Image" ],
        "Basketball"            -> Entity[ "Icon", "Basketball"            ][ "Image" ],
        "Boating"               -> Entity[ "Icon", "Anchor"                ][ "Image" ],
        "Boxing"                -> Entity[ "Icon", "Boxing"                ][ "Image" ],
        "CrossCountrySkiing"    -> Entity[ "Icon", "CrossCountrySkiTrail"  ][ "Image" ],
        "Cycling"               -> Entity[ "Icon", "Cycling"               ][ "Image" ],
        "Diving"                -> Entity[ "Icon", "Diving"                ][ "Image" ],
        "Driving"               -> Entity[ "Icon", "FourWheelDriveRoad"    ][ "Image" ],
        "ElectricBiking"        -> Entity[ "Icon", "MotorBikeTrail"        ][ "Image" ],
        "Fishing"               -> Entity[ "Icon", "Fishing"               ][ "Image" ],
        "FitnessEquipment"      -> Entity[ "Icon", "FitnessCenter"         ][ "Image" ],
        "FloorClimbing"         -> Entity[ "Icon", "HoldHandRail"          ][ "Image" ],
        "Flying"                -> Entity[ "Icon", "AirShow"               ][ "Image" ],
        "Generic"               -> Entity[ "Icon", "ExerciseAndFitness"    ][ "Image" ],
        "Golf"                  -> Entity[ "Icon", "Golfing"               ][ "Image" ],
        "HangGliding"           -> Entity[ "Icon", "HangGliding"           ][ "Image" ],
        "Hiking"                -> Entity[ "Icon", "Trailhead"             ][ "Image" ],
        "HorsebackRiding"       -> Entity[ "Icon", "HorsebackRiding"       ][ "Image" ],
        "Hunting"               -> Entity[ "Icon", "Shooting"              ][ "Image" ],
        "IceSkating"            -> Entity[ "Icon", "IceSkating"            ][ "Image" ],
        "InlineSkating"         -> Entity[ "Icon", "InlineSkating"         ][ "Image" ],
        "Jumpmaster"            -> Entity[ "Icon", "Flight"                ][ "Image" ],
        "Kayaking"              -> Entity[ "Icon", "Kayaking"              ][ "Image" ],
        "Kitesurfing"           -> Entity[ "Icon", "Sailing"               ][ "Image" ],
        "Motorcycling"          -> Entity[ "Icon", "MotorBikeTrail"        ][ "Image" ],
        "Mountaineering"        -> Entity[ "Icon", "Climbing"              ][ "Image" ],
        "MultiSport"            -> Entity[ "Icon", "ExerciseAndFitness"    ][ "Image" ],
        "Paddling"              -> Entity[ "Icon", "Rowboating"            ][ "Image" ],
        "Rafting"               -> Entity[ "Icon", "RiverRafting"          ][ "Image" ],
        "RockClimbing"          -> Entity[ "Icon", "Climbing"              ][ "Image" ],
        "Rowing"                -> Entity[ "Icon", "Rowing"                ][ "Image" ],
        "Running"               -> Entity[ "Icon", "Running"               ][ "Image" ],
        "Sailing"               -> Entity[ "Icon", "Sailing"               ][ "Image" ],
        "SkyDiving"             -> Entity[ "Icon", "Flight"                ][ "Image" ],
        "Snowboarding"          -> Entity[ "Icon", "Snowboarding"          ][ "Image" ],
        "Snowmobiling"          -> Entity[ "Icon", "SnowmobileTrail"       ][ "Image" ],
        "Snowshoeing"           -> Entity[ "Icon", "SnowShoeing"           ][ "Image" ],
        "Soccer"                -> Entity[ "Icon", "Soccer"                ][ "Image" ],
        "StandUpPaddleboarding" -> Entity[ "Icon", "SprintCanoeing"        ][ "Image" ],
        "Surfing"               -> Entity[ "Icon", "Surfing"               ][ "Image" ],
        "Swimming"              -> Entity[ "Icon", "Swimming"              ][ "Image" ],
        "Tactical"              -> Entity[ "Icon", "Geocache"              ][ "Image" ],
        "Tennis"                -> Entity[ "Icon", "Tennis"                ][ "Image" ],
        "Training"              -> Entity[ "Icon", "Weightlifting"         ][ "Image" ],
        "Transition"            -> Entity[ "Icon", "Information"           ][ "Image" ],
        "Wakeboarding"          -> Entity[ "Icon", "Waterskiing"           ][ "Image" ],
        "Walking"               -> Entity[ "Icon", "Walking"               ][ "Image" ],
        "WaterSkiing"           -> Entity[ "Icon", "Waterskiing"           ][ "Image" ],
        "Windsurfing"           -> Entity[ "Icon", "WindSurfing"           ][ "Image" ]
    |>
|> /. gfx_Graphics :> RuleCondition @ recolorIcon @ gfx;

iconFile = FileNameJoin @ { $pacletDir, "Data", "FITIcons.wxf" };
GeneralUtilities`EnsureDirectory @ DirectoryName @ iconFile;
$exportedIconData = Export[ iconFile, $iconData, "WXF" ];
cicd`ConsoleLog[ "Updated FIT icon data: " <> $exportedIconData ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Exit*)

Exit[ 0 ];

(* :!CodeAnalysis::EndBlock:: *)