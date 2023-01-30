PreemptProtect[ BeginPackage[ "RH`ComputationalFitness`" ]; EndPackage[ ] ];

RH`ComputationalFitnessLoader`$MXFile = FileNameJoin @ {
    DirectoryName @ $InputFileName,
    ToString @ $SystemWordLength <> "Bit",
    "ComputationalFitness.mx"
};

Quiet[

    If[ FileExistsQ @ RH`ComputationalFitnessLoader`$MXFile,
        Get @ RH`ComputationalFitnessLoader`$MXFile,
        WithCleanup[
            Get[ "RH`ComputationalFitness`Package`" ],
            { $Context, $ContextPath, $ContextAliases } = { ## }
        ] & [ $Context, $ContextPath, $ContextAliases ]
    ];

    If[ ! TrueQ @ RH`ComputationalFitnessLoader`$BuildingMX,
        RH`ComputationalFitness`Package`initialize[ ]
    ],
    General::shdw
];