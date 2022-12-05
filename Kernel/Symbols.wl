Needs[ "GeneralUtilities`" -> None ];

(* Preserve values if already set: *)
HoldComplete[
    RH`ComputationalFitness`$FunctionalThresholdPower,
    RH`ComputationalFitness`$MaxHeartRate,
    RH`ComputationalFitness`$Sport,
    RH`ComputationalFitness`$Weight
];

(* Clear for new definitions: *)
GeneralUtilities`UnprotectAndClearAll[
    RH`ComputationalFitness`ComputationalFitness,
    RH`ComputationalFitness`FITExport,
    RH`ComputationalFitness`FITImport,
    RH`ComputationalFitness`FunctionalThresholdPower,
    RH`ComputationalFitness`MaxHeartRate,
    RH`ComputationalFitness`Sport,
    RH`ComputationalFitness`TCXImport,
    RH`ComputationalFitness`Weight,
    RH`ComputationalFitness`ZWOExport,
    RH`ComputationalFitness`ZWOImport
];
