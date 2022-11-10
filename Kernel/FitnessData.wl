BeginPackage[ "RH`FitnessData`" ];
EndPackage[ ];

RH`FitnessDataLoader`$MXFile = FileNameJoin @ {
    DirectoryName @ $InputFileName,
    ToString @ $SystemWordLength <> "Bit",
    "FitnessData.mx"
};

Quiet[
    If[ FileExistsQ @ RH`FitnessDataLoader`$MXFile
        ,
        Get @ RH`FitnessDataLoader`$MXFile
        ,
        Get[ "RH`FitnessData`Symbols`"   ];
        Get[ "RH`FitnessData`Libraries`" ];
        Get[ "RH`FitnessData`FITImport`" ];
    ],
    General::shdw
];