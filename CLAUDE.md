# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

ComputationalFitness is a Wolfram Language paclet for importing and analyzing fitness data from smartwatches, cycling computers, and other sources. It supports FIT, TCX, and ZWO file formats with C-based binary parsing for performance.

## Development

In order to test changes to paclet code, you must first evaluate the following as a separate call to the WolframLanguageEvaluator tool:
```wl
PacletDirectoryLoad["path/to/ComputationalFitness"];
Get["RickHennigan`ComputationalFitness`"]
```

Now you can make additional tool calls to run paclet code.

If you've previously built an MX file for the paclet, you should delete it before testing your changes. You can find it in `Kernel/64Bit/ComputationalFitness.mx`.

## Writing Tests

Write tests in the following format:
```wl
VerificationTest[
    input,
    expected,
    SameTest -> MatchQ,
    TestID   -> "AnAppropriateTestID"
]
```

You can optionally include a third argument to specify any expected messages that occur during the evaluation of the input, for example:

```wl
{ FITImport::InvalidFileFormat, ... }
```

Existing test IDs will also have a suffix appended to them (everything after the last `@@`) to indicate where the test is located in the codebase. You do not need to include this suffix in your new test IDs, since they are automatically generated on commit.

You can run test files individually using:

```wl
report = TestReport["path/to/test/file.wlt"];
report["TestsFailed"]
```

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

**Kernel/Package.wl** must load files in this order:
- `Utilities.wl` - Common utilities
- `Data.wl` - Data handling
- `Config.wl` - Configuration management
- All other package files in any order
- `Initialization.wl` - Final setup

### Key Architecture Patterns

#### Error Handling

Error handling is managed using the following helpers:
- `catchTop` - Catches anything thrown by `throwFailure` or `throwInternalFailure`. Only the outermost `catchTop` is used.
- `throwFailure` - Throws a handled handled error with a message ID and arguments.
- `throwInternalFailure` - Throws an unhandled internal failure error.

The functions `catchMine` and `catchTopAs` are variations of `catchTop` that specify the symbol that should be used for error messages. These should only be used for public functions.

Define any error messages using the `ComputationalFitness` symbol. For example:
```wl
ComputationalFitness::NotMachineReal = "Expected real machine precision numbers but encountered `1`.";
```

Then, you can use something like the following to throw an error to the top level:
```wl
throwFailure[ "NotMachineReal", badValue ]
```

The message will automatically be issued from the symbol that's using the outermost `catchMine` or `catchTopAs` block.

#### Exported Functions

Exported functions in the main context must be declared in both the PacletInfo.wl and Kernel/Package.wl files. Define them using the following format:
```wl
NameOfFunction // beginDefinition;
NameOfFunction[ ... ] := catchMine @ internalFunction[ ... ];
NameOfFunction // endExportedDefinition;
```

The name of the internal function is often the same as the exported function, but beginning with a lowercase letter.

#### Internal Functions

Define internal helper functions using the following format:

```wl
nameOfFunction // beginDefinition;

nameOfFunction[ ... ] := Enclose[
    body,
    throwInternalFailure
];

nameOfFunction // endDefinition;
```

The `Enclose` wrapper is only necessary if you are using any `Confirm`, `ConfirmBy`, `ConfirmMatch`, etc. functions in the body, and it will trigger a throw of an internal failure error if any of them fail.

### C Library Components

C source files in `Source/FIT/` implement the FIT SDK:
- `fit_import.c/h`: Binary import
- `fit_export.c/h`: Binary export
- `fit_convert.c/h`: Data conversion
- `fit_crc.c/h`: CRC validation
- Compiled outputs go to `LibraryResources/{SystemID}/`

These files are generated from the FIT SDK using the `Scripts/GenerateSourceFiles.wls` script and should not be edited manually.

## CI/CD Pipeline

The `.github/workflows/Check.yml` workflow:
1. Compiles C libraries for all platforms in parallel (Windows, macOS x86/ARM, Linux)
2. Builds the paclet with all compiled artifacts
3. Runs tests on all platforms

Platform-specific compilation uses different Wolfram Engine versions and caching strategies for efficiency.

## Key Symbols

Main exported symbols (see PacletInfo.wl):
- `FITImport/FITExport` - FIT file I/O
- `FitnessData` - Main data container

## Development Notes

- Context aliases (e.g., ``sp`PrivateHoldNotValidQ``) reduce symbol verbosity
- The build system integrates with GitHub Actions for automated releases
- Release metadata (`$RELEASE_ID$`, etc.) is templated in PacletInfo.wl and replaced during CI builds
