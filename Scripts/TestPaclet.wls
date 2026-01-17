#!/usr/bin/env wolframscript

If[ ! TrueQ @ $loadedDefinitions, Get @ FileNameJoin @ { DirectoryName @ $InputFileName, "Common.wl" } ];

checkResult @ Wolfram`PacletCICD`TestPaclet @ FileNameJoin @ { $pacletDir, "Tests" }