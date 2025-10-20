(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RickHennigan`ComputationalFitness`" ];
Needs[ "RickHennigan`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Configuration*)
$returnMMPArray = False;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Messages*)
ComputationalFitness::NotMachineReal    = "Expected real machine precision numbers but encountered `1`.";
ComputationalFitness::IncompatibleUnits = "`1` and `2` are incompatible units";

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*MeanMaximalPowerCurve*)
MeanMaximalPowerCurve // beginDefinition;
MeanMaximalPowerCurve[ data_ ] := catchMine @ meanMaximalPowerCurve @ data;
MeanMaximalPowerCurve // endExportedDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*meanMaximalPowerCurve*)
meanMaximalPowerCurve // beginDefinition;

meanMaximalPowerCurve[ power_List? machineRealArrayQ          ] := machineRealArrayToMMP @ power;
meanMaximalPowerCurve[ power_List? numberArrayQ               ] := numberArrayToMMP @ power;
meanMaximalPowerCurve[ array_QuantityArray? ArrayQ            ] := quantityArrayToMMP @ array;
meanMaximalPowerCurve[ timeSeries_TemporalData? temporalDataQ ] := temporalDataToMMP @ timeSeries;
meanMaximalPowerCurve[ data_FitnessData? FitnessDataQ         ] := fitnessDataToMMP @ data;
meanMaximalPowerCurve[ file: _File | _String? FileExistsQ     ] := fileToMMP @ file;
meanMaximalPowerCurve[ sources: { __ }                        ] := multiSourceToMMP @ sources;

meanMaximalPowerCurve[ other_ ] :=
    throwFailure[ "InvalidArguments", MeanMaximalPowerCurve, HoldForm @ MeanMaximalPowerCurve @ other ];

meanMaximalPowerCurve // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*machineRealArrayToMMP*)
machineRealArrayToMMP // beginDefinition;

machineRealArrayToMMP[ power_List ] := Enclose[
    Module[ { result },
        result = ConfirmBy[ compiledFunction[ "MaximalMeanPowerCurve" ][ N @ power ], machineRealArrayQ, "ArrayCheck" ];
        If[ TrueQ @ $returnMMPArray,
            Throw[ result, $mmpTag ],
            result
        ]
    ],
    throwInternalFailure
];

machineRealArrayToMMP // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*machineRealArrayQ*)
machineRealArrayQ // beginDefinition;
machineRealArrayQ[ list_List ] := VectorQ[ list, Developer`MachineRealQ ];
machineRealArrayQ[ ___ ] := False;
machineRealArrayQ // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*machineRealArrayOrMissingQ*)
machineRealArrayOrMissingQ // beginDefinition;
machineRealArrayOrMissingQ[ _Missing ] := True;
machineRealArrayOrMissingQ[ other_ ] := machineRealArrayQ @ other;
machineRealArrayOrMissingQ // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*numberArrayToMMP*)
numberArrayToMMP // beginDefinition;

numberArrayToMMP[ power0_List ] := Enclose[
    Module[ { power },
        power = N @ power0;
        If[ machineRealArrayQ @ power,
            ConfirmBy[ machineRealArrayToMMP @ power, machineRealArrayQ, "Result" ],
            ConfirmBy[ throwNumberArrayError @ power0, FailureQ, "Failure" ]
        ]
    ],
    throwInternalFailure
];

numberArrayToMMP // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*numberArrayQ*)
numberArrayQ // beginDefinition;
numberArrayQ[ list_List ] := VectorQ[ N @ list, NumberQ ];
numberArrayQ[ ___ ] := False;
numberArrayQ // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*throwNumberArrayError*)
throwNumberArrayError // beginDefinition;

throwNumberArrayError[ list_List ] := Enclose[
    throwFailure[
        "NotMachineReal",
        ConfirmMatch[ SelectFirst[ list, Not @* Developer`MachineRealQ @* N, $fail ], Except[ $fail ], "Element" ]
    ],
    throwInternalFailure
];

throwNumberArrayError // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*quantityArrayToMMP*)
quantityArrayToMMP // beginDefinition;

quantityArrayToMMP[ array_QuantityArray ] := Enclose[
    Module[ { invalid, watts, power, result },
        If[ ! CompatibleUnitQ[ array, "Watts" ],
            invalid = ConfirmBy[
                SelectFirst[ DeleteDuplicates @ QuantityUnit @ array, ! CompatibleUnitQ[ #, "Watts" ] & ],
                StringQ,
                "InvalidUnit"
            ];
            throwFailure[ "IncompatibleUnits", invalid, "Watts" ]
        ];
        watts = ConfirmMatch[ UnitConvert[ array, "Watts" ], _QuantityArray, "UnitConvert" ];
        power = ConfirmBy[ QuantityMagnitude @ watts, numberArrayQ, "QuantityMagnitude" ];
        result = ConfirmBy[ numberArrayToMMP @ power, machineRealArrayQ, "PowerCurve" ];
        ConfirmMatch[ QuantityArray[ result, "Watts" ], _QuantityArray? ArrayQ, "Result" ]
    ],
    throwInternalFailure
];

quantityArrayToMMP // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*temporalDataToMMP*)
temporalDataToMMP // beginDefinition;

temporalDataToMMP[ timeSeries_TemporalData ] := Enclose[
    Module[ { resampled, values, result },
        resampled = ConfirmMatch[ TimeSeriesResample[ timeSeries, 1 ], _TemporalData, "TimeSeriesResample" ];
        values = ConfirmMatch[ resampled[ "Values" ], _QuantityArray? ArrayQ, "Values" ];
        result = ConfirmMatch[ quantityArrayToMMP @ values, _QuantityArray? ArrayQ, "PowerCurve" ];
        result
    ],
    throwInternalFailure
];

temporalDataToMMP // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*temporalDataQ*)
temporalDataQ // beginDefinition;
temporalDataQ[ data_TemporalData ] := System`Private`ValidQ @ Unevaluated @ data;
temporalDataQ[ ___ ] := False;
temporalDataQ // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*temporalDataOrMissingQ*)
temporalDataOrMissingQ // beginDefinition;
temporalDataOrMissingQ[ _Missing ] := True;
temporalDataOrMissingQ[ other_ ] := temporalDataQ @ other;
temporalDataOrMissingQ // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitnessDataToMMP*)
fitnessDataToMMP // beginDefinition;

fitnessDataToMMP[ data_FitnessData ] := Enclose[
    ConfirmMatch[ temporalDataToMMP @ data[ "Power" ], _QuantityArray? ArrayQ, "Power" ],
    throwInternalFailure
];

fitnessDataToMMP // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fileToMMP*)
fileToMMP // beginDefinition;

(* TODO: support importing power from other formats *)
fileToMMP[ dir_? DirectoryQ ] :=
    directoryToMMP @ dir;

fileToMMP[ file_ ] := Enclose[
    Catch @ Module[ { data },
        data = ConfirmBy[ FITImport[ file, "Power" ], temporalDataOrMissingQ, "Import" ];
        If[ MissingQ @ data, Throw @ Missing[ "NotAvailable" ] ];
        ConfirmMatch[ temporalDataToMMP @ data, _QuantityArray? ArrayQ, "PowerCurve" ]
    ],
    throwInternalFailure
];

fileToMMP // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*directoryToMMP*)
directoryToMMP // beginDefinition;

directoryToMMP[ dir_ ] := Enclose[
    Catch @ Module[ { files, usable },
        files = ConfirmMatch[ FileNames[ All, dir ], { ___String }, "Files" ];
        If[ files === { }, Throw @ Missing[ "NoUsableFiles", dir ] ];
        usable = Select[ files, FITFormatQ[ #, "Activity" ] & ];
        If[ usable === { }, Throw @ Missing[ "NoUsableFiles", dir ] ];
        multiSourceToMMP @ usable
    ],
    throwInternalFailure
];

directoryToMMP // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*multiSourceToMMP*)
multiSourceToMMP // beginDefinition;

multiSourceToMMP[ { first_, rest___ } ] := Enclose[
    Catch @ Module[ { initial, current, total, combined, result },

        initial = ConfirmBy[ importRealArrayMMP @ first, machineRealArrayOrMissingQ, "Initial" ];

        current = 1;
        total   = Length @ { first, rest };

        combined = ConfirmBy[
            Progress`EvaluateWithProgress[
                Fold[ Function[ current++; takeLargerMMP @ ## ], initial, { rest } ],
                <|
                    "ElapsedTime"   -> Automatic,
                    "RemainingTime" -> Automatic,
                    "ItemTotal"     :> total,
                    "ItemCurrent"   :> current,
                    "Progress"      :> Automatic
                |>
            ],
            machineRealArrayOrMissingQ,
            "Combined"
        ];

        If[ MissingQ @ combined, Throw @ Missing[ "NotAvailable" ] ];

        result = ConfirmMatch[ QuantityArray[ combined, "Watts" ], _QuantityArray? ArrayQ, "Result" ];
        result
    ],
    throwInternalFailure
];

multiSourceToMMP // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*importRealArrayMMP*)
importRealArrayMMP // beginDefinition;
importRealArrayMMP[ source_ ] := Block[ { $returnMMPArray = True }, Catch[ meanMaximalPowerCurve @ source, $mmpTag ] ];
importRealArrayMMP // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*takeLargerMMP*)
takeLargerMMP // beginDefinition;

takeLargerMMP[ _Missing, source_ ] := Enclose[
    Module[ { new },
        new = ConfirmBy[ importRealArrayMMP @ source, machineRealArrayOrMissingQ, "New" ];
        clearCache[ ];
        new
    ],
    throwInternalFailure
];

takeLargerMMP[ current_List, source_ ] := Enclose[
    Catch @ Module[ { new, res },
        new = ConfirmBy[ importRealArrayMMP @ source, machineRealArrayOrMissingQ, "New" ];
        If[ MissingQ @ new, clearCache[ ]; Throw @ current ];
        res = ConfirmBy[ compiledFunction[ "PairwiseMax" ][ current, new ], Developer`PackedArrayQ, "Result" ];
        clearCache[ ];
        res
    ],
    throwInternalFailure
];

takeLargerMMP // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
