PreemptProtect[ BeginPackage[ "RH`ComputationalFitness`" ]; EndPackage[ ] ];

RH`ComputationalFitnessLoader`$MXFile = FileNameJoin @ {
    DirectoryName @ $InputFileName,
    ToString @ $SystemWordLength <> "Bit",
    "ComputationalFitness.mx"
};

If[ FileExistsQ @ RH`ComputationalFitnessLoader`$MXFile,
    Get[ RH`ComputationalFitnessLoader`$MXFile ],
    Block[ { $ContextPath },
        Quiet[ Get[ "RH`ComputationalFitness`Package`" ], General::shdw ]
    ]
];

RH`ComputationalFitness`Package`$thisPacletLocation =
    DirectoryName[ $InputFileName, 2 ];
