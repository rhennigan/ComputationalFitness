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

FITExport::InvalidMessages =
"The given messages are not valid.";

FITExport::InvalidTSData =
"The given time series data is not valid.";

(* ::**********************************************************************:: *)
(* ::Section:: *)
(*Options*)
FITExport // Options = {
    FunctionalThresholdPower :> $FunctionalThresholdPower,
    MaximumHeartRate         :> $MaximumHeartRate,
    Sport                    :> $Sport,
    TimeZone                 :> $TimeZone, (* TODO *)
    UnitSystem               :> $UnitSystem,
    Weight                   :> $Weight
};

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Main definition*)

FITExport[ file_, data_List? rawDataQ, opts: OptionsPattern[ ] ] :=
    fitExportOptionsBlock[
        fitExport[ file, data ],
        opts
    ];

FITExport[ file_, ds_Dataset, opts: OptionsPattern[ ] ] :=
    fitExportOptionsBlock[
        FITExport[ file, Normal @ ds, opts ],
        opts
    ];

FITExport[ file_, data_Association? tsDataQ, opts: OptionsPattern[ ] ] :=
    fitExportOptionsBlock[
        FITExport[ file, makeRawData @ tsToMessageList @ data, opts ],
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
(*fitExport*)
fitExport // beginDefinition;

fitExport[ target: $$target, data_ ] := (
    setPreferences @ data;
    fitExport0[ target, data ]
);

(* TODO: catch target errors here *)
fitExport // endDefinition;


fitExport0 // beginDefinition;

fitExport0[ target: $$file|$$string, data_ ] :=
    fitExport0[ target, ExpandFileName @ target, data ];

(* TODO: CloudObject, LocalObject *)

fitExport0[ target_, file_String, data_ ] :=
    fitExport0[
        target,
        file,
        data,
        Quiet[ fitExportLibFunction[ file, data ], LibraryFunction::rterr ]
    ];

fitExport0[ target_, file_, data_, err_LibraryFunctionError ] :=
    libraryError[ target, file, err ];

fitExport0[ target_, file_, data_, exportCount_Integer ] :=
    If[ exportCount === Length @ data,
        File @ file,
        (* TODO: *)
        issueExportCountWarning[ target, file, Length @ data, exportCount ];
        File @ file
    ];

fitExport0 // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*makeRawData*)
makeRawData // beginDefinition;

makeRawData[ messages_ ] :=
    Module[ { withFileID, vectors, packed },
        withFileID = ensureFileID @ messages;
        vectors = Select[ toMessageVector /@ withFileID, dev`PackedArrayQ ];
        packed = dev`ToPackedArray @ vectors;
        If[ packedIntegerArrayQ @ packed,
            packed,
            throwFailure[ FITExport::InvalidMessages, packed ]
        ]
    ];

makeRawData // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*ensureFileID*)
ensureFileID // beginDefinition;

ensureFileID[ messages: { ___Association } ] :=
    Module[ { fileID },
        fileID = FirstCase[ messages, KeyValuePattern[ "MessageType" -> "FileID" ] ];
        If[ MissingQ @ fileID,
            Prepend[ messages, newFileIDMessage @ guessFitFileType @ messages ],
            messages
        ]
    ];

ensureFileID // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*messageListQ*)
messageListQ // ClearAll;
messageListQ[ { __? messageAssociationQ } ] := True;
messageListQ[ ___ ] := False;

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

toMessageVector[ message_ ] :=
    Module[ { type, vector, fields, usable, exported, packed },
        type     = message[ "MessageType" ];
        vector   = initializeMessageVector @ type;
        fields   = $FITMessageDefinitions[ type, "Fields" ];
        usable   = KeyDrop[ DeleteMissing @ message, "MessageType" ];
        exported = setMessageVector[ vector, type, fields, usable ];
        packed   = dev`ToPackedArray @ vector;

        (* TODO: unhandled keys in `exported` should probably produce a warning *)

        If[ packedIntegerArrayQ @ packed,
            packed,
            messagePrint[ FITExport::InvalidMessage, message, packed ];
            Nothing
        ]
    ];

toMessageVector // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*setMessageVector*)
setMessageVector // beginDefinition;
setMessageVector // Attributes = { HoldFirst };
setMessageVector[ vector_, type_, fields_, message_ ] :=
    Map[ (* TODO: Scan might be faster, but would lose post-analysis capability *)
        setMessageVectorValue[
            vector,
            #Index,
            ifitValue[ type, #FieldName, #Dimensions, message ]
        ] &,
        fields
    ];

setMessageVector // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*setMessageVectorValue*)
setMessageVectorValue // ClearAll;
setMessageVectorValue // Attributes = { HoldFirst };

setMessageVectorValue[ vector_, index_Integer, value_Integer ] := vector[[ index ]] = value;
setMessageVectorValue[ vector_, Span[ a_, b_ ], value_ ] := setMessageVectorValueA[ vector, a, b, value ];
setMessageVectorValue[ ___ ] := $Failed;

setMessageVectorValueA // ClearAll;
setMessageVectorValueA // Attributes = { HoldFirst };
setMessageVectorValueA[ vector_, a_Integer, b_Integer, value: { __Integer } ] :=
    If[ Length @ value == b - a + 1,
        vector[[ a;;b ]] = dev`ToPackedArray @ value,
        $Failed
    ];

setMessageVectorValueA[ ___ ] := $Failed;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*tsDataQ*)
tsDataQ // ClearAll;

tsDataQ[ as_Association ] :=
    And[ AllTrue[ Keys @ as, fitRecordKeyQ ],
         AllTrue[ Values @ as, MatchQ[ _TemporalData | _TimeSeries ] ]
    ];

tsDataQ[ ___ ] := False;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*tsToMessageList*)
tsToMessageList // beginDefinition;

tsToMessageList[ as_Association ] :=
    Module[ { keys, td, messages },
        keys = Keys @ as;
        td = TemporalData @ Values @ as;
        messages = KeyValueMap[
            Association[
                "MessageType" -> "Record",
                "Timestamp" -> DateObject[ #1 ],
                #2
            ] &,
            Merge[
                makeTSRules /@ Transpose @ { keys, td[ "Paths" ] },
                Association
            ]
        ];

        If[ TrueQ @ messageListQ @ messages,
            messages,
            throwFailure[ FITExport::InvalidTSData, as, messages ]
        ]
    ];

tsToMessageList // endDefinition;

makeTSRules // beginDefinition;
makeTSRules[ { key_, pairs_ } ] := (Apply[ #1 -> <| key -> #2 |> & ]) /@ pairs;
makeTSRules // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Default Messages*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*guessFitFileType*)
guessFitFileType // beginDefinition;
guessFitFileType[ _ ] := "Activity"; (* TODO: make this do stuff *)
guessFitFileType // endDefinition;

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*newFileIDMessage*)
newFileIDMessage // beginDefinition;

newFileIDMessage[ ] := newFileIDMessage[ "Activity" ];

newFileIDMessage[ type_? fitFileTypeQ ] := <|
    "MessageType"  -> "FileID",
    "Type"         -> type,
    "TimeCreated"  -> DateObject[ TimeZone -> 0 ],
    "SerialNumber" -> $pacletSerialNumber,
    "Manufacturer" -> $manufacturerName,
    "Product"      -> $productID,
    "ProductName"  -> $productName
|>;

newFileIDMessage // endDefinition;

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
