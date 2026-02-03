# ComputationalFitness

A Wolfram Language paclet for importing and analyzing fitness data from smartwatches, cycling computers, and other sources.

## Features

- **Multi-format support**: Import and export FIT, TCX, and ZWO file formats
- **High-performance parsing**: C-based binary parsing via LibraryLink for fast FIT file processing
- **Rich data container**: `FitnessData` objects provide structured access to activity data
- **Power analysis tools**:
  - Mean Maximal Power Curve calculation and visualization
  - Critical Power parameter estimation
  - Functional Threshold Power (FTP) analysis
  - Power zone visualization
- **Physiological metrics**: Maximum heart rate estimation, energy system strain analysis
- **Workout creation**: Export structured workouts to ZWO format for use with Zwift and other platforms

## Requirements

- Wolfram Language 13.0 or later (Mathematica, Wolfram Desktop, or Wolfram Engine)

## Installation

Install directly from the Wolfram Paclet Repository:

```wl
PacletInstall["RickHennigan/ComputationalFitness"]
```

Or install from a local build:

```wl
PacletInstall["path/to/ComputationalFitness.paclet"]
```

## Quick Start

```wl
(* Load the paclet *)
Needs["RickHennigan`ComputationalFitness`"]

(* Import a FIT file *)
data = FITImport["Activity.fit"]

(* Access activity properties *)
data["Sport"]
data["Duration"]
data["Power"]

(* Calculate mean maximal power curve *)
mmp = MeanMaximalPowerCurve[data]

(* Visualize the power curve *)
MeanMaximalPowerCurvePlot[mmp]

(* Estimate critical power parameters *)
EstimateCriticalPowerParameters[mmp]
```

## Main Functions

| Function | Description |
|----------|-------------|
| `FITImport` | Import FIT files from Garmin, Wahoo, and other devices |
| `FITExport` | Export data to FIT format |
| `TCXImport` | Import TCX (Training Center XML) files |
| `ZWOImport` / `ZWOExport` | Import and export Zwift workout files |
| `FitnessData` | Structured container for fitness activity data |
| `MeanMaximalPowerCurve` | Calculate best average power for all durations |
| `MeanMaximalPowerCurvePlot` | Visualize mean maximal power curves |
| `EstimateCriticalPowerParameters` | Estimate CP and W' from power data |
| `FunctionalThresholdPower` | Calculate or set FTP values |
| `MaximumHeartRate` | Estimate maximum heart rate |
| `EnergySystemStrain` | Analyze training stress by energy system |
| `FITFileType` | Determine the type of a FIT file |
| `FITInterpreter` | Custom interpreter for FIT data fields |

## Documentation

Full documentation is included with the paclet and accessible through the Wolfram Documentation Center after installation. Each function has detailed reference pages with examples.

## Building from Source

### Build the paclet

```bash
wolframscript -f Scripts/BuildPaclet.wls
```

### Compile C libraries (current platform)

```bash
wolframscript -f Scripts/Compile.wls
```

Built artifacts are placed in the `build/` directory.

## Example Data

The paclet includes example FIT, TCX, and ZWO files in the `ExampleData` directory for testing and experimentation:

- Cycling activities (indoor and outdoor)
- Multi-sport activities
- Swimming workouts
- Weight scale data
- Structured workouts

## License

MIT License - see [LICENSE](LICENSE) for details.

## Author

Richard Hennigan (Wolfram Research)

## Links

- [Source Code](https://github.com/rhennigan/ComputationalFitness)
- [Paclet Repository](https://www.wolframcloud.com/obj/rhennigan/DeployedResources/Paclet/RickHennigan/ComputationalFitness)
