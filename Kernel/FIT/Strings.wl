(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "RH`ComputationalFitness`FIT`" ];
Needs[ "RH`ComputationalFitness`" ];
Needs[ "RH`ComputationalFitness`Package`" ];
Begin[ "`Private`" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*FIT Enumerations*)

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Utilities*)

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*removePrefix*)
removePrefix[ a_, p_ ] :=
    AssociationThread[ Keys @ a -> StringDelete[ Values @ a, p ] ];

(* ::**********************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Enumeration Values*)

(* Auto generated from defines in fit_example.h *)

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitMessageNUM*)
fitMessageNUM // ClearAll;
fitMessageNUM[ n_Integer ] := Lookup[ $fitMessageNUM, n, Missing[ "NotAvailable" ] ];
fitMessageNUM[ ___ ] := Missing[ "NotAvailable" ];

$fitMessageNUM0 = <|
    0   -> "FIT_MESG_NUM_FILE_ID",
    1   -> "FIT_MESG_NUM_CAPABILITIES",
    2   -> "FIT_MESG_NUM_DEVICE_SETTINGS",
    3   -> "FIT_MESG_NUM_USER_PROFILE",
    4   -> "FIT_MESG_NUM_HRM_PROFILE",
    5   -> "FIT_MESG_NUM_SDM_PROFILE",
    6   -> "FIT_MESG_NUM_BIKE_PROFILE",
    7   -> "FIT_MESG_NUM_ZONES_TARGET",
    8   -> "FIT_MESG_NUM_HR_ZONE",
    9   -> "FIT_MESG_NUM_POWER_ZONE",
    10  -> "FIT_MESG_NUM_MET_ZONE",
    12  -> "FIT_MESG_NUM_SPORT",
    15  -> "FIT_MESG_NUM_GOAL",
    18  -> "FIT_MESG_NUM_SESSION",
    19  -> "FIT_MESG_NUM_LAP",
    20  -> "FIT_MESG_NUM_RECORD",
    21  -> "FIT_MESG_NUM_EVENT",
    23  -> "FIT_MESG_NUM_DEVICE_INFO",
    26  -> "FIT_MESG_NUM_WORKOUT",
    27  -> "FIT_MESG_NUM_WORKOUT_STEP",
    28  -> "FIT_MESG_NUM_SCHEDULE",
    30  -> "FIT_MESG_NUM_WEIGHT_SCALE",
    31  -> "FIT_MESG_NUM_COURSE",
    32  -> "FIT_MESG_NUM_COURSE_POINT",
    33  -> "FIT_MESG_NUM_TOTALS",
    34  -> "FIT_MESG_NUM_ACTIVITY",
    35  -> "FIT_MESG_NUM_SOFTWARE",
    37  -> "FIT_MESG_NUM_FILE_CAPABILITIES",
    38  -> "FIT_MESG_NUM_MESG_CAPABILITIES",
    39  -> "FIT_MESG_NUM_FIELD_CAPABILITIES",
    49  -> "FIT_MESG_NUM_FILE_CREATOR",
    51  -> "FIT_MESG_NUM_BLOOD_PRESSURE",
    53  -> "FIT_MESG_NUM_SPEED_ZONE",
    55  -> "FIT_MESG_NUM_MONITORING",
    72  -> "FIT_MESG_NUM_TRAINING_FILE",
    78  -> "FIT_MESG_NUM_HRV",
    80  -> "FIT_MESG_NUM_ANT_RX",
    81  -> "FIT_MESG_NUM_ANT_TX",
    82  -> "FIT_MESG_NUM_ANT_CHANNEL_ID",
    101 -> "FIT_MESG_NUM_LENGTH",
    103 -> "FIT_MESG_NUM_MONITORING_INFO",
    105 -> "FIT_MESG_NUM_PAD",
    106 -> "FIT_MESG_NUM_SLAVE_DEVICE",
    127 -> "FIT_MESG_NUM_CONNECTIVITY",
    128 -> "FIT_MESG_NUM_WEATHER_CONDITIONS",
    129 -> "FIT_MESG_NUM_WEATHER_ALERT",
    131 -> "FIT_MESG_NUM_CADENCE_ZONE",
    132 -> "FIT_MESG_NUM_HR",
    142 -> "FIT_MESG_NUM_SEGMENT_LAP",
    145 -> "FIT_MESG_NUM_MEMO_GLOB",
    148 -> "FIT_MESG_NUM_SEGMENT_ID",
    149 -> "FIT_MESG_NUM_SEGMENT_LEADERBOARD_ENTRY",
    150 -> "FIT_MESG_NUM_SEGMENT_POINT",
    151 -> "FIT_MESG_NUM_SEGMENT_FILE",
    158 -> "FIT_MESG_NUM_WORKOUT_SESSION",
    159 -> "FIT_MESG_NUM_WATCHFACE_SETTINGS",
    160 -> "FIT_MESG_NUM_GPS_METADATA",
    161 -> "FIT_MESG_NUM_CAMERA_EVENT",
    162 -> "FIT_MESG_NUM_TIMESTAMP_CORRELATION",
    164 -> "FIT_MESG_NUM_GYROSCOPE_DATA",
    165 -> "FIT_MESG_NUM_ACCELEROMETER_DATA",
    167 -> "FIT_MESG_NUM_THREE_D_SENSOR_CALIBRATION",
    169 -> "FIT_MESG_NUM_VIDEO_FRAME",
    174 -> "FIT_MESG_NUM_OBDII_DATA",
    177 -> "FIT_MESG_NUM_NMEA_SENTENCE",
    178 -> "FIT_MESG_NUM_AVIATION_ATTITUDE",
    184 -> "FIT_MESG_NUM_VIDEO",
    185 -> "FIT_MESG_NUM_VIDEO_TITLE",
    186 -> "FIT_MESG_NUM_VIDEO_DESCRIPTION",
    187 -> "FIT_MESG_NUM_VIDEO_CLIP",
    188 -> "FIT_MESG_NUM_OHR_SETTINGS",
    200 -> "FIT_MESG_NUM_EXD_SCREEN_CONFIGURATION",
    201 -> "FIT_MESG_NUM_EXD_DATA_FIELD_CONFIGURATION",
    202 -> "FIT_MESG_NUM_EXD_DATA_CONCEPT_CONFIGURATION",
    206 -> "FIT_MESG_NUM_FIELD_DESCRIPTION",
    207 -> "FIT_MESG_NUM_DEVELOPER_DATA_ID",
    208 -> "FIT_MESG_NUM_MAGNETOMETER_DATA",
    209 -> "FIT_MESG_NUM_BAROMETER_DATA",
    210 -> "FIT_MESG_NUM_ONE_D_SENSOR_CALIBRATION",
    225 -> "FIT_MESG_NUM_SET",
    227 -> "FIT_MESG_NUM_STRESS_LEVEL",
    258 -> "FIT_MESG_NUM_DIVE_SETTINGS",
    259 -> "FIT_MESG_NUM_DIVE_GAS",
    262 -> "FIT_MESG_NUM_DIVE_ALARM",
    264 -> "FIT_MESG_NUM_EXERCISE_TITLE",
    268 -> "FIT_MESG_NUM_DIVE_SUMMARY",
    285 -> "FIT_MESG_NUM_JUMP",
    317 -> "FIT_MESG_NUM_CLIMB_PRO",
    375 -> "FIT_MESG_NUM_DEVICE_AUX_BATTERY_INFO"
|>;

