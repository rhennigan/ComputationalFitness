Begin[ "RH`ComputationalFitness`FormatDump`FIT`" ];

fitExporter[ args___ ] := Function[
    Block[ { RH`ComputationalFitness`Package`$messageSymbol = Export },
        RH`ComputationalFitness`FITExport[ #1, args ]
    ]
];

ImportExport`RegisterExport[
    "FIT",
    fitExporter,
    "BinaryFormat"     -> True,
    "FunctionChannels" -> { "FileNames" }
];

If[ MatchQ[ FileFormatDump`FormatProperties[ "FIT" ][ "Name" ], Except[ _String ] | "" ],
    Get @ FileNameJoin @ { DirectoryName @ $InputFileName, "Properties.m" }
];

End[ ];