(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`" ];
Needs[ "GeneralUtilities`" -> None ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Exported Symbols*)

(* Preserve values if already set: *)
HoldComplete[
    `$FunctionalThresholdPower,
    `$MaximumHeartRate,
    `$Sport,
    `$Weight
];

(* Clear for new definitions: *)
GeneralUtilities`UnprotectAndClearAll[
    `$FITMessageDefinitions,
    `ComputationalFitness,
    `FITExport,
    `FITFileType,
    `FITFormatQ,
    `FITImport,
    `FITInterpreter,
    `FitnessData,
    `FunctionalThresholdPower,
    `MaximumHeartRate,
    `PowerZoneColorFunction,
    `Sport,
    `TCXImport,
    `Weight,
    `ZWOExport,
    `ZWOImport
];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Symbols*)

(* Shared across subpackages: *)
BeginPackage[ "`Package`" ];

(* Preserve values if already set: *)
HoldComplete[
    `$debug
];

(* Clear for new definitions: *)
GeneralUtilities`UnprotectAndClearAll[
    `$fitIcons,
    `$messageSymbol,
    `$thisPacletLocation,
    `beginDefinition,
    `cacheBlock,
    `cached,
    `catchFormattingTop,
    `catchMine,
    `catchTop,
    `catchTopAs,
    `endDefinition,
    `findFile,
    `messageFailure,
    `messagePrint,
    `recompileLibraries,
    `setIfUndefined,
    `throwFailure,
    `throwInternalFailure,
    `toNiceCamelCase
];

EndPackage[ ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Load Files*)
<<`Utilities`;
<<`FIT`;
<<`TCX`;
<<`FitnessData`;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*End Package*)
EndPackage[ ];
