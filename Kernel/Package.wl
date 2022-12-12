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
    `$MaxHeartRate,
    `$Sport,
    `$Weight
];

(* Clear for new definitions: *)
GeneralUtilities`UnprotectAndClearAll[
    `ComputationalFitness,
    `FITExport,
    `FITFileType,
    `FITImport,
    `FunctionalThresholdPower,
    `MaxHeartRate,
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
    `$messageSymbol,
    `$thisPacletLocation,
    `beginDefinition,
    `cacheBlock,
    `cached,
    `catchMine,
    `catchTop,
    `catchTopAs,
    `endDefinition,
    `findFile,
    `messageFailure,
    `messagePrint,
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

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*End Package*)
EndPackage[ ];
