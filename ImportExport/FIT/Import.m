Begin[ "RH`ComputationalFitness`FormatDump`FIT`" ];

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
    Block[ { RH`ComputationalFitness`Package`$messageSymbol = Import },
        { elem -> RH`ComputationalFitness`FITImport[ #1, elem, args ] }
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
    "DefaultElement"    -> "FitnessData"
];

If[ MatchQ[ FileFormatDump`FormatProperties[ "FIT" ][ "Name" ], Except[ _String ] | "" ],
    Get @ FileNameJoin @ { DirectoryName @ $InputFileName, "Properties.m" }
];

End[ ];
