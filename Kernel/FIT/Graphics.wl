(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RickHennigan`ComputationalFitness`FIT`" ];
Needs[ "RickHennigan`ComputationalFitness`" ];
Needs[ "RickHennigan`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Messages*)
ComputationalFitness::NoFTPValue =
"No functional threshold power specified.";

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Argument Patterns*)
$$ftp = _? NumberQ | _Quantity? powerQuantityQ;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*PowerZoneColorFunction*)
PowerZoneColorFunction[ Automatic, ftp: $$ftp ] :=
    catchMine @ powerZonePlotCF @ ftp;

PowerZoneColorFunction[ "Garmin", ftp: $$ftp ] :=
    catchMine @ Block[ { $powerZoneColors = $garminPZColors },
        powerZonePlotCF @ ftp
    ];

PowerZoneColorFunction[ name_, ftp_ ] :=
    catchMine @ Block[ { $ftp = setFTP @ ftp },
        PowerZoneColorFunction[ name, $ftp ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*powerQuantityQ*)
powerQuantityQ // ClearAll;
powerQuantityQ[ q_Quantity ] := CompatibleUnitQ[ q, "Watts" ];
powerQuantityQ[ ___ ] := False;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*PowerZonePlot*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*powerZonePlot*)
powerZonePlot // beginDefinition;

powerZonePlot[ power: _TimeSeries|_TemporalData ] :=
    powerZonePlot[ power, $ftp ];

powerZonePlot[ power: _TimeSeries|_TemporalData, ftp_? NumberQ ] :=
    Module[ { mean, top, resampled, cf },
        mean = Mean @ power;
        top  = Max[ 1.2 * Max @ power, Quantity[ 1.5 * ftp, "Watts" ] ];
        resampled = TimeSeriesResample[ power, (power["LastDate"] - power["FirstDate"]) / 1600 ];
        cf = powerZonePlotCF @ ftp;
        DateListPlot[
            resampled,
            AspectRatio          -> 1 / 5,
            Filling              -> Bottom,
            ColorFunction        -> cf,
            ColorFunctionScaling -> False,
            PlotLegends          -> Placed[ $pzLegend, After ],
            ImageSize            -> $pzPlotWidth,
            PlotRange            -> { All, { Quantity[ 0, "Watts" ], top } },
            GridLines            -> {
                None,
                {
                    {
                        mean,
                        Directive[ Dashed, Gray ]
                    },
                    {
                        Quantity[ ftp, "Watts" ],
                        Directive[ Gray ]
                    }
                }
            }
        ]
    ];

powerZonePlot[ power_, Automatic|None|_Missing ] :=
    Module[ { mean, top, resampled },
        messageFailure[ "NoFTPValue" ];
        mean = Mean @ power;
        top  = 1.2 * Max @ power;
        resampled = TimeSeriesResample[ power, (power["LastDate"] - power["FirstDate"]) / 1600 ];
        DateListPlot[
            resampled,
            AspectRatio          -> 1 / 5,
            Filling              -> Bottom,
            ImageSize            -> $pzPlotWidth,
            PlotRange            -> { All, { Quantity[ 0, "Watts" ], top } },
            GridLines            -> {
                None,
                { { mean, Directive[ Dashed, Gray ] } }
            }
        ]
    ];

powerZonePlot // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*powerZonePlotCF*)
powerZonePlotCF // beginDefinition;

powerZonePlotCF[ ftp_Quantity ] :=
    With[ { watts = UnitConvert[ ftp, "Watts" ] },
        powerZonePlotCF @ QuantityMagnitude @ watts
    ];

powerZonePlotCF[ ftp_? NumberQ ] :=
    With[
        {
            v =
                Transpose @ {
                    Mean /@ Partition[ Append[ $powerZoneThresholds, 2. ], 2, 1 ] + 0.025,
                    Values @ $powerZoneColors
                }
        },
        Function[ { x, y }, Blend[ v, y / ftp ] ]
    ];

powerZonePlotCF // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$pzLegend*)
$pzLegend :=
    With[ { c = Reverse @ KeySort @ $powerZoneColors },
        SwatchLegend[
            Values @ c,
            Style[ #, FontSize -> 10 ] & /@ Lookup[ $pzDescriptions, Keys @ c ],
            LegendMarkers -> Graphics @ { Rectangle[ ] },
            LegendMargins -> 2
        ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$pzDescriptions*)
$pzDescriptions = <|
    1 -> "Active Recovery",
    2 -> "Endurance",
    3 -> "Tempo",
    4 -> "Lactate Threshold",
    5 -> "\!\(\*SubscriptBox[\(VO\), \(2\)]\) max",
    6 -> "Anaerobic Capacity",
    7 -> "Neuromuscular Power"
|>;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*AveragePowerPhasePlot*)

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*averagePowerPhasePlot*)
averagePowerPhasePlot // beginDefinition;

averagePowerPhasePlot[ session0_Dataset ] /; Length @ session0 >= 1 := Enclose[
    Module[
        {
            session, cq, cn, watts, percent, phase1, phase2, peak1, peak2,
            color, left, right, legend
        },
        session = session0[ 1 ];
        cq = ConfirmBy[ #, QuantityQ ] &;
        cn = ConfirmBy[ #, NumberQ ] &;

        watts = cq @ session[ "AveragePower" ];
        percent = cq @ session[ "LeftRightBalance" ][ 1 ];
        phase1 = cn @ Normal @ session[ "AverageLeftPowerPhaseStart" ];
        phase2 = cn @ Normal @ session[ "AverageLeftPowerPhaseEnd" ];
        peak1 = cn @ Normal @ session[ "AverageLeftPowerPhasePeakStart" ];
        peak2 = cn @ Normal @ session[ "AverageLeftPowerPhasePeakEnd" ];
        color = ColorData[ 97 ][ 3 ];

        left = phasePlotHalf[
            { phase1, phase2 },
            { peak1, peak2 },
            color,
            watts,
            percent,
            "LEFT"
        ];

        percent = cq @ session[ "LeftRightBalance" ][ 2 ];
        phase1 = cn @ Normal @ session[ "AverageRightPowerPhaseStart" ];
        phase2 = cn @ Normal @ session[ "AverageRightPowerPhaseEnd" ];
        peak1 = cn @ Normal @ session[ "AverageRightPowerPhasePeakStart" ];
        peak2 = cn @ Normal @ session[ "AverageRightPowerPhasePeakEnd" ];
        color = ColorData[ 97 ][ 1 ];

        right = phasePlotHalf[
            { phase1, phase2 },
            { peak1, peak2 },
            color,
            watts,
            percent,
            "RIGHT"
        ];

        legend = SwatchLegend[
            {
                Lighter[ ColorData[ 97 ][ 3 ], 0.35 ],
                ColorData[ 97 ][ 3 ],
                Lighter[ ColorData[ 97 ][ 1 ], 0.35 ],
                ColorData[ 97 ][ 1 ]
            },
            Map[
                Style[ #1, FontColor -> GrayLevel[ 0.4 ] ] &,
                {
                    "Left Power Phase",
                    "Left Peak Power Phase",
                    "Right Power Phase",
                    "Right Peak Power Phase"
                }
            ]
        ];

        GraphicsRow[ { left, right, legend } ]
    ],
    Missing[ "NotAvailable" ] &
];

averagePowerPhasePlot[ missing_Missing ] := missing;

averagePowerPhasePlot // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*phasePlotHalf*)
phasePlotHalf // beginDefinition;

phasePlotHalf[
    { phase1_, phase2_ },
    { peak1_, peak2_ },
    color_,
    watts_,
    percent_,
    label_
] :=
    Module[ { phase1Pt, phase2Pt, peak1Pt, peak2Pt },

        phase1Pt = { Sin @ phase1, Cos @ phase1 };
        phase2Pt = { Sin @ phase2, Cos @ phase2 };
        peak1Pt = { Sin @ peak1, Cos @ peak1 };
        peak2Pt = { Sin @ peak2, Cos @ peak2 };

        Graphics[
            {
                GrayLevel[ 0.75 ],
                Annulus[ { 0, 0 }, { 1, 1.1 } ],
                Lighter[ color, 0.35 ],
                Annulus[
                    { 0, 0 },
                    { 1, 1.2 },
                    -{ phase2, phase1 + (-1) * 2 * Pi } + Pi / 2
                ],
                White,
                Thick,
                Line @ { phase1Pt, 1.2 * phase1Pt },
                Line @ { phase2Pt, 1.2 * phase2Pt },
                color,
                Annulus[
                    { 0, 0 },
                    { 1, 1.35 },
                    -{ peak2, peak1 } + Pi / 2
                ],
                White,
                Line @ { peak1Pt, 1.35 * peak1Pt },
                Line @ { peak2Pt, 1.35 * peak2Pt },
                GrayLevel[ 0.4 ],
                Thickness[ 0.005 ],
                Line @ { { 0, 0.875 }, { 0, 0.925 } },
                Line @ { { 0, -0.875 }, { 0, -0.925 } },
                Line @ { { -0.95, 0 }, { -0.875, 0 } },
                Line @ { { 0.95, 0 }, { 0.875, 0 } },
                Text[
                    Style[
                        "TDC",
                        FontSize -> Scaled[ 1 / 25 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    { 0, 0.75 },
                    Automatic
                ],
                Text[
                    Style[
                        "BDC",
                        FontSize -> Scaled[ 1 / 25 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    { 0, -0.75 },
                    Automatic
                ],
                Black,
                Text[
                    Style[
                        Round[ percent, 0.1 ],
                        FontSize -> Scaled[ 1 / 8 ],
                        FontWeight -> Bold,
                        FontColor -> GrayLevel[ 0.25 ]
                    ],
                    { 0, 0.2 }
                ],
                Text[
                    Style[
                        Round[ Normal @ percent * watts, 0.1 ],
                        FontSize -> Scaled[ 1 / 12 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    { 0, -0.2 }
                ],
                GrayLevel[ 0.4 ],
                Thickness[ 0.01 ],
                Text[
                    Style[
                        Round @ Quantity[
                            360 * (phase1 / (2 * Pi)),
                            "AngularDegrees"
                        ],
                        FontSize -> Scaled[ 1 / 16 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    1.4 * phase1Pt,
                    Automatic
                ],
                Text[
                    Style[
                        Round @ Quantity[
                            360 * (phase2 / (2 * Pi)),
                            "AngularDegrees"
                        ],
                        FontSize -> Scaled[ 1 / 16 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    1.4 * phase2Pt,
                    Automatic
                ],
                Text[
                    Style[
                        Round @ Quantity[
                            360 * (peak1 / (2 * Pi)),
                            "AngularDegrees"
                        ],
                        FontSize -> Scaled[ 1 / 16 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    1.6 * peak1Pt,
                    Automatic
                ],
                Text[
                    Style[
                        Round @ Quantity[
                            360 * (peak2 / (2 * Pi)),
                            "AngularDegrees"
                        ],
                        FontSize -> Scaled[ 1 / 16 ],
                        FontColor -> GrayLevel[ 0.5 ]
                    ],
                    1.6 * peak2Pt,
                    Automatic
                ],
                GrayLevel[ 0.65 ],
                Arrowheads[ 0.075 ],
                Arrow @ BezierCurve @ {
                    { -1.275, -0.4 },
                    { -1.45, 0 },
                    { -1.275, 0.4 }
                }
            },
            ImageSize -> 200,
            PlotRange -> { { -1.65, 1.65 }, { -1.65, 1.65 } }
        ]
    ];

phasePlotHalf // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*CriticalPowerCurvePlot*)
criticalPowerCurve // beginDefinition;

criticalPowerCurve[ power_TemporalData ] :=
    Module[ { t1, t2, duration, cpCurve },

        t1 = power[ "FirstDate" ];
        t2 = power[ "LastDate" ];
        duration = t2 - t1;

        cpCurve = Map[
            { #1, Max @ MovingMap[ Mean, power, #1 ] } &,
            TakeWhile[ $criticalPowerPoints, LessThan @ duration ]
        ];

        ListLinePlot[
            Append[ cpCurve, { duration, Mean @ power } ],
            ScalingFunctions -> { "Log", None },
            Filling          -> Bottom,
            Ticks            -> { $cpTicks, Automatic },
            AspectRatio      -> 1 / 5,
            PlotRange        -> {
                { Quantity[ 1, "Seconds" ], All },
                All
            },
            GridLines -> {
                $cpTicks,
                None
            }
        ]
    ];

criticalPowerCurve // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$criticalPowerPoints*)
$criticalPowerPoints = {
    Quantity[  1, "Seconds" ],
    Quantity[  5, "Seconds" ],
    Quantity[ 10, "Seconds" ],
    Quantity[ 20, "Seconds" ],
    Quantity[ 30, "Seconds" ],
    Quantity[  1, "Minutes" ],
    Quantity[  3, "Minutes" ],
    Quantity[  5, "Minutes" ],
    Quantity[ 10, "Minutes" ],
    Quantity[ 20, "Minutes" ],
    Quantity[ 30, "Minutes" ],
    Quantity[  1, "Hours"   ],
    Quantity[ 90, "Minutes" ],
    Quantity[  2, "Hours"   ],
    Quantity[  3, "Hours"   ],
    Quantity[  4, "Hours"   ],
    Quantity[  5, "Hours"   ]
};

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*$cpTicks*)
$cpTicks = {
    Quantity[  5, "Seconds" ],
    Quantity[ 20, "Seconds" ],
    Quantity[  1, "Minutes" ],
    Quantity[  5, "Minutes" ],
    Quantity[ 20, "Minutes" ],
    Quantity[  1, "Hours"   ],
    Quantity[  2, "Hours"   ],
    Quantity[  5, "Hours"   ]
};

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Colors*)

$powerZoneColors = <|
    1 -> RGBColor[ "#53b3d1" ],
    2 -> RGBColor[ "#00cba9" ],
    3 -> RGBColor[ "#b4de67" ],
    4 -> RGBColor[ "#e3e562" ],
    5 -> RGBColor[ "#f3b846" ],
    6 -> RGBColor[ "#fa7021" ],
    7 -> RGBColor[ "#fb0052" ]
|>;

$garminPZColors = <|
    1 -> RGBColor[ "#a6a6a6" ],
    2 -> RGBColor[ "#3b97f3" ],
    3 -> RGBColor[ "#82c91e" ],
    4 -> RGBColor[ "#faca48" ],
    5 -> RGBColor[ "#f98925" ],
    6 -> RGBColor[ "#d32020" ],
    7 -> RGBColor[ "#5a30d7" ]
|>;

$hrZoneColors = <|
    1 -> RGBColor[ "#53b3d1" ],
    2 -> RGBColor[ "#5ad488" ],
    3 -> RGBColor[ "#e3e562" ],
    4 -> RGBColor[ "#f69434" ],
    5 -> RGBColor[ "#fb0052" ]
|>;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Icons*)
$fitIcons = getDataFile[ "FITIcons" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