$fitMessageNUM = toNiceCamelCase /@ removePrefix[ $fitMessageNUM0, "FIT_MESG_NUM_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGender*)
fitGender // ClearAll;
fitGender[ n_Integer ] := Lookup[ $fitGender, n, Missing[ "NotAvailable" ] ];
fitGender[ ___ ] := Missing[ "NotAvailable" ];

$fitGender0 = <|
    0 -> "FIT_GENDER_FEMALE",
    1 -> "FIT_GENDER_MALE"
|>;

$fitGender = toNiceCamelCase /@ removePrefix[ $fitGender0, "FIT_GENDER_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSessionTrigger*)
fitSessionTrigger // ClearAll;
fitSessionTrigger[ n_Integer ] := Lookup[ $fitSessionTrigger, n, Missing[ "NotAvailable" ] ];
fitSessionTrigger[ ___ ] := Missing[ "NotAvailable" ];

$fitSessionTrigger0 = <|
    0 -> "FIT_SESSION_TRIGGER_ACTIVITY_END",
    1 -> "FIT_SESSION_TRIGGER_MANUAL",
    2 -> "FIT_SESSION_TRIGGER_AUTO_MULTI_SPORT",
    3 -> "FIT_SESSION_TRIGGER_FITNESS_EQUIPMENT"
|>;

$fitSessionTrigger = toNiceCamelCase /@ removePrefix[ $fitSessionTrigger0, "FIT_SESSION_TRIGGER_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSwimStroke*)
fitSwimStroke // ClearAll;
fitSwimStroke[ n_Integer ] := Lookup[ $fitSwimStroke, n, Missing[ "NotAvailable" ] ];
fitSwimStroke[ ___ ] := Missing[ "NotAvailable" ];

$fitSwimStroke0 = <|
    0 -> "FIT_SWIM_STROKE_FREESTYLE",
    1 -> "FIT_SWIM_STROKE_BACKSTROKE",
    2 -> "FIT_SWIM_STROKE_BREASTSTROKE",
    3 -> "FIT_SWIM_STROKE_BUTTERFLY",
    4 -> "FIT_SWIM_STROKE_DRILL",
    5 -> "FIT_SWIM_STROKE_MIXED",
    6 -> "FIT_SWIM_STROKE_IM"
|>;

$fitSwimStroke = toNiceCamelCase /@ removePrefix[ $fitSwimStroke0, "FIT_SWIM_STROKE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDisplayMeasure*)
fitDisplayMeasure // ClearAll;
fitDisplayMeasure[ n_Integer ] := Lookup[ $fitDisplayMeasure, n, Missing[ "NotAvailable" ] ];
fitDisplayMeasure[ ___ ] := Missing[ "NotAvailable" ];

$fitDisplayMeasure0 = <|
    0 -> "FIT_DISPLAY_MEASURE_METRIC",
    1 -> "FIT_DISPLAY_MEASURE_STATUTE",
    2 -> "FIT_DISPLAY_MEASURE_NAUTICAL"
|>;

$fitDisplayMeasure = toNiceCamelCase /@ removePrefix[ $fitDisplayMeasure0, "FIT_DISPLAY_MEASURE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDisplayHeart*)
fitDisplayHeart // ClearAll;
fitDisplayHeart[ n_Integer ] := Lookup[ $fitDisplayHeart, n, Missing[ "NotAvailable" ] ];
fitDisplayHeart[ ___ ] := Missing[ "NotAvailable" ];

$fitDisplayHeart0 = <|
    0 -> "FIT_DISPLAY_HEART_BPM",
    1 -> "FIT_DISPLAY_HEART_MAX",
    2 -> "FIT_DISPLAY_HEART_RESERVE"
|>;

$fitDisplayHeart = toNiceCamelCase /@ removePrefix[ $fitDisplayHeart0, "FIT_DISPLAY_HEART_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDisplayPower*)
fitDisplayPower // ClearAll;
fitDisplayPower[ n_Integer ] := Lookup[ $fitDisplayPower, n, Missing[ "NotAvailable" ] ];
fitDisplayPower[ ___ ] := Missing[ "NotAvailable" ];

$fitDisplayPower0 = <|
    0 -> "FIT_DISPLAY_POWER_WATTS",
    1 -> "FIT_DISPLAY_POWER_PERCENT_FTP"
|>;

$fitDisplayPower = toNiceCamelCase /@ removePrefix[ $fitDisplayPower0, "FIT_DISPLAY_POWER_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitActivityClass*)
fitActivityClass // ClearAll;
fitActivityClass[ n_Integer ] := Lookup[ $fitActivityClass, n, Missing[ "NotAvailable" ] ];
fitActivityClass[ ___ ] := Missing[ "NotAvailable" ];

$fitActivityClass0 = <|
    100 -> "FIT_ACTIVITY_CLASS_LEVEL_MAX",
    128 -> "FIT_ACTIVITY_CLASS_ATHLETE"
|>;

$fitActivityClass = toNiceCamelCase /@ removePrefix[ $fitActivityClass0, "FIT_ACTIVITY_CLASS_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDisplayPosition*)
fitDisplayPosition // ClearAll;
fitDisplayPosition[ n_Integer ] := Lookup[ $fitDisplayPosition, n, Missing[ "NotAvailable" ] ];
fitDisplayPosition[ ___ ] := Missing[ "NotAvailable" ];

$fitDisplayPosition0 = <|
    0  -> "FIT_DISPLAY_POSITION_DEGREE",
    1  -> "FIT_DISPLAY_POSITION_DEGREE_MINUTE",
    2  -> "FIT_DISPLAY_POSITION_DEGREE_MINUTE_SECOND",
    3  -> "FIT_DISPLAY_POSITION_AUSTRIAN_GRID",
    4  -> "FIT_DISPLAY_POSITION_BRITISH_GRID",
    5  -> "FIT_DISPLAY_POSITION_DUTCH_GRID",
    6  -> "FIT_DISPLAY_POSITION_HUNGARIAN_GRID",
    7  -> "FIT_DISPLAY_POSITION_FINNISH_GRID",
    8  -> "FIT_DISPLAY_POSITION_GERMAN_GRID",
    9  -> "FIT_DISPLAY_POSITION_ICELANDIC_GRID",
    10 -> "FIT_DISPLAY_POSITION_INDONESIAN_EQUATORIAL",
    11 -> "FIT_DISPLAY_POSITION_INDONESIAN_IRIAN",
    12 -> "FIT_DISPLAY_POSITION_INDONESIAN_SOUTHERN",
    13 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_0",
    14 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IA",
    15 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IB",
    16 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IIA",
    17 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IIB",
    18 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IIIA",
    19 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IIIB",
    20 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IVA",
    21 -> "FIT_DISPLAY_POSITION_INDIA_ZONE_IVB",
    22 -> "FIT_DISPLAY_POSITION_IRISH_TRANSVERSE",
    23 -> "FIT_DISPLAY_POSITION_IRISH_GRID",
    24 -> "FIT_DISPLAY_POSITION_LORAN",
    25 -> "FIT_DISPLAY_POSITION_MAIDENHEAD_GRID",
    26 -> "FIT_DISPLAY_POSITION_MGRS_GRID",
    27 -> "FIT_DISPLAY_POSITION_NEW_ZEALAND_GRID",
    28 -> "FIT_DISPLAY_POSITION_NEW_ZEALAND_TRANSVERSE",
    29 -> "FIT_DISPLAY_POSITION_QATAR_GRID",
    30 -> "FIT_DISPLAY_POSITION_MODIFIED_SWEDISH_GRID",
    31 -> "FIT_DISPLAY_POSITION_SWEDISH_GRID",
    32 -> "FIT_DISPLAY_POSITION_SOUTH_AFRICAN_GRID",
    33 -> "FIT_DISPLAY_POSITION_SWISS_GRID",
    34 -> "FIT_DISPLAY_POSITION_TAIWAN_GRID",
    35 -> "FIT_DISPLAY_POSITION_UNITED_STATES_GRID",
    36 -> "FIT_DISPLAY_POSITION_UTM_UPS_GRID",
    37 -> "FIT_DISPLAY_POSITION_WEST_MALAYAN",
    38 -> "FIT_DISPLAY_POSITION_BORNEO_RSO",
    39 -> "FIT_DISPLAY_POSITION_ESTONIAN_GRID",
    40 -> "FIT_DISPLAY_POSITION_LATVIAN_GRID",
    41 -> "FIT_DISPLAY_POSITION_SWEDISH_REF_99_GRID"
|>;

$fitDisplayPosition = toNiceCamelCase /@ removePrefix[ $fitDisplayPosition0, "FIT_DISPLAY_POSITION_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitActivity*)
fitActivity // ClearAll;
fitActivity[ n_Integer ] := Lookup[ $fitActivity, n, Missing[ "NotAvailable" ] ];
fitActivity[ ___ ] := Missing[ "NotAvailable" ];

$fitActivity0 = <|
    0 -> "FIT_ACTIVITY_MANUAL",
    1 -> "FIT_ACTIVITY_AUTO_MULTI_SPORT"
|>;

$fitActivity = toNiceCamelCase /@ removePrefix[ $fitActivity0, "FIT_ACTIVITY_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitEvent*)
fitEvent // ClearAll;
fitEvent[ n_Integer ] := Lookup[ $fitEvent, n, Missing[ "NotAvailable" ] ];
fitEvent[ ___ ] := Missing[ "NotAvailable" ];

$fitEvent0 = <|
    0  -> "FIT_EVENT_TIMER",
    3  -> "FIT_EVENT_WORKOUT",
    4  -> "FIT_EVENT_WORKOUT_STEP",
    5  -> "FIT_EVENT_POWER_DOWN",
    6  -> "FIT_EVENT_POWER_UP",
    7  -> "FIT_EVENT_OFF_COURSE",
    8  -> "FIT_EVENT_SESSION",
    9  -> "FIT_EVENT_LAP",
    10 -> "FIT_EVENT_COURSE_POINT",
    11 -> "FIT_EVENT_BATTERY",
    12 -> "FIT_EVENT_VIRTUAL_PARTNER_PACE",
    13 -> "FIT_EVENT_HR_HIGH_ALERT",
    14 -> "FIT_EVENT_HR_LOW_ALERT",
    15 -> "FIT_EVENT_SPEED_HIGH_ALERT",
    16 -> "FIT_EVENT_SPEED_LOW_ALERT",
    17 -> "FIT_EVENT_CAD_HIGH_ALERT",
    18 -> "FIT_EVENT_CAD_LOW_ALERT",
    19 -> "FIT_EVENT_POWER_HIGH_ALERT",
    20 -> "FIT_EVENT_POWER_LOW_ALERT",
    21 -> "FIT_EVENT_RECOVERY_HR",
    22 -> "FIT_EVENT_BATTERY_LOW",
    23 -> "FIT_EVENT_TIME_DURATION_ALERT",
    24 -> "FIT_EVENT_DISTANCE_DURATION_ALERT",
    25 -> "FIT_EVENT_CALORIE_DURATION_ALERT",
    26 -> "FIT_EVENT_ACTIVITY",
    27 -> "FIT_EVENT_FITNESS_EQUIPMENT",
    28 -> "FIT_EVENT_LENGTH",
    32 -> "FIT_EVENT_USER_MARKER",
    33 -> "FIT_EVENT_SPORT_POINT",
    36 -> "FIT_EVENT_CALIBRATION",
    42 -> "FIT_EVENT_FRONT_GEAR_CHANGE",
    43 -> "FIT_EVENT_REAR_GEAR_CHANGE",
    44 -> "FIT_EVENT_RIDER_POSITION_CHANGE",
    45 -> "FIT_EVENT_ELEV_HIGH_ALERT",
    46 -> "FIT_EVENT_ELEV_LOW_ALERT",
    47 -> "FIT_EVENT_COMM_TIMEOUT",
    75 -> "FIT_EVENT_RADAR_THREAT_ALERT"
|>;

$fitEvent = toNiceCamelCase /@ removePrefix[ $fitEvent0, "FIT_EVENT_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitEventType*)
fitEventType // ClearAll;
fitEventType[ n_Integer ] := Lookup[ $fitEventType, n, Missing[ "NotAvailable" ] ];
fitEventType[ ___ ] := Missing[ "NotAvailable" ];

$fitEventType0 = <|
    0 -> "FIT_EVENT_TYPE_START",
    1 -> "FIT_EVENT_TYPE_STOP",
    2 -> "FIT_EVENT_TYPE_CONSECUTIVE_DEPRECIATED",
    3 -> "FIT_EVENT_TYPE_MARKER",
    4 -> "FIT_EVENT_TYPE_STOP_ALL",
    5 -> "FIT_EVENT_TYPE_BEGIN_DEPRECIATED",
    6 -> "FIT_EVENT_TYPE_END_DEPRECIATED",
    7 -> "FIT_EVENT_TYPE_END_ALL_DEPRECIATED",
    8 -> "FIT_EVENT_TYPE_STOP_DISABLE",
    9 -> "FIT_EVENT_TYPE_STOP_DISABLE_ALL"
|>;

$fitEventType = toNiceCamelCase /@ removePrefix[ $fitEventType0, "FIT_EVENT_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitIntensity*)
fitIntensity // ClearAll;
fitIntensity[ n_Integer ] := Lookup[ $fitIntensity, n, Missing[ "NotAvailable" ] ];
fitIntensity[ ___ ] := Missing[ "NotAvailable" ];

$fitIntensity0 = <|
    0 -> "FIT_INTENSITY_ACTIVE",
    1 -> "FIT_INTENSITY_REST",
    2 -> "FIT_INTENSITY_WARMUP",
    3 -> "FIT_INTENSITY_COOLDOWN",
    4 -> "FIT_INTENSITY_RECOVERY",
    5 -> "FIT_INTENSITY_INTERVAL",
    6 -> "FIT_INTENSITY_OTHER"
|>;

$fitIntensity = toNiceCamelCase /@ removePrefix[ $fitIntensity0, "FIT_INTENSITY_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitLapTrigger*)
fitLapTrigger // ClearAll;
fitLapTrigger[ n_Integer ] := Lookup[ $fitLapTrigger, n, Missing[ "NotAvailable" ] ];
fitLapTrigger[ ___ ] := Missing[ "NotAvailable" ];

$fitLapTrigger0 = <|
    0 -> "FIT_LAP_TRIGGER_MANUAL",
    1 -> "FIT_LAP_TRIGGER_TIME",
    2 -> "FIT_LAP_TRIGGER_DISTANCE",
    3 -> "FIT_LAP_TRIGGER_POSITION_START",
    4 -> "FIT_LAP_TRIGGER_POSITION_LAP",
    5 -> "FIT_LAP_TRIGGER_POSITION_WAYPOINT",
    6 -> "FIT_LAP_TRIGGER_POSITION_MARKED",
    7 -> "FIT_LAP_TRIGGER_SESSION_END",
    8 -> "FIT_LAP_TRIGGER_FITNESS_EQUIPMENT"
|>;

$fitLapTrigger = toNiceCamelCase /@ removePrefix[ $fitLapTrigger0, "FIT_LAP_TRIGGER_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBacklightMode*)
fitBacklightMode // ClearAll;
fitBacklightMode[ n_Integer ] := Lookup[ $fitBacklightMode, n, Missing[ "NotAvailable" ] ];
fitBacklightMode[ ___ ] := Missing[ "NotAvailable" ];

$fitBacklightMode0 = <|
    0 -> "FIT_BACKLIGHT_MODE_OFF",
    1 -> "FIT_BACKLIGHT_MODE_MANUAL",
    2 -> "FIT_BACKLIGHT_MODE_KEY_AND_MESSAGES",
    3 -> "FIT_BACKLIGHT_MODE_AUTO_BRIGHTNESS",
    4 -> "FIT_BACKLIGHT_MODE_SMART_NOTIFICATIONS",
    5 -> "FIT_BACKLIGHT_MODE_KEY_AND_MESSAGES_NIGHT",
    6 -> "FIT_BACKLIGHT_MODE_KEY_AND_MESSAGES_AND_SMART_NOTIFICATIONS"
|>;

$fitBacklightMode = toNiceCamelCase /@ removePrefix[ $fitBacklightMode0, "FIT_BACKLIGHT_MODE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDateMode*)
fitDateMode // ClearAll;
fitDateMode[ n_Integer ] := Lookup[ $fitDateMode, n, Missing[ "NotAvailable" ] ];
fitDateMode[ ___ ] := Missing[ "NotAvailable" ];

$fitDateMode0 = <|
    0 -> "FIT_DATE_MODE_DAY_MONTH",
    1 -> "FIT_DATE_MODE_MONTH_DAY"
|>;

$fitDateMode = toNiceCamelCase /@ removePrefix[ $fitDateMode0, "FIT_DATE_MODE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDisplayOrientation*)
fitDisplayOrientation // ClearAll;
fitDisplayOrientation[ n_Integer ] := Lookup[ $fitDisplayOrientation, n, Missing[ "NotAvailable" ] ];
fitDisplayOrientation[ ___ ] := Missing[ "NotAvailable" ];

$fitDisplayOrientation0 = <|
    0 -> "FIT_DISPLAY_ORIENTATION_AUTO",
    1 -> "FIT_DISPLAY_ORIENTATION_PORTRAIT",
    2 -> "FIT_DISPLAY_ORIENTATION_LANDSCAPE",
    3 -> "FIT_DISPLAY_ORIENTATION_PORTRAIT_FLIPPED",
    4 -> "FIT_DISPLAY_ORIENTATION_LANDSCAPE_FLIPPED"
|>;

$fitDisplayOrientation = toNiceCamelCase /@ removePrefix[ $fitDisplayOrientation0, "FIT_DISPLAY_ORIENTATION_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSide*)
fitSide // ClearAll;
fitSide[ n_Integer ] := Lookup[ $fitSide, n, Missing[ "NotAvailable" ] ];
fitSide[ ___ ] := Missing[ "NotAvailable" ];

$fitSide0 = <|
    0 -> "FIT_SIDE_RIGHT",
    1 -> "FIT_SIDE_LEFT"
|>;

$fitSide = toNiceCamelCase /@ removePrefix[ $fitSide0, "FIT_SIDE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTapSensitivity*)
fitTapSensitivity // ClearAll;
fitTapSensitivity[ n_Integer ] := Lookup[ $fitTapSensitivity, n, Missing[ "NotAvailable" ] ];
fitTapSensitivity[ ___ ] := Missing[ "NotAvailable" ];

$fitTapSensitivity0 = <|
    0 -> "FIT_TAP_SENSITIVITY_HIGH",
    1 -> "FIT_TAP_SENSITIVITY_MEDIUM",
    2 -> "FIT_TAP_SENSITIVITY_LOW"
|>;

$fitTapSensitivity = toNiceCamelCase /@ removePrefix[ $fitTapSensitivity0, "FIT_TAP_SENSITIVITY_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitTimeMode*)
fitTimeMode // ClearAll;
fitTimeMode[ n_Integer ] := Lookup[ $fitTimeMode, n, Missing[ "NotAvailable" ] ];
fitTimeMode[ ___ ] := Missing[ "NotAvailable" ];

$fitTimeMode0 = <|
    0 -> "FIT_TIME_MODE_HOUR12",
    1 -> "FIT_TIME_MODE_HOUR24",
    2 -> "FIT_TIME_MODE_MILITARY",
    3 -> "FIT_TIME_MODE_HOUR_12_WITH_SECONDS",
    4 -> "FIT_TIME_MODE_HOUR_24_WITH_SECONDS",
    5 -> "FIT_TIME_MODE_UTC"
|>;

$fitTimeMode = toNiceCamelCase /@ removePrefix[ $fitTimeMode0, "FIT_TIME_MODE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitActivityType*)
fitActivityType // ClearAll;
fitActivityType[ n_Integer ] := Lookup[ $fitActivityType, n, Missing[ "NotAvailable" ] ];
fitActivityType[ ___ ] := Missing[ "NotAvailable" ];

$fitActivityType0 = <|
    0   -> "FIT_ACTIVITY_TYPE_GENERIC",
    1   -> "FIT_ACTIVITY_TYPE_RUNNING",
    2   -> "FIT_ACTIVITY_TYPE_CYCLING",
    3   -> "FIT_ACTIVITY_TYPE_TRANSITION",
    4   -> "FIT_ACTIVITY_TYPE_FITNESS_EQUIPMENT",
    5   -> "FIT_ACTIVITY_TYPE_SWIMMING",
    6   -> "FIT_ACTIVITY_TYPE_WALKING",
    8   -> "FIT_ACTIVITY_TYPE_SEDENTARY",
    254 -> "FIT_ACTIVITY_TYPE_ALL"
|>;

$fitActivityType = toNiceCamelCase /@ removePrefix[ $fitActivityType0, "FIT_ACTIVITY_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitStrokeType*)
fitStrokeType // ClearAll;
fitStrokeType[ n_Integer ] := Lookup[ $fitStrokeType, n, Missing[ "NotAvailable" ] ];
fitStrokeType[ ___ ] := Missing[ "NotAvailable" ];

$fitStrokeType0 = <|
    0 -> "FIT_STROKE_TYPE_NO_EVENT",
    1 -> "FIT_STROKE_TYPE_OTHER",
    2 -> "FIT_STROKE_TYPE_SERVE",
    3 -> "FIT_STROKE_TYPE_FOREHAND",
    4 -> "FIT_STROKE_TYPE_BACKHAND",
    5 -> "FIT_STROKE_TYPE_SMASH"
|>;

$fitStrokeType = toNiceCamelCase /@ removePrefix[ $fitStrokeType0, "FIT_STROKE_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitDeviceIndex*)
fitDeviceIndex // ClearAll;
fitDeviceIndex[ n_Integer ] := Lookup[ $fitDeviceIndex, n, Missing[ "NotAvailable" ] ];
fitDeviceIndex[ ___ ] := Missing[ "NotAvailable" ];

$fitDeviceIndex0 = <|
    0 -> "FIT_DEVICE_INDEX_CREATOR"
|>;

$fitDeviceIndex = toNiceCamelCase /@ removePrefix[ $fitDeviceIndex0, "FIT_DEVICE_INDEX_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitManufacturer*)
fitManufacturer // ClearAll;
fitManufacturer[ n_Integer ] := Lookup[ $fitManufacturer, n, Missing[ "NotAvailable" ] ];
fitManufacturer[ ___ ] := Missing[ "NotAvailable" ];

$fitManufacturer0 = <|
    1    -> "FIT_MANUFACTURER_GARMIN",
    2    -> "FIT_MANUFACTURER_GARMIN_FR405_ANTFS",
    3    -> "FIT_MANUFACTURER_ZEPHYR",
    4    -> "FIT_MANUFACTURER_DAYTON",
    5    -> "FIT_MANUFACTURER_IDT",
    6    -> "FIT_MANUFACTURER_SRM",
    7    -> "FIT_MANUFACTURER_QUARQ",
    8    -> "FIT_MANUFACTURER_IBIKE",
    9    -> "FIT_MANUFACTURER_SARIS",
    10   -> "FIT_MANUFACTURER_SPARK_HK",
    11   -> "FIT_MANUFACTURER_TANITA",
    12   -> "FIT_MANUFACTURER_ECHOWELL",
    13   -> "FIT_MANUFACTURER_DYNASTREAM_OEM",
    14   -> "FIT_MANUFACTURER_NAUTILUS",
    15   -> "FIT_MANUFACTURER_DYNASTREAM",
    16   -> "FIT_MANUFACTURER_TIMEX",
    17   -> "FIT_MANUFACTURER_METRIGEAR",
    18   -> "FIT_MANUFACTURER_XELIC",
    19   -> "FIT_MANUFACTURER_BEURER",
    20   -> "FIT_MANUFACTURER_CARDIOSPORT",
    21   -> "FIT_MANUFACTURER_A_AND_D",
    22   -> "FIT_MANUFACTURER_HMM",
    23   -> "FIT_MANUFACTURER_SUUNTO",
    24   -> "FIT_MANUFACTURER_THITA_ELEKTRONIK",
    25   -> "FIT_MANUFACTURER_GPULSE",
    26   -> "FIT_MANUFACTURER_CLEAN_MOBILE",
    27   -> "FIT_MANUFACTURER_PEDAL_BRAIN",
    28   -> "FIT_MANUFACTURER_PEAKSWARE",
    29   -> "FIT_MANUFACTURER_SAXONAR",
    30   -> "FIT_MANUFACTURER_LEMOND_FITNESS",
    31   -> "FIT_MANUFACTURER_DEXCOM",
    32   -> "FIT_MANUFACTURER_WAHOO_FITNESS",
    33   -> "FIT_MANUFACTURER_OCTANE_FITNESS",
    34   -> "FIT_MANUFACTURER_ARCHINOETICS",
    35   -> "FIT_MANUFACTURER_THE_HURT_BOX",
    36   -> "FIT_MANUFACTURER_CITIZEN_SYSTEMS",
    37   -> "FIT_MANUFACTURER_MAGELLAN",
    38   -> "FIT_MANUFACTURER_OSYNCE",
    39   -> "FIT_MANUFACTURER_HOLUX",
    40   -> "FIT_MANUFACTURER_CONCEPT2",
    41   -> "FIT_MANUFACTURER_SHIMANO",
    42   -> "FIT_MANUFACTURER_ONE_GIANT_LEAP",
    43   -> "FIT_MANUFACTURER_ACE_SENSOR",
    44   -> "FIT_MANUFACTURER_BRIM_BROTHERS",
    45   -> "FIT_MANUFACTURER_XPLOVA",
    46   -> "FIT_MANUFACTURER_PERCEPTION_DIGITAL",
    47   -> "FIT_MANUFACTURER_BF1SYSTEMS",
    48   -> "FIT_MANUFACTURER_PIONEER",
    49   -> "FIT_MANUFACTURER_SPANTEC",
    50   -> "FIT_MANUFACTURER_METALOGICS",
    51   -> "FIT_MANUFACTURER_4IIIIS",
    52   -> "FIT_MANUFACTURER_SEIKO_EPSON",
    53   -> "FIT_MANUFACTURER_SEIKO_EPSON_OEM",
    54   -> "FIT_MANUFACTURER_IFOR_POWELL",
    55   -> "FIT_MANUFACTURER_MAXWELL_GUIDER",
    56   -> "FIT_MANUFACTURER_STAR_TRAC",
    57   -> "FIT_MANUFACTURER_BREAKAWAY",
    58   -> "FIT_MANUFACTURER_ALATECH_TECHNOLOGY_LTD",
    59   -> "FIT_MANUFACTURER_MIO_TECHNOLOGY_EUROPE",
    60   -> "FIT_MANUFACTURER_ROTOR",
    61   -> "FIT_MANUFACTURER_GEONAUTE",
    62   -> "FIT_MANUFACTURER_ID_BIKE",
    63   -> "FIT_MANUFACTURER_SPECIALIZED",
    64   -> "FIT_MANUFACTURER_WTEK",
    65   -> "FIT_MANUFACTURER_PHYSICAL_ENTERPRISES",
    66   -> "FIT_MANUFACTURER_NORTH_POLE_ENGINEERING",
    67   -> "FIT_MANUFACTURER_BKOOL",
    68   -> "FIT_MANUFACTURER_CATEYE",
    69   -> "FIT_MANUFACTURER_STAGES_CYCLING",
    70   -> "FIT_MANUFACTURER_SIGMASPORT",
    71   -> "FIT_MANUFACTURER_TOMTOM",
    72   -> "FIT_MANUFACTURER_PERIPEDAL",
    73   -> "FIT_MANUFACTURER_WATTBIKE",
    76   -> "FIT_MANUFACTURER_MOXY",
    77   -> "FIT_MANUFACTURER_CICLOSPORT",
    78   -> "FIT_MANUFACTURER_POWERBAHN",
    79   -> "FIT_MANUFACTURER_ACORN_PROJECTS_APS",
    80   -> "FIT_MANUFACTURER_LIFEBEAM",
    81   -> "FIT_MANUFACTURER_BONTRAGER",
    82   -> "FIT_MANUFACTURER_WELLGO",
    83   -> "FIT_MANUFACTURER_SCOSCHE",
    84   -> "FIT_MANUFACTURER_MAGURA",
    85   -> "FIT_MANUFACTURER_WOODWAY",
    86   -> "FIT_MANUFACTURER_ELITE",
    87   -> "FIT_MANUFACTURER_NIELSEN_KELLERMAN",
    88   -> "FIT_MANUFACTURER_DK_CITY",
    89   -> "FIT_MANUFACTURER_TACX",
    90   -> "FIT_MANUFACTURER_DIRECTION_TECHNOLOGY",
    91   -> "FIT_MANUFACTURER_MAGTONIC",
    92   -> "FIT_MANUFACTURER_1PARTCARBON",
    93   -> "FIT_MANUFACTURER_INSIDE_RIDE_TECHNOLOGIES",
    94   -> "FIT_MANUFACTURER_SOUND_OF_MOTION",
    95   -> "FIT_MANUFACTURER_STRYD",
    96   -> "FIT_MANUFACTURER_ICG",
    97   -> "FIT_MANUFACTURER_MIPULSE",
    98   -> "FIT_MANUFACTURER_BSX_ATHLETICS",
    99   -> "FIT_MANUFACTURER_LOOK",
    100  -> "FIT_MANUFACTURER_CAMPAGNOLO_SRL",
    101  -> "FIT_MANUFACTURER_BODY_BIKE_SMART",
    102  -> "FIT_MANUFACTURER_PRAXISWORKS",
    103  -> "FIT_MANUFACTURER_LIMITS_TECHNOLOGY",
    104  -> "FIT_MANUFACTURER_TOPACTION_TECHNOLOGY",
    105  -> "FIT_MANUFACTURER_COSINUSS",
    106  -> "FIT_MANUFACTURER_FITCARE",
    107  -> "FIT_MANUFACTURER_MAGENE",
    108  -> "FIT_MANUFACTURER_GIANT_MANUFACTURING_CO",
    109  -> "FIT_MANUFACTURER_TIGRASPORT",
    110  -> "FIT_MANUFACTURER_SALUTRON",
    111  -> "FIT_MANUFACTURER_TECHNOGYM",
    112  -> "FIT_MANUFACTURER_BRYTON_SENSORS",
    113  -> "FIT_MANUFACTURER_LATITUDE_LIMITED",
    114  -> "FIT_MANUFACTURER_SOARING_TECHNOLOGY",
    115  -> "FIT_MANUFACTURER_IGPSPORT",
    116  -> "FIT_MANUFACTURER_THINKRIDER",
    117  -> "FIT_MANUFACTURER_GOPHER_SPORT",
    118  -> "FIT_MANUFACTURER_WATERROWER",
    119  -> "FIT_MANUFACTURER_ORANGETHEORY",
    120  -> "FIT_MANUFACTURER_INPEAK",
    121  -> "FIT_MANUFACTURER_KINETIC",
    122  -> "FIT_MANUFACTURER_JOHNSON_HEALTH_TECH",
    123  -> "FIT_MANUFACTURER_POLAR_ELECTRO",
    124  -> "FIT_MANUFACTURER_SEESENSE",
    125  -> "FIT_MANUFACTURER_NCI_TECHNOLOGY",
    126  -> "FIT_MANUFACTURER_IQSQUARE",
    127  -> "FIT_MANUFACTURER_LEOMO",
    128  -> "FIT_MANUFACTURER_IFIT_COM",
    129  -> "FIT_MANUFACTURER_COROS_BYTE",
    130  -> "FIT_MANUFACTURER_VERSA_DESIGN",
    131  -> "FIT_MANUFACTURER_CHILEAF",
    132  -> "FIT_MANUFACTURER_CYCPLUS",
    133  -> "FIT_MANUFACTURER_GRAVAA_BYTE",
    134  -> "FIT_MANUFACTURER_SIGEYI",
    135  -> "FIT_MANUFACTURER_COOSPO",
    136  -> "FIT_MANUFACTURER_GEOID",
    137  -> "FIT_MANUFACTURER_BOSCH",
    138  -> "FIT_MANUFACTURER_KYTO",
    139  -> "FIT_MANUFACTURER_KINETIC_SPORTS",
    140  -> "FIT_MANUFACTURER_DECATHLON_BYTE",
    141  -> "FIT_MANUFACTURER_TQ_SYSTEMS",
    142  -> "FIT_MANUFACTURER_TAG_HEUER",
    143  -> "FIT_MANUFACTURER_KEISER_FITNESS",
    144  -> "FIT_MANUFACTURER_ZWIFT_BYTE",
    255  -> "FIT_MANUFACTURER_DEVELOPMENT",
    257  -> "FIT_MANUFACTURER_HEALTHANDLIFE",
    258  -> "FIT_MANUFACTURER_LEZYNE",
    259  -> "FIT_MANUFACTURER_SCRIBE_LABS",
    260  -> "FIT_MANUFACTURER_ZWIFT",
    261  -> "FIT_MANUFACTURER_WATTEAM",
    262  -> "FIT_MANUFACTURER_RECON",
    263  -> "FIT_MANUFACTURER_FAVERO_ELECTRONICS",
    264  -> "FIT_MANUFACTURER_DYNOVELO",
    265  -> "FIT_MANUFACTURER_STRAVA",
    266  -> "FIT_MANUFACTURER_PRECOR",
    267  -> "FIT_MANUFACTURER_BRYTON",
    268  -> "FIT_MANUFACTURER_SRAM",
    269  -> "FIT_MANUFACTURER_NAVMAN",
    270  -> "FIT_MANUFACTURER_COBI",
    271  -> "FIT_MANUFACTURER_SPIVI",
    272  -> "FIT_MANUFACTURER_MIO_MAGELLAN",
    273  -> "FIT_MANUFACTURER_EVESPORTS",
    274  -> "FIT_MANUFACTURER_SENSITIVUS_GAUGE",
    275  -> "FIT_MANUFACTURER_PODOON",
    276  -> "FIT_MANUFACTURER_LIFE_TIME_FITNESS",
    277  -> "FIT_MANUFACTURER_FALCO_E_MOTORS",
    278  -> "FIT_MANUFACTURER_MINOURA",
    279  -> "FIT_MANUFACTURER_CYCLIQ",
    280  -> "FIT_MANUFACTURER_LUXOTTICA",
    281  -> "FIT_MANUFACTURER_TRAINER_ROAD",
    282  -> "FIT_MANUFACTURER_THE_SUFFERFEST",
    283  -> "FIT_MANUFACTURER_FULLSPEEDAHEAD",
    284  -> "FIT_MANUFACTURER_VIRTUALTRAINING",
    285  -> "FIT_MANUFACTURER_FEEDBACKSPORTS",
    286  -> "FIT_MANUFACTURER_OMATA",
    287  -> "FIT_MANUFACTURER_VDO",
    288  -> "FIT_MANUFACTURER_MAGNETICDAYS",
    289  -> "FIT_MANUFACTURER_HAMMERHEAD",
    290  -> "FIT_MANUFACTURER_KINETIC_BY_KURT",
    291  -> "FIT_MANUFACTURER_SHAPELOG",
    292  -> "FIT_MANUFACTURER_DABUZIDUO",
    293  -> "FIT_MANUFACTURER_JETBLACK",
    294  -> "FIT_MANUFACTURER_COROS",
    295  -> "FIT_MANUFACTURER_VIRTUGO",
    296  -> "FIT_MANUFACTURER_VELOSENSE",
    297  -> "FIT_MANUFACTURER_CYCLIGENTINC",
    298  -> "FIT_MANUFACTURER_TRAILFORKS",
    299  -> "FIT_MANUFACTURER_MAHLE_EBIKEMOTION",
    300  -> "FIT_MANUFACTURER_NURVV",
    301  -> "FIT_MANUFACTURER_MICROPROGRAM",
    302  -> "FIT_MANUFACTURER_ZONE5CLOUD",
    303  -> "FIT_MANUFACTURER_GREENTEG",
    304  -> "FIT_MANUFACTURER_YAMAHA_MOTORS",
    305  -> "FIT_MANUFACTURER_WHOOP",
    306  -> "FIT_MANUFACTURER_GRAVAA",
    307  -> "FIT_MANUFACTURER_ONELAP",
    308  -> "FIT_MANUFACTURER_MONARK_EXERCISE",
    309  -> "FIT_MANUFACTURER_FORM",
    310  -> "FIT_MANUFACTURER_DECATHLON",
    311  -> "FIT_MANUFACTURER_SYNCROS",
    312  -> "FIT_MANUFACTURER_HEATUP",
    313  -> "FIT_MANUFACTURER_CANNONDALE",
    314  -> "FIT_MANUFACTURER_TRUE_FITNESS",
    315  -> "FIT_MANUFACTURER_RGT_CYCLING",
    316  -> "FIT_MANUFACTURER_VASA",
    317  -> "FIT_MANUFACTURER_RACE_REPUBLIC",
    318  -> "FIT_MANUFACTURER_FAZUA",
    319  -> "FIT_MANUFACTURER_OREKA_TRAINING",
    320  -> "FIT_MANUFACTURER_ISEC",
    321  -> "FIT_MANUFACTURER_LULULEMON_STUDIO",
    5759 -> "FIT_MANUFACTURER_ACTIGRAPHCORP"
|>;

$fitManufacturer = toNiceCamelCase /@ removePrefix[ $fitManufacturer0, "FIT_MANUFACTURER_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitANTPlusDeviceType*)
fitANTPlusDeviceType // ClearAll;
fitANTPlusDeviceType[ n_Integer ] := Lookup[ $fitANTPlusDeviceType, n, Missing[ "NotAvailable" ] ];
fitANTPlusDeviceType[ ___ ] := Missing[ "NotAvailable" ];

$fitANTPlusDeviceType0 = <|
    1   -> "FIT_ANTPLUS_DEVICE_TYPE_ANTFS",
    11  -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_POWER",
    12  -> "FIT_ANTPLUS_DEVICE_TYPE_ENVIRONMENT_SENSOR_LEGACY",
    15  -> "FIT_ANTPLUS_DEVICE_TYPE_MULTI_SPORT_SPEED_DISTANCE",
    16  -> "FIT_ANTPLUS_DEVICE_TYPE_CONTROL",
    17  -> "FIT_ANTPLUS_DEVICE_TYPE_FITNESS_EQUIPMENT",
    18  -> "FIT_ANTPLUS_DEVICE_TYPE_BLOOD_PRESSURE",
    19  -> "FIT_ANTPLUS_DEVICE_TYPE_GEOCACHE_NODE",
    20  -> "FIT_ANTPLUS_DEVICE_TYPE_LIGHT_ELECTRIC_VEHICLE",
    25  -> "FIT_ANTPLUS_DEVICE_TYPE_ENV_SENSOR",
    26  -> "FIT_ANTPLUS_DEVICE_TYPE_RACQUET",
    27  -> "FIT_ANTPLUS_DEVICE_TYPE_CONTROL_HUB",
    31  -> "FIT_ANTPLUS_DEVICE_TYPE_MUSCLE_OXYGEN",
    34  -> "FIT_ANTPLUS_DEVICE_TYPE_SHIFTING",
    35  -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_LIGHT_MAIN",
    36  -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_LIGHT_SHARED",
    38  -> "FIT_ANTPLUS_DEVICE_TYPE_EXD",
    40  -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_RADAR",
    46  -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_AERO",
    119 -> "FIT_ANTPLUS_DEVICE_TYPE_WEIGHT_SCALE",
    120 -> "FIT_ANTPLUS_DEVICE_TYPE_HEART_RATE",
    121 -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_SPEED_CADENCE",
    122 -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_CADENCE",
    123 -> "FIT_ANTPLUS_DEVICE_TYPE_BIKE_SPEED",
    124 -> "FIT_ANTPLUS_DEVICE_TYPE_STRIDE_SPEED_DISTANCE"
|>;

$fitANTPlusDeviceType = toNiceCamelCase /@ removePrefix[ $fitANTPlusDeviceType0, "FIT_ANTPLUS_DEVICE_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBatteryStatus*)
fitBatteryStatus // ClearAll;
fitBatteryStatus[ n_Integer ] := Lookup[ $fitBatteryStatus, n, Missing[ "NotAvailable" ] ];
fitBatteryStatus[ ___ ] := Missing[ "NotAvailable" ];

$fitBatteryStatus0 = <|
    1 -> "FIT_BATTERY_STATUS_NEW",
    2 -> "FIT_BATTERY_STATUS_GOOD",
    3 -> "FIT_BATTERY_STATUS_OK",
    4 -> "FIT_BATTERY_STATUS_LOW",
    5 -> "FIT_BATTERY_STATUS_CRITICAL",
    6 -> "FIT_BATTERY_STATUS_CHARGING",
    7 -> "FIT_BATTERY_STATUS_UNKNOWN"
|>;

$fitBatteryStatus = toNiceCamelCase /@ removePrefix[ $fitBatteryStatus0, "FIT_BATTERY_STATUS_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitBodyLocation*)
fitBodyLocation // ClearAll;
fitBodyLocation[ n_Integer ] := Lookup[ $fitBodyLocation, n, Missing[ "NotAvailable" ] ];
fitBodyLocation[ ___ ] := Missing[ "NotAvailable" ];

$fitBodyLocation0 = <|
    0  -> "FIT_BODY_LOCATION_LEFT_LEG",
    1  -> "FIT_BODY_LOCATION_LEFT_CALF",
    2  -> "FIT_BODY_LOCATION_LEFT_SHIN",
    3  -> "FIT_BODY_LOCATION_LEFT_HAMSTRING",
    4  -> "FIT_BODY_LOCATION_LEFT_QUAD",
    5  -> "FIT_BODY_LOCATION_LEFT_GLUTE",
    6  -> "FIT_BODY_LOCATION_RIGHT_LEG",
    7  -> "FIT_BODY_LOCATION_RIGHT_CALF",
    8  -> "FIT_BODY_LOCATION_RIGHT_SHIN",
    9  -> "FIT_BODY_LOCATION_RIGHT_HAMSTRING",
    10 -> "FIT_BODY_LOCATION_RIGHT_QUAD",
    11 -> "FIT_BODY_LOCATION_RIGHT_GLUTE",
    12 -> "FIT_BODY_LOCATION_TORSO_BACK",
    13 -> "FIT_BODY_LOCATION_LEFT_LOWER_BACK",
    14 -> "FIT_BODY_LOCATION_LEFT_UPPER_BACK",
    15 -> "FIT_BODY_LOCATION_RIGHT_LOWER_BACK",
    16 -> "FIT_BODY_LOCATION_RIGHT_UPPER_BACK",
    17 -> "FIT_BODY_LOCATION_TORSO_FRONT",
    18 -> "FIT_BODY_LOCATION_LEFT_ABDOMEN",
    19 -> "FIT_BODY_LOCATION_LEFT_CHEST",
    20 -> "FIT_BODY_LOCATION_RIGHT_ABDOMEN",
    21 -> "FIT_BODY_LOCATION_RIGHT_CHEST",
    22 -> "FIT_BODY_LOCATION_LEFT_ARM",
    23 -> "FIT_BODY_LOCATION_LEFT_SHOULDER",
    24 -> "FIT_BODY_LOCATION_LEFT_BICEP",
    25 -> "FIT_BODY_LOCATION_LEFT_TRICEP",
    26 -> "FIT_BODY_LOCATION_LEFT_BRACHIORADIALIS",
    27 -> "FIT_BODY_LOCATION_LEFT_FOREARM_EXTENSORS",
    28 -> "FIT_BODY_LOCATION_RIGHT_ARM",
    29 -> "FIT_BODY_LOCATION_RIGHT_SHOULDER",
    30 -> "FIT_BODY_LOCATION_RIGHT_BICEP",
    31 -> "FIT_BODY_LOCATION_RIGHT_TRICEP",
    32 -> "FIT_BODY_LOCATION_RIGHT_BRACHIORADIALIS",
    33 -> "FIT_BODY_LOCATION_RIGHT_FOREARM_EXTENSORS",
    34 -> "FIT_BODY_LOCATION_NECK",
    35 -> "FIT_BODY_LOCATION_THROAT",
    36 -> "FIT_BODY_LOCATION_WAIST_MID_BACK",
    37 -> "FIT_BODY_LOCATION_WAIST_FRONT",
    38 -> "FIT_BODY_LOCATION_WAIST_LEFT",
    39 -> "FIT_BODY_LOCATION_WAIST_RIGHT"
|>;

$fitBodyLocation = toNiceCamelCase /@ removePrefix[ $fitBodyLocation0, "FIT_BODY_LOCATION_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitANTNetwork*)
fitANTNetwork // ClearAll;
fitANTNetwork[ n_Integer ] := Lookup[ $fitANTNetwork, n, Missing[ "NotAvailable" ] ];
fitANTNetwork[ ___ ] := Missing[ "NotAvailable" ];

$fitANTNetwork0 = <|
    0 -> "FIT_ANT_NETWORK_PUBLIC",
    1 -> "FIT_ANT_NETWORK_ANTPLUS",
    2 -> "FIT_ANT_NETWORK_ANTFS",
    3 -> "FIT_ANT_NETWORK_PRIVATE"
|>;

$fitANTNetwork = toNiceCamelCase /@ removePrefix[ $fitANTNetwork0, "FIT_ANT_NETWORK_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSourceType*)
fitSourceType // ClearAll;
fitSourceType[ n_Integer ] := Lookup[ $fitSourceType, n, Missing[ "NotAvailable" ] ];
fitSourceType[ ___ ] := Missing[ "NotAvailable" ];

$fitSourceType0 = <|
    0 -> "FIT_SOURCE_TYPE_ANT",
    1 -> "FIT_SOURCE_TYPE_ANTPLUS",
    2 -> "FIT_SOURCE_TYPE_BLUETOOTH",
    3 -> "FIT_SOURCE_TYPE_BLUETOOTH_LOW_ENERGY",
    4 -> "FIT_SOURCE_TYPE_WIFI",
    5 -> "FIT_SOURCE_TYPE_LOCAL"
|>;

$fitSourceType = toNiceCamelCase /@ removePrefix[ $fitSourceType0, "FIT_SOURCE_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFile*)
fitFile // ClearAll;
fitFile[ n_Integer ] := Lookup[ $fitFile, n, Missing[ "NotAvailable" ] ];
fitFile[ ___ ] := Missing[ "NotAvailable" ];

$fitFile0 = <|
    1  -> "FIT_FILE_DEVICE",
    2  -> "FIT_FILE_SETTINGS",
    3  -> "FIT_FILE_SPORT",
    4  -> "FIT_FILE_ACTIVITY",
    5  -> "FIT_FILE_WORKOUT",
    6  -> "FIT_FILE_COURSE",
    7  -> "FIT_FILE_SCHEDULES",
    9  -> "FIT_FILE_WEIGHT",
    10 -> "FIT_FILE_TOTALS",
    11 -> "FIT_FILE_GOALS",
    14 -> "FIT_FILE_BLOOD_PRESSURE",
    15 -> "FIT_FILE_MONITORING_A",
    20 -> "FIT_FILE_ACTIVITY_SUMMARY",
    28 -> "FIT_FILE_MONITORING_DAILY",
    32 -> "FIT_FILE_MONITORING_B",
    34 -> "FIT_FILE_SEGMENT",
    35 -> "FIT_FILE_SEGMENT_LIST",
    40 -> "FIT_FILE_EXD_CONFIGURATION"
|>;

$fitFile = toNiceCamelCase /@ removePrefix[ $fitFile0, "FIT_FILE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSport*)
fitSport // ClearAll;
fitSport[ n_Integer ] := Lookup[ $fitSport, n, Missing[ "NotAvailable" ] ];
fitSport[ ___ ] := Missing[ "NotAvailable" ];

$fitSport0 = <|
    0   -> "FIT_SPORT_GENERIC",
    1   -> "FIT_SPORT_RUNNING",
    2   -> "FIT_SPORT_CYCLING",
    3   -> "FIT_SPORT_TRANSITION",
    4   -> "FIT_SPORT_FITNESS_EQUIPMENT",
    5   -> "FIT_SPORT_SWIMMING",
    6   -> "FIT_SPORT_BASKETBALL",
    7   -> "FIT_SPORT_SOCCER",
    8   -> "FIT_SPORT_TENNIS",
    9   -> "FIT_SPORT_AMERICAN_FOOTBALL",
    10  -> "FIT_SPORT_TRAINING",
    11  -> "FIT_SPORT_WALKING",
    12  -> "FIT_SPORT_CROSS_COUNTRY_SKIING",
    13  -> "FIT_SPORT_ALPINE_SKIING",
    14  -> "FIT_SPORT_SNOWBOARDING",
    15  -> "FIT_SPORT_ROWING",
    16  -> "FIT_SPORT_MOUNTAINEERING",
    17  -> "FIT_SPORT_HIKING",
    18  -> "FIT_SPORT_MULTISPORT",
    19  -> "FIT_SPORT_PADDLING",
    20  -> "FIT_SPORT_FLYING",
    21  -> "FIT_SPORT_E_BIKING",
    22  -> "FIT_SPORT_MOTORCYCLING",
    23  -> "FIT_SPORT_BOATING",
    24  -> "FIT_SPORT_DRIVING",
    25  -> "FIT_SPORT_GOLF",
    26  -> "FIT_SPORT_HANG_GLIDING",
    27  -> "FIT_SPORT_HORSEBACK_RIDING",
    28  -> "FIT_SPORT_HUNTING",
    29  -> "FIT_SPORT_FISHING",
    30  -> "FIT_SPORT_INLINE_SKATING",
    31  -> "FIT_SPORT_ROCK_CLIMBING",
    32  -> "FIT_SPORT_SAILING",
    33  -> "FIT_SPORT_ICE_SKATING",
    34  -> "FIT_SPORT_SKY_DIVING",
    35  -> "FIT_SPORT_SNOWSHOEING",
    36  -> "FIT_SPORT_SNOWMOBILING",
    37  -> "FIT_SPORT_STAND_UP_PADDLEBOARDING",
    38  -> "FIT_SPORT_SURFING",
    39  -> "FIT_SPORT_WAKEBOARDING",
    40  -> "FIT_SPORT_WATER_SKIING",
    41  -> "FIT_SPORT_KAYAKING",
    42  -> "FIT_SPORT_RAFTING",
    43  -> "FIT_SPORT_WINDSURFING",
    44  -> "FIT_SPORT_KITESURFING",
    45  -> "FIT_SPORT_TACTICAL",
    46  -> "FIT_SPORT_JUMPMASTER",
    47  -> "FIT_SPORT_BOXING",
    48  -> "FIT_SPORT_FLOOR_CLIMBING",
    53  -> "FIT_SPORT_DIVING",
    254 -> "FIT_SPORT_ALL"
|>;

$fitSport = toNiceCamelCase /@ removePrefix[ $fitSport0, "FIT_SPORT_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitSubSport*)
fitSubSport // ClearAll;
fitSubSport[ n_Integer ] := Lookup[ $fitSubSport, n, Missing[ "NotAvailable" ] ];
fitSubSport[ ___ ] := Missing[ "NotAvailable" ];

$fitSubSport0 = <|
    0   -> "FIT_SUB_SPORT_GENERIC",
    1   -> "FIT_SUB_SPORT_TREADMILL",
    2   -> "FIT_SUB_SPORT_STREET",
    3   -> "FIT_SUB_SPORT_TRAIL",
    4   -> "FIT_SUB_SPORT_TRACK",
    5   -> "FIT_SUB_SPORT_SPIN",
    6   -> "FIT_SUB_SPORT_INDOOR_CYCLING",
    7   -> "FIT_SUB_SPORT_ROAD",
    8   -> "FIT_SUB_SPORT_MOUNTAIN",
    9   -> "FIT_SUB_SPORT_DOWNHILL",
    10  -> "FIT_SUB_SPORT_RECUMBENT",
    11  -> "FIT_SUB_SPORT_CYCLOCROSS",
    12  -> "FIT_SUB_SPORT_HAND_CYCLING",
    13  -> "FIT_SUB_SPORT_TRACK_CYCLING",
    14  -> "FIT_SUB_SPORT_INDOOR_ROWING",
    15  -> "FIT_SUB_SPORT_ELLIPTICAL",
    16  -> "FIT_SUB_SPORT_STAIR_CLIMBING",
    17  -> "FIT_SUB_SPORT_LAP_SWIMMING",
    18  -> "FIT_SUB_SPORT_OPEN_WATER",
    19  -> "FIT_SUB_SPORT_FLEXIBILITY_TRAINING",
    20  -> "FIT_SUB_SPORT_STRENGTH_TRAINING",
    21  -> "FIT_SUB_SPORT_WARM_UP",
    22  -> "FIT_SUB_SPORT_MATCH",
    23  -> "FIT_SUB_SPORT_EXERCISE",
    24  -> "FIT_SUB_SPORT_CHALLENGE",
    25  -> "FIT_SUB_SPORT_INDOOR_SKIING",
    26  -> "FIT_SUB_SPORT_CARDIO_TRAINING",
    27  -> "FIT_SUB_SPORT_INDOOR_WALKING",
    28  -> "FIT_SUB_SPORT_E_BIKE_FITNESS",
    29  -> "FIT_SUB_SPORT_BMX",
    30  -> "FIT_SUB_SPORT_CASUAL_WALKING",
    31  -> "FIT_SUB_SPORT_SPEED_WALKING",
    32  -> "FIT_SUB_SPORT_BIKE_TO_RUN_TRANSITION",
    33  -> "FIT_SUB_SPORT_RUN_TO_BIKE_TRANSITION",
    34  -> "FIT_SUB_SPORT_SWIM_TO_BIKE_TRANSITION",
    35  -> "FIT_SUB_SPORT_ATV",
    36  -> "FIT_SUB_SPORT_MOTOCROSS",
    37  -> "FIT_SUB_SPORT_BACKCOUNTRY",
    38  -> "FIT_SUB_SPORT_RESORT",
    39  -> "FIT_SUB_SPORT_RC_DRONE",
    40  -> "FIT_SUB_SPORT_WINGSUIT",
    41  -> "FIT_SUB_SPORT_WHITEWATER",
    42  -> "FIT_SUB_SPORT_SKATE_SKIING",
    43  -> "FIT_SUB_SPORT_YOGA",
    44  -> "FIT_SUB_SPORT_PILATES",
    45  -> "FIT_SUB_SPORT_INDOOR_RUNNING",
    46  -> "FIT_SUB_SPORT_GRAVEL_CYCLING",
    47  -> "FIT_SUB_SPORT_E_BIKE_MOUNTAIN",
    48  -> "FIT_SUB_SPORT_COMMUTING",
    49  -> "FIT_SUB_SPORT_MIXED_SURFACE",
    50  -> "FIT_SUB_SPORT_NAVIGATE",
    51  -> "FIT_SUB_SPORT_TRACK_ME",
    52  -> "FIT_SUB_SPORT_MAP",
    53  -> "FIT_SUB_SPORT_SINGLE_GAS_DIVING",
    54  -> "FIT_SUB_SPORT_MULTI_GAS_DIVING",
    55  -> "FIT_SUB_SPORT_GAUGE_DIVING",
    56  -> "FIT_SUB_SPORT_APNEA_DIVING",
    57  -> "FIT_SUB_SPORT_APNEA_HUNTING",
    58  -> "FIT_SUB_SPORT_VIRTUAL_ACTIVITY",
    59  -> "FIT_SUB_SPORT_OBSTACLE",
    62  -> "FIT_SUB_SPORT_BREATHING",
    65  -> "FIT_SUB_SPORT_SAIL_RACE",
    67  -> "FIT_SUB_SPORT_ULTRA",
    68  -> "FIT_SUB_SPORT_INDOOR_CLIMBING",
    69  -> "FIT_SUB_SPORT_BOULDERING",
    254 -> "FIT_SUB_SPORT_ALL"
|>;

$fitSubSport = toNiceCamelCase /@ removePrefix[ $fitSubSport0, "FIT_SUB_SPORT_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitGarminProduct*)
fitGarminProduct // ClearAll;
fitGarminProduct[ n_Integer ] := Lookup[ $fitGarminProduct, n, Missing[ "NotAvailable" ] ];
fitGarminProduct[ ___ ] := Missing[ "NotAvailable" ];

$fitGarminProduct0 = <|
    1     -> "FIT_GARMIN_PRODUCT_HRM1",
    2     -> "FIT_GARMIN_PRODUCT_AXH01",
    3     -> "FIT_GARMIN_PRODUCT_AXB01",
    4     -> "FIT_GARMIN_PRODUCT_AXB02",
    5     -> "FIT_GARMIN_PRODUCT_HRM2SS",
    6     -> "FIT_GARMIN_PRODUCT_DSI_ALF02",
    7     -> "FIT_GARMIN_PRODUCT_HRM3SS",
    8     -> "FIT_GARMIN_PRODUCT_HRM_RUN_SINGLE_BYTE_PRODUCT_ID",
    9     -> "FIT_GARMIN_PRODUCT_BSM",
    10    -> "FIT_GARMIN_PRODUCT_BCM",
    11    -> "FIT_GARMIN_PRODUCT_AXS01",
    12    -> "FIT_GARMIN_PRODUCT_HRM_TRI_SINGLE_BYTE_PRODUCT_ID",
    13    -> "FIT_GARMIN_PRODUCT_HRM4_RUN_SINGLE_BYTE_PRODUCT_ID",
    14    -> "FIT_GARMIN_PRODUCT_FR225_SINGLE_BYTE_PRODUCT_ID",
    15    -> "FIT_GARMIN_PRODUCT_GEN3_BSM_SINGLE_BYTE_PRODUCT_ID",
    16    -> "FIT_GARMIN_PRODUCT_GEN3_BCM_SINGLE_BYTE_PRODUCT_ID",
    255   -> "FIT_GARMIN_PRODUCT_OHR",
    473   -> "FIT_GARMIN_PRODUCT_FR301_CHINA",
    474   -> "FIT_GARMIN_PRODUCT_FR301_JAPAN",
    475   -> "FIT_GARMIN_PRODUCT_FR301_KOREA",
    494   -> "FIT_GARMIN_PRODUCT_FR301_TAIWAN",
    717   -> "FIT_GARMIN_PRODUCT_FR405",
    782   -> "FIT_GARMIN_PRODUCT_FR50",
    987   -> "FIT_GARMIN_PRODUCT_FR405_JAPAN",
    988   -> "FIT_GARMIN_PRODUCT_FR60",
    1011  -> "FIT_GARMIN_PRODUCT_DSI_ALF01",
    1018  -> "FIT_GARMIN_PRODUCT_FR310XT",
    1036  -> "FIT_GARMIN_PRODUCT_EDGE500",
    1124  -> "FIT_GARMIN_PRODUCT_FR110",
    1169  -> "FIT_GARMIN_PRODUCT_EDGE800",
    1199  -> "FIT_GARMIN_PRODUCT_EDGE500_TAIWAN",
    1213  -> "FIT_GARMIN_PRODUCT_EDGE500_JAPAN",
    1253  -> "FIT_GARMIN_PRODUCT_CHIRP",
    1274  -> "FIT_GARMIN_PRODUCT_FR110_JAPAN",
    1325  -> "FIT_GARMIN_PRODUCT_EDGE200",
    1328  -> "FIT_GARMIN_PRODUCT_FR910XT",
    1333  -> "FIT_GARMIN_PRODUCT_EDGE800_TAIWAN",
    1334  -> "FIT_GARMIN_PRODUCT_EDGE800_JAPAN",
    1341  -> "FIT_GARMIN_PRODUCT_ALF04",
    1345  -> "FIT_GARMIN_PRODUCT_FR610",
    1360  -> "FIT_GARMIN_PRODUCT_FR210_JAPAN",
    1380  -> "FIT_GARMIN_PRODUCT_VECTOR_SS",
    1381  -> "FIT_GARMIN_PRODUCT_VECTOR_CP",
    1386  -> "FIT_GARMIN_PRODUCT_EDGE800_CHINA",
    1387  -> "FIT_GARMIN_PRODUCT_EDGE500_CHINA",
    1405  -> "FIT_GARMIN_PRODUCT_APPROACH_G10",
    1410  -> "FIT_GARMIN_PRODUCT_FR610_JAPAN",
    1422  -> "FIT_GARMIN_PRODUCT_EDGE500_KOREA",
    1436  -> "FIT_GARMIN_PRODUCT_FR70",
    1446  -> "FIT_GARMIN_PRODUCT_FR310XT_4T",
    1461  -> "FIT_GARMIN_PRODUCT_AMX",
    1482  -> "FIT_GARMIN_PRODUCT_FR10",
    1497  -> "FIT_GARMIN_PRODUCT_EDGE800_KOREA",
    1499  -> "FIT_GARMIN_PRODUCT_SWIM",
    1537  -> "FIT_GARMIN_PRODUCT_FR910XT_CHINA",
    1551  -> "FIT_GARMIN_PRODUCT_FENIX",
    1555  -> "FIT_GARMIN_PRODUCT_EDGE200_TAIWAN",
    1561  -> "FIT_GARMIN_PRODUCT_EDGE510",
    1567  -> "FIT_GARMIN_PRODUCT_EDGE810",
    1570  -> "FIT_GARMIN_PRODUCT_TEMPE",
    1600  -> "FIT_GARMIN_PRODUCT_FR910XT_JAPAN",
    1623  -> "FIT_GARMIN_PRODUCT_FR620",
    1632  -> "FIT_GARMIN_PRODUCT_FR220",
    1664  -> "FIT_GARMIN_PRODUCT_FR910XT_KOREA",
    1688  -> "FIT_GARMIN_PRODUCT_FR10_JAPAN",
    1721  -> "FIT_GARMIN_PRODUCT_EDGE810_JAPAN",
    1735  -> "FIT_GARMIN_PRODUCT_VIRB_ELITE",
    1736  -> "FIT_GARMIN_PRODUCT_EDGE_TOURING",
    1742  -> "FIT_GARMIN_PRODUCT_EDGE510_JAPAN",
    1743  -> "FIT_GARMIN_PRODUCT_HRM_TRI",
    1752  -> "FIT_GARMIN_PRODUCT_HRM_RUN",
    1765  -> "FIT_GARMIN_PRODUCT_FR920XT",
    1821  -> "FIT_GARMIN_PRODUCT_EDGE510_ASIA",
    1822  -> "FIT_GARMIN_PRODUCT_EDGE810_CHINA",
    1823  -> "FIT_GARMIN_PRODUCT_EDGE810_TAIWAN",
    1836  -> "FIT_GARMIN_PRODUCT_EDGE1000",
    1837  -> "FIT_GARMIN_PRODUCT_VIVO_FIT",
    1853  -> "FIT_GARMIN_PRODUCT_VIRB_REMOTE",
    1885  -> "FIT_GARMIN_PRODUCT_VIVO_KI",
    1903  -> "FIT_GARMIN_PRODUCT_FR15",
    1907  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE",
    1918  -> "FIT_GARMIN_PRODUCT_EDGE510_KOREA",
    1928  -> "FIT_GARMIN_PRODUCT_FR620_JAPAN",
    1929  -> "FIT_GARMIN_PRODUCT_FR620_CHINA",
    1930  -> "FIT_GARMIN_PRODUCT_FR220_JAPAN",
    1931  -> "FIT_GARMIN_PRODUCT_FR220_CHINA",
    1936  -> "FIT_GARMIN_PRODUCT_APPROACH_S6",
    1956  -> "FIT_GARMIN_PRODUCT_VIVO_SMART",
    1967  -> "FIT_GARMIN_PRODUCT_FENIX2",
    1988  -> "FIT_GARMIN_PRODUCT_EPIX",
    2050  -> "FIT_GARMIN_PRODUCT_FENIX3",
    2052  -> "FIT_GARMIN_PRODUCT_EDGE1000_TAIWAN",
    2053  -> "FIT_GARMIN_PRODUCT_EDGE1000_JAPAN",
    2061  -> "FIT_GARMIN_PRODUCT_FR15_JAPAN",
    2067  -> "FIT_GARMIN_PRODUCT_EDGE520",
    2070  -> "FIT_GARMIN_PRODUCT_EDGE1000_CHINA",
    2072  -> "FIT_GARMIN_PRODUCT_FR620_RUSSIA",
    2073  -> "FIT_GARMIN_PRODUCT_FR220_RUSSIA",
    2079  -> "FIT_GARMIN_PRODUCT_VECTOR_S",
    2100  -> "FIT_GARMIN_PRODUCT_EDGE1000_KOREA",
    2130  -> "FIT_GARMIN_PRODUCT_FR920XT_TAIWAN",
    2131  -> "FIT_GARMIN_PRODUCT_FR920XT_CHINA",
    2132  -> "FIT_GARMIN_PRODUCT_FR920XT_JAPAN",
    2134  -> "FIT_GARMIN_PRODUCT_VIRBX",
    2135  -> "FIT_GARMIN_PRODUCT_VIVO_SMART_APAC",
    2140  -> "FIT_GARMIN_PRODUCT_ETREX_TOUCH",
    2147  -> "FIT_GARMIN_PRODUCT_EDGE25",
    2148  -> "FIT_GARMIN_PRODUCT_FR25",
    2150  -> "FIT_GARMIN_PRODUCT_VIVO_FIT2",
    2153  -> "FIT_GARMIN_PRODUCT_FR225",
    2156  -> "FIT_GARMIN_PRODUCT_FR630",
    2157  -> "FIT_GARMIN_PRODUCT_FR230",
    2158  -> "FIT_GARMIN_PRODUCT_FR735XT",
    2160  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE_APAC",
    2161  -> "FIT_GARMIN_PRODUCT_VECTOR_2",
    2162  -> "FIT_GARMIN_PRODUCT_VECTOR_2S",
    2172  -> "FIT_GARMIN_PRODUCT_VIRBXE",
    2173  -> "FIT_GARMIN_PRODUCT_FR620_TAIWAN",
    2174  -> "FIT_GARMIN_PRODUCT_FR220_TAIWAN",
    2175  -> "FIT_GARMIN_PRODUCT_TRUSWING",
    2187  -> "FIT_GARMIN_PRODUCT_D2AIRVENU",
    2188  -> "FIT_GARMIN_PRODUCT_FENIX3_CHINA",
    2189  -> "FIT_GARMIN_PRODUCT_FENIX3_TWN",
    2192  -> "FIT_GARMIN_PRODUCT_VARIA_HEADLIGHT",
    2193  -> "FIT_GARMIN_PRODUCT_VARIA_TAILLIGHT_OLD",
    2204  -> "FIT_GARMIN_PRODUCT_EDGE_EXPLORE_1000",
    2219  -> "FIT_GARMIN_PRODUCT_FR225_ASIA",
    2225  -> "FIT_GARMIN_PRODUCT_VARIA_RADAR_TAILLIGHT",
    2226  -> "FIT_GARMIN_PRODUCT_VARIA_RADAR_DISPLAY",
    2238  -> "FIT_GARMIN_PRODUCT_EDGE20",
    2260  -> "FIT_GARMIN_PRODUCT_EDGE520_ASIA",
    2261  -> "FIT_GARMIN_PRODUCT_EDGE520_JAPAN",
    2262  -> "FIT_GARMIN_PRODUCT_D2_BRAVO",
    2266  -> "FIT_GARMIN_PRODUCT_APPROACH_S20",
    2271  -> "FIT_GARMIN_PRODUCT_VIVO_SMART2",
    2274  -> "FIT_GARMIN_PRODUCT_EDGE1000_THAI",
    2276  -> "FIT_GARMIN_PRODUCT_VARIA_REMOTE",
    2288  -> "FIT_GARMIN_PRODUCT_EDGE25_ASIA",
    2289  -> "FIT_GARMIN_PRODUCT_EDGE25_JPN",
    2290  -> "FIT_GARMIN_PRODUCT_EDGE20_ASIA",
    2292  -> "FIT_GARMIN_PRODUCT_APPROACH_X40",
    2293  -> "FIT_GARMIN_PRODUCT_FENIX3_JAPAN",
    2294  -> "FIT_GARMIN_PRODUCT_VIVO_SMART_EMEA",
    2310  -> "FIT_GARMIN_PRODUCT_FR630_ASIA",
    2311  -> "FIT_GARMIN_PRODUCT_FR630_JPN",
    2313  -> "FIT_GARMIN_PRODUCT_FR230_JPN",
    2327  -> "FIT_GARMIN_PRODUCT_HRM4_RUN",
    2332  -> "FIT_GARMIN_PRODUCT_EPIX_JAPAN",
    2337  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE_HR",
    2347  -> "FIT_GARMIN_PRODUCT_VIVO_SMART_GPS_HR",
    2348  -> "FIT_GARMIN_PRODUCT_VIVO_SMART_HR",
    2361  -> "FIT_GARMIN_PRODUCT_VIVO_SMART_HR_ASIA",
    2362  -> "FIT_GARMIN_PRODUCT_VIVO_SMART_GPS_HR_ASIA",
    2368  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE",
    2379  -> "FIT_GARMIN_PRODUCT_VARIA_TAILLIGHT",
    2396  -> "FIT_GARMIN_PRODUCT_FR235_ASIA",
    2397  -> "FIT_GARMIN_PRODUCT_FR235_JAPAN",
    2398  -> "FIT_GARMIN_PRODUCT_VARIA_VISION",
    2406  -> "FIT_GARMIN_PRODUCT_VIVO_FIT3",
    2407  -> "FIT_GARMIN_PRODUCT_FENIX3_KOREA",
    2408  -> "FIT_GARMIN_PRODUCT_FENIX3_SEA",
    2413  -> "FIT_GARMIN_PRODUCT_FENIX3_HR",
    2417  -> "FIT_GARMIN_PRODUCT_VIRB_ULTRA_30",
    2429  -> "FIT_GARMIN_PRODUCT_INDEX_SMART_SCALE",
    2431  -> "FIT_GARMIN_PRODUCT_FR235",
    2432  -> "FIT_GARMIN_PRODUCT_FENIX3_CHRONOS",
    2441  -> "FIT_GARMIN_PRODUCT_OREGON7XX",
    2444  -> "FIT_GARMIN_PRODUCT_RINO7XX",
    2457  -> "FIT_GARMIN_PRODUCT_EPIX_KOREA",
    2473  -> "FIT_GARMIN_PRODUCT_FENIX3_HR_CHN",
    2474  -> "FIT_GARMIN_PRODUCT_FENIX3_HR_TWN",
    2475  -> "FIT_GARMIN_PRODUCT_FENIX3_HR_JPN",
    2476  -> "FIT_GARMIN_PRODUCT_FENIX3_HR_SEA",
    2477  -> "FIT_GARMIN_PRODUCT_FENIX3_HR_KOR",
    2496  -> "FIT_GARMIN_PRODUCT_NAUTIX",
    2497  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE_HR_APAC",
    2512  -> "FIT_GARMIN_PRODUCT_OREGON7XX_WW",
    2530  -> "FIT_GARMIN_PRODUCT_EDGE_820",
    2531  -> "FIT_GARMIN_PRODUCT_EDGE_EXPLORE_820",
    2533  -> "FIT_GARMIN_PRODUCT_FR735XT_APAC",
    2534  -> "FIT_GARMIN_PRODUCT_FR735XT_JAPAN",
    2544  -> "FIT_GARMIN_PRODUCT_FENIX5S",
    2547  -> "FIT_GARMIN_PRODUCT_D2_BRAVO_TITANIUM",
    2567  -> "FIT_GARMIN_PRODUCT_VARIA_UT800",
    2593  -> "FIT_GARMIN_PRODUCT_RUNNING_DYNAMICS_POD",
    2599  -> "FIT_GARMIN_PRODUCT_EDGE_820_CHINA",
    2600  -> "FIT_GARMIN_PRODUCT_EDGE_820_JAPAN",
    2604  -> "FIT_GARMIN_PRODUCT_FENIX5X",
    2606  -> "FIT_GARMIN_PRODUCT_VIVO_FIT_JR",
    2622  -> "FIT_GARMIN_PRODUCT_VIVO_SMART3",
    2623  -> "FIT_GARMIN_PRODUCT_VIVO_SPORT",
    2628  -> "FIT_GARMIN_PRODUCT_EDGE_820_TAIWAN",
    2629  -> "FIT_GARMIN_PRODUCT_EDGE_820_KOREA",
    2630  -> "FIT_GARMIN_PRODUCT_EDGE_820_SEA",
    2650  -> "FIT_GARMIN_PRODUCT_FR35_HEBREW",
    2656  -> "FIT_GARMIN_PRODUCT_APPROACH_S60",
    2667  -> "FIT_GARMIN_PRODUCT_FR35_APAC",
    2668  -> "FIT_GARMIN_PRODUCT_FR35_JAPAN",
    2675  -> "FIT_GARMIN_PRODUCT_FENIX3_CHRONOS_ASIA",
    2687  -> "FIT_GARMIN_PRODUCT_VIRB_360",
    2691  -> "FIT_GARMIN_PRODUCT_FR935",
    2697  -> "FIT_GARMIN_PRODUCT_FENIX5",
    2700  -> "FIT_GARMIN_PRODUCT_VIVOACTIVE3",
    2733  -> "FIT_GARMIN_PRODUCT_FR235_CHINA_NFC",
    2769  -> "FIT_GARMIN_PRODUCT_FORETREX_601_701",
    2772  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE_HR",
    2713  -> "FIT_GARMIN_PRODUCT_EDGE_1030",
    2727  -> "FIT_GARMIN_PRODUCT_FR35_SEA",
    2787  -> "FIT_GARMIN_PRODUCT_VECTOR_3",
    2796  -> "FIT_GARMIN_PRODUCT_FENIX5_ASIA",
    2797  -> "FIT_GARMIN_PRODUCT_FENIX5S_ASIA",
    2798  -> "FIT_GARMIN_PRODUCT_FENIX5X_ASIA",
    2806  -> "FIT_GARMIN_PRODUCT_APPROACH_Z80",
    2814  -> "FIT_GARMIN_PRODUCT_FR35_KOREA",
    2819  -> "FIT_GARMIN_PRODUCT_D2CHARLIE",
    2831  -> "FIT_GARMIN_PRODUCT_VIVO_SMART3_APAC",
    2832  -> "FIT_GARMIN_PRODUCT_VIVO_SPORT_APAC",
    2833  -> "FIT_GARMIN_PRODUCT_FR935_ASIA",
    2859  -> "FIT_GARMIN_PRODUCT_DESCENT",
    2878  -> "FIT_GARMIN_PRODUCT_VIVO_FIT4",
    2886  -> "FIT_GARMIN_PRODUCT_FR645",
    2888  -> "FIT_GARMIN_PRODUCT_FR645M",
    2891  -> "FIT_GARMIN_PRODUCT_FR30",
    2900  -> "FIT_GARMIN_PRODUCT_FENIX5S_PLUS",
    2909  -> "FIT_GARMIN_PRODUCT_EDGE_130",
    2924  -> "FIT_GARMIN_PRODUCT_EDGE_1030_ASIA",
    2927  -> "FIT_GARMIN_PRODUCT_VIVOSMART_4",
    2945  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE_HR_ASIA",
    2962  -> "FIT_GARMIN_PRODUCT_APPROACH_X10",
    2977  -> "FIT_GARMIN_PRODUCT_FR30_ASIA",
    2988  -> "FIT_GARMIN_PRODUCT_VIVOACTIVE3M_W",
    3003  -> "FIT_GARMIN_PRODUCT_FR645_ASIA",
    3004  -> "FIT_GARMIN_PRODUCT_FR645M_ASIA",
    3011  -> "FIT_GARMIN_PRODUCT_EDGE_EXPLORE",
    3028  -> "FIT_GARMIN_PRODUCT_GPSMAP66",
    3049  -> "FIT_GARMIN_PRODUCT_APPROACH_S10",
    3066  -> "FIT_GARMIN_PRODUCT_VIVOACTIVE3M_L",
    3085  -> "FIT_GARMIN_PRODUCT_APPROACH_G80",
    3092  -> "FIT_GARMIN_PRODUCT_EDGE_130_ASIA",
    3095  -> "FIT_GARMIN_PRODUCT_EDGE_1030_BONTRAGER",
    3110  -> "FIT_GARMIN_PRODUCT_FENIX5_PLUS",
    3111  -> "FIT_GARMIN_PRODUCT_FENIX5X_PLUS",
    3112  -> "FIT_GARMIN_PRODUCT_EDGE_520_PLUS",
    3113  -> "FIT_GARMIN_PRODUCT_FR945",
    3121  -> "FIT_GARMIN_PRODUCT_EDGE_530",
    3122  -> "FIT_GARMIN_PRODUCT_EDGE_830",
    3126  -> "FIT_GARMIN_PRODUCT_INSTINCT_ESPORTS",
    3134  -> "FIT_GARMIN_PRODUCT_FENIX5S_PLUS_APAC",
    3135  -> "FIT_GARMIN_PRODUCT_FENIX5X_PLUS_APAC",
    3142  -> "FIT_GARMIN_PRODUCT_EDGE_520_PLUS_APAC",
    3144  -> "FIT_GARMIN_PRODUCT_FR235L_ASIA",
    3145  -> "FIT_GARMIN_PRODUCT_FR245_ASIA",
    3163  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE3M_APAC",
    3192  -> "FIT_GARMIN_PRODUCT_GEN3_BSM",
    3193  -> "FIT_GARMIN_PRODUCT_GEN3_BCM",
    3218  -> "FIT_GARMIN_PRODUCT_VIVO_SMART4_ASIA",
    3224  -> "FIT_GARMIN_PRODUCT_VIVOACTIVE4_SMALL",
    3225  -> "FIT_GARMIN_PRODUCT_VIVOACTIVE4_LARGE",
    3226  -> "FIT_GARMIN_PRODUCT_VENU",
    3246  -> "FIT_GARMIN_PRODUCT_MARQ_DRIVER",
    3247  -> "FIT_GARMIN_PRODUCT_MARQ_AVIATOR",
    3248  -> "FIT_GARMIN_PRODUCT_MARQ_CAPTAIN",
    3249  -> "FIT_GARMIN_PRODUCT_MARQ_COMMANDER",
    3250  -> "FIT_GARMIN_PRODUCT_MARQ_EXPEDITION",
    3251  -> "FIT_GARMIN_PRODUCT_MARQ_ATHLETE",
    3258  -> "FIT_GARMIN_PRODUCT_DESCENT_MK2",
    3284  -> "FIT_GARMIN_PRODUCT_GPSMAP66I",
    3287  -> "FIT_GARMIN_PRODUCT_FENIX6S_SPORT",
    3288  -> "FIT_GARMIN_PRODUCT_FENIX6S",
    3289  -> "FIT_GARMIN_PRODUCT_FENIX6_SPORT",
    3290  -> "FIT_GARMIN_PRODUCT_FENIX6",
    3291  -> "FIT_GARMIN_PRODUCT_FENIX6X",
    3299  -> "FIT_GARMIN_PRODUCT_HRM_DUAL",
    3300  -> "FIT_GARMIN_PRODUCT_HRM_PRO",
    3308  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE3_PREMIUM",
    3314  -> "FIT_GARMIN_PRODUCT_APPROACH_S40",
    3321  -> "FIT_GARMIN_PRODUCT_FR245M_ASIA",
    3349  -> "FIT_GARMIN_PRODUCT_EDGE_530_APAC",
    3350  -> "FIT_GARMIN_PRODUCT_EDGE_830_APAC",
    3378  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE3",
    3387  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE4_SMALL_ASIA",
    3388  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE4_LARGE_ASIA",
    3389  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE4_OLED_ASIA",
    3405  -> "FIT_GARMIN_PRODUCT_SWIM2",
    3420  -> "FIT_GARMIN_PRODUCT_MARQ_DRIVER_ASIA",
    3421  -> "FIT_GARMIN_PRODUCT_MARQ_AVIATOR_ASIA",
    3422  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE3_ASIA",
    3441  -> "FIT_GARMIN_PRODUCT_FR945_ASIA",
    3446  -> "FIT_GARMIN_PRODUCT_VIVO_ACTIVE3T_CHN",
    3448  -> "FIT_GARMIN_PRODUCT_MARQ_CAPTAIN_ASIA",
    3449  -> "FIT_GARMIN_PRODUCT_MARQ_COMMANDER_ASIA",
    3450  -> "FIT_GARMIN_PRODUCT_MARQ_EXPEDITION_ASIA",
    3451  -> "FIT_GARMIN_PRODUCT_MARQ_ATHLETE_ASIA",
    3466  -> "FIT_GARMIN_PRODUCT_INSTINCT_SOLAR",
    3469  -> "FIT_GARMIN_PRODUCT_FR45_ASIA",
    3473  -> "FIT_GARMIN_PRODUCT_VIVOACTIVE3_DAIMLER",
    3498  -> "FIT_GARMIN_PRODUCT_LEGACY_REY",
    3499  -> "FIT_GARMIN_PRODUCT_LEGACY_DARTH_VADER",
    3500  -> "FIT_GARMIN_PRODUCT_LEGACY_CAPTAIN_MARVEL",
    3501  -> "FIT_GARMIN_PRODUCT_LEGACY_FIRST_AVENGER",
    3512  -> "FIT_GARMIN_PRODUCT_FENIX6S_SPORT_ASIA",
    3513  -> "FIT_GARMIN_PRODUCT_FENIX6S_ASIA",
    3514  -> "FIT_GARMIN_PRODUCT_FENIX6_SPORT_ASIA",
    3515  -> "FIT_GARMIN_PRODUCT_FENIX6_ASIA",
    3516  -> "FIT_GARMIN_PRODUCT_FENIX6X_ASIA",
    3535  -> "FIT_GARMIN_PRODUCT_LEGACY_CAPTAIN_MARVEL_ASIA",
    3536  -> "FIT_GARMIN_PRODUCT_LEGACY_FIRST_AVENGER_ASIA",
    3537  -> "FIT_GARMIN_PRODUCT_LEGACY_REY_ASIA",
    3538  -> "FIT_GARMIN_PRODUCT_LEGACY_DARTH_VADER_ASIA",
    3542  -> "FIT_GARMIN_PRODUCT_DESCENT_MK2S",
    3558  -> "FIT_GARMIN_PRODUCT_EDGE_130_PLUS",
    3570  -> "FIT_GARMIN_PRODUCT_EDGE_1030_PLUS",
    3578  -> "FIT_GARMIN_PRODUCT_RALLY_200",
    3589  -> "FIT_GARMIN_PRODUCT_FR745",
    3600  -> "FIT_GARMIN_PRODUCT_VENUSQ",
    3615  -> "FIT_GARMIN_PRODUCT_LILY",
    3624  -> "FIT_GARMIN_PRODUCT_MARQ_ADVENTURER",
    3638  -> "FIT_GARMIN_PRODUCT_ENDURO",
    3639  -> "FIT_GARMIN_PRODUCT_SWIM2_APAC",
    3648  -> "FIT_GARMIN_PRODUCT_MARQ_ADVENTURER_ASIA",
    3652  -> "FIT_GARMIN_PRODUCT_FR945_LTE",
    3702  -> "FIT_GARMIN_PRODUCT_DESCENT_MK2_ASIA",
    3703  -> "FIT_GARMIN_PRODUCT_VENU2",
    3704  -> "FIT_GARMIN_PRODUCT_VENU2S",
    3737  -> "FIT_GARMIN_PRODUCT_VENU_DAIMLER_ASIA",
    3739  -> "FIT_GARMIN_PRODUCT_MARQ_GOLFER",
    3740  -> "FIT_GARMIN_PRODUCT_VENU_DAIMLER",
    3794  -> "FIT_GARMIN_PRODUCT_FR745_ASIA",
    3809  -> "FIT_GARMIN_PRODUCT_LILY_ASIA",
    3812  -> "FIT_GARMIN_PRODUCT_EDGE_1030_PLUS_ASIA",
    3813  -> "FIT_GARMIN_PRODUCT_EDGE_130_PLUS_ASIA",
    3823  -> "FIT_GARMIN_PRODUCT_APPROACH_S12",
    3872  -> "FIT_GARMIN_PRODUCT_ENDURO_ASIA",
    3837  -> "FIT_GARMIN_PRODUCT_VENUSQ_ASIA",
    3843  -> "FIT_GARMIN_PRODUCT_EDGE_1040",
    3850  -> "FIT_GARMIN_PRODUCT_MARQ_GOLFER_ASIA",
    3851  -> "FIT_GARMIN_PRODUCT_VENU2_PLUS",
    3869  -> "FIT_GARMIN_PRODUCT_FR55",
    3888  -> "FIT_GARMIN_PRODUCT_INSTINCT_2",
    3905  -> "FIT_GARMIN_PRODUCT_FENIX7S",
    3906  -> "FIT_GARMIN_PRODUCT_FENIX7",
    3907  -> "FIT_GARMIN_PRODUCT_FENIX7X",
    3908  -> "FIT_GARMIN_PRODUCT_FENIX7S_APAC",
    3909  -> "FIT_GARMIN_PRODUCT_FENIX7_APAC",
    3910  -> "FIT_GARMIN_PRODUCT_FENIX7X_APAC",
    3930  -> "FIT_GARMIN_PRODUCT_DESCENT_MK2S_ASIA",
    3934  -> "FIT_GARMIN_PRODUCT_APPROACH_S42",
    3943  -> "FIT_GARMIN_PRODUCT_EPIX_GEN2",
    3944  -> "FIT_GARMIN_PRODUCT_EPIX_GEN2_APAC",
    3949  -> "FIT_GARMIN_PRODUCT_VENU2S_ASIA",
    3950  -> "FIT_GARMIN_PRODUCT_VENU2_ASIA",
    3978  -> "FIT_GARMIN_PRODUCT_FR945_LTE_ASIA",
    3982  -> "FIT_GARMIN_PRODUCT_VIVO_MOVE_SPORT",
    3986  -> "FIT_GARMIN_PRODUCT_APPROACH_S12_ASIA",
    3990  -> "FIT_GARMIN_PRODUCT_FR255_MUSIC",
    3991  -> "FIT_GARMIN_PRODUCT_FR255_SMALL_MUSIC",
    3992  -> "FIT_GARMIN_PRODUCT_FR255",
    3993  -> "FIT_GARMIN_PRODUCT_FR255_SMALL",
    4002  -> "FIT_GARMIN_PRODUCT_APPROACH_S42_ASIA",
    4005  -> "FIT_GARMIN_PRODUCT_DESCENT_G1",
    4017  -> "FIT_GARMIN_PRODUCT_VENU2_PLUS_ASIA",
    4024  -> "FIT_GARMIN_PRODUCT_FR955",
    4033  -> "FIT_GARMIN_PRODUCT_FR55_ASIA",
    4063  -> "FIT_GARMIN_PRODUCT_VIVOSMART_5",
    4071  -> "FIT_GARMIN_PRODUCT_INSTINCT_2_ASIA",
    4115  -> "FIT_GARMIN_PRODUCT_VENUSQ2",
    4116  -> "FIT_GARMIN_PRODUCT_VENUSQ2MUSIC",
    4125  -> "FIT_GARMIN_PRODUCT_D2_AIR_X10",
    4130  -> "FIT_GARMIN_PRODUCT_HRM_PRO_PLUS",
    4132  -> "FIT_GARMIN_PRODUCT_DESCENT_G1_ASIA",
    4135  -> "FIT_GARMIN_PRODUCT_TACTIX7",
    4169  -> "FIT_GARMIN_PRODUCT_EDGE_EXPLORE2",
    4265  -> "FIT_GARMIN_PRODUCT_TACX_NEO_SMART",
    4266  -> "FIT_GARMIN_PRODUCT_TACX_NEO2_SMART",
    4267  -> "FIT_GARMIN_PRODUCT_TACX_NEO2_T_SMART",
    4268  -> "FIT_GARMIN_PRODUCT_TACX_NEO_SMART_BIKE",
    4269  -> "FIT_GARMIN_PRODUCT_TACX_SATORI_SMART",
    4270  -> "FIT_GARMIN_PRODUCT_TACX_FLOW_SMART",
    4271  -> "FIT_GARMIN_PRODUCT_TACX_VORTEX_SMART",
    4272  -> "FIT_GARMIN_PRODUCT_TACX_BUSHIDO_SMART",
    4273  -> "FIT_GARMIN_PRODUCT_TACX_GENIUS_SMART",
    4274  -> "FIT_GARMIN_PRODUCT_TACX_FLUX_FLUX_S_SMART",
    4275  -> "FIT_GARMIN_PRODUCT_TACX_FLUX2_SMART",
    4276  -> "FIT_GARMIN_PRODUCT_TACX_MAGNUM",
    4305  -> "FIT_GARMIN_PRODUCT_EDGE_1040_ASIA",
    4341  -> "FIT_GARMIN_PRODUCT_ENDURO2",
    10007 -> "FIT_GARMIN_PRODUCT_SDM4",
    10014 -> "FIT_GARMIN_PRODUCT_EDGE_REMOTE",
    20533 -> "FIT_GARMIN_PRODUCT_TACX_TRAINING_APP_WIN",
    20534 -> "FIT_GARMIN_PRODUCT_TACX_TRAINING_APP_MAC",
    20565 -> "FIT_GARMIN_PRODUCT_TACX_TRAINING_APP_MAC_CATALYST",
    20119 -> "FIT_GARMIN_PRODUCT_TRAINING_CENTER",
    30045 -> "FIT_GARMIN_PRODUCT_TACX_TRAINING_APP_ANDROID",
    30046 -> "FIT_GARMIN_PRODUCT_TACX_TRAINING_APP_IOS",
    30047 -> "FIT_GARMIN_PRODUCT_TACX_TRAINING_APP_LEGACY",
    65531 -> "FIT_GARMIN_PRODUCT_CONNECTIQ_SIMULATOR",
    65532 -> "FIT_GARMIN_PRODUCT_ANDROID_ANTPLUS_PLUGIN",
    65534 -> "FIT_GARMIN_PRODUCT_CONNECT"
|>;

$fitGarminProduct = toNiceCamelCase /@ removePrefix[ $fitGarminProduct0, "FIT_GARMIN_PRODUCT_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitHeartRateZoneCalc*)
fitHeartRateZoneCalc // ClearAll;
fitHeartRateZoneCalc[ n_Integer ] := Lookup[ $fitHeartRateZoneCalc, n, Missing[ "NotAvailable" ] ];
fitHeartRateZoneCalc[ ___ ] := Missing[ "NotAvailable" ];

$fitHeartRateZoneCalc0 = <|
    0 -> "FIT_HR_ZONE_CALC_CUSTOM",
    1 -> "FIT_HR_ZONE_CALC_PERCENT_MAX_HR",
    2 -> "FIT_HR_ZONE_CALC_PERCENT_HRR"
|>;

$fitHeartRateZoneCalc = toNiceCamelCase /@ removePrefix[ $fitHeartRateZoneCalc0, "FIT_HR_ZONE_CALC_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitPowerZoneCalc*)
fitPowerZoneCalc // ClearAll;
fitPowerZoneCalc[ n_Integer ] := Lookup[ $fitPowerZoneCalc, n, Missing[ "NotAvailable" ] ];
fitPowerZoneCalc[ ___ ] := Missing[ "NotAvailable" ];

$fitPowerZoneCalc0 = <|
    0 -> "FIT_PWR_ZONE_CALC_CUSTOM",
    1 -> "FIT_PWR_ZONE_CALC_PERCENT_FTP"
|>;

$fitPowerZoneCalc = toNiceCamelCase /@ removePrefix[ $fitPowerZoneCalc0, "FIT_PWR_ZONE_CALC_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitRadarThreatLevelType*)
fitRadarThreatLevelType // ClearAll;
fitRadarThreatLevelType[ n_Integer ] := Lookup[ $fitRadarThreatLevelType, n, Missing[ "NotAvailable" ] ];
fitRadarThreatLevelType[ ___ ] := Missing[ "NotAvailable" ];

$fitRadarThreatLevelType0 = <|
    0 -> "FIT_RADAR_THREAT_LEVEL_TYPE_THREAT_UNKNOWN",
    1 -> "FIT_RADAR_THREAT_LEVEL_TYPE_THREAT_NONE",
    2 -> "FIT_RADAR_THREAT_LEVEL_TYPE_THREAT_APPROACHING",
    3 -> "FIT_RADAR_THREAT_LEVEL_TYPE_THREAT_APPROACHING_FAST"
|>;

$fitRadarThreatLevelType = toNiceCamelCase /@ removePrefix[ $fitRadarThreatLevelType0, "FIT_RADAR_THREAT_LEVEL_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFitBaseUnit*)
fitFitBaseUnit // ClearAll;
fitFitBaseUnit[ n_Integer ] := Lookup[ $fitFitBaseUnit, n, Missing[ "NotAvailable" ] ];
fitFitBaseUnit[ ___ ] := Missing[ "NotAvailable" ];

$fitFitBaseUnit0 = <|
    0 -> "FIT_FIT_BASE_UNIT_OTHER",
    1 -> "FIT_FIT_BASE_UNIT_KILOGRAM",
    2 -> "FIT_FIT_BASE_UNIT_POUND"
|>;

$fitFitBaseUnit = toNiceCamelCase /@ removePrefix[ $fitFitBaseUnit0, "FIT_FIT_BASE_UNIT_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFitBaseType*)
fitFitBaseType // ClearAll;
fitFitBaseType[ n_Integer ] := Lookup[ $fitFitBaseType, n, Missing[ "NotAvailable" ] ];
fitFitBaseType[ ___ ] := Missing[ "NotAvailable" ];

$fitFitBaseType0 = <|
    0   -> "FIT_FIT_BASE_TYPE_ENUM",
    1   -> "FIT_FIT_BASE_TYPE_SINT8",
    2   -> "FIT_FIT_BASE_TYPE_UINT8",
    131 -> "FIT_FIT_BASE_TYPE_SINT16",
    132 -> "FIT_FIT_BASE_TYPE_UINT16",
    133 -> "FIT_FIT_BASE_TYPE_SINT32",
    134 -> "FIT_FIT_BASE_TYPE_UINT32",
    7   -> "FIT_FIT_BASE_TYPE_STRING",
    136 -> "FIT_FIT_BASE_TYPE_FLOAT32",
    137 -> "FIT_FIT_BASE_TYPE_FLOAT64",
    10  -> "FIT_FIT_BASE_TYPE_UINT8Z",
    139 -> "FIT_FIT_BASE_TYPE_UINT16Z",
    140 -> "FIT_FIT_BASE_TYPE_UINT32Z",
    13  -> "FIT_FIT_BASE_TYPE_BYTE",
    142 -> "FIT_FIT_BASE_TYPE_SINT64",
    143 -> "FIT_FIT_BASE_TYPE_UINT64",
    144 -> "FIT_FIT_BASE_TYPE_UINT64Z"
|>;

$fitFitBaseType = removePrefix[ $fitFitBaseType0, "FIT_FIT_BASE_TYPE_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitFaveroProduct*)
fitFaveroProduct // ClearAll;
fitFaveroProduct[ n_Integer ] := Lookup[ $fitFaveroProduct, n, Missing[ "NotAvailable" ] ];
fitFaveroProduct[ ___ ] := Missing[ "NotAvailable" ];

$fitFaveroProduct0 = <|
    10 -> "FIT_FAVERO_PRODUCT_ASSIOMA_UNO",
    12 -> "FIT_FAVERO_PRODUCT_ASSIOMA_DUO"
|>;

$fitFaveroProduct = toNiceCamelCase /@ removePrefix[ $fitFaveroProduct0, "FIT_FAVERO_PRODUCT_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitExerciseCategory*)
fitExerciseCategory // ClearAll;
fitExerciseCategory[ n_Integer ] := Lookup[ $fitExerciseCategory, n, Missing[ "NotAvailable" ] ];
fitExerciseCategory[ ___ ] := Missing[ "NotAvailable" ];

$fitExerciseCategory0 = <|
    0     -> "FIT_EXERCISE_CATEGORY_BENCH_PRESS",
    1     -> "FIT_EXERCISE_CATEGORY_CALF_RAISE",
    2     -> "FIT_EXERCISE_CATEGORY_CARDIO",
    3     -> "FIT_EXERCISE_CATEGORY_CARRY",
    4     -> "FIT_EXERCISE_CATEGORY_CHOP",
    5     -> "FIT_EXERCISE_CATEGORY_CORE",
    6     -> "FIT_EXERCISE_CATEGORY_CRUNCH",
    7     -> "FIT_EXERCISE_CATEGORY_CURL",
    8     -> "FIT_EXERCISE_CATEGORY_DEADLIFT",
    9     -> "FIT_EXERCISE_CATEGORY_FLYE",
    10    -> "FIT_EXERCISE_CATEGORY_HIP_RAISE",
    11    -> "FIT_EXERCISE_CATEGORY_HIP_STABILITY",
    12    -> "FIT_EXERCISE_CATEGORY_HIP_SWING",
    13    -> "FIT_EXERCISE_CATEGORY_HYPEREXTENSION",
    14    -> "FIT_EXERCISE_CATEGORY_LATERAL_RAISE",
    15    -> "FIT_EXERCISE_CATEGORY_LEG_CURL",
    16    -> "FIT_EXERCISE_CATEGORY_LEG_RAISE",
    17    -> "FIT_EXERCISE_CATEGORY_LUNGE",
    18    -> "FIT_EXERCISE_CATEGORY_OLYMPIC_LIFT",
    19    -> "FIT_EXERCISE_CATEGORY_PLANK",
    20    -> "FIT_EXERCISE_CATEGORY_PLYO",
    21    -> "FIT_EXERCISE_CATEGORY_PULL_UP",
    22    -> "FIT_EXERCISE_CATEGORY_PUSH_UP",
    23    -> "FIT_EXERCISE_CATEGORY_ROW",
    24    -> "FIT_EXERCISE_CATEGORY_SHOULDER_PRESS",
    25    -> "FIT_EXERCISE_CATEGORY_SHOULDER_STABILITY",
    26    -> "FIT_EXERCISE_CATEGORY_SHRUG",
    27    -> "FIT_EXERCISE_CATEGORY_SIT_UP",
    28    -> "FIT_EXERCISE_CATEGORY_SQUAT",
    29    -> "FIT_EXERCISE_CATEGORY_TOTAL_BODY",
    30    -> "FIT_EXERCISE_CATEGORY_TRICEPS_EXTENSION",
    31    -> "FIT_EXERCISE_CATEGORY_WARM_UP",
    32    -> "FIT_EXERCISE_CATEGORY_RUN",
    65534 -> "FIT_EXERCISE_CATEGORY_UNKNOWN"
|>;

$fitExerciseCategory = toNiceCamelCase /@ removePrefix[ $fitExerciseCategory0, "FIT_EXERCISE_CATEGORY_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWorkoutStepDuration*)
fitWorkoutStepDuration // ClearAll;
fitWorkoutStepDuration[ n_Integer ] := Lookup[ $fitWorkoutStepDuration, n, Missing[ "NotAvailable" ] ];
fitWorkoutStepDuration[ ___ ] := Missing[ "NotAvailable" ];

$fitWorkoutStepDuration0 = <|
    0  -> "FIT_WKT_STEP_DURATION_TIME",
    1  -> "FIT_WKT_STEP_DURATION_DISTANCE",
    2  -> "FIT_WKT_STEP_DURATION_HR_LESS_THAN",
    3  -> "FIT_WKT_STEP_DURATION_HR_GREATER_THAN",
    4  -> "FIT_WKT_STEP_DURATION_CALORIES",
    5  -> "FIT_WKT_STEP_DURATION_OPEN",
    6  -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_STEPS_CMPLT",
    7  -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_TIME",
    8  -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_DISTANCE",
    9  -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_CALORIES",
    10 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_HR_LESS_THAN",
    11 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_HR_GREATER_THAN",
    12 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_POWER_LESS_THAN",
    13 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_POWER_GREATER_THAN",
    14 -> "FIT_WKT_STEP_DURATION_POWER_LESS_THAN",
    15 -> "FIT_WKT_STEP_DURATION_POWER_GREATER_THAN",
    16 -> "FIT_WKT_STEP_DURATION_TRAINING_PEAKS_TSS",
    17 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_POWER_LAST_LAP_LESS_THAN",
    18 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_MAX_POWER_LAST_LAP_LESS_THAN",
    19 -> "FIT_WKT_STEP_DURATION_POWER_3S_LESS_THAN",
    20 -> "FIT_WKT_STEP_DURATION_POWER_10S_LESS_THAN",
    21 -> "FIT_WKT_STEP_DURATION_POWER_30S_LESS_THAN",
    22 -> "FIT_WKT_STEP_DURATION_POWER_3S_GREATER_THAN",
    23 -> "FIT_WKT_STEP_DURATION_POWER_10S_GREATER_THAN",
    24 -> "FIT_WKT_STEP_DURATION_POWER_30S_GREATER_THAN",
    25 -> "FIT_WKT_STEP_DURATION_POWER_LAP_LESS_THAN",
    26 -> "FIT_WKT_STEP_DURATION_POWER_LAP_GREATER_THAN",
    27 -> "FIT_WKT_STEP_DURATION_REPEAT_UNTIL_TRAINING_PEAKS_TSS",
    28 -> "FIT_WKT_STEP_DURATION_REPETITION_TIME",
    29 -> "FIT_WKT_STEP_DURATION_REPS",
    31 -> "FIT_WKT_STEP_DURATION_TIME_ONLY"
|>;

$fitWorkoutStepDuration = toNiceCamelCase /@ removePrefix[ $fitWorkoutStepDuration0, "FIT_WKT_STEP_DURATION_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWorkoutStepTarget*)
fitWorkoutStepTarget // ClearAll;
fitWorkoutStepTarget[ n_Integer ] := Lookup[ $fitWorkoutStepTarget, n, Missing[ "NotAvailable" ] ];
fitWorkoutStepTarget[ ___ ] := Missing[ "NotAvailable" ];

$fitWorkoutStepTarget0 = <|
    0  -> "FIT_WKT_STEP_TARGET_SPEED",
    1  -> "FIT_WKT_STEP_TARGET_HEART_RATE",
    2  -> "FIT_WKT_STEP_TARGET_OPEN",
    3  -> "FIT_WKT_STEP_TARGET_CADENCE",
    4  -> "FIT_WKT_STEP_TARGET_POWER",
    5  -> "FIT_WKT_STEP_TARGET_GRADE",
    6  -> "FIT_WKT_STEP_TARGET_RESISTANCE",
    7  -> "FIT_WKT_STEP_TARGET_POWER_3S",
    8  -> "FIT_WKT_STEP_TARGET_POWER_10S",
    9  -> "FIT_WKT_STEP_TARGET_POWER_30S",
    10 -> "FIT_WKT_STEP_TARGET_POWER_LAP",
    11 -> "FIT_WKT_STEP_TARGET_SWIM_STROKE",
    12 -> "FIT_WKT_STEP_TARGET_SPEED_LAP",
    13 -> "FIT_WKT_STEP_TARGET_HEART_RATE_LAP"
|>;

$fitWorkoutStepTarget = toNiceCamelCase /@ removePrefix[ $fitWorkoutStepTarget0, "FIT_WKT_STEP_TARGET_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWorkoutEquipment*)
fitWorkoutEquipment // ClearAll;
fitWorkoutEquipment[ n_Integer ] := Lookup[ $fitWorkoutEquipment, n, Missing[ "NotAvailable" ] ];
fitWorkoutEquipment[ ___ ] := Missing[ "NotAvailable" ];

$fitWorkoutEquipment0 = <|
    0 -> "FIT_WORKOUT_EQUIPMENT_NONE",
    1 -> "FIT_WORKOUT_EQUIPMENT_SWIM_FINS",
    2 -> "FIT_WORKOUT_EQUIPMENT_SWIM_KICKBOARD",
    3 -> "FIT_WORKOUT_EQUIPMENT_SWIM_PADDLES",
    4 -> "FIT_WORKOUT_EQUIPMENT_SWIM_PULL_BUOY",
    5 -> "FIT_WORKOUT_EQUIPMENT_SWIM_SNORKEL"
|>;

$fitWorkoutEquipment = toNiceCamelCase /@ removePrefix[ $fitWorkoutEquipment0, "FIT_WORKOUT_EQUIPMENT_" ];

(* ::**********************************************************************:: *)
(* ::Subsubsection::Closed:: *)
(*fitWorkoutCapabilities*)
fitWorkoutCapabilities // ClearAll;
fitWorkoutCapabilities[ n_Integer ] := Lookup[ $fitWorkoutCapabilities, n, Missing[ "NotAvailable" ] ];
fitWorkoutCapabilities[ ___ ] := Missing[ "NotAvailable" ];

$fitWorkoutCapabilities0 = <|
    1     -> "FIT_WORKOUT_CAPABILITIES_INTERVAL",
    2     -> "FIT_WORKOUT_CAPABILITIES_CUSTOM",
    4     -> "FIT_WORKOUT_CAPABILITIES_FITNESS_EQUIPMENT",
    8     -> "FIT_WORKOUT_CAPABILITIES_FIRSTBEAT",
    16    -> "FIT_WORKOUT_CAPABILITIES_NEW_LEAF",
    32    -> "FIT_WORKOUT_CAPABILITIES_TCX",
    128   -> "FIT_WORKOUT_CAPABILITIES_SPEED",
    256   -> "FIT_WORKOUT_CAPABILITIES_HEART_RATE",
    512   -> "FIT_WORKOUT_CAPABILITIES_DISTANCE",
    1024  -> "FIT_WORKOUT_CAPABILITIES_CADENCE",
    2048  -> "FIT_WORKOUT_CAPABILITIES_POWER",
    4096  -> "FIT_WORKOUT_CAPABILITIES_GRADE",
    8192  -> "FIT_WORKOUT_CAPABILITIES_RESISTANCE",
    16384 -> "FIT_WORKOUT_CAPABILITIES_PROTECTED"
|>;

$fitWorkoutCapabilities = toNiceCamelCase /@ removePrefix[ $fitWorkoutCapabilities0, "FIT_WORKOUT_CAPABILITIES_" ];

(* ::**********************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
End[ ];
EndPackage[ ];
