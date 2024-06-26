Begin[ "RickHennigan`ComputationalFitness`FormatDump`FIT`" ];

$fitImportElements = {
    "Data",
    "Dataset",
    "Elements",
    "Events",
    "FitnessData",
    "RawData",
    "Records",
    "MessageInformation",
    "FileType",
    "MessageData",
    "Messages",
    "PowerZonePlot",
    "AveragePowerPhasePlot",
    "CriticalPowerCurvePlot"
};

fitImporter[ elem_, args___ ] := Function[
    Block[ { RickHennigan`ComputationalFitness`Package`$messageSymbol = Import },
        { elem -> RickHennigan`ComputationalFitness`FITImport[ #1, elem, args, ##2 ] }
    ]
];

ImportExport`RegisterImport[
    "FIT",
    {
        elem_String              :> fitImporter[ elem ],
        { elem_String, args___ } :> fitImporter[ elem, args ]
    },
    "BinaryFormat"      -> True,
    "AvailableElements" -> $fitImportElements,
    "HiddenElements"    -> { },
    "FunctionChannels"  -> { "FileNames" },
    "DefaultElement"    -> "FitnessData",
    "Options"           -> { "FunctionalThresholdPower", "MaximumHeartRate", "Sport", "UnitSystem", "Weight" }
];

If[ MatchQ[ FileFormatDump`FormatProperties[ "FIT" ][ "Name" ], Except[ _String ] | "" ],
    Get @ FileNameJoin @ { DirectoryName @ $InputFileName, "Properties.m" }
];

End[ ];
