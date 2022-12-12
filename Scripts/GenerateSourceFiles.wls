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

$setTimestampTemplate       = "ImportInteger(`Index`, libData, data, pos, WLTimestamp(mesg->`Name`));";
$setIntegerTemplate         = "ImportInteger(`Index`, libData, data, pos, mesg->`Name`);";
$setIntegerSequenceTemplate = "ImportIntegerSequence(`Index`, libData, data, pos, mesg->`Name`, `Count`);";
$setFloatTemplate           = "ImportFloat(`Index`, libData, data, pos, mesg->`Name`);";
$setFloatSequenceTemplate   = "ImportFloatSequence(`Index`, libData, data, pos, mesg->`Name`, `Count`);";
$setStringTemplate          = "ImportString(`Index`, libData, data, pos, mesg->`Name`, `Count`);";
$setDoneTemplate            = "ImportFinish(`Index`, libData, data, pos);";
$funcHeaderTemplate         = "static void `Name`(WolframLibraryData libData, MTensor data, int idx, const `Type` *mesg)";

$importCaseTemplate = "\
                    case `MessageNumber`:
                    {
                        const `Type` *new = (`Type` *) mesg;
                        idx++;
                        `FunctionName`(libData, data, idx, new);
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


makeSetIntegerStringN // ClearAll;

makeSetIntegerStringN[ str_String ] :=
    makeSetIntegerStringN @ StringSplit[ str, " " ];

makeSetIntegerStringN[ { type_String, val_ } ] :=
    makeSetIntegerStringN[ type, StringSplit[ val, "[" | "]" ] ];

makeSetIntegerStringN[ $$dateType, { name_String } ] :=
    TemplateApply[
        $setTimestampTemplate,
        <|
            "Name"  -> name,
            "Index" -> nextNamedIndex[ name ]
        |>
    ];

makeSetIntegerStringN[ $$integerType | $$enumType, { name_String } ] :=
    TemplateApply[
        $setIntegerTemplate,
        <|
            "Name"  -> name,
            "Index" -> nextNamedIndex[ name ]
        |>
    ];

makeSetIntegerStringN[
    $$integerType | $$enumType,
    { name_String, count_String }
] :=
    With[ { s = sizes @ count },
        TemplateApply[
            $setIntegerSequenceTemplate,
            <|
                "Name"  -> name,
                "Index" -> nextNamedIndex[ name, s ],
                "Count" -> count
            |>
        ] /;
            IntegerQ @ s
    ];

makeSetIntegerStringN[ "FIT_FLOAT32", { name_String } ] :=
    TemplateApply[
        $setFloatTemplate,
        <|
            "Name"  -> name,
            "Index" -> nextNamedIndex[ name ]
        |>
    ];

makeSetIntegerStringN[ "FIT_FLOAT32", { name_String, count_String } ] :=
    With[ { s = sizes @ count },
        TemplateApply[
            $setFloatSequenceTemplate,
            <|
                "Name"  -> name,
                "Index" -> nextNamedIndex[ name, s ],
                "Count" -> count
            |>
        ] /;
            IntegerQ @ s
    ];

makeSetIntegerStringN[ "FIT_STRING", { name_String, count_String } ] :=
    With[ { s = sizes @ count },
        TemplateApply[
            $setStringTemplate,
            <|
                "Name"  -> name,
                "Index" -> nextNamedIndex[ name, s ],
                "Count" -> count
            |>
        ]
    ];



makeImportData[ struct_ ] :=
    Block[ { $index = 0, $indexedNames = Internal`Bag[ ] },
        Module[
            {
                structLines,
                codeBlock,
                type,
                funcName,
                funcHeader,
                funcDef,
                mesgNum,
                lastIndex
            },

            structLines =
                StringTrim @ StringDelete[
                    struct,
                    { StartOfString ~~ $structHead, $structFoot ~~ EndOfString }
                ];

            $index = 1;

            codeBlock =
                StringJoin[
                    "    ",
                    StringRiffle[
                        Map[
                            makeSetIntegerStringN,
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


            funcName =
                StringJoin[
                    "import_",
                    ToLowerCase @ StringDelete[
                        type,
                        { StartOfString ~~ "FIT_", "_MESG" ~~ EndOfString }
                    ]
                ];


            funcHeader =
                TemplateApply[
                    $funcHeaderTemplate,
                    <|
                        "Name" -> funcName,
                        "Type" -> type
                    |>
                ];

            lastIndex = nextIndex[ ];

            mesgNum = StringReplace[
                            type,
                            "FIT_" ~~ base__ ~~ "_MESG" :>
                                "FIT_MESG_NUM_" <> base
                        ];

            funcDef =
                StringJoin[
                    funcHeader,
                    "\n",
                    "{\n",
                    "    mint pos[2] = {idx, 0};\n",
                    StringJoin[
                        "    ImportInteger(1, libData, data, pos, ",
                        mesgNum,
                        ");\n"
                    ],
                    codeBlock,
                    "\n    ",
                    TemplateApply[
                        $setDoneTemplate,
                        <|
                            "Index" -> lastIndex
                        |>
                    ],
                    "\n",
                    "}"
                ];

            <|
                "Type"               -> type,
                "FunctionName"       -> funcName,
                "FunctionHeader"     -> funcHeader,
                "LastIndex"          -> lastIndex,
                "FunctionDefinition" -> funcDef,
                "MessageNumber"      -> mesgNum,
                "Indices"            -> Association @ Internal`BagPart[ $indexedNames, All ],
                "StructLines"        -> structLines
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



$importData = makeImportData /@ mesgStructs;

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Struct Index*)
makeIndex // ClearAll;
makeIndex[ KeyValuePattern @ { "offset" -> idx_, "list" -> False } ] := idx;
makeIndex[ KeyValuePattern @ { "offset" -> idx_, "list" -> True, "length" -> n_ } ] := idx;;idx + n - 1;



$fitIndex = KeySort[ KeySort /@ KeyMap[
    cf`toNiceCamelCase @ StringDelete[ #1, { StartOfString~~"FIT_", "_MESG"~~EndOfString } ] &,
    Association[ (#Type -> KeyMap[ cf`toNiceCamelCase, makeIndex /@ #Indices ] &) /@ $importData ]
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
    $importData,
    "WXF"
];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Import Functions*)

$importFunctions = StringRiffle[ $importData[[ All, "FunctionDefinition" ]], "\n\n" ];

fitImportSrcFile = cFile @ FileNameJoin @ { $sourceDir, "fit_import.c" };
fitImportString  = StringReplace[ cStr @ ReadString @ fitImportSrcFile, "\r\n" -> "\n" ];
importCases = StringRiffle[
    Map[
        TemplateApply[ $importCaseTemplate, #1 ] &,
        DeleteCases[
            $importData,
            KeyValuePattern[ "MessageNumber" -> "FIT_MESG_NUM_ACTIVITY" ]
        ]
    ],
    "\n"
];

importCounts =
    StringRiffle[
        (TemplateApply[ $importCountTemplate, #1 ] &) /@ $importData,
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

$importFunctionDeclarations = StringRiffle[ (#FunctionHeader <> ";" &) /@ $importData, "\n" ];

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
        ]

cicd`ConsoleLog[ "Updated import header file:" <> fitImportHFile ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Exit*)

Exit[ 0 ];

(* :!CodeAnalysis::EndBlock:: *)