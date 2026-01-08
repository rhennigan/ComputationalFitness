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
    `EnergySystemStrain,
    `FITExport,
    `FITFileType,
    `FITFormatQ,
    `FITImport,
    `FITInterpreter,
    `FitnessData,
    `FitnessDataQ,
    `FunctionalThresholdPower,
    `MaximumHeartRate,
    `MeanMaximalPowerCurve,
    `MeanMaximalPowerCurvePlot,
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
    `checkPowerArray,
    `clearCache,
    `compactFitFitnessDataQ,
    `compiledFunction,
    `endDefinition,
    `findFile,
    `getDataFile,
    `importXML,
    `libraryError,
    `machineRealArrayQ,
    `messageFailure,
    `messagePrint,
    `numberArrayQ,
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
    `temporalDataOrMissingQ,
    `temporalDataQ,
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
<<`LibraryFunctions`;
<<`FIT`;
<<`TCX`;
<<`ZWO`;
<<`FitnessData`;
<<`MeanMaximalPowerCurve`;
<<`EnergySystemStrain`;
<<`Initialization`;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*End Package*)
EndPackage[ ];
