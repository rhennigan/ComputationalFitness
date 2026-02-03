#!/usr/bin/env wolframscript

If[ ! TrueQ @ $loadedDefinitions, Get @ FileNameJoin @ { DirectoryName @ $InputFileName, "Common.wl" } ];

Block[ { messagePrint }, checkResult @ Wolfram`PacletCICD`TestPaclet @ FileNameJoin @ { $pacletDir, "Tests" } ]