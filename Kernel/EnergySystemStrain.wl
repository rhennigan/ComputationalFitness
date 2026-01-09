(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RickHennigan`ComputationalFitness`" ];
Needs[ "RickHennigan`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Overview*)

(* The three-dimensional strain score model quantifies training load based on energy system-specific
   contributions to power output. This implementation is based on the model described in:

   Kontro, H., Mastracci, A., Cheung, S. S., & MacInnis, M. J. (2025).
   "The three-dimensional impulse-response model: Modeling the training process in accordance
   with energy system-specific adaptation"
   arXiv:2503.14841v2

   The model uses the 3-parameter critical power model to estimate the contribution of three
   energy systems during exercise:

   1. Aerobic/Oxidative System (CP - Critical Power):
      - Represents the maximal sustainable aerobic power output
      - The ceiling for rate-limited oxidative energy provision
      - All power <= CP comes from this system

   2. Glycolytic/Lactic System (W' - Anaerobic Work Capacity):
      - Finite capacity for anaerobic energy production via glycolysis
      - Depletes during sustained exercise above CP
      - Primary contributor at moderate to high intensities above CP

   3. Alactic/PCr System (PMax - Maximal Instantaneous Power):
      - Phosphocreatine system providing immediate energy
      - Dominant during very high power outputs
      - Rate-limited but quickly replenished

   The strain score accounts for both the intensity and duration of exercise by tracking
   how close the athlete is to their maximum power available (MPA), which decreases as
   W' is depleted. This provides a more physiologically accurate measure of training
   load than traditional single-dimensional metrics like TSS. *)

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

(* EnergySystemStrain calculates energy system-specific training load from power data.

   Usage:
     EnergySystemStrain[data, history]

   Arguments:
     data    - Power data for a single activity. Can be a List, QuantityArray, TemporalData,
               FitnessData object, or file path (String/File).
     history - Either:
               1) Historical training data used to estimate the athlete's CP, W', and PMax parameters
                  via EstimateCriticalPowerParameters, OR
               2) An Association with pre-computed parameters from EstimateCriticalPowerParameters
                  containing "CriticalPower", "AnaerobicWorkCapacity", and "MaximalInstantaneousPower"

   Returns:
     An Association with four keys:
       "StrainScore"      - Total training load (analogous to TSS)
       "AerobicStrain"    - Load on the oxidative/aerobic system (CP)
       "GlycolyticStrain" - Load on the glycolytic/lactic system (W')
       "PCrStrain"        - Load on the phosphocreatine/alactic system (PMax)

   Example:
     (* Estimate parameters from mean maximal power curve *)
     params = EstimateCriticalPowerParameters[mmpCurve];
     (* Calculate strain for a specific activity *)
     strain = EnergySystemStrain[activityFile, params];

   The three-dimensional strain score provides a more detailed analysis of training load
   than traditional single-dimensional metrics by separating the load on each energy system.
   This allows for better tracking of energy system-specific adaptations over time. *)

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

(* Calculates energy system-specific strain scores from continuous power data using the
   3-parameter critical power model. The calculation follows the methodology described in
   Kontro et al. (2025), arXiv:2503.14841v2, Section III.

   Key Concepts:

   1. Maximum Power Available (MPA) - Equation (4):
      MPA = PMax - (PMax - CP) * (W'exp / W')

      MPA represents the highest instantaneous power achievable at a given moment and decreases
      as W' is depleted. When W' is fully expended, MPA equals CP. This dynamic ceiling creates
      the foundation for the strain coefficient calculation.

   2. Strain Coefficient (kStrain) - Equation (11):
      kStrain = (PMax - MPA + CP) / (PMax - P + CP)

      The strain coefficient quantifies how difficult a given power output is relative to the
      athlete's current state of fatigue. As MPA approaches P, kStrain increases, reflecting
      that the same power output becomes more strenuous as W' depletes. When fresh (MPA = PMax),
      kStrain is lower; when fatigued (MPA approaches CP), kStrain approaches 1.0.

   3. Energy System Contributions - Equations (8-10):
      For P <= CP:  all power comes from the aerobic system (P_CP = P)
      For P > CP:
        P_CP    = CP                             (aerobic system maxed out)
        P_PMax  = (P - CP)^2 / (PMax - CP)       (alactic/PCr system contribution)
        P_W'    = P - CP - P_PMax                (glycolytic system contribution)

      These equations partition power output among the three energy systems based on the
      3-parameter critical power model. The aerobic system operates at maximum (CP) for all
      power above CP. The PCr system contributes proportionally more at higher power outputs,
      while the glycolytic system fills the gap.

   4. Strain Rate (SR) - Equation (12):
      SR = kStrain * P

      Multiplying power by the strain coefficient gives the instantaneous strain rate. This
      rate is then partitioned among the three energy systems based on their power contributions,
      yielding SR_CP, SR_W', and SR_PMax.

   5. Normalization:
      The normalization factor (PMax / CP^2) * (100 / 3600) scales the strain scores so that
      one hour at CP equals 100 strain score units, making it comparable to TSS.

   TODO: This could be compiled as a library function in LibraryFunctions.wl for performance. *)

calculateStrainScores[ power_List, cp_, wPrime_, pMax_ ] := Enclose[
    Module[ { n, wExp, mpa, kStrain, pCP, pPMax, pWPrime, srCP, srWPrime, srPMax,
              ssCP, ssWPrime, ssPMax, ss, normFactor },

        n = Length @ power;

        (* Initialize W' expenditure (W'exp) to zero - athlete starts fresh *)
        wExp = 0.0;

        (* Initialize strain score accumulators for each energy system *)
        ssCP = 0.0;
        ssWPrime = 0.0;
        ssPMax = 0.0;

        (* Normalization factor: (PMax / CP^2) * (100 / 3600)
           This scales the output so that 1 hour at CP = 100 strain score units *)
        normFactor = (pMax / (cp * cp)) * (100.0 / 3600.0);

        (* Process each second of power data *)
        Do[
            Module[ { p },
                p = power[[i]];

                (* Calculate Maximum Power Available (MPA) - Equation (4)
                   MPA decreases as W' is depleted, representing the athlete's diminishing
                   capacity for high-intensity efforts *)
                mpa = pMax - (pMax - cp) * (wExp / wPrime);

                (* Calculate strain coefficient (kStrain) - Equation (11)
                   Higher values indicate greater physiological strain for the current power output *)
                kStrain = (pMax - mpa + cp) / (pMax - p + cp);

                (* Calculate power contributions from each energy system - Equations (8-10) *)
                If[ p <= cp,
                    (* Below CP: only aerobic system contributes *)
                    pCP = p;
                    pPMax = 0.0;
                    pWPrime = 0.0,
                    (* else *)
                    (* Above CP: all three systems contribute *)
                    pCP = cp;                                    (* Aerobic maxed out *)
                    pPMax = ((p - cp) * (p - cp)) / (pMax - cp); (* PCr system *)
                    pWPrime = (p - cp) - pPMax                   (* Glycolytic system *)
                ];

                (* Calculate strain rates for each energy system - Equation (12) *)
                srCP = kStrain * pCP;
                srPMax = kStrain * pPMax;
                srWPrime = kStrain * pWPrime;

                (* Accumulate strain scores - Equation (13) *)
                ssCP += srCP * normFactor;
                ssWPrime += srWPrime * normFactor;
                ssPMax += srPMax * normFactor;

                (* Update W' expenditure
                   W' depletes at rate (P - CP) per second when power exceeds CP
                   Note: W' recovery during rest is not implemented in this version *)
                If[ p > cp,
                    wExp = Min[ wExp + (p - cp), wPrime ]
                ]
            ],
            { i, 1, n }
        ];

        (* Calculate total strain score as sum of system-specific scores *)
        ss = ssCP + ssWPrime + ssPMax;

        <|
            "StrainScore"      -> ss,        (* Total training load *)
            "AerobicStrain"    -> ssCP,      (* Oxidative system load *)
            "GlycolyticStrain" -> ssWPrime,  (* Glycolytic system load *)
            "PCrStrain"        -> ssPMax     (* Phosphocreatine system load *)
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
