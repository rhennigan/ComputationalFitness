# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

ComputationalFitness is a Wolfram Language paclet for importing and analyzing fitness data from smartwatches, cycling computers, and other sources. It supports FIT, TCX, and ZWO file formats with C-based binary parsing for performance.

## Build System

### Common Commands

**Build the paclet:**
```bash
wolframscript -f Scripts/BuildPaclet.wls
```

**Run tests:**
```bash
wolframscript -f Scripts/TestPaclet.wls
```

**Compile C libraries for current platform:**
```bash
wolframscript -f Scripts/Compile.wls
```

**Generate source files from ResourceDefinition.nb:**
```bash
wolframscript -f Scripts/GenerateSourceFiles.wls
```

**Format Wolfram Language files:**
```bash
wolframscript -f Scripts/FormatFiles.wls
```

### Build Architecture

- **Scripts/Common.wl**: Shared build infrastructure, loads `Wolfram/PacletCICD` for CI/CD operations
- **ResourceDefinition.nb**: Source of truth for the paclet - generates code, tests, and documentation
- **Scripts/BuildMX.wls**: Creates optimized MX (compiled) versions of the paclet for faster loading
- **build/**: Output directory for built paclet artifacts

## Code Organization

### Package Structure

The paclet follows a modular structure with a main loader (`Kernel/ComputationalFitness.wl`) that:
1. Attempts to load a pre-compiled MX file if available (for performance)
2. Falls back to loading `Kernel/Package.wl` which orchestrates loading all submodules

**Kernel/Package.wl** loads files in this order:
- `Utilities.wl` - Common utilities
- `Data.wl` - Data handling
- `Config.wl` - Configuration management
- `Strings.wl` - String utilities
- `ImportExport.wl` - Format registration
- `LibraryFunctions.wl` - C library bindings
- `FIT/` - FIT format support (subdirectory)
- `TCX/` - TCX format support (subdirectory)
- `ZWO/` - ZWO format support (subdirectory)
- `FitnessData.wl` - Main data type
- `MeanMaximalPowerCurve.wl` - Power analysis
- `Initialization.wl` - Final setup

### Key Architecture Patterns

**Exported Symbols**: Exported symbols in the main context must be declared in both the PacletInfo.wl and Kernel/Package.wl files.

**Binary Data Parsing**: The FIT format parser is implemented in C (Source/FIT/) and linked via LibraryLink for performance. The C code handles binary protocol parsing while Wolfram Language handles higher-level interpretation.

**Validation Pattern**: Core types like `FitnessData` use the ``System`Private`HoldNotValidQ`` / `HoldSetValid` pattern for efficient validation caching.

**Error Handling**: Uses `catchMine`, `catchTop`, `throwFailure`, and `throwInternalFailure` helpers (defined in Package context) for consistent error management across the codebase.

**Definition Wrappers**: Functions are wrapped with `beginDefinition` / `endDefinition` (or `endExportedDefinition`) for consistent setup/teardown.

### Format Support

- **FIT (Flexible and Interoperable Data Transfer)**: Primary format from Garmin and other devices. Binary protocol with message definitions in `Data/FITMessageDefinitions.wl`
- **TCX (Training Center XML)**: XML-based format. Parser in `Kernel/TCX/`
- **ZWO**: Zwift workout format. Parser in `Kernel/ZWO/`

### C Library Components

C source files in `Source/FIT/` implement the FIT SDK:
- `fit_import.c/h`: Binary import
- `fit_export.c/h`: Binary export
- `fit_convert.c/h`: Data conversion
- `fit_crc.c/h`: CRC validation
- Compiled outputs go to `LibraryResources/{SystemID}/`

## Testing

Tests are in `Tests/` directory using `.wlt` format (Wolfram Language Test files):
- `FITImport.wlt` - FIT import tests
- `ImportExport.wlt` - General import/export tests
- `MeanMaximalPowerCurve.wlt` - Power curve calculation tests

Tests can be run individually:
```wl
TestReport["Tests/MeanMaximalPowerCurve.wlt"]
```

## CI/CD Pipeline

The `.github/workflows/Check.yml` workflow:
1. Compiles C libraries for all platforms in parallel (Windows, macOS x86/ARM, Linux)
2. Builds the paclet with all compiled artifacts
3. Runs tests on all platforms

Platform-specific compilation uses different Wolfram Engine versions and caching strategies for efficiency.

## Key Symbols

Main exported symbols (see PacletInfo.wl):
- `FITImport/FITExport` - FIT file I/O
- `TCXImport` - TCX file import
- `ZWOImport/ZWOExport` - ZWO file I/O
- `FitnessData` - Main data container
- `MeanMaximalPowerCurve` - Power curve analysis
- `FunctionalThresholdPower`, `MaximumHeartRate`, `Weight`, `Sport` - Configuration

## Development Notes

- The paclet uses `GeneralUtilities` for common patterns
- Context aliases (e.g., ``sp`PrivateHoldNotValidQ``) reduce symbol verbosity
- The build system integrates with GitHub Actions for automated releases
- Release metadata (`$RELEASE_ID$`, etc.) is templated in PacletInfo.wl and replaced during CI builds
