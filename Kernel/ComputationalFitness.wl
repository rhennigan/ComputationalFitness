BeginPackage[ "RH`ComputationalFitness`" ];
EndPackage[ ];

RH`ComputationalFitnessLoader`$MXFile = FileNameJoin @ {
    DirectoryName @ $InputFileName,
    ToString @ $SystemWordLength <> "Bit",
    "ComputationalFitness.mx"
};

Quiet[
    If[ FileExistsQ @ RH`ComputationalFitnessLoader`$MXFile
        ,
        Get @ RH`ComputationalFitnessLoader`$MXFile
        ,
        Get[ "RH`ComputationalFitness`Symbols`"          ];
        Get[ "RH`ComputationalFitness`Utilities`"        ];
        Get[ "RH`ComputationalFitness`Libraries`"        ];
        Get[ "RH`ComputationalFitness`FITImportStrings`" ];
        Get[ "RH`ComputationalFitness`FITImport`"        ];
        Get[ "RH`ComputationalFitness`TCXImport`"        ];
    ],
    General::shdw
];