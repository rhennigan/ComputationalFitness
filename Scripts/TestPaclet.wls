#!/usr/bin/env wolframscript

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
If[ ! TrueQ @ $loadedDefinitions, Get @ FileNameJoin @ { DirectoryName @ $InputFileName, "Common.wl" } ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Arguments*)
$plaintext = cicd`ScriptConfirmMatch[ getBooleanArgument[ { "p", "plaintext" }, False ], True|False ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*TestReport Options*)
SetOptions[
    TestReport,
    HandlerFunctions -> <|
        "FileStarted"  -> Function @ logPrint[ "Starting test file: ", #[ "TestFileName" ] ],
        "FileFinished" -> Function @ logPrint[ "Finished test file: ", #[ "TestFileName" ] ],
        "TestCreated"  -> Function @ logPrint[ "\tCurrent test: " , #[ "TestObject" ][ "TestID" ] ]
    |>,
    HandlerFunctionsKeys -> { "TestFileName", "TestObject" },
    ProgressReporting    -> False
];

SetOptions[ First @ Streams[ "stdout" ], PageWidth -> Infinity ];
SetOptions[ First @ Streams[ "stderr" ], PageWidth -> Infinity ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Definitions*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*printTextOutput*)
(* :!CodeAnalysis::BeginBlock:: *)
(* :!CodeAnalysis::Disable::SuspiciousSessionSymbol:: *)
printTestMarkdown // ClearAll;
printTestMarkdown[ res_Association ] := Print @ testResultsToMarkdown @ res;
(* :!CodeAnalysis::EndBlock:: *)

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*testResultsToMarkdown*)
testResultsToMarkdown // ClearAll;

testResultsToMarkdown[ resultsByFile_Association ] :=
    Module[ { overall, fileSections },
        overall      = overallSummaryMarkdown @ resultsByFile;
        fileSections = KeyValueMap[ fileResultsMarkdown, resultsByFile ];
        StringRiffle[ Flatten @ { overall, fileSections }, "\n\n" ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*overallSummaryMarkdown*)
overallSummaryMarkdown // ClearAll;

overallSummaryMarkdown[ resultsByFile_Association ] :=
    Module[
        {
            reports, totalFiles, totalTests, totalPassed, totalFailed,
            totalTime, passPercent, failPercent, outcome
        },

        reports     = Values @ resultsByFile;
        totalFiles  = Length @ reports;
        totalTests  = Total[ #[ "TestsSucceededCount" ] + #[ "TestsFailedCount" ] & /@ reports ];
        totalPassed = Total[ #[ "TestsSucceededCount" ] & /@ reports ];
        totalFailed = Total[ #[ "TestsFailedCount" ] & /@ reports ];
        totalTime   = Total[ #[ "TimeElapsed" ] & /@ reports ];
        passPercent = If[ totalTests > 0, Round[ 100.0 * totalPassed / totalTests, 0.1 ], 0 ];
        failPercent = If[ totalTests > 0, Round[ 100.0 * totalFailed / totalTests, 0.1 ], 0 ];
        outcome     = If[ totalFailed === 0, "Success", "Failure" ];

        StringJoin[
            "# Test Results Summary\n\n",
            "| Metric | Value |\n",
            "| --- | --- |\n",
            "| **Overall Result** | ", outcome, " |\n",
            "| **Total Files** | ", ToString @ totalFiles, " |\n",
            "| **Total Tests** | ", ToString @ totalTests, " |\n",
            "| **Passed** | ", ToString @ totalPassed, " (", formatPercent @ passPercent, ") |\n",
            "| **Failed** | ", ToString @ totalFailed, " (", formatPercent @ failPercent, ") |\n",
            "| **Total Time** | ", formatTime @ totalTime, " |"
        ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fileResultsMarkdown*)
fileResultsMarkdown // ClearAll;

fileResultsMarkdown[ file_String, report_TestReportObject ] :=
    Module[
        {
            fileName, passed, failed, total, time,
            passPercent, failPercent, summaryTable, failedTests, failedSection
        },

        fileName    = FileNameTake @ file;
        passed      = report[ "TestsSucceededCount" ];
        failed      = report[ "TestsFailedCount" ];
        total       = passed + failed;
        time        = report[ "TimeElapsed" ];
        passPercent = If[ total > 0, Round[ 100.0 * passed / total, 0.1 ], 0 ];
        failPercent = If[ total > 0, Round[ 100.0 * failed / total, 0.1 ], 0 ];

        summaryTable = StringJoin[
            "## ", fileName, "\n\n",
            "| Metric | Value |\n",
            "| --- | --- |\n",
            "| **Tests** | ", ToString @ total, " |\n",
            "| **Passed** | ", ToString @ passed, " (", formatPercent @ passPercent, ") |\n",
            "| **Failed** | ", ToString @ failed, " (", formatPercent @ failPercent, ") |\n",
            "| **Time** | ", formatTime @ time, " |"
        ];

        failedTests = DeleteCases[ report[ "TestsFailed" ], <||> ];

        If[ Length @ Flatten @ Values @ failedTests === 0,
            summaryTable,
            failedSection = StringRiffle[
                Flatten @ {
                    failedTestsSection[ "Wrong Results", failedTests[ "TestsFailedWrongResults" ] ],
                    failedTestsSection[ "Message Failures", failedTests[ "TestsFailedWithMessages" ] ],
                    failedTestsSection[ "Errors", failedTests[ "TestsFailedWithErrors" ] ]
                },
                "\n\n"
            ];
            StringJoin[ summaryTable, "\n\n", failedSection ]
        ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*failedTestsSection*)
failedTestsSection // ClearAll;

failedTestsSection[ _, { } | <||> | _Missing ] := Nothing;

failedTestsSection[ title_String, tests_Association ] :=
    failedTestsSection[ title, Values @ tests ];

failedTestsSection[ title_String, tests_List ] :=
    Module[ { header, testDetails },
        header      = "### " <> title;
        testDetails = failedTestMarkdown /@ tests;
        StringRiffle[ Prepend[ testDetails, header ], "\n\n" ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*failedTestMarkdown*)
failedTestMarkdown // ClearAll;

failedTestMarkdown[ test: (_TestResultObject | _TestObject) ] :=
    Module[ { testID, outcome, time, memory, input, expected, actual, expectedMsg, actualMsg, details },

        testID      = test[ "TestID" ];
        outcome     = test[ "Outcome" ];
        time        = formatTime @ test[ "AbsoluteTimeUsed" ];
        memory      = formatMemory @ test[ "MemoryUsed" ];
        input       = formatHeldCode @ test[ "Input" ];
        expected    = formatHeldCode @ test[ "ExpectedOutput" ];
        actual      = formatHeldCode @ test[ "ActualOutput" ];
        expectedMsg = formatHeldCode @ test[ "ExpectedMessages" ];
        actualMsg   = formatHeldCode @ test[ "ActualMessages" ];

        details = {
            "#### " <> ToString @ testID,
            "| Property | Value |",
            "| --- | --- |",
            "| **Outcome** | " <> ToString @ outcome <> " |",
            "| **Time** | " <> time <> " |",
            "| **Memory** | " <> memory <> " |",
            "",
            "**Input:**",
            "```wl",
            input,
            "```",
            "",
            "**Expected Output:**",
            "```wl",
            expected,
            "```",
            "",
            "**Actual Output:**",
            "```wl",
            actual,
            "```"
        };

        If[ expectedMsg =!= "{ }" && actualMsg =!= "{ }",
            details = Join[ details, {
                "",
                "**Expected Messages:**",
                "```wl",
                expectedMsg,
                "```",
                "",
                "**Actual Messages:**",
                "```wl",
                actualMsg,
                "```"
            } ]
        ];

        StringRiffle[ details, "\n" ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*formatHeldCode*)
formatHeldCode // ClearAll;

formatHeldCode[ (HoldForm | HoldCompleteForm)[ expr_ ] ] :=
    Module[ { str },
        str = ToString @ Wolfram`PacletCICD`ReadableForm[ Unevaluated @ expr, TimeConstraint -> 3 ];
        If[ StringLength @ str > 500,
            StringTake[ str, 250 ] <> " ... " <> StringTake[ str, -250 ],
            str
        ]
    ];

formatHeldCode[ expr_ ] := formatHeldCode @ HoldForm @ expr;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*formatTime*)
formatTime // ClearAll;

formatTime[ sec_? NumericQ ] :=
    Which[
        sec < 0.001,  "< 1 ms",
        sec < 1,      ToString @ Round[ 1000 * sec ] <> " ms",
        sec < 60,     ToString @ Round[ sec, 0.1 ] <> " s",
        sec < 3600,   ToString @ Round[ sec / 60, 0.1 ] <> " min",
        True,         ToString @ Round[ sec / 3600, 0.1 ] <> " h"
    ];

formatTime[ Quantity[ val_, _ ] ] := formatTime @ val;
formatTime[ _ ] := "N/A";

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*formatMemory*)
formatMemory // ClearAll;

formatMemory[ bytes_? NumericQ ] :=
    Which[
        bytes < 1024,          ToString @ Round @ bytes <> " B",
        bytes < 1024^2,        ToString @ Round[ bytes / 1024.0, 0.1 ] <> " KB",
        bytes < 1024^3,        ToString @ Round[ bytes / 1024.0^2, 0.01 ] <> " MB",
        True,                  ToString @ Round[ bytes / 1024.0^3, 0.001 ] <> " GB"
    ];

formatMemory[ Quantity[ val_, _ ] ] := formatMemory @ val;
formatMemory[ _ ] := "N/A";

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*formatPercent*)
formatPercent // ClearAll;
formatPercent[ n_? NumericQ ] := StringReplace[ ToString @ Round[ n, 0.1 ] <> "%", ".%" -> "%" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Run*)
If[ $plaintext,
    res = AssociationMap[
        TestReport @* File,
        FileNames[ "*.wlt", FileNameJoin @ { $pacletDir, "Tests" }, Infinity ]
    ];
    printTestMarkdown @ res;
    ,
    checkResult @ Wolfram`PacletCICD`TestPaclet @ FileNameJoin @ { $pacletDir, "Tests" }
]