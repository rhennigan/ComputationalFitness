Begin[ "RickHennigan`ComputationalFitness`FormatDump`FIT`" ];

fitExporter[ args___ ] :=
    Block[ { RickHennigan`ComputationalFitness`Package`$messageSymbol = Export },
        RickHennigan`ComputationalFitness`FITExport @ args
    ];

ImportExport`RegisterExport[
    "FIT",
    fitExporter,
    "BinaryFormat" -> True
];

If[ MatchQ[ FileFormatDump`FormatProperties[ "FIT" ][ "Name" ], Except[ _String ] | "" ],
    Get @ FileNameJoin @ { DirectoryName @ $InputFileName, "Properties.m" }
];

End[ ];