(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`ZWO`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Config*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoInterpreterSymbol*)
zwoInterpreterSymbol // beginDefinition;
zwoInterpreterSymbol[ s_String ] := zwoInterpreterSymbol[ s, Symbol @ s ];
zwoInterpreterSymbol[ _, sym_Symbol? AtomQ ] := sym;
zwoInterpreterSymbol // endDefinition;
zwoInterpreterSymbol // excludeFromMX;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$zwoInterpreters*)
$zwoInterpreters = AssociationMap[
    zwoInterpreterSymbol,
    Union[
        Values @ $zwoReference[[ "Elements"  , All, "Value", "Interpreter" ]],
        Values @ $zwoReference[[ "Attributes", All, "Value", "Interpreter" ]]
    ]
];

(* ::**************************************************************************************************************:: *)
(* ::Section:: *)
(*Messages*)
ZWOImport::Internal =
"An unexpected error occurred. `1`";

ZWOImport::InvalidXML =
"Cannot import data as ZWO format.";

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Options*)
ZWOImport // Options = { UnitSystem :> $UnitSystem };

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Main Definition*)
ZWOImport[ file_, opts: OptionsPattern[ ] ] := zwoOptionsBlock[ zwoImport @ file, opts ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoOptionsBlock*)
zwoOptionsBlock // beginDefinition;

zwoOptionsBlock[ eval_, opts: OptionsPattern[ ZWOImport ] ] :=
    catchTopAs[ ZWOImport ] @ Block[
        {
            $UnitSystem     = OptionValue @ UnitSystem,
            zwoOptionsBlock = # &
        },
        eval
    ];

zwoOptionsBlock // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoImport*)
zwoImport // beginDefinition;
zwoImport[ source: $$source ] := cached @ sourceFileApply[ zwoImport0, source ];
zwoImport // endDefinition;

zwoImport0 // beginDefinition;
zwoImport0[ source_, file_String ] := zwoImport0[ source, ReadByteArray @ file ];
zwoImport0[ source_, bytes_ByteArray ] := zwoImport0[ source, bytes, importXML @ bytes ];
zwoImport0[ source_, bytes_, xml: XMLObject[ _ ][ ___ ] ] := makeZWOFitnessData[ source, bytes, zwoParse @ xml ];
zwoImport0 // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoPostProcess*)
zwoPostProcess // beginDefinition;
zwoPostProcess[ source_, bytes_, result_ ] := <| "Source" -> source, "Bytes" -> bytes, "Result" -> result |>; (* TODO *)
zwoPostProcess // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoParse*)
zwoParse // beginDefinition;

zwoParse[ XMLObject[ "Document" ][ _, xml_XMLElement, ___ ] ] :=
    Block[ { $parseBag = Internal`Bag[ ] },
        zwoParse[ { }, xml ];
        Internal`BagPart[ $parseBag, All ]
    ];

zwoParse[ path_List, element: XMLElement[ tag_, _, elements_ ] ] :=
    Module[ { reference, tagName, interpreter, result, data },

        reference   = $zwoReference[ "Elements", tag ];
        tagName     = reference[ "Name" ];
        interpreter = makeZWOInterpreter[ tagName, path, reference ];
        result      = interpreter[ tagName, path, element ];
        data        = <| "TagName" -> tagName, "Path" -> path, "Result" -> result |>;

        If[ ! MissingQ @ data, Internal`StuffBag[ $parseBag, data ] ];
        If[ result === element, zwoParse[ Append[ path, tag ], elements ] ]
    ];

zwoParse[ path_, elements_List ] := zwoParse[ path, # ] & /@ elements;

zwoParse[ path_, other_ ] := Null;

zwoParse // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*makeZWOInterpreter*)
makeZWOInterpreter // beginDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Custom Overrides*)
makeZWOInterpreter[ "Tags", { "workout_file" }, _ ] := zwoTags;
makeZWOInterpreter[ "Workout", { "workout_file" }, _ ] := zwoWorkout;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*Other*)
makeZWOInterpreter[ name_, _, as_Association ] := makeZWOInterpreter0 @ as[ "Value", "Interpreter" ];
makeZWOInterpreter // endDefinition;


makeZWOInterpreter0 // beginDefinition;
makeZWOInterpreter0[ interpreter_String ] := makeZWOInterpreter0[ interpreter, $zwoInterpreters @ interpreter ];
makeZWOInterpreter0[ interpreter_String, symbol_Symbol ] := symbol;
makeZWOInterpreter0 // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*xmlElementPaths*)
xmlElementPaths // beginDefinition;

xmlElementPaths[ xml_ ] :=
    Module[ { pathBag, debug, result },
        pathBag = Internal`Bag[ ];
        debug = Flatten @ xmlElementPaths[ pathBag, { }, xml ];
        result = Internal`BagPart[ pathBag, All ];
        $lastXMLElementPathResult = <| "Result" -> result, "Debug" -> debug |>;
        result
    ];

xmlElementPaths[ pathBag_, path_, XMLObject[ "Document" ][ _, xml_XMLElement, ___ ] ] :=
    xmlElementPaths[ pathBag, path, xml ];

xmlElementPaths[ pathBag_, path_, { }     ] := Nothing;
xmlElementPaths[ pathBag_, path_, _String ] := Nothing;

xmlElementPaths[ pathBag_, path_, elements_List ] := xmlElementPaths[ pathBag, path, #1 ] & /@ elements;

xmlElementPaths[ pathBag_, { path___ }, elem: XMLElement[ tag_, attributes_, elements_ ] ] := (
    Internal`StuffBag[ pathBag, <| "Tag" -> tag, "Path" -> { path }, "Element" -> elem |> ];
    xmlElementPaths[ pathBag, { path, tag }, elements ]
);

xmlElementPaths // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Interpreters*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Basic Types*)

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*zwoBoolean*)
zwoBoolean // ClearAll;
zwoBoolean[ _, _, xml_ ] := zwoBoolean @ xml;
zwoBoolean[ XMLElement[ _, _, data_ ] ] := zwoBoolean @ data;
zwoBoolean[ { data_ } ] := zwoBoolean @ data;
zwoBoolean[ s_String ] := zwoBoolean0 @ ToLowerCase @ s;
zwoBoolean[ boolean: True|False ] := boolean;
zwoBoolean[ n_Integer ] := n =!= 0;
zwoBoolean[ n_Real    ] := TrueQ[ n != 0.0 ];
zwoBoolean[ ___ ] := Missing[ "NotAvailable" ];

zwoBoolean0 // ClearAll;
zwoBoolean0[ "1"|"true"  ] := True;
zwoBoolean0[ "0"|"false" ] := False;
zwoBoolean0[ s_String? (StringMatchQ @ NumberString) ] := zwoBoolean @ ToExpression @ s;
zwoBoolean0[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*zwoReal*)
zwoReal // ClearAll;
zwoReal[ _, _, xml_ ] := zwoReal @ xml;
zwoReal[ XMLElement[ _, _, data_ ] ] := zwoReal @ data;
zwoReal[ { data_ } ] := zwoReal @ data;
zwoReal[ s_String? (StringMatchQ @ NumberString) ] := N @ ToExpression @ s;
zwoReal[ n_Real ] := n;
zwoReal[ n_Integer ] := N @ n;
zwoReal[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*zwoInteger*)
zwoInteger // ClearAll;
zwoInteger[ _, _, xml_ ] := zwoInteger @ xml;
zwoInteger[ XMLElement[ _, _, data_ ] ] := zwoInteger @ data;
zwoInteger[ { data_ } ] := zwoInteger @ data;
zwoInteger[ s_String? (StringMatchQ @ NumberString) ] := zwoInteger @ ToExpression @ s;
zwoInteger[ n_Integer ] := n;
zwoInteger[ n_Real ] := IntegerPart @ n;
zwoInteger[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*zwoString*)
zwoString // ClearAll;
zwoString[ _, _, xml_ ] := zwoString @ xml;
zwoString[ XMLElement[ _, _, data_ ] ] := zwoString @ data;
zwoString[ { data_ } ] := zwoString @ data;
zwoString[ s_String ] := s;
zwoString[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*zwoMissing*)
zwoMissing // ClearAll;
zwoMissing[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoPercent*)
zwoPercent // ClearAll;
zwoPercent[ _, _, xml_ ] := zwoPercent @ xml;
zwoPercent[ XMLElement[ _, _, data_ ] ] := zwoPercent @ data;
zwoPercent[ { data_ } ] := zwoPercent @ data;
zwoPercent[ s_String? (StringMatchQ @ NumberString) ] := zwoPercent @ ToExpression @ s;
zwoPercent[ n_Integer ] := zwoPercent @ N @ n;
zwoPercent[ n_Real ] := Quantity[ 100*n, "Percent" ];
zwoPercent[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoPowerPercent*)
zwoPowerPercent // beginDefinition;
zwoPowerPercent[ tag_, path_, data_ ] := zwoPowerPercent0[ zwoPercent[ tag, path, data ] ];
zwoPowerPercent // endDefinition;

zwoPowerPercent0 // ClearAll;
zwoPowerPercent0[ _Missing ] := Missing[ "NotAvailable" ];
zwoPowerPercent0[ percent_ ] := zwoPowerPercent0[ percent, $ftp ]; (* TODO: move this to package scope and set in options *)
zwoPowerPercent0[ Quantity[ percent_, "Percent" ], ftp_? NumberQ ] := Quantity[ percent*ftp, "Watts" ];
zwoPowerPercent0[ percent_, Quantity[ ftp_, "Watts" ] ] := zwoPowerPercent0[ percent, ftp ];
zwoPowerPercent0[ Quantity[ percent_, "Percent" ], _ ] := percent/100 * QuantityVariable[ "FTP", "Power" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoSeconds*)
zwoSeconds // ClearAll;
zwoSeconds[ _, _, xml_ ] := zwoSeconds @ xml;
zwoSeconds[ XMLElement[ _, _, data_ ] ] := zwoSeconds @ data;
zwoSeconds[ { data_ } ] := zwoSeconds @ data;
zwoSeconds[ s_String? (StringMatchQ @ NumberString) ] := zwoSeconds @ ToExpression @ s;
zwoSeconds[ n_Integer ] := secondsToQuantity @ n;
zwoSeconds[ n_Real ] := secondsToQuantity @ n;
zwoSeconds[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoSportType*)
zwoSportType // ClearAll;
zwoSportType[ _, _, xml_ ] := zwoSportType @ xml;
zwoSportType[ XMLElement[ _, _, data_ ] ] := zwoSportType @ data;
zwoSportType[ { data_ } ] := zwoSportType @ data;
zwoSportType[ "Bike"|"bike"|"Ride"|"ride" ] := "Cycling";
zwoSportType[ "Run"|"run" ] := "Running";
zwoSportType[ sport_String ] := Capitalize @ sport;
zwoSportType[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoTimestamp*)
zwoTimestamp // ClearAll;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoWatts*)
zwoWatts // ClearAll;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoTags*)
zwoTags // ClearAll;
zwoTags[ _, _, xml_ ] := zwoTags @ xml;

zwoTags[ XMLElement[ "tags", _, xml_ ] ] :=
    Replace[
        Cases[ Flatten @ { xml }, XMLElement[ "tag", { ___, "name" -> tag_String, ___ }, _ ] :> tag, Infinity ],
        { } -> Missing[ "NotAvailable" ]
    ];

zwoTags[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoWorkout*)
zwoWorkout // ClearAll;
zwoWorkout[ _, path_, xml_ ] := zwoWorkout[ path, xml ];
zwoWorkout[ { path___ }, XMLElement[ tag_, _, steps_ ] ] := zwoWorkout[ { path, tag }, Flatten @ { steps } ];
zwoWorkout[ path_, { } ] := Missing[ "NotAvailable" ];
zwoWorkout[ path_, steps_List ] := Flatten @ { zwoWorkoutSteps[ path, steps ] };
zwoWorkout[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*zwoWorkoutSteps*)
zwoWorkoutSteps // beginDefinition;
zwoWorkoutSteps[ path_List, steps_List ] := Block[ { $stepIndex = 0 }, zwoWorkoutStep[ path, # ] & /@ steps ];
zwoWorkoutSteps // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*zwoWorkoutStep*)
zwoWorkoutStep // beginDefinition;

zwoWorkoutStep[ path_, XMLElement[ tag_, attributes_, data_ ] ] :=
    zwoWorkoutStep[ tag, path, attributes, data ];

zwoWorkoutStep[ tag_, { path__ }, attributes_, data_ ] :=
    zwoWorkoutStep0[
        tag,
        Association[
            "Tag"  -> tag,
            "Path" -> { path },
            Cases[
                Flatten @ { attributes },
                Rule[ attribute_, value_ ] :> zwoAttributeRule[ attribute, { path, tag }, value ]
            ]
        ],
        data
    ];

zwoWorkoutStep // endDefinition;


zwoWorkoutStep0 // beginDefinition;

zwoWorkoutStep0[ tag_, as_, { } ] := zwoWorkoutStep0[ tag, as, Missing[ ] ];
zwoWorkoutStep0[ "IntervalsT", as_, data_ ] := repeatedWorkoutSteps[ "IntervalsT", as[ "Repeat" ], as, data ];

zwoWorkoutStep0[ tag_, as_Association? AssociationQ, data_ ] :=
    DeleteMissing @ Association[
        "Tag" -> tag,
        "MessageIndex" -> ++$stepIndex,
        as,
        "XMLData" -> data
    ];

zwoWorkoutStep0 // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*repeatedWorkoutSteps*)
repeatedWorkoutSteps // beginDefinition;
repeatedWorkoutSteps[ "IntervalsT", n_, as_, data_ ] := intervalsT[ n, as, data ];
repeatedWorkoutSteps // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*intervalsT*)
intervalsT // beginDefinition;

intervalsT[
    n_,
    KeyValuePattern @ { "OnDuration" -> onDuration_, "OffDuration" -> offDuration_ },
    data_
]

intervalsT[ repeat_Integer, as_Association, data_ ] :=
    Flatten @ Table[ { intervalsTOn[ as, data ], intervalsTOff[ as, data ] }, { repeat } ];

intervalsT // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoXML*)
zwoXML // beginDefinition;
zwoXML[ _, _, xml_ ] := zwoXML @ xml;
zwoXML[ { } ] := Missing[ "NotAvailable" ];
zwoXML[ xml_ ] := xml;
zwoXML // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoAttributeRule*)
zwoAttributeRule // beginDefinition;

zwoAttributeRule[ path_, attribute_ -> value_ ] := zwoAttributeRule[ attribute, path, value ];

zwoAttributeRule[ attribute_, path_, value_ ] :=
    Module[ { reference, tagName, interpreter, result },
        reference   = $zwoReference[ "Attributes", attribute ];
        tagName     = reference[ "Name" ];
        interpreter = makeZWOInterpreter[ tagName, path, reference ];
        result      = interpreter[ tagName, path, value ];
        tagName -> result
    ];

zwoAttributeRule // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
