(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`FIT`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section:: *)
(*Options*)
FITExport // Options = {
    FunctionalThresholdPower :> $FunctionalThresholdPower,
    MaxHeartRate             :> $MaxHeartRate,
    Sport                    :> $Sport,
    UnitSystem               :> $UnitSystem,
    Weight                   :> $Weight
};

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Main definition*)

FITExport[ file_, data_List? rawDataQ, opts: OptionsPattern[ ] ] :=
    fitExportOptionsBlock[
        fitExportLibFunction[ file, data ],
        opts
    ];

FITExport[ file_, ds_Dataset, opts: OptionsPattern[ ] ] :=
    fitExportOptionsBlock[
        FITExport[ file, Normal @ ds, opts ],
        opts
    ];

FITExport[ file_, data_List? messageListQ, opts: OptionsPattern[ ] ] :=
    fitExportOptionsBlock[
        FITExport[ file, makeRawData @ data, opts ],
        opts
    ];

FITExport[ ___ ] := Failure[ "NotImplemented", <| |> ];

(* ::**********************************************************************:: *)
(* ::Section:: *)
(*Dependencies*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*fitExportOptionsBlock*)
fitExportOptionsBlock // beginDefinition;
fitExportOptionsBlock // Attributes = { HoldFirst };

fitExportOptionsBlock[ eval_, opts: OptionsPattern[ FITExport ] ] :=
    catchTopAs[ FITExport ] @ Block[
        {
            $UnitSystem     = setUnitSystem @ OptionValue @ UnitSystem, (* FIXME: fix it! *)
            $ftp            = setFTP @ OptionValue @ FunctionalThresholdPower,
            $maxHR          = setMaxHR @ OptionValue @ MaxHeartRate,
            $weight         = setWeight @ OptionValue @ Weight,
            $sport          = setSport @ OptionValue @ Sport,
            $timeOffset     = 0,
            $fileByteCount  = 0,
            $lastHRV        = None,
            fitExportOptionsBlock = # &
        },
        eval
    ];

fitExportOptionsBlock // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
