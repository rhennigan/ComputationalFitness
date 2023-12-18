PreemptProtect[ BeginPackage[ "RickHennigan`ComputationalFitness`" ]; EndPackage[ ] ];

RickHennigan`ComputationalFitnessLoader`$MXFile = FileNameJoin @ {
    DirectoryName @ $InputFileName,
    ToString @ $SystemWordLength <> "Bit",
    "ComputationalFitness.mx"
};

Quiet[

    If[ FileExistsQ @ RickHennigan`ComputationalFitnessLoader`$MXFile,
        Get @ RickHennigan`ComputationalFitnessLoader`$MXFile,
        WithCleanup[
            Get[ "RickHennigan`ComputationalFitness`Package`" ],
            { $Context, $ContextPath, $ContextAliases } = { ## }
        ] & [ $Context, $ContextPath, $ContextAliases ]
    ];

    If[ ! TrueQ @ RickHennigan`ComputationalFitnessLoader`$BuildingMX,
        RickHennigan`ComputationalFitness`Package`initialize[ ]
    ],
    General::shdw
];