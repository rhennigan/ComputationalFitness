(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`" ];
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
    $$assoc,
    $$bytes,
    $$co,
    $$file,
    $$lo,
    $$resp,
    $$source,
    $$string,
    $$target,
    $$url,
    $fitIcons,
    $messageSymbol,
    $mxExclusions,
    $thisPacletLocation,
    $top,
    beginDefinition,
    cacheBlock,
    cached,
    catchFormattingTop,
    catchMine,
    catchTop,
    catchTopAs,
    compactFitFitnessDataQ,
    endDefinition,
    findFile,
    getDataFile,
    importXML,
    messageFailure,
    messagePrint,
    optionsAssociation,
    rawDataQ,
    recompileLibraries,
    setIfUndefined,
    throwFailure,
    throwInternalFailure,
    toNiceCamelCase
];

EndPackage[ ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Load Files*)
<<`Utilities`;
<<`Data`;
<<`Config`;
<<`Strings`;
<<`FIT`;
<<`TCX`;
<<`ZWO`;
<<`FitnessData`;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*End Package*)
EndPackage[ ];
