(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`FIT`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

$ContextAliases[ "dev`" ] = "Developer`";
$ContextAliases[ "int`" ] = "Internal`";

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Messages*)

FITExport::InitializeMessageFailure =
"Unable to initialize message vector for message type `1`.";

FITExport::InvalidMessage =
"Invalid message data: `1`.";

(* ::**********************************************************************:: *)
(* ::Section:: *)
(*Options*)
FITExport // Options = {
    FunctionalThresholdPower :> $FunctionalThresholdPower,
    MaximumHeartRate         :> $MaximumHeartRate,
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
            $maxHR          = setMaxHR @ OptionValue @ MaximumHeartRate,
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
(* ::Subsection::Closed:: *)
(*packedIntegerArrayQ*)
packedIntegerArrayQ // ClearAll;
packedIntegerArrayQ[ array_? dev`PackedArrayQ ] := int`PackedArrayType @ array === Integer;
packedIntegerArrayQ[ ___ ] := False;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$fitInitialMessageVector*)
$fitInitialMessageVector := Enclose[
    $fitInitialMessageVector =
        ConfirmBy[
            dev`ToPackedArray @ ConstantArray[
                0,
                ConfirmBy[ $fitMessageTensorRowWidth, IntegerQ ]
            ],
            packedIntegerArrayQ
        ],
    throwInternalFailure[ HoldForm @ $fitInitialMessageVector, # ] &
];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*initializeMessageVector*)
initializeMessageVector // beginDefinition;

initializeMessageVector[ name_String ] := Enclose[
    Module[ { definition, size, fields, vector, packed },
        definition = ConfirmBy[ $FITMessageDefinitions @ name, AssociationQ ];
        size       = ConfirmBy[ definition[ "Size"   ], IntegerQ     ];
        fields     = ConfirmBy[ definition[ "Fields" ], AssociationQ ];
        vector     = ConfirmBy[ $fitInitialMessageVector, packedIntegerArrayQ ];

        (* Set message type *)
        vector[[ 1 ]] = definition[ "MessageNumber" ];

        (* Set scalar fields to initial values *)
        Cases[ fields,
               KeyValuePattern @ {
                   "Index"   -> idx_Integer,
                   "Invalid" -> inv_Integer
               } :> (vector[[ idx ]] = inv)
        ];

        (* Set array fields to initial values *)
        Cases[ fields,
               KeyValuePattern @ {
                   "Index"   -> (a_);;(b_),
                   "Invalid" -> inv_Integer
               } :> (vector[[ a;;b ]] = ConstantArray[ inv, b - a + 1 ])
        ];

        (* Mark end of field values *)
        vector[[ size + 1 ]] = $fitTerm;

        (* Ensure packed and return cached result *)
        packed = ConfirmBy[ dev`ToPackedArray @ vector, packedIntegerArrayQ ];
        initializeMessageVector[ name ] = packed
    ],
    throwFailure[ FITExport::InitializeMessageFailure, name, # ] &
];

initializeMessageVector[ KeyValuePattern[ "MessageType" -> mesgType_ ] ] :=
    initializeMessageVector @ mesgType;

initializeMessageVector[ mesgNum_Integer ] :=
    initializeMessageVector @ fitMessageType @ mesgNum;

initializeMessageVector // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*messageAssociationQ*)
messageAssociationQ // ClearAll;
messageAssociationQ[ KeyValuePattern[ "MessageType" -> type_ ] ] := messageTypeQ @ type;
messageAssociationQ[ ___ ] := False;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*toMessageVector*)
toMessageVector // beginDefinition;

toMessageVector[ message_Association? messageAssociationQ ] :=
    Module[ { type, vector, definition, keys, usable, packed },
        type       = message[ "MessageType" ];
        vector     = initializeMessageVector @ type;
        definition = $FITMessageDefinitions @ type;
        keys       = Keys @ definition[ "Fields" ];
        usable     = KeyTake[ message, keys ];

        (* FIXME: set parts here instead of in ifitValue defs *)
        KeyValueMap[ ifitValue[ vector, type, #1, #2 ] &, usable ];

        packed = dev`ToPackedArray @ vector;

        If[ packedIntegerArrayQ @ packed,
            packed,
            messagePrint[ FITExport::InvalidMessage, message, packed ];
            $Failed
        ]
    ];

toMessageVector // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
