(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Nice Capitalization*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*toNiceCamelCase*)
toNiceCamelCase // beginDefinition;

toNiceCamelCase[ s_String ] :=
    snakeToCamel @ StringDelete[ s, StartOfString~~$deletePrefixes ];

toNiceCamelCase // endDefinition;

$deletePrefixes = Alternatives[
    "FIT_MESG_NUM_"
];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*snakeToCamel*)
snakeToCamel // beginDefinition;

snakeToCamel[ s_String ] :=
    StringReplace[
        StringJoin @ ReplaceAll[
            capitalize @ ToLowerCase @ StringSplit[
                StringReplace[ s, a_? LowerCaseQ ~~ b_? UpperCaseQ :> a <> "_" <> b ],
                { "_", d: DigitCharacter.. :> d }
            ],
            $capitalizationRules1
        ],
        $capitalizationRules2
    ];

snakeToCamel // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*capitalize*)
capitalize // beginDefinition;
capitalize // Attributes = { Listable };

capitalize[ s_String ] :=
    If[ TrueQ[ StringLength @ s <= 3 && ! DictionaryWordQ @ s ],
        ToUpperCase @ s,
        Capitalize @ s
    ];

capitalize // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$capitalizationRules1*)
$capitalizationRules1 // ClearAll;
$capitalizationRules1 = {
(* cSpell:disable *)
    "Accel"           -> "Acceleration",
    "Ant"             -> "ANT",
    "Auto"            -> "Automatic",
    "Aux"             -> "Auxiliary",
    "AUX"             -> "Auxiliary",
    "Avg"             -> "Average",
    "Bool"            -> "Boolean",
    "Bosu"            -> "BOSU",
    "BPM"             -> "BeatsPerMinute",
    "Calc"            -> "Calculation",
    "Cmplt"           -> "Complete",
    "CNT"             -> "Count",
    "COMM"            -> "Communication",
    "Conc"            -> "Concentration",
    "Connectiq"       -> "ConnectIQ",
    "Dist"            -> "Distance",
    "Elev"            -> "Elevation",
    "Enum"            -> "Enumeration",
    "ENV"             -> "Environment",
    "EXD"             -> "ExtendedDisplay",
    "Ftp"             -> "FTP",
    "Hr"              -> "HeartRate",
    "HR"              -> "HeartRate",
    "Hrm"             -> "HeartRateMonitor",
    "HRM"             -> "HeartRateMonitor",
    "HRR"             -> "RestingHeartRate",
    "Hrv"             -> "HeartRateVariability",
    "HRV"             -> "HeartRateVariability",
    "HW"              -> "Hardware",
    "Ia"              -> "IA",
    "Ib"              -> "IB",
    "Id"              -> "ID",
    "IDX"             -> "Index",
    "Iia"             -> "IIA",
    "Iib"             -> "IIB",
    "Iiia"            -> "IIIA",
    "Iiib"            -> "IIIB",
    "Info"            -> "Information",
    "INV"             -> "Invalid",
    "Iva"             -> "IVA",
    "Ivb"             -> "IVB",
    "LEV"             -> "LightElectricalVehicle",
    "Max"             -> "Maximum",
    "Mesg"            -> "Message",
    "Met"             -> "MET",
    "Mfg"             -> "Manufacturer",
    "Mgrs"            -> "MGRS",
    "Min"             -> "Minimum",
    "Ms"              -> "Milliseconds",
    "N2"              -> "Nitrogen",
    "NDL"             -> "NoDecompressionLimit",
    "Nmea"            -> "NMEA",
    "Num"             -> "Number",
    "NUM"             -> "Number",
    "Obdii"           -> "OBDII",
    "Ohr"             -> "OHR",
    "OHR"             -> "OpticalHeartRate",
    "Oled"            -> "OLED",
    "PCO"             -> "PlatformCenterOffset",
    "PWR"             -> "Power",
    "Ref"             -> "Reference",
    "REF"             -> "Reference",
    "Rpm"             -> "RevolutionsPerMinute",
    "Rso"             -> "RSO",
    "RX"              -> "Receive",
    "SDM"             -> "StrideAndDistanceMonitor",
    "Sint"            -> "SignedInteger",
    "Soc"             -> "StateOfCharge",
    "SPD"             -> "Speed",
    "Spdcad"          -> "SpeedCadence",
    "TX"              -> "Transmit",
    "Uint"            -> "UnsignedInteger",
    "Ups"             -> "UPS",
    "Us"              -> "US",
    "Utm"             -> "UTM",
    "Uuid"            -> "UUID",
    "VAM"             -> "AverageAscentSpeed",
    "VMG"             -> "VelocityMadeGood",
    "WKT"             -> "Workout",
    Nothing
(* cSpell:enable *)
};

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$capitalizationRules2*)
$capitalizationRules2 // ClearAll;
$capitalizationRules2 = {
(* cSpell:disable *)
    "24H"~~EndOfString                   -> "24Hour",
    "3Way"                               -> "ThreeWay",
    "ActiveMET"                          -> "ActiveMetabolicRate",
    "Antfs"                              -> "ANTFS",
    "Antplus"                            -> "ANTPlus",
    "Autolap"                            -> "AutoLap",
    "Autoscroll"                         -> "AutoScroll",
    "Autosync"                           -> "AutoSync",
    "AverageAverageAscentSpeed"          -> "AverageAscentSpeed",
    "BasalMET"                           -> "BasalMetabolicRate",
    "BikeCadANT"                         -> "BikeCadenceANT",
    "BikeSPD"                            -> "BikeSpeed",
    "BluetoothLe"                        -> "BluetoothLE",
    "CadEnabled"                         -> "CadenceEnabled",
    "CadHigh"                            -> "CadenceHigh",
    "CadLow"                             -> "CadenceLow",
    "Cal"~~EndOfString                   -> "Calibration",
    "CalFactor"                          -> "CalibrationFactor",
    "CNSLoad"                            -> "CentralNervousSystemLoading",
    "CumOperatingTime"                   -> "CumulativeOperatingTime",
    "Datatype"                           -> "DataType",
    "Distoffset"                         -> "DistanceOffset",
    "Ebike"                              -> "ElectricBike",
    "EBike"                              -> "ElectricBike",
    "EBiking"                            -> "ElectricBiking",
    "Entid"                              -> "EntityID",
    "Float32"                            -> "Real32",
    "Float64"                            -> "Real64",
    "Freeride"                           -> "FreeRide",
    "Ftptest"                            -> "FTPTest",
    "Gameplayevent"                      -> "GamePlayEvent",
    "Grouptrack"                         -> "GroupTrack",
    "InchesHG"                           -> "InchesOfMercury",
    "Localtime"                          -> "LocalTime",
    "LocationLat"~~EndOfString           -> "Latitude",
    "LocationLong"~~EndOfString          -> "Longitude",
    "Mbars"                              -> "Millibars",
    "METZone"                            -> "MetabolicZone",
    "MmHG"                               -> "MillimetersOfMercury",
    "Multisport"                         -> "MultiSport",
    "Navaid"                             -> "NavigationAid",
    "NECLat"                             -> "NorthEastCornerLatitude",
    "NECLong"                            -> "NorthEastCornerLongitude",
    "NegGrade"                           -> "NegativeGrade",
    "NegVertical"                        -> "NegativeVertical",
    "NumberActiveLengths"                -> "NumberOfActiveLengths",
    "NumberLaps"                         -> "NumberOfLaps",
    "NumberLengths"                      -> "NumberOfLengths",
    "NumberSessions"                     -> "NumberOfSessions",
    "NumberValid"                        -> "NumberOfValid",
    "OneDSensor"                         -> "OneDimensionalSensor",
    "Paceid"                             -> "PaceID",
    "PerSec"~~EndOfString                -> "PerSecond",
    "Plyo"                               -> "Plyometrics",
    "PosGrade"                           -> "PositiveGrade",
    "PositionLat"~~EndOfString           -> "PositionLatitude",
    "PositionLong"~~EndOfString          -> "PositionLongitude",
    "PosVertical"                        -> "PositiveVertical",
    "Ramptest"                           -> "RampTest",
    "Spdcad"                             -> "SpeedCadence",
    "SWCLat"                             -> "SouthWestCornerLatitude",
    "SWCLong"                            -> "SouthWestCornerLongitude",
    "Textevent"                          -> "TextEvent",
    "Textscale"                          -> "TextScale",
    "ThreeDSensor"                       -> "ThreeDimensionalSensor",
    "Timeoffset"                         -> "TimeOffset",
    "TransType"                          -> "TransmissionType",
    "TwoDSensor"                         -> "TwoDimensionalSensor",
    "Wheelsize"                          -> "WheelSize",
    "Wifi"                               -> "WiFi",
    Nothing
(* cSpell:enable *)
};

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
