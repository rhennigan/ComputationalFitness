(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RickHennigan`ComputationalFitness`" ];
Needs[ "RickHennigan`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Initialization*)
initialize[ ] := <|
    "PacletInformation" -> setPacletInformation[ ],
    "ImportExport"      -> registerFormats[ ]
|>;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*setPacletInformation*)
setPacletInformation // beginDefinition;

setPacletInformation[ ] := <|
    "PacletLocation"    -> ($thisPacletLocation = DirectoryName[ $InputFileName, 2 ]),
    "PacletInformation" -> ($thisPacletInfo = PacletObject[ File[ $thisPacletLocation ] ][ "PacletInfo" ])
|>;

setPacletInformation // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*registerFormats*)
registerFormats // beginDefinition;
registerFormats[ ] := AssociationMap[ registerFormat, { "FIT"(*, "TCX", "ZWO"*) } ];
registerFormats // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*registerFormat*)
registerFormat // beginDefinition;

registerFormat[ fmt_String ] /; $debug :=
    getFormatFiles[ fmt, FileNameJoin @ { $thisPacletLocation, "ImportExport", fmt } ];

registerFormat[ fmt_String ] :=
    With[ { properties = FileFormatDump`FormatProperties @ fmt },
        properties /; MatchQ[ properties[ "Name" ], Except[ "", _String ] ]
    ];

registerFormat[ fmt_String ] :=
    Module[ { sourceDirectory, targetDirectory, metaFile },
        sourceDirectory = FileNameJoin @ { $thisPacletLocation, "ImportExport", fmt };
        targetDirectory = FileNameJoin @ { $UserBaseDirectory, "SystemFiles", "Formats", fmt };
        metaFile        = FileNameJoin @ { targetDirectory, "MetaInformation.wxf" };
        registerFormat[ fmt, sourceDirectory, targetDirectory, metaFile ]
    ];

registerFormat[ fmt_String, sourceDirectory_, targetDirectory_, metaFile_? currentFormatMetaQ ] :=
    getFormatFiles[ fmt, targetDirectory ];

registerFormat[ fmt_, sourceDirectory_, targetDirectory_, metaFile_ ] := Enclose[
    Module[ { targetFile, copyFile, sourceFiles, copied, version, metadata },
        ConfirmBy[ GeneralUtilities`EnsureDirectory @ targetDirectory, DirectoryQ ];
        targetFile  = FileNameJoin @ { targetDirectory, FileNameTake @ # } &;
        copyFile    = ConfirmBy[ CopyFile[ #, targetFile @ #, OverwriteTarget -> True ], FileExistsQ ] &;
        sourceFiles = ConfirmMatch[ formatFiles @ sourceDirectory, { __? FileExistsQ } ];
        copied      = copyFile /@ sourceFiles;
        version     = ConfirmBy[ $thisPacletInfo[ "Version" ], StringQ ];
        metadata    = <| "Version" -> version, "Format" -> fmt |>;
        ConfirmBy[ Developer`WriteWXFFile[ metaFile, metadata ], FileExistsQ ];
        ConfirmMatch[ getFormatFiles[ fmt, targetDirectory ], KeyValuePattern[ "Name" -> fmt ] ]
    ],
    throwInternalFailure @ HoldForm @ registerFormat[ fmt, sourceDirectory, targetDirectory, metaFile ] &
];

registerFormat // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*getFormatFiles*)
getFormatFiles // beginDefinition;
getFormatFiles[ fmt_, directory_ ] := (Get /@ formatFiles @ directory; FileFormatDump`FormatProperties @ fmt);
getFormatFiles // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*formatFiles*)
formatFiles // beginDefinition;

formatFiles[ directory_? DirectoryQ ] :=
    With[ { files = FileNames[ $formatFileNames, directory ] },
        files /; Length @ files === Length @ $formatFileNames
    ];

formatFiles // endDefinition;

$formatFileNames = { "Converter.m", "Properties.m", "Export.m", "Import.m" };

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*currentFormatMetaQ*)
currentFormatMetaQ // beginDefinition;
currentFormatMetaQ[ file_? FileExistsQ ] := currentFormatMetaQ[ file, Developer`ReadWXFFile @ file ];
currentFormatMetaQ[ file_ ] := False;
currentFormatMetaQ[ file_, KeyValuePattern[ "Version" -> version_String ] ] := version === $thisPacletInfo[ "Version" ];
currentFormatMetaQ[ file_, _ ] := False;
currentFormatMetaQ // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
