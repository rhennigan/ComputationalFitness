Begin[ "RickHennigan`ComputationalFitness`FormatDump`FIT`" ];

fitExporter[ args___ ] := Function[
    Block[ { RickHennigan`ComputationalFitness`Package`$messageSymbol = Export },
        RickHennigan`ComputationalFitness`FITExport[ #1, args ]
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