(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RickHennigan`ComputationalFitness`" ];
Needs[ "RickHennigan`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Messages*)
ComputationalFitness::InvalidCP     = "Critical power (CP) must be a positive number in watts.";
ComputationalFitness::InvalidWPrime = "Work prime (W') must be a positive number in joules or kilojoules.";
ComputationalFitness::InvalidPMax   = "Maximal power (PMax) must be a positive number in watts greater than CP.";
ComputationalFitness::MissingPower  = "No power data available in the input.";

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*EnergySystemStrain*)
EnergySystemStrain // beginDefinition;

EnergySystemStrain[ data_, history_, opts: OptionsPattern[ ] ] :=
    catchMine @ energySystemStrain[ data, history, opts ];

EnergySystemStrain // endExportedDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*energySystemStrain*)
energySystemStrain // beginDefinition;

energySystemStrain[ data_, history_, opts___ ] := Enclose[
    Module[ { params, cp, wPrime, pMax },
        (* Extract or estimate critical power parameters from history *)
        params = ConfirmMatch[
            extractParameters @ history,
            _Association,
            "Parameters"
        ];

        cp     = params[ "CriticalPower" ];
        wPrime = params[ "AnaerobicWorkCapacity" ];
        pMax   = params[ "MaximalInstantaneousPower" ];

        (* Dispatch to appropriate handler based on data type *)
        ConfirmMatch[
            energySystemStrainWithParams[ data, cp, wPrime, pMax, opts ],
            _Association,
            "Result"
        ]
    ],
    throwInternalFailure
];

energySystemStrain // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*criticalPowerParametersQ*)
criticalPowerParametersQ // beginDefinition;

criticalPowerParametersQ[ assoc_Association ] :=
    KeyExistsQ[ assoc, "CriticalPower" ] &&
    KeyExistsQ[ assoc, "AnaerobicWorkCapacity" ] &&
    KeyExistsQ[ assoc, "MaximalInstantaneousPower" ];

criticalPowerParametersQ[ _ ] := False;

criticalPowerParametersQ // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*extractParameters*)
extractParameters // beginDefinition;

(* If history is already an association with the required keys, use it directly *)
extractParameters[ params_Association? criticalPowerParametersQ ] := params;

(* Otherwise, estimate parameters from the history data *)
extractParameters[ history_ ] := Enclose[
    ConfirmMatch[
        EstimateCriticalPowerParameters @ history,
        _Association,
        "EstimatedParameters"
    ],
    throwInternalFailure
];

extractParameters // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*energySystemStrainWithParams*)
energySystemStrainWithParams // beginDefinition;

energySystemStrainWithParams[ power_List? machineRealArrayQ, cp_, wPrime_, pMax_, opts___ ] :=
    machineRealArrayToStrain[ power, cp, wPrime, pMax, opts ];

energySystemStrainWithParams[ power_List? numberArrayQ, cp_, wPrime_, pMax_, opts___ ] :=
    numberArrayToStrain[ power, cp, wPrime, pMax, opts ];

energySystemStrainWithParams[ array_QuantityArray? ArrayQ, cp_, wPrime_, pMax_, opts___ ] :=
    quantityArrayToStrain[ array, cp, wPrime, pMax, opts ];

energySystemStrainWithParams[ timeSeries_TemporalData? temporalDataQ, cp_, wPrime_, pMax_, opts___ ] :=
    temporalDataToStrain[ timeSeries, cp, wPrime, pMax, opts ];

energySystemStrainWithParams[ data_FitnessData? FitnessDataQ, cp_, wPrime_, pMax_, opts___ ] :=
    fitnessDataToStrain[ data, cp, wPrime, pMax, opts ];

energySystemStrainWithParams[ file: _File | _String? FileExistsQ, cp_, wPrime_, pMax_, opts___ ] :=
    fileToStrain[ file, cp, wPrime, pMax, opts ];

energySystemStrainWithParams // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*machineRealArrayToStrain*)
machineRealArrayToStrain // beginDefinition;

machineRealArrayToStrain[ power_List, cp_, wPrime_, pMax_, opts___ ] := Enclose[
    Module[ { cpVal, wPrimeVal, pMaxVal, result },
        (* Validate and extract parameter values *)
        cpVal      = ConfirmBy[ validateCP @ cp, NumberQ, "CP" ];
        wPrimeVal  = ConfirmBy[ validateWPrime @ wPrime, NumberQ, "WPrime" ];
        pMaxVal    = ConfirmBy[ validatePMax[ pMax, cpVal ], NumberQ, "PMax" ];

        (* Calculate strain scores *)
        result = ConfirmMatch[
            calculateStrainScores[ N @ power, cpVal, wPrimeVal, pMaxVal ],
            _Association,
            "StrainScores"
        ];

        result
    ],
    throwInternalFailure
];

machineRealArrayToStrain // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*numberArrayToStrain*)
numberArrayToStrain // beginDefinition;

numberArrayToStrain[ power0_List, cp_, wPrime_, pMax_, opts___ ] := Enclose[
    Module[ { power },
        power = N @ power0;
        If[ machineRealArrayQ @ power,
            ConfirmMatch[ machineRealArrayToStrain[ power, cp, wPrime, pMax, opts ], _Association, "Result" ],
            throwFailure[ "NotMachineReal", SelectFirst[ power0, Not @* Developer`MachineRealQ @* N, $fail ] ]
        ]
    ],
    throwInternalFailure
];

numberArrayToStrain // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*quantityArrayToStrain*)
quantityArrayToStrain // beginDefinition;

quantityArrayToStrain[ array_QuantityArray, cp_, wPrime_, pMax_, opts___ ] := Enclose[
    Module[ { watts, power },
        watts = ConfirmMatch[ UnitConvert[ checkPowerArray @ array, "Watts" ], _QuantityArray, "UnitConvert" ];
        power = ConfirmBy[ QuantityMagnitude @ watts, numberArrayQ, "QuantityMagnitude" ];
        ConfirmMatch[ numberArrayToStrain[ power, cp, wPrime, pMax, opts ], _Association, "Result" ]
    ],
    throwInternalFailure
];

quantityArrayToStrain // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*temporalDataToStrain*)
temporalDataToStrain // beginDefinition;

temporalDataToStrain[ timeSeries_TemporalData, cp_, wPrime_, pMax_, opts___ ] := Enclose[
    Module[ { resampled, values },
        resampled = ConfirmMatch[ TimeSeriesResample[ timeSeries, 1 ], _TemporalData, "TimeSeriesResample" ];
        values = ConfirmMatch[ resampled[ "Values" ], _QuantityArray? ArrayQ, "Values" ];
        ConfirmMatch[ quantityArrayToStrain[ values, cp, wPrime, pMax, opts ], _Association, "Result" ]
    ],
    throwInternalFailure
];

temporalDataToStrain // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitnessDataToStrain*)
fitnessDataToStrain // beginDefinition;

fitnessDataToStrain[ data_FitnessData, cp_, wPrime_, pMax_, opts___ ] := Enclose[
    Module[ { powerData },
        powerData = data[ "Power" ];
        If[ MissingQ @ powerData,
            throwFailure[ "MissingPower" ],
            ConfirmMatch[ temporalDataToStrain[ powerData, cp, wPrime, pMax, opts ], _Association, "Result" ]
        ]
    ],
    throwInternalFailure
];

fitnessDataToStrain // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fileToStrain*)
fileToStrain // beginDefinition;

fileToStrain[ file_, cp_, wPrime_, pMax_, opts___ ] := Enclose[
    Module[ { data },
        data = ConfirmBy[ FITImport[ file, "Power" ], temporalDataOrMissingQ, "Import" ];
        If[ MissingQ @ data,
            throwFailure[ "MissingPower" ],
            ConfirmMatch[ temporalDataToStrain[ data, cp, wPrime, pMax, opts ], _Association, "Result" ]
        ]
    ],
    throwInternalFailure
];

fileToStrain // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Parameter Validation*)

(* ::Subsubsection::Closed:: *)
(*validateCP*)
validateCP // beginDefinition;

validateCP[ cp_? NumericQ ] := Enclose[
    Module[ { value },
        value = N @ QuantityMagnitude @ UnitConvert[ Quantity[ cp, "Watts" ], "Watts" ];
        If[ value > 0,
            value,
            throwFailure[ "InvalidCP" ]
        ]
    ],
    throwInternalFailure
];

validateCP[ Quantity[ cp_? NumericQ, unit_ ] ] := Enclose[
    Module[ { watts, value },
        watts = ConfirmMatch[ UnitConvert[ Quantity[ cp, unit ], "Watts" ], _Quantity, "UnitConvert" ];
        value = N @ QuantityMagnitude @ watts;
        If[ value > 0,
            value,
            throwFailure[ "InvalidCP" ]
        ]
    ],
    throwInternalFailure
];

validateCP[ _ ] := throwFailure[ "InvalidCP" ];

validateCP // endDefinition;

(* ::Subsubsection::Closed:: *)
(*validateWPrime*)
validateWPrime // beginDefinition;

validateWPrime[ wPrime_? NumericQ ] := Enclose[
    Module[ { value },
        value = N @ QuantityMagnitude @ UnitConvert[ Quantity[ wPrime, "Kilojoules" ], "Kilojoules" ];
        If[ value > 0,
            value * 1000.0, (* Convert to joules *)
            throwFailure[ "InvalidWPrime" ]
        ]
    ],
    throwInternalFailure
];

validateWPrime[ Quantity[ wPrime_? NumericQ, unit_ ] ] := Enclose[
    Module[ { joules, value },
        joules = ConfirmMatch[ UnitConvert[ Quantity[ wPrime, unit ], "Joules" ], _Quantity, "UnitConvert" ];
        value = N @ QuantityMagnitude @ joules;
        If[ value > 0,
            value,
            throwFailure[ "InvalidWPrime" ]
        ]
    ],
    throwInternalFailure
];

validateWPrime[ _ ] := throwFailure[ "InvalidWPrime" ];

validateWPrime // endDefinition;

(* ::Subsubsection::Closed:: *)
(*validatePMax*)
validatePMax // beginDefinition;

validatePMax[ pMax_? NumericQ, cp_? NumericQ ] := Enclose[
    Module[ { value },
        value = N @ QuantityMagnitude @ UnitConvert[ Quantity[ pMax, "Watts" ], "Watts" ];
        If[ value > cp,
            value,
            throwFailure[ "InvalidPMax" ]
        ]
    ],
    throwInternalFailure
];

validatePMax[ Quantity[ pMax_? NumericQ, unit_ ], cp_? NumericQ ] := Enclose[
    Module[ { watts, value },
        watts = ConfirmMatch[ UnitConvert[ Quantity[ pMax, unit ], "Watts" ], _Quantity, "UnitConvert" ];
        value = N @ QuantityMagnitude @ watts;
        If[ value > cp,
            value,
            throwFailure[ "InvalidPMax" ]
        ]
    ],
    throwInternalFailure
];

validatePMax[ _, _ ] := throwFailure[ "InvalidPMax" ];

validatePMax // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Core Calculation*)

(* ::Subsubsection::Closed:: *)
(*calculateStrainScores*)
calculateStrainScores // beginDefinition;

(* TODO: This could be compiled as a library function in LibraryFunctions.wl *)
calculateStrainScores[ power_List, cp_, wPrime_, pMax_ ] := Enclose[
    Module[ { n, wExp, mpa, kStrain, pCP, pPMax, pWPrime, srCP, srWPrime, srPMax,
              ssCP, ssWPrime, ssPMax, ss, normFactor },

        n = Length @ power;

        (* Initialize W' expenditure *)
        wExp = 0.0;

        (* Initialize accumulators *)
        ssCP = 0.0;
        ssWPrime = 0.0;
        ssPMax = 0.0;

        (* Normalization factor: (PMax / CP^2) * (100 / 3600) *)
        normFactor = (pMax / (cp * cp)) * (100.0 / 3600.0);

        (* Process each second of power data *)
        Do[
            Module[ { p },
                p = power[[i]];

                (* Calculate MPA *)
                mpa = pMax - (pMax - cp) * (wExp / wPrime);

                (* Calculate strain coefficient *)
                kStrain = (pMax - mpa + cp) / (pMax - p + cp);

                (* Calculate power contributions *)
                If[ p <= cp,
                    (* Below CP: only aerobic contribution *)
                    pCP = p;
                    pPMax = 0.0;
                    pWPrime = 0.0,
                    (* else *)
                    (* Above CP: all three systems contribute *)
                    pCP = cp;
                    pPMax = ((p - cp) * (p - cp)) / (pMax - cp);
                    pWPrime = (p - cp) - pPMax
                ];

                (* Calculate strain rates *)
                srCP = kStrain * pCP;
                srPMax = kStrain * pPMax;
                srWPrime = kStrain * pWPrime;

                (* Accumulate strain scores *)
                ssCP += srCP * normFactor;
                ssWPrime += srWPrime * normFactor;
                ssPMax += srPMax * normFactor;

                (* Update W' expenditure *)
                If[ p > cp,
                    wExp = Min[ wExp + (p - cp), wPrime ]
                    (* Note: W' recovery during rest not implemented in this version *)
                ]
            ],
            { i, 1, n }
        ];

        (* Calculate total strain score *)
        ss = ssCP + ssWPrime + ssPMax;

        <|
            "StrainScore"      -> ss,
            "AerobicStrain"    -> ssCP,
            "GlycolyticStrain" -> ssWPrime,
            "PCrStrain"        -> ssPMax
        |>
    ],
    throwInternalFailure
];

calculateStrainScores // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
