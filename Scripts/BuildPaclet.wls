#!/usr/bin/env wolframscript

If[ ! TrueQ @ $loadedDefinitions, Get @ FileNameJoin @ { DirectoryName @ $InputFileName, "Common.wl" } ];
Get @ cFile @ FileNameJoin @ { DirectoryName @ $InputFileName, "BuildMX.wls" };

checkResult @ cicd`BuildPaclet[
    $defNB,
    "Check"      -> True,
    "ExitOnFail" -> True,
    "Target"     -> "Submit"
]