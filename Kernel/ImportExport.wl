(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Messages*)
ComputationalFitness::InvalidFTP =
"The value `1` is not a valid value for functional threshold power.";

ComputationalFitness::InvalidMaxHR =
"The value `1` is not a valid value for maximum heart rate.";

ComputationalFitness::InvalidWeight =
"The value `1` is not a valid value for weight.";

ComputationalFitness::InvalidSport =
"The value `1` is not a valid value for sport type.";

ComputationalFitness::InvalidUnitSystem =
"The value `1` is not a valid value for UnitSystem.";

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Global Option Values*)
$ftp    = Automatic;
$maxHR  = Automatic;
$weight = Automatic;
$sport  = Automatic;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*setFTP*)
setFTP // beginDefinition;
setFTP[ Automatic     ] := Automatic;
setFTP[ None|_Missing ] := None;
setFTP[ ftp_Integer   ] := N @ ftp;
setFTP[ ftp_Real      ] := ftp;
setFTP[ Quantity[ ftp_, "Watts" ] ] := setFTP @ ftp;
setFTP[ ftp_Quantity ] := setFTP @ UnitConvert[ ftp, "Watts" ];
setFTP[ ftp_ ] := throwFailure[ "InvalidFTP", ftp ];
setFTP // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*setMaxHR*)
setMaxHR // beginDefinition;
setMaxHR[ Automatic     ] := Automatic;
setMaxHR[ None|_Missing ] := None;
setMaxHR[ hr_Integer    ] := N @ hr;
setMaxHR[ hr_Real       ] := hr;
setMaxHR[ Quantity[ hr_, "Beats"/"Minutes" ] ] := setMaxHR @ hr;
setMaxHR[ hr_Quantity ] := setMaxHR @ UnitConvert[ hr, "Beats"/"Minutes" ];
setMaxHR[ hr_ ] := throwFailure[ ComputationalFitness::InvalidMaxHR, hr ];
setMaxHR // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*setWeight*)
setWeight // beginDefinition;
setWeight[ Automatic     ] := Automatic;
setWeight[ None|_Missing ] := None;
setWeight[ w_Integer     ] := N @ w;
setWeight[ w_Real        ] := w;
setWeight[ Quantity[ w_, "Kilograms" ] ] := setWeight @ w;
setWeight[ w_Quantity ] := setWeight @ UnitConvert[ w, "Kilograms" ];
setWeight[ w_ ] := throwFailure[ ComputationalFitness::InvalidWeight, w ];
setWeight // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*setSport*)
setSport // beginDefinition;
setSport[ Automatic     ] := Automatic;
setSport[ None|_Missing ] := None;
setSport[ s_String      ] := s;
setSport[ s_            ] := throwFailure[ ComputationalFitness::InvalidSport, s ];
setSport // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*setUnitSystem*)
setUnitSystem // beginDefinition;
setUnitSystem[ Automatic|None|_Missing ] := $UnitSystem;
setUnitSystem[ units: "Imperial"|"Metric" ] := units;
setUnitSystem[ "Statute" ] := "Imperial";
setUnitSystem[ "SI" ] := "Metric";
setUnitSystem[ KeyValuePattern[ "UnitSystem" -> u_ ] ] := setUnitSystem @ u;
setUnitSystem[ KeyValuePattern[ UnitSystem -> u_ ] ] := setUnitSystem @ u;
setUnitSystem[ units_ ] := throwFailure[ ComputationalFitness::InvalidUnitSystem, units ];
setUnitSystem // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
