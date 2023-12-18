(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RickHennigan`ComputationalFitness`" ];
Needs[ "GeneralUtilities`" -> None ];

(* ::**************************************************************************************************************:: *)
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
    `FitnessDataQ,
    `FunctionalThresholdPower,
    `MaximumHeartRate,
    `PowerZoneColorFunction,
    `Sport,
    `TCXImport,
    `Weight,
    `ZWOExport,
    `ZWOImport
];

(* ::**************************************************************************************************************:: *)
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
    `$$assoc,
    `$$bytes,
    `$$co,
    `$$file,
    `$$lo,
    `$$resp,
    `$$source,
    `$$string,
    `$$target,
    `$$url,
    `$fitIcons,
    `$ftp,
    `$maxHR,
    `$messageSymbol,
    `$mxExclusions,
    `$sport,
    `$thisPacletLocation,
    `$top,
    `$weight,
    `beginDefinition,
    `cacheBlock,
    `cached,
    `catchFormattingTop,
    `catchMine,
    `catchTop,
    `catchTopAs,
    `compactFitFitnessDataQ,
    `endDefinition,
    `findFile,
    `getDataFile,
    `importXML,
    `messageFailure,
    `messagePrint,
    `optionsAssociation,
    `rawDataQ,
    `recompileLibraries,
    `registeredFormatQ,
    `registerFormats,
    `secondsToQuantity, (* TODO: move to a dedicated Units.wl file *)
    `setFTP,
    `setIfUndefined,
    `setMaxHR,
    `setSport,
    `setUnitSystem,
    `setWeight,
    `sourceFileApply,
    `throwFailure,
    `throwInternalFailure,
    `toNiceCamelCase
];

EndPackage[ ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Load Files*)
<<`Utilities`;
<<`Data`;
<<`Config`;
<<`Strings`;
<<`ImportExport`;
<<`FIT`;
<<`TCX`;
<<`ZWO`;
<<`FitnessData`;
<<`Initialization`;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*End Package*)
EndPackage[ ];
