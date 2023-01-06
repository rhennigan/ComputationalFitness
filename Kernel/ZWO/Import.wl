(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`ZWO`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* Reference: https://github.com/h4l/zwift-workout-file-reference/blob/master/zwift_workout_file_tag_reference.md *)

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Config*)

$zwoStringTypes = {
    "activitySaveName",
    "author",
    "author_alias",
    "authorIcon",
    "category",
    "description",
    "durationType",
    "name",
    "nameImperial",
    "nameMetric",
    "subcategory"
};

$zwoIntegerTypes = {
    "categoryIndex",
    "entid",
    "ftpFemaleOverride",
    "ftpMaleOverride",
    "ftpOverride",
    "overrideHash",
    "painIndex",
    "ShowCP20",
    "visibleAfterTime",
    "workoutLength",
    "WorkoutPlan"
};

$zwoRealTypes = {
    "setFtpAtPercentage"
};

$zwoBooleanTypes = {
    "Skippable",
    "Tutorial",
    "visibleOutsidePlan"
};

(* ::**************************************************************************************************************:: *)
(* ::Section:: *)
(*Messages*)
ZWOImport::Internal =
"An unexpected error occurred. `1`";

ZWOImport::InvalidXML =
"Cannot import data as ZWO format.";

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Options*)
ZWOImport // Options = { UnitSystem :> $UnitSystem };

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Main Definition*)
ZWOImport[ file_, opts: OptionsPattern[ ] ] := zwoOptionsBlock[ zwoImport @ file, opts ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoOptionsBlock*)
zwoOptionsBlock // beginDefinition;

zwoOptionsBlock[ eval_, opts: OptionsPattern[ ZWOImport ] ] :=
    catchTopAs[ ZWOImport ] @ Block[
        {
            $UnitSystem     = OptionValue @ UnitSystem,
            zwoOptionsBlock = # &
        },
        eval
    ];

zwoOptionsBlock // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoImport*)
zwoImport // beginDefinition;
zwoImport[ file_ ] := zwoImport[ file, importXML @ file ];
zwoImport[ file_, xml: XMLObject[ _ ][ ___ ] ] := zwoPostProcess @ zwoParse @ xml;
zwoImport // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoPostProcess*)
zwoPostProcess // beginDefinition;
zwoPostProcess[ data_ ] := data; (* TODO *)
zwoPostProcess // endDefinition;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*zwoParse*)
zwoParse // ClearAll;

zwoParse[ xml: XMLObject[ ___ ][ ___ ] ] := FirstCase[
    xml,
    XMLElement[ "workout_file", _, data_ ] :> zwoWorkoutFile @ data,
    Missing[ "NotAvailable" ],
    Infinity
];

zwoParse[ ___ ] := Missing[ "NotAvailable" ];

$zwoWorkoutFileStringTypes = {
    "activitySaveName",
    "author",
    "author_alias",
    "authorIcon",
    "category",
    "description",
    "durationType",
    "name",
    "nameImperial",
    "nameMetric",
    "subcategory"
};

$zwoWorkoutFileIntegerTypes = {
    "categoryIndex",
    "entid",
    "ftpFemaleOverride",
    "ftpMaleOverride",
    "ftpOverride",
    "overrideHash",
    "painIndex",
    "ShowCP20",
    "visibleAfterTime",
    "workoutLength",
    "WorkoutPlan"
};

$zwoWorkoutFileRealTypes = {
    "setFtpAtPercentage"
};

$zwoWorkoutFileBooleanTypes = {
    "Skippable",
    "Tutorial",
    "visibleOutsidePlan"
};

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*zwoWorkoutFile*)
zwoWorkoutFile[ elements_List ] := Flatten[ zwoWorkoutFile /@ elements ];

zwoWorkoutFile[ XMLElement[ "sportType", _, data_ ] ] := "Sport" -> zwoSport @ data;
zwoWorkoutFile[ XMLElement[ "tags", _, data_ ] ] := "Tags" -> zwoTags @ data;
zwoWorkoutFile[ XMLElement[ "workout", _, data_ ] ] := "Workout" -> zwoWorkout @ data;

zwoWorkoutFile[ XMLElement[ key_, _, data_ ] ] /; MemberQ[ $zwoWorkoutFileStringTypes , key ] := zwoString @ data;
zwoWorkoutFile[ XMLElement[ key_, _, data_ ] ] /; MemberQ[ $zwoWorkoutFileIntegerTypes, key ] := zwoInteger @ data;
zwoWorkoutFile[ XMLElement[ key_, _, data_ ] ] /; MemberQ[ $zwoWorkoutFileRealTypes   , key ] := zwoReal @ data;
zwoWorkoutFile[ XMLElement[ key_, _, data_ ] ] /; MemberQ[ $zwoWorkoutFileBooleanTypes, key ] := zwoBoolean @ data;

zwoWorkoutFile[ XMLElement[ key_String, _, { string_String } ] ] := key -> string;
zwoWorkoutFile[ XMLElement[ key_String, _, data_ ] ] := key -> data;

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*zwoString*)
zwoString // ClearAll;
zwoString[ { author_String } ] := author;
zwoString[   author_String   ] := author;
zwoString[   ___             ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*zwoSport*)
zwoSport // ClearAll;
zwoSport[ "Bike"|"bike"|"Ride"|"ride" ] := "Cycling";
zwoSport[ "Run"|"run" ] := "Running";
zwoSport[ sport_String ] := Capitalize @ sport;
zwoSport[ other_ ] := With[ { str = zwoString @ other }, zwoSport @ str /; StringQ @ str ];
zwoSport[ ___ ] := Missing[ "NotAvailable" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*zwoTags*)
zwoTags // ClearAll;

zwoTags[ elements_List ] :=
    Replace[
        Select[ Flatten[ zwoTag /@ elements ], StringQ ],
        Except[ { __String } ] -> Missing[ "NotAvailable" ]
    ];

zwoTags[ ___ ] := Missing[ "NotAvailable" ];

zwoTag // ClearAll;
zwoTag[ XMLElement[ "tag", { ___, "name" -> tag_String, ___ }, { } ] ] := tag;
zwoTag[ XMLElement[ "tag", _, data_ ] ] := zwoString @ data;
zwoTag[ other_ ] := zwoString @ other;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
