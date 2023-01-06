(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Global Values*)
setIfUndefined[ $FunctionalThresholdPower, Automatic ];
setIfUndefined[ $MaximumHeartRate        , Automatic ];
setIfUndefined[ $Sport                   , Automatic ];
setIfUndefined[ $Weight                  , Automatic ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Argument Patterns*)
$$string = _String? StringQ;
$$bytes  = _ByteArray? ByteArrayQ;
$$assoc  = _Association? AssociationQ;
$$file   = File[ $$string ];
$$url    = URL[ $$string ];
$$co     = HoldPattern[ CloudObject ][ $$string, OptionsPattern[ ] ];
$$lo     = HoldPattern[ LocalObject ][ $$string, OptionsPattern[ ] ];
$$resp   = HoldPattern[ HTTPResponse ][ $$bytes, $$assoc, OptionsPattern[ ] ];
$$source = $$string | $$file | $$url | $$co | $$lo | $$resp;
$$target = $$string | $$file | $$co | $$lo;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
