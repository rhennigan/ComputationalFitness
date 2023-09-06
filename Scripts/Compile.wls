#!/usr/bin/env wolframscript

(* :!CodeAnalysis::BeginBlock:: *)
(* :!CodeAnalysis::Disable::SuspiciousSessionSymbol:: *)

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
If[ ! TrueQ @ $loadedDefinitions, Get @ FileNameJoin @ { DirectoryName @ $InputFileName, "Common.wl" } ];
Needs[ "CCompilerDriver`" -> "ccd`"  ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Paths*)
$targetDir = cStr @ FileNameJoin @ { $pacletDir, "LibraryResources" };

cicd`ConsoleLog[ "Build target directory: " <> $targetDir ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Compile*)
cicd`ScriptConfirmMatch[ PacletDirectoryLoad @ $pacletDir, { ___, $pacletDir, ___ } ];
Get[ "RH`ComputationalFitness`" ];

cicd`ConsoleLog[ "Compiling libraries..." ];
$compiled = RH`ComputationalFitness`Package`recompileLibraries[ True ];

cicd`ScriptConfirmAssert[ FileExistsQ @ $compiled[ "FITImportExport" ] ];
cicd`ScriptConfirmAssert[ AssociationQ @ $compiled[ "CodeFunctions" ] ];
cicd`ScriptConfirmAssert[ Length @ $compiled[ "CodeFunctions" ] > 0 ];
cicd`ScriptConfirmAssert[ AllTrue[ $compiled[ "CodeFunctions" ], FileExistsQ ] ];

printBuilt // ClearAll;
printBuilt[ as_Association ] := printBuilt /@ as;
printBuilt[ file_String? FileExistsQ ] := cicd`ConsoleLog[ "    " <> file ];
printBuilt[ ___ ] := cicd`ConsoleError[ "Failed to build the library.", "Fatal" -> True ];

cicd`ConsoleLog[ "Built libraries:" ];
printBuilt @ $compiled;
$compiled

(* :!CodeAnalysis::EndBlock:: *)