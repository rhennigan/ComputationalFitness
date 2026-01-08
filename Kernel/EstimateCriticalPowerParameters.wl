(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RickHennigan`ComputationalFitness`" ];
Needs[ "RickHennigan`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Messages*)
ComputationalFitness::InsufficientData = "At least `1` data points are required for parameter estimation.";
ComputationalFitness::FitFailed        = "Failed to fit the 3-parameter critical power model to the data.";
ComputationalFitness::InvalidFit       = "The fitted parameters are not physiologically valid: `1`";

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*EstimateCriticalPowerParameters*)
EstimateCriticalPowerParameters // beginDefinition;

EstimateCriticalPowerParameters[ data_, opts: OptionsPattern[ ] ] :=
    catchMine @ estimateCriticalPowerParameters[ data, opts ];

EstimateCriticalPowerParameters // endExportedDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*estimateCriticalPowerParameters*)
estimateCriticalPowerParameters // beginDefinition;

estimateCriticalPowerParameters[ array_QuantityArray? ArrayQ, opts___ ] :=
    quantityArrayToParameters[ array, opts ];

estimateCriticalPowerParameters[ power_List? numberArrayQ, opts___ ] :=
    numberArrayToParameters[ power, opts ];

estimateCriticalPowerParameters[ timeSeries_TemporalData? temporalDataQ, opts___ ] :=
    temporalDataToParameters[ timeSeries, opts ];

estimateCriticalPowerParameters[ data_FitnessData? FitnessDataQ, opts___ ] :=
    fitnessDataToParameters[ data, opts ];

estimateCriticalPowerParameters[ file: _File | _String? FileExistsQ, opts___ ] :=
    fileToParameters[ file, opts ];

estimateCriticalPowerParameters[ sources: { __ }, opts___ ] :=
    multiSourceToParameters[ sources, opts ];

estimateCriticalPowerParameters[ other_, ___ ] :=
    throwFailure[ "InvalidArguments", EstimateCriticalPowerParameters,
                  HoldForm @ EstimateCriticalPowerParameters @ other ];

estimateCriticalPowerParameters // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*quantityArrayToParameters*)
quantityArrayToParameters // beginDefinition;

quantityArrayToParameters[ array_QuantityArray, opts___ ] := Enclose[
    Module[ { watts, power },
        watts = ConfirmMatch[ UnitConvert[ checkPowerArray @ array, "Watts" ], _QuantityArray, "UnitConvert" ];
        power = ConfirmBy[ QuantityMagnitude @ watts, numberArrayQ, "QuantityMagnitude" ];
        ConfirmMatch[ numberArrayToParameters[ power, opts ], _Association, "Result" ]
    ],
    throwInternalFailure
];

quantityArrayToParameters // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*numberArrayToParameters*)
numberArrayToParameters // beginDefinition;

numberArrayToParameters[ power_List, opts___ ] := Enclose[
    Module[ { n, durations, validData, params },
        n = Length @ power;

        (* Create duration-power pairs (duration in seconds, 1-indexed) *)
        durations = Range[ 1, n ];

        (* Filter out zero or negative power values and very short durations *)
        validData = ConfirmMatch[
            Select[ Transpose @ { N @ durations, N @ power }, #[[1]] >= 5 && #[[2]] > 0 & ],
            { { _Real, _Real } .. },
            "ValidData"
        ];

        If[ Length @ validData < 10,
            throwFailure[ "InsufficientData", 10 ]
        ];

        (* Fit the 3-parameter model *)
        params = ConfirmMatch[
            fitCriticalPowerModel @ validData,
            _Association,
            "FitResult"
        ];

        params
    ],
    throwInternalFailure
];

numberArrayToParameters // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*temporalDataToParameters*)
temporalDataToParameters // beginDefinition;

temporalDataToParameters[ timeSeries_TemporalData, opts___ ] := Enclose[
    Module[ { mmpCurve },
        mmpCurve = ConfirmMatch[ MeanMaximalPowerCurve @ timeSeries, _QuantityArray? ArrayQ, "MMP" ];
        ConfirmMatch[ quantityArrayToParameters[ mmpCurve, opts ], _Association, "Result" ]
    ],
    throwInternalFailure
];

temporalDataToParameters // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitnessDataToParameters*)
fitnessDataToParameters // beginDefinition;

fitnessDataToParameters[ data_FitnessData, opts___ ] := Enclose[
    Module[ { mmpCurve },
        mmpCurve = ConfirmMatch[ MeanMaximalPowerCurve @ data, _QuantityArray? ArrayQ, "MMP" ];
        ConfirmMatch[ quantityArrayToParameters[ mmpCurve, opts ], _Association, "Result" ]
    ],
    throwInternalFailure
];

fitnessDataToParameters // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fileToParameters*)
fileToParameters // beginDefinition;

fileToParameters[ file_, opts___ ] := Enclose[
    Module[ { mmpCurve },
        mmpCurve = ConfirmMatch[ MeanMaximalPowerCurve @ file, _QuantityArray? ArrayQ, "MMP" ];
        ConfirmMatch[ quantityArrayToParameters[ mmpCurve, opts ], _Association, "Result" ]
    ],
    throwInternalFailure
];

fileToParameters // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*multiSourceToParameters*)
multiSourceToParameters // beginDefinition;

multiSourceToParameters[ sources_List, opts___ ] := Enclose[
    Module[ { mmpCurve },
        mmpCurve = ConfirmMatch[ MeanMaximalPowerCurve @ sources, _QuantityArray? ArrayQ, "MMP" ];
        ConfirmMatch[ quantityArrayToParameters[ mmpCurve, opts ], _Association, "Result" ]
    ],
    throwInternalFailure
];

multiSourceToParameters // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Core Fitting Function*)

(* ::Subsubsection::Closed:: *)
(*fitCriticalPowerModel*)
fitCriticalPowerModel // beginDefinition;

fitCriticalPowerModel[ data: { { _Real, _Real } .. } ] := Enclose[
    Module[ { pMax, cp, wPrime, initialGuess, fit, params, validated },

        (* Initial parameter estimates *)
        initialGuess = ConfirmMatch[ estimateInitialParameters @ data, _Association, "InitialGuess" ];

        pMax   = initialGuess[ "PMax" ];
        cp     = initialGuess[ "CP" ];
        wPrime = initialGuess[ "WPrime" ];

        (* Fit the model: P = CP + (PMax - CP) * W' / (W' + (PMax - CP) * t) *)
        fit = Quiet @ Check[
            FindFit[
                data,
                cp + (pMax - cp) * wPrime / (wPrime + (pMax - cp) * t),
                {
                    { cp, initialGuess[ "CP" ], 0.5 * initialGuess[ "CP" ], 1.5 * initialGuess[ "CP" ] },
                    { wPrime, initialGuess[ "WPrime" ], 0.5 * initialGuess[ "WPrime" ], 2.0 * initialGuess[ "WPrime" ] },
                    { pMax, initialGuess[ "PMax" ], 0.8 * initialGuess[ "PMax" ], 1.5 * initialGuess[ "PMax" ] }
                },
                t,
                Method -> "LevenbergMarquardt",
                MaxIterations -> 500
            ],
            $Failed
        ];

        If[ fit === $Failed,
            throwFailure[ "FitFailed" ]
        ];

        (* Extract fitted parameters *)
        params = <|
            "CP"     -> Quantity[ cp /. fit, "Watts" ],
            "WPrime" -> Quantity[ (wPrime /. fit), "Kilojoules" ],
            "PMax"   -> Quantity[ pMax /. fit, "Watts" ]
        |>;

        (* Validate fitted parameters *)
        validated = ConfirmMatch[
            validateFittedParameters @ params,
            _Association,
            "Validation"
        ];

        validated
    ],
    throwInternalFailure
];

fitCriticalPowerModel // endDefinition;

(* ::Subsubsection::Closed:: *)
(*estimateInitialParameters*)
estimateInitialParameters // beginDefinition;

estimateInitialParameters[ data: { { _Real, _Real } .. } ] := Enclose[
    Module[ { sorted, shortDurations, longDurations, pMaxEst, cpEst, wPrimeEst },

        (* Sort by duration *)
        sorted = SortBy[ data, First ];

        (* Estimate PMax from short durations (5-15 seconds) *)
        shortDurations = Select[ sorted, 5 <= #[[1]] <= 15 & ];
        pMaxEst = If[ Length @ shortDurations >= 3,
            Mean @ Take[ SortBy[ shortDurations, -#[[2]] & ], UpTo[ 3 ] ][[All, 2]],
            Max @ sorted[[All, 2]]
        ];

        (* Estimate CP from long durations (>20 minutes) *)
        longDurations = Select[ sorted, #[[1]] > 1200 & ];
        cpEst = If[ Length @ longDurations >= 5,
            Mean @ Take[ SortBy[ longDurations, #[[2]] & ], UpTo[ 5 ] ][[All, 2]],
            Min @ sorted[[All, 2]]
        ];

        (* Ensure PMax > CP *)
        If[ pMaxEst <= cpEst,
            pMaxEst = cpEst * 1.5;
        ];

        (* Estimate W' from the area under the curve above CP for medium durations *)
        wPrimeEst = Confirm[
            estimateWPrimeFromData[ sorted, cpEst ],
            "WPrimeEstimate"
        ];

        <|
            "PMax"   -> pMaxEst,
            "CP"     -> cpEst,
            "WPrime" -> wPrimeEst
        |>
    ],
    throwInternalFailure
];

estimateInitialParameters // endDefinition;

(* ::Subsubsection::Closed:: *)
(*estimateWPrimeFromData*)
estimateWPrimeFromData // beginDefinition;

estimateWPrimeFromData[ data: { { _Real, _Real } .. }, cp_Real ] := Enclose[
    Module[ { mediumDurations, avgPower, avgDuration, wPrimeEst },

        (* Use data from 2-10 minutes *)
        mediumDurations = Select[ data, 120 <= #[[1]] <= 600 & ];

        If[ Length @ mediumDurations < 3,
            (* Fallback: use a typical value scaled by CP *)
            Return[ 20000.0, Module ]
        ];

        (* Estimate W' from: W' ≈ (P - CP) * t for medium durations *)
        avgPower = Mean @ mediumDurations[[All, 2]];
        avgDuration = Mean @ mediumDurations[[All, 1]];

        wPrimeEst = Max[ (avgPower - cp) * avgDuration, 10000.0 ];

        wPrimeEst
    ],
    throwInternalFailure
];

estimateWPrimeFromData // endDefinition;

(* ::Subsubsection::Closed:: *)
(*validateFittedParameters*)
validateFittedParameters // beginDefinition;

validateFittedParameters[ params_Association ] := Enclose[
    Module[ { cp, wPrime, pMax, cpVal, wPrimeVal, pMaxVal, issues },

        cp      = params[ "CP" ];
        wPrime  = params[ "WPrime" ];
        pMax    = params[ "PMax" ];

        cpVal     = QuantityMagnitude @ UnitConvert[ cp, "Watts" ];
        wPrimeVal = QuantityMagnitude @ UnitConvert[ wPrime, "Joules" ];
        pMaxVal   = QuantityMagnitude @ UnitConvert[ pMax, "Watts" ];

        issues = {};

        (* Check if parameters are positive *)
        If[ cpVal <= 0, AppendTo[ issues, "CP must be positive" ] ];
        If[ wPrimeVal <= 0, AppendTo[ issues, "W' must be positive" ] ];
        If[ pMaxVal <= 0, AppendTo[ issues, "PMax must be positive" ] ];

        (* Check if PMax > CP *)
        If[ pMaxVal <= cpVal, AppendTo[ issues, "PMax must be greater than CP" ] ];

        (* Check for reasonable physiological ranges *)
        If[ cpVal < 50 || cpVal > 600, AppendTo[ issues, "CP outside reasonable range (50-600 W)" ] ];
        If[ wPrimeVal < 5000 || wPrimeVal > 50000, AppendTo[ issues, "W' outside reasonable range (5-50 kJ)" ] ];
        If[ pMaxVal < 200 || pMaxVal > 3000, AppendTo[ issues, "PMax outside reasonable range (200-3000 W)" ] ];

        If[ Length @ issues > 0,
            throwFailure[ "InvalidFit", StringRiffle[ issues, ", " ] ]
        ];

        params
    ],
    throwInternalFailure
];

validateFittedParameters // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
