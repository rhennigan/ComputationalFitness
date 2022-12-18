(* This file is auto-generated. Do not edit manually. *)
<|
    "AccelerometerData" -> <|
        "MessageName"   -> "AccelerometerData",
        "MessageNumber" -> 165,
        "Size"          -> 13,
        "Fields"        -> <|
            "AccelerationX" -> <|
                "Comment"         -> "1 * counts + 0, These are the raw ADC reading. Maximum number of samples is 30 in each message. The samples may span across seconds. A conversion will need to be done on this data once read.",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "AccelerationX",
                "Index"           -> 8;;8,
                "Interpreter"     -> "fitUINT16A",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "accel_x",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AccelerationY" -> <|
                "Comment"         -> "1 * counts + 0, These are the raw ADC reading. Maximum number of samples is 30 in each message. The samples may span across seconds. A conversion will need to be done on this data once read.",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "AccelerationY",
                "Index"           -> 9;;9,
                "Interpreter"     -> "fitUINT16A",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "accel_y",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AccelerationZ" -> <|
                "Comment"         -> "1 * counts + 0, These are the raw ADC reading. Maximum number of samples is 30 in each message. The samples may span across seconds. A conversion will need to be done on this data once read.",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "AccelerationZ",
                "Index"           -> 10;;10,
                "Interpreter"     -> "fitUINT16A",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "accel_z",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "CalibratedAccelerationX" -> <|
                "Comment"         -> "1 * g + 0, Calibrated accel reading",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "CalibratedAccelerationX",
                "Index"           -> 3;;3,
                "Interpreter"     -> "fitFloat32A",
                "Invalid"         -> -9223372036854775808,
                "NativeFieldName" -> "calibrated_accel_x",
                "NativeType"      -> "FIT_FLOAT32",
                "Type"            -> "Real32"
            |>
            ,
            "CalibratedAccelerationY" -> <|
                "Comment"         -> "1 * g + 0, Calibrated accel reading",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "CalibratedAccelerationY",
                "Index"           -> 4;;4,
                "Interpreter"     -> "fitFloat32A",
                "Invalid"         -> -9223372036854775808,
                "NativeFieldName" -> "calibrated_accel_y",
                "NativeType"      -> "FIT_FLOAT32",
                "Type"            -> "Real32"
            |>
            ,
            "CalibratedAccelerationZ" -> <|
                "Comment"         -> "1 * g + 0, Calibrated accel reading",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "CalibratedAccelerationZ",
                "Index"           -> 5;;5,
                "Interpreter"     -> "fitFloat32A",
                "Invalid"         -> -9223372036854775808,
                "NativeFieldName" -> "calibrated_accel_z",
                "NativeType"      -> "FIT_FLOAT32",
                "Type"            -> "Real32"
            |>
            ,
            "CompressedCalibratedAccelerationX" -> <|
                "Comment"         -> "1 * mG + 0, Calibrated accel reading",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "CompressedCalibratedAccelerationX",
                "Index"           -> 11;;11,
                "Interpreter"     -> "fitSINT16A",
                "Invalid"         -> 32767,
                "NativeFieldName" -> "compressed_calibrated_accel_x",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "CompressedCalibratedAccelerationY" -> <|
                "Comment"         -> "1 * mG + 0, Calibrated accel reading",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "CompressedCalibratedAccelerationY",
                "Index"           -> 12;;12,
                "Interpreter"     -> "fitSINT16A",
                "Invalid"         -> 32767,
                "NativeFieldName" -> "compressed_calibrated_accel_y",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "CompressedCalibratedAccelerationZ" -> <|
                "Comment"         -> "1 * mG + 0, Calibrated accel reading",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "CompressedCalibratedAccelerationZ",
                "Index"           -> 13;;13,
                "Interpreter"     -> "fitSINT16A",
                "Invalid"         -> 32767,
                "NativeFieldName" -> "compressed_calibrated_accel_z",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "SampleTimeOffset" -> <|
                "Comment"         -> "1 * ms + 0, Each time in the array describes the time at which the accelerometer sample with the corrosponding index was taken. Limited to 30 samples in each message. The samples may span across seconds. Array size must match the number of samples in accel_x and accel_y and accel_z",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "SampleTimeOffset",
                "Index"           -> 7;;7,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Seconds", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "sample_time_offset",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0, Whole second part of the timestamp",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "TimestampMilliseconds" -> <|
                "Comment"         -> "1 * ms + 0, Millisecond part of the timestamp.",
                "Dimensions"      -> { },
                "FieldName"       -> "TimestampMilliseconds",
                "Index"           -> 6,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Seconds", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "timestamp_ms",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
        |>
    |>
    ,
    "Activity" -> <|
        "MessageName"   -> "Activity",
        "MessageNumber" -> 34,
        "Size"          -> 9,
        "Fields"        -> <|
            "Event" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Event",
                "Index"           -> 7,
                "Interpreter"     -> { "fitEnum", "Event" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "event",
                "NativeType"      -> "FIT_EVENT",
                "Type"            -> "Event"
            |>
            ,
            "EventGroup" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "EventGroup",
                "Index"           -> 9,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "event_group",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "EventType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "EventType",
                "Index"           -> 8,
                "Interpreter"     -> { "fitEnum", "EventType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "event_type",
                "NativeType"      -> "FIT_EVENT_TYPE",
                "Type"            -> "EventType"
            |>
            ,
            "LocalTimestamp" -> <|
                "Comment"         -> "timestamp epoch expressed in local time, used to convert activity timestamps to local time",
                "Dimensions"      -> { },
                "FieldName"       -> "LocalTimestamp",
                "Index"           -> 4,
                "Interpreter"     -> "fitLocalTimestamp",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "local_timestamp",
                "NativeType"      -> "FIT_LOCAL_DATE_TIME",
                "Type"            -> "LocalDateTime"
            |>
            ,
            "NumberOfSessions" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "NumberOfSessions",
                "Index"           -> 5,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "num_sessions",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Timestamp" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "TotalTimerTime" -> <|
                "Comment"         -> "1000 * s + 0, Exclude pauses",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalTimerTime",
                "Index"           -> 3,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_timer_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Type" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Type",
                "Index"           -> 6,
                "Interpreter"     -> { "fitEnum", "Activity" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "type",
                "NativeType"      -> "FIT_ACTIVITY",
                "Type"            -> "Activity"
            |>
        |>
    |>
    ,
    "ANTReceive" -> <|
        "MessageName"   -> "ANTReceive",
        "MessageNumber" -> 80,
        "Size"          -> 22,
        "Fields"        -> <|
            "ChannelNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ChannelNumber",
                "Index"           -> 22,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "channel_number",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Data" -> <|
                "Dimensions"      -> { 8 },
                "FieldName"       -> "Data",
                "Index"           -> 3;;10,
                "Interpreter"     -> "fitByteA",
                "Invalid"         -> 255,
                "NativeFieldName" -> "data",
                "NativeType"      -> "FIT_BYTE",
                "Type"            -> "Byte"
            |>
            ,
            "FractionalTimestamp" -> <|
                "Comment"         -> "32768 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "FractionalTimestamp",
                "Index"           -> 11,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "fractional_timestamp",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MessageData" -> <|
                "Dimensions"      -> { 9 },
                "FieldName"       -> "MessageData",
                "Index"           -> 13;;21,
                "Interpreter"     -> "fitByteA",
                "Invalid"         -> 255,
                "NativeFieldName" -> "mesg_data",
                "NativeType"      -> "FIT_BYTE",
                "Type"            -> "Byte"
            |>
            ,
            "MessageID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageID",
                "Index"           -> 12,
                "Interpreter"     -> "fitByte",
                "Invalid"         -> 255,
                "NativeFieldName" -> "mesg_id",
                "NativeType"      -> "FIT_BYTE",
                "Type"            -> "Byte"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
        |>
    |>
    ,
    "ANTTransmit" -> <|
        "MessageName"   -> "ANTTransmit",
        "MessageNumber" -> 81,
        "Size"          -> 22,
        "Fields"        -> <|
            "ChannelNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ChannelNumber",
                "Index"           -> 22,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "channel_number",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Data" -> <|
                "Dimensions"      -> { 8 },
                "FieldName"       -> "Data",
                "Index"           -> 3;;10,
                "Interpreter"     -> "fitByteA",
                "Invalid"         -> 255,
                "NativeFieldName" -> "data",
                "NativeType"      -> "FIT_BYTE",
                "Type"            -> "Byte"
            |>
            ,
            "FractionalTimestamp" -> <|
                "Comment"         -> "32768 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "FractionalTimestamp",
                "Index"           -> 11,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "fractional_timestamp",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MessageData" -> <|
                "Dimensions"      -> { 9 },
                "FieldName"       -> "MessageData",
                "Index"           -> 13;;21,
                "Interpreter"     -> "fitByteA",
                "Invalid"         -> 255,
                "NativeFieldName" -> "mesg_data",
                "NativeType"      -> "FIT_BYTE",
                "Type"            -> "Byte"
            |>
            ,
            "MessageID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageID",
                "Index"           -> 12,
                "Interpreter"     -> "fitByte",
                "Invalid"         -> 255,
                "NativeFieldName" -> "mesg_id",
                "NativeType"      -> "FIT_BYTE",
                "Type"            -> "Byte"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
        |>
    |>
    ,
    "AviationAttitude" -> <|
        "MessageName"   -> "AviationAttitude",
        "MessageNumber" -> 178,
        "Size"          -> 13,
        "Fields"        -> <|
            "AccelerationLateral" -> <|
                "Comment"         -> "100 * m/s^2 + 0, Range -78.4 to +78.4 (-8 Gs to 8 Gs)",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "AccelerationLateral",
                "Index"           -> 7;;7,
                "Interpreter"     -> "fitSINT16A",
                "Invalid"         -> 32767,
                "NativeFieldName" -> "accel_lateral",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AccelerationNormal" -> <|
                "Comment"         -> "100 * m/s^2 + 0, Range -78.4 to +78.4 (-8 Gs to 8 Gs)",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "AccelerationNormal",
                "Index"           -> 8;;8,
                "Interpreter"     -> "fitSINT16A",
                "Invalid"         -> 32767,
                "NativeFieldName" -> "accel_normal",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AttitudeStageComplete" -> <|
                "Comment"         -> "1 * % + 0, The percent complete of the current attitude stage. Set to 0 for attitude stages 0, 1 and 2 and to 100 for attitude stage 3 by AHRS modules that do not support it. Range - 100",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "AttitudeStageComplete",
                "Index"           -> 13;;13,
                "Interpreter"     -> { "fitQuantity", "fitUINT8A", "Percent", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "attitude_stage_complete",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Pitch" -> <|
                "Comment"         -> "10430.38 * radians + 0, Range -PI/2 to +PI/2",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "Pitch",
                "Index"           -> 5;;5,
                "Interpreter"     -> "fitSINT16A",
                "Invalid"         -> 32767,
                "NativeFieldName" -> "pitch",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "Roll" -> <|
                "Comment"         -> "10430.38 * radians + 0, Range -PI to +PI",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "Roll",
                "Index"           -> 6;;6,
                "Interpreter"     -> "fitSINT16A",
                "Invalid"         -> 32767,
                "NativeFieldName" -> "roll",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "Stage" -> <|
                "Dimensions"      -> { 1 },
                "FieldName"       -> "Stage",
                "Index"           -> 12;;12,
                "Interpreter"     -> { "fitEnum", "AttitudeStage" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "stage",
                "NativeType"      -> "FIT_ATTITUDE_STAGE",
                "Type"            -> "AttitudeStage"
            |>
            ,
            "SystemTime" -> <|
                "Comment"         -> "1 * ms + 0, System time associated with sample expressed in ms.",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "SystemTime",
                "Index"           -> 3;;3,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "system_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0, Timestamp message was output",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "TimestampMilliseconds" -> <|
                "Comment"         -> "1 * ms + 0, Fractional part of timestamp, added to timestamp",
                "Dimensions"      -> { },
                "FieldName"       -> "TimestampMilliseconds",
                "Index"           -> 4,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Seconds", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "timestamp_ms",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Track" -> <|
                "Comment"         -> "10430.38 * radians + 0, Track Angle/Heading Range 0 - 2pi",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "Track",
                "Index"           -> 10;;10,
                "Interpreter"     -> "fitUINT16A",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "track",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TurnRate" -> <|
                "Comment"         -> "1024 * radians/second + 0, Range -8.727 to +8.727 (-500 degs/sec to +500 degs/sec)",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "TurnRate",
                "Index"           -> 9;;9,
                "Interpreter"     -> "fitSINT16A",
                "Invalid"         -> 32767,
                "NativeFieldName" -> "turn_rate",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "Validity" -> <|
                "Dimensions"      -> { 1 },
                "FieldName"       -> "Validity",
                "Index"           -> 11;;11,
                "Interpreter"     -> { "fitEnum", "AttitudeValidity" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "validity",
                "NativeType"      -> "FIT_ATTITUDE_VALIDITY",
                "Type"            -> "AttitudeValidity"
            |>
        |>
    |>
    ,
    "BikeProfile" -> <|
        "MessageName"   -> "BikeProfile",
        "MessageNumber" -> 6,
        "Size"          -> 80,
        "Fields"        -> <|
            "AutomaticPowerZero" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "AutomaticPowerZero",
                "Index"           -> 47,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "auto_power_zero",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "AutomaticWheelCalibration" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "AutomaticWheelCalibration",
                "Index"           -> 46,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "auto_wheel_cal",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "AutomaticWheelSize" -> <|
                "Comment"         -> "1000 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AutomaticWheelSize",
                "Index"           -> 41,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "auto_wheelsize",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "BikeCadenceANTID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "BikeCadenceANTID",
                "Index"           -> 37,
                "Interpreter"     -> "fitUINT16Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "bike_cad_ant_id",
                "NativeType"      -> "FIT_UINT16Z",
                "Type"            -> "UnsignedInteger16Z"
            |>
            ,
            "BikeCadenceANTIDTransmissionType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "BikeCadenceANTIDTransmissionType",
                "Index"           -> 56,
                "Interpreter"     -> "fitUINT8Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "bike_cad_ant_id_trans_type",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "BikePowerANTID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "BikePowerANTID",
                "Index"           -> 39,
                "Interpreter"     -> "fitUINT16Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "bike_power_ant_id",
                "NativeType"      -> "FIT_UINT16Z",
                "Type"            -> "UnsignedInteger16Z"
            |>
            ,
            "BikePowerANTIDTransmissionType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "BikePowerANTIDTransmissionType",
                "Index"           -> 58,
                "Interpreter"     -> "fitUINT8Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "bike_power_ant_id_trans_type",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "BikeSpeedANTID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "BikeSpeedANTID",
                "Index"           -> 36,
                "Interpreter"     -> "fitUINT16Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "bike_spd_ant_id",
                "NativeType"      -> "FIT_UINT16Z",
                "Type"            -> "UnsignedInteger16Z"
            |>
            ,
            "BikeSpeedANTIDTransmissionType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "BikeSpeedANTIDTransmissionType",
                "Index"           -> 55,
                "Interpreter"     -> "fitUINT8Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "bike_spd_ant_id_trans_type",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "BikeSpeedCadenceANTID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "BikeSpeedCadenceANTID",
                "Index"           -> 38,
                "Interpreter"     -> "fitUINT16Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "bike_spdcad_ant_id",
                "NativeType"      -> "FIT_UINT16Z",
                "Type"            -> "UnsignedInteger16Z"
            |>
            ,
            "BikeSpeedCadenceANTIDTransmissionType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "BikeSpeedCadenceANTIDTransmissionType",
                "Index"           -> 57,
                "Interpreter"     -> "fitUINT8Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "bike_spdcad_ant_id_trans_type",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "BikeWeight" -> <|
                "Comment"         -> "10 * kg + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "BikeWeight",
                "Index"           -> 42,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Grams", 0.01, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "bike_weight",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "CadenceEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "CadenceEnabled",
                "Index"           -> 50,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "cad_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "CrankLength" -> <|
                "Comment"         -> "2 * mm + -110",
                "Dimensions"      -> { },
                "FieldName"       -> "CrankLength",
                "Index"           -> 53,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Meters", 2000, -110 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "crank_length",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "CustomWheelSize" -> <|
                "Comment"         -> "1000 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "CustomWheelSize",
                "Index"           -> 40,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "custom_wheelsize",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Enabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Enabled",
                "Index"           -> 54,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "FrontGear" -> <|
                "Comment"         -> "Number of teeth on each gear 0 is innermost",
                "Dimensions"      -> { 3 },
                "FieldName"       -> "FrontGear",
                "Index"           -> 61;;63,
                "Interpreter"     -> "fitUINT8ZA",
                "Invalid"         -> 0,
                "NativeFieldName" -> "front_gear",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "FrontGearNumber" -> <|
                "Comment"         -> "Number of front gears",
                "Dimensions"      -> { },
                "FieldName"       -> "FrontGearNumber",
                "Index"           -> 60,
                "Interpreter"     -> "fitUINT8Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "front_gear_num",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "ID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ID",
                "Index"           -> 48,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "id",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 35,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Name" -> <|
                "Dimensions"      -> { 32 },
                "FieldName"       -> "Name",
                "Index"           -> 2;;33,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "Odometer" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Odometer",
                "Index"           -> 34,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 100, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "odometer",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "OdometerRollover" -> <|
                "Comment"         -> "Rollover counter that can be used to extend the odometer",
                "Dimensions"      -> { },
                "FieldName"       -> "OdometerRollover",
                "Index"           -> 59,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "odometer_rollover",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "PowerCalibrationFactor" -> <|
                "Comment"         -> "10 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "PowerCalibrationFactor",
                "Index"           -> 43,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 10, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "power_cal_factor",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "PowerEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "PowerEnabled",
                "Index"           -> 52,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "power_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "RearGear" -> <|
                "Comment"         -> "Number of teeth on each gear 0 is innermost",
                "Dimensions"      -> { 15 },
                "FieldName"       -> "RearGear",
                "Index"           -> 65;;79,
                "Interpreter"     -> "fitUINT8ZA",
                "Invalid"         -> 0,
                "NativeFieldName" -> "rear_gear",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "RearGearNumber" -> <|
                "Comment"         -> "Number of rear gears",
                "Dimensions"      -> { },
                "FieldName"       -> "RearGearNumber",
                "Index"           -> 64,
                "Interpreter"     -> "fitUINT8Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "rear_gear_num",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "ShimanoDI2Enabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ShimanoDI2Enabled",
                "Index"           -> 80,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "shimano_di2_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "SpeedCadenceEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SpeedCadenceEnabled",
                "Index"           -> 51,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "spdcad_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "SpeedEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SpeedEnabled",
                "Index"           -> 49,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "spd_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "Sport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Sport",
                "Index"           -> 44,
                "Interpreter"     -> { "fitEnum", "Sport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sport",
                "NativeType"      -> "FIT_SPORT",
                "Type"            -> "Sport"
            |>
            ,
            "SubSport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SubSport",
                "Index"           -> 45,
                "Interpreter"     -> { "fitEnum", "SubSport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sub_sport",
                "NativeType"      -> "FIT_SUB_SPORT",
                "Type"            -> "SubSport"
            |>
        |>
    |>
    ,
    "BloodPressure" -> <|
        "MessageName"   -> "BloodPressure",
        "MessageNumber" -> 51,
        "Size"          -> 12,
        "Fields"        -> <|
            "DiastolicPressure" -> <|
                "Comment"         -> "1 * mmHg + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "DiastolicPressure",
                "Index"           -> 4,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "diastolic_pressure",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "HeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "HeartRate",
                "Index"           -> 10,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "HeartRateType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "HeartRateType",
                "Index"           -> 11,
                "Interpreter"     -> { "fitEnum", "HeartRateType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "heart_rate_type",
                "NativeType"      -> "FIT_HR_TYPE",
                "Type"            -> "HeartRateType"
            |>
            ,
            "Map3SampleMean" -> <|
                "Comment"         -> "1 * mmHg + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Map3SampleMean",
                "Index"           -> 6,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "map_3_sample_mean",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MapEveningValues" -> <|
                "Comment"         -> "1 * mmHg + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MapEveningValues",
                "Index"           -> 8,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "map_evening_values",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MapMorningValues" -> <|
                "Comment"         -> "1 * mmHg + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MapMorningValues",
                "Index"           -> 7,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "map_morning_values",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MeanArterialPressure" -> <|
                "Comment"         -> "1 * mmHg + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MeanArterialPressure",
                "Index"           -> 5,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "mean_arterial_pressure",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Status" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Status",
                "Index"           -> 12,
                "Interpreter"     -> { "fitEnum", "BPStatus" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "status",
                "NativeType"      -> "FIT_BP_STATUS",
                "Type"            -> "BPStatus"
            |>
            ,
            "SystolicPressure" -> <|
                "Comment"         -> "1 * mmHg + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "SystolicPressure",
                "Index"           -> 3,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "systolic_pressure",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "UserProfileIndex" -> <|
                "Comment"         -> "Associates this blood pressure message to a user. This corresponds to the index of the user profile message in the blood pressure file.",
                "Dimensions"      -> { },
                "FieldName"       -> "UserProfileIndex",
                "Index"           -> 9,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "user_profile_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
        |>
    |>
    ,
    "CadenceZone" -> <|
        "MessageName"   -> "CadenceZone",
        "MessageNumber" -> 131,
        "Size"          -> 19,
        "Fields"        -> <|
            "HighValue" -> <|
                "Comment"         -> "1 * rpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "HighValue",
                "Index"           -> 19,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "high_value",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 18,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Name" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "Name",
                "Index"           -> 2;;17,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
        |>
    |>
    ,
    "Capabilities" -> <|
        "MessageName"   -> "Capabilities",
        "MessageNumber" -> 1,
        "Size"          -> 8,
        "Fields"        -> <|
            "ConnectivitySupported" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ConnectivitySupported",
                "Index"           -> 7,
                "Interpreter"     -> { "fitEnum", "ConnectivityCapabilities" },
                "Invalid"         -> 0,
                "NativeFieldName" -> "connectivity_supported",
                "NativeType"      -> "FIT_CONNECTIVITY_CAPABILITIES",
                "Type"            -> "ConnectivityCapabilities"
            |>
            ,
            "Languages" -> <|
                "Comment"         -> "Use language_bits_x types where x is index of array.",
                "Dimensions"      -> { 4 },
                "FieldName"       -> "Languages",
                "Index"           -> 2;;5,
                "Interpreter"     -> "fitUINT8ZA",
                "Invalid"         -> 0,
                "NativeFieldName" -> "languages",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "Sports" -> <|
                "Comment"         -> "Use sport_bits_x types where x is index of array.",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "Sports",
                "Index"           -> 8;;8,
                "Interpreter"     -> { "fitEnum", "SportBits0" },
                "Invalid"         -> 0,
                "NativeFieldName" -> "sports",
                "NativeType"      -> "FIT_SPORT_BITS_0",
                "Type"            -> "SportBits0"
            |>
            ,
            "WorkoutsSupported" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "WorkoutsSupported",
                "Index"           -> 6,
                "Interpreter"     -> { "fitEnum", "WorkoutCapabilities" },
                "Invalid"         -> 0,
                "NativeFieldName" -> "workouts_supported",
                "NativeType"      -> "FIT_WORKOUT_CAPABILITIES",
                "Type"            -> "WorkoutCapabilities"
            |>
        |>
    |>
    ,
    "Connectivity" -> <|
        "MessageName"   -> "Connectivity",
        "MessageNumber" -> 127,
        "Size"          -> 37,
        "Fields"        -> <|
            "ANTEnabled" -> <|
                "Comment"         -> "Use ANT for connectivity features",
                "Dimensions"      -> { },
                "FieldName"       -> "ANTEnabled",
                "Index"           -> 28,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "ant_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "AutomaticActivityUploadEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "AutomaticActivityUploadEnabled",
                "Index"           -> 32,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "auto_activity_upload_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "BluetoothEnabled" -> <|
                "Comment"         -> "Use Bluetooth for connectivity features",
                "Dimensions"      -> { },
                "FieldName"       -> "BluetoothEnabled",
                "Index"           -> 26,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "bluetooth_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "BluetoothLEEnabled" -> <|
                "Comment"         -> "Use Bluetooth Low Energy for connectivity features",
                "Dimensions"      -> { },
                "FieldName"       -> "BluetoothLEEnabled",
                "Index"           -> 27,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "bluetooth_le_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "CourseDownloadEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "CourseDownloadEnabled",
                "Index"           -> 33,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "course_download_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "GPSEphemerisDownloadEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "GPSEphemerisDownloadEnabled",
                "Index"           -> 35,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "gps_ephemeris_download_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "GroupTrackEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "GroupTrackEnabled",
                "Index"           -> 37,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "grouptrack_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "IncidentDetectionEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "IncidentDetectionEnabled",
                "Index"           -> 36,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "incident_detection_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "LiveTrackingEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "LiveTrackingEnabled",
                "Index"           -> 29,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "live_tracking_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "Name" -> <|
                "Dimensions"      -> { 24 },
                "FieldName"       -> "Name",
                "Index"           -> 2;;25,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "WeatherAlertsEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "WeatherAlertsEnabled",
                "Index"           -> 31,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "weather_alerts_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "WeatherConditionsEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "WeatherConditionsEnabled",
                "Index"           -> 30,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "weather_conditions_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "WorkoutDownloadEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "WorkoutDownloadEnabled",
                "Index"           -> 34,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "workout_download_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
        |>
    |>
    ,
    "Course" -> <|
        "MessageName"   -> "Course",
        "MessageNumber" -> 31,
        "Size"          -> 20,
        "Fields"        -> <|
            "Capabilities" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Capabilities",
                "Index"           -> 18,
                "Interpreter"     -> { "fitEnum", "CourseCapabilities" },
                "Invalid"         -> 0,
                "NativeFieldName" -> "capabilities",
                "NativeType"      -> "FIT_COURSE_CAPABILITIES",
                "Type"            -> "CourseCapabilities"
            |>
            ,
            "Name" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "Name",
                "Index"           -> 2;;17,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "Sport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Sport",
                "Index"           -> 19,
                "Interpreter"     -> { "fitEnum", "Sport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sport",
                "NativeType"      -> "FIT_SPORT",
                "Type"            -> "Sport"
            |>
            ,
            "SubSport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SubSport",
                "Index"           -> 20,
                "Interpreter"     -> { "fitEnum", "SubSport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sub_sport",
                "NativeType"      -> "FIT_SUB_SPORT",
                "Type"            -> "SubSport"
            |>
        |>
    |>
    ,
    "CoursePoint" -> <|
        "MessageName"   -> "CoursePoint",
        "MessageNumber" -> 32,
        "Size"          -> 24,
        "Fields"        -> <|
            "Distance" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Distance",
                "Index"           -> 5,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 100, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "distance",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Favorite" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Favorite",
                "Index"           -> 24,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "favorite",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 22,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Name" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "Name",
                "Index"           -> 6;;21,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "PositionLatitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "PositionLatitude",
                "Index"           -> 3,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "position_lat",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "PositionLongitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "PositionLongitude",
                "Index"           -> 4,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "position_long",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "Timestamp" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "Type" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Type",
                "Index"           -> 23,
                "Interpreter"     -> { "fitEnum", "CoursePoint" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "type",
                "NativeType"      -> "FIT_COURSE_POINT",
                "Type"            -> "CoursePoint"
            |>
        |>
    |>
    ,
    "DeveloperDataID" -> <|
        "MessageName"   -> "DeveloperDataID",
        "MessageNumber" -> 207,
        "Size"          -> 36,
        "Fields"        -> <|
            "ApplicationID" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "ApplicationID",
                "Index"           -> 18;;33,
                "Interpreter"     -> "fitByteA",
                "Invalid"         -> 255,
                "NativeFieldName" -> "application_id",
                "NativeType"      -> "FIT_BYTE",
                "Type"            -> "Byte"
            |>
            ,
            "ApplicationVersion" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ApplicationVersion",
                "Index"           -> 34,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "application_version",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "DeveloperDataIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DeveloperDataIndex",
                "Index"           -> 36,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "developer_data_index",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "DeveloperID" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "DeveloperID",
                "Index"           -> 2;;17,
                "Interpreter"     -> "fitByteA",
                "Invalid"         -> 255,
                "NativeFieldName" -> "developer_id",
                "NativeType"      -> "FIT_BYTE",
                "Type"            -> "Byte"
            |>
            ,
            "ManufacturerID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ManufacturerID",
                "Index"           -> 35,
                "Interpreter"     -> { "fitEnum", "Manufacturer" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "manufacturer_id",
                "NativeType"      -> "FIT_MANUFACTURER",
                "Type"            -> "Manufacturer"
            |>
        |>
    |>
    ,
    "DeviceAuxiliaryBatteryInformation" -> <|
        "MessageName"   -> "DeviceAuxiliaryBatteryInformation",
        "MessageNumber" -> 375,
        "Size"          -> 6,
        "Fields"        -> <|
            "BatteryIdentifier" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "BatteryIdentifier",
                "Index"           -> 6,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "battery_identifier",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "BatteryStatus" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "BatteryStatus",
                "Index"           -> 5,
                "Interpreter"     -> { "fitEnum", "BatteryStatus" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "battery_status",
                "NativeType"      -> "FIT_BATTERY_STATUS",
                "Type"            -> "BatteryStatus"
            |>
            ,
            "BatteryVoltage" -> <|
                "Comment"         -> "256 * V + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "BatteryVoltage",
                "Index"           -> 3,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Volts", 256, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "battery_voltage",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "DeviceIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DeviceIndex",
                "Index"           -> 4,
                "Interpreter"     -> { "fitEnum", "DeviceIndex" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "device_index",
                "NativeType"      -> "FIT_DEVICE_INDEX",
                "Type"            -> "DeviceIndex"
            |>
            ,
            "Timestamp" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
        |>
    |>
    ,
    "DeviceInformation" -> <|
        "MessageName"   -> "DeviceInformation",
        "MessageNumber" -> 23,
        "Size"          -> 58,
        "Fields"        -> <|
            "ANTDeviceNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ANTDeviceNumber",
                "Index"           -> 49,
                "Interpreter"     -> "fitUINT16Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "ant_device_number",
                "NativeType"      -> "FIT_UINT16Z",
                "Type"            -> "UnsignedInteger16Z"
            |>
            ,
            "ANTNetwork" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ANTNetwork",
                "Index"           -> 56,
                "Interpreter"     -> { "fitEnum", "ANTNetwork" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "ant_network",
                "NativeType"      -> "FIT_ANT_NETWORK",
                "Type"            -> "ANTNetwork"
            |>
            ,
            "ANTTransmissionType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ANTTransmissionType",
                "Index"           -> 55,
                "Interpreter"     -> "fitUINT8Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "ant_transmission_type",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "BatteryLevel" -> <|
                "Comment"         -> "1 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "BatteryLevel",
                "Index"           -> 58,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "battery_level",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "BatteryStatus" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "BatteryStatus",
                "Index"           -> 53,
                "Interpreter"     -> { "fitEnum", "BatteryStatus" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "battery_status",
                "NativeType"      -> "FIT_BATTERY_STATUS",
                "Type"            -> "BatteryStatus"
            |>
            ,
            "BatteryVoltage" -> <|
                "Comment"         -> "256 * V + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "BatteryVoltage",
                "Index"           -> 48,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Volts", 256, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "battery_voltage",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "CumulativeOperatingTime" -> <|
                "Comment"         -> "1 * s + 0, Reset by new battery or charge.",
                "Dimensions"      -> { },
                "FieldName"       -> "CumulativeOperatingTime",
                "Index"           -> 4,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "cum_operating_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Descriptor" -> <|
                "Comment"         -> "Used to describe the sensor or location",
                "Dimensions"      -> { 20 },
                "FieldName"       -> "Descriptor",
                "Index"           -> 5;;24,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "descriptor",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "DeviceIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DeviceIndex",
                "Index"           -> 50,
                "Interpreter"     -> { "fitEnum", "DeviceIndex" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "device_index",
                "NativeType"      -> "FIT_DEVICE_INDEX",
                "Type"            -> "DeviceIndex"
            |>
            ,
            "DeviceType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DeviceType",
                "Index"           -> 51,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "device_type",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "HardwareVersion" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "HardwareVersion",
                "Index"           -> 52,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "hardware_version",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Manufacturer" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Manufacturer",
                "Index"           -> 45,
                "Interpreter"     -> { "fitEnum", "Manufacturer" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "manufacturer",
                "NativeType"      -> "FIT_MANUFACTURER",
                "Type"            -> "Manufacturer"
            |>
            ,
            "Product" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Product",
                "Index"           -> 46,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "product",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "ProductName" -> <|
                "Comment"         -> "Optional free form string to indicate the devices name or model",
                "Dimensions"      -> { 20 },
                "FieldName"       -> "ProductName",
                "Index"           -> 25;;44,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "product_name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "SensorPosition" -> <|
                "Comment"         -> "Indicates the location of the sensor",
                "Dimensions"      -> { },
                "FieldName"       -> "SensorPosition",
                "Index"           -> 54,
                "Interpreter"     -> { "fitEnum", "BodyLocation" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sensor_position",
                "NativeType"      -> "FIT_BODY_LOCATION",
                "Type"            -> "BodyLocation"
            |>
            ,
            "SerialNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SerialNumber",
                "Index"           -> 3,
                "Interpreter"     -> "fitUINT32Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "serial_number",
                "NativeType"      -> "FIT_UINT32Z",
                "Type"            -> "UnsignedInteger32Z"
            |>
            ,
            "SoftwareVersion" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SoftwareVersion",
                "Index"           -> 47,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "software_version",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "SourceType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SourceType",
                "Index"           -> 57,
                "Interpreter"     -> { "fitEnum", "SourceType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "source_type",
                "NativeType"      -> "FIT_SOURCE_TYPE",
                "Type"            -> "SourceType"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
        |>
    |>
    ,
    "DeviceSettings" -> <|
        "MessageName"   -> "DeviceSettings",
        "MessageNumber" -> 2,
        "Size"          -> 18,
        "Fields"        -> <|
            "ActiveTimeZone" -> <|
                "Comment"         -> "Index into time zone arrays.",
                "Dimensions"      -> { },
                "FieldName"       -> "ActiveTimeZone",
                "Index"           -> 9,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "active_time_zone",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "ActivityTrackerEnabled" -> <|
                "Comment"         -> "Enabled state of the activity tracker functionality",
                "Dimensions"      -> { },
                "FieldName"       -> "ActivityTrackerEnabled",
                "Index"           -> 13,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "activity_tracker_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "AutoSyncMinimumSteps" -> <|
                "Comment"         -> "1 * steps + 0, Minimum steps before an autosync can occur",
                "Dimensions"      -> { },
                "FieldName"       -> "AutoSyncMinimumSteps",
                "Index"           -> 7,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "autosync_min_steps",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AutoSyncMinimumTime" -> <|
                "Comment"         -> "1 * minutes + 0, Minimum minutes before an autosync can occur",
                "Dimensions"      -> { },
                "FieldName"       -> "AutoSyncMinimumTime",
                "Index"           -> 8,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Seconds", 1 / 60, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "autosync_min_time",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "BacklightMode" -> <|
                "Comment"         -> "Mode for backlight",
                "Dimensions"      -> { },
                "FieldName"       -> "BacklightMode",
                "Index"           -> 12,
                "Interpreter"     -> { "fitEnum", "BacklightMode" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "backlight_mode",
                "NativeType"      -> "FIT_BACKLIGHT_MODE",
                "Type"            -> "BacklightMode"
            |>
            ,
            "ClockTime" -> <|
                "Comment"         -> "UTC timestamp used to set the devices clock and date",
                "Dimensions"      -> { },
                "FieldName"       -> "ClockTime",
                "Index"           -> 4,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "clock_time",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "DateMode" -> <|
                "Comment"         -> "Display mode for the date",
                "Dimensions"      -> { },
                "FieldName"       -> "DateMode",
                "Index"           -> 15,
                "Interpreter"     -> { "fitEnum", "DateMode" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "date_mode",
                "NativeType"      -> "FIT_DATE_MODE",
                "Type"            -> "DateMode"
            |>
            ,
            "DefaultPage" -> <|
                "Comment"         -> "Bitfield to indicate one page as default for each supported loop",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "DefaultPage",
                "Index"           -> 6;;6,
                "Interpreter"     -> "fitUINT16A",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "default_page",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "DisplayOrientation" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DisplayOrientation",
                "Index"           -> 16,
                "Interpreter"     -> { "fitEnum", "DisplayOrientation" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "display_orientation",
                "NativeType"      -> "FIT_DISPLAY_ORIENTATION",
                "Type"            -> "DisplayOrientation"
            |>
            ,
            "MountingSide" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MountingSide",
                "Index"           -> 17,
                "Interpreter"     -> { "fitEnum", "Side" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "mounting_side",
                "NativeType"      -> "FIT_SIDE",
                "Type"            -> "Side"
            |>
            ,
            "MoveAlertEnabled" -> <|
                "Comment"         -> "Enabled state of the move alert",
                "Dimensions"      -> { },
                "FieldName"       -> "MoveAlertEnabled",
                "Index"           -> 14,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "move_alert_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "PagesEnabled" -> <|
                "Comment"         -> "Bitfield to configure enabled screens for each supported loop",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "PagesEnabled",
                "Index"           -> 5;;5,
                "Interpreter"     -> "fitUINT16A",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "pages_enabled",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TapSensitivity" -> <|
                "Comment"         -> "Used to hold the tap threshold setting",
                "Dimensions"      -> { },
                "FieldName"       -> "TapSensitivity",
                "Index"           -> 18,
                "Interpreter"     -> { "fitEnum", "TapSensitivity" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "tap_sensitivity",
                "NativeType"      -> "FIT_TAP_SENSITIVITY",
                "Type"            -> "TapSensitivity"
            |>
            ,
            "TimeMode" -> <|
                "Comment"         -> "Display mode for the time",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "TimeMode",
                "Index"           -> 10;;10,
                "Interpreter"     -> { "fitEnum", "TimeMode" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "time_mode",
                "NativeType"      -> "FIT_TIME_MODE",
                "Type"            -> "TimeMode"
            |>
            ,
            "TimeOffset" -> <|
                "Comment"         -> "1 * s + 0, Offset from system time.",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "TimeOffset",
                "Index"           -> 3;;3,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_offset",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TimeZoneOffset" -> <|
                "Comment"         -> "4 * hr + 0, timezone offset in 1/4 hour increments",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "TimeZoneOffset",
                "Index"           -> 11;;11,
                "Interpreter"     -> "fitSINT8A",
                "Invalid"         -> 127,
                "NativeFieldName" -> "time_zone_offset",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "UTCOffset" -> <|
                "Comment"         -> "Offset from system time. Required to convert timestamp from system time to UTC.",
                "Dimensions"      -> { },
                "FieldName"       -> "UTCOffset",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "utc_offset",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
        |>
    |>
    ,
    "DiveSettings" -> <|
        "MessageName"   -> "DiveSettings",
        "MessageNumber" -> 258,
        "Size"          -> 18,
        "Fields"        -> <|
            "HeartRateSource" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "HeartRateSource",
                "Index"           -> 18,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "heart_rate_source",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Name" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "Name",
                "Index"           -> 2;;17,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
        |>
    |>
    ,
    "Event" -> <|
        "MessageName"   -> "Event",
        "MessageNumber" -> 21,
        "Size"          -> 15,
        "Fields"        -> <|
            "Data" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Data",
                "Index"           -> 3,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "data",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Data16" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Data16",
                "Index"           -> 4,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "data16",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Event" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Event",
                "Index"           -> 7,
                "Interpreter"     -> { "fitEnum", "Event" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "event",
                "NativeType"      -> "FIT_EVENT",
                "Type"            -> "Event"
            |>
            ,
            "EventGroup" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "EventGroup",
                "Index"           -> 9,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "event_group",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "EventType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "EventType",
                "Index"           -> 8,
                "Interpreter"     -> { "fitEnum", "EventType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "event_type",
                "NativeType"      -> "FIT_EVENT_TYPE",
                "Type"            -> "EventType"
            |>
            ,
            "FrontGear" -> <|
                "Comment"         -> "Do not populate directly. Autogenerated by decoder for gear_change subfield components. Number of front teeth.",
                "Dimensions"      -> { },
                "FieldName"       -> "FrontGear",
                "Index"           -> 11,
                "Interpreter"     -> "fitUINT8Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "front_gear",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "FrontGearNumber" -> <|
                "Comment"         -> "Do not populate directly. Autogenerated by decoder for gear_change subfield components. Front gear number. 1 is innermost.",
                "Dimensions"      -> { },
                "FieldName"       -> "FrontGearNumber",
                "Index"           -> 10,
                "Interpreter"     -> "fitUINT8Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "front_gear_num",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "OpponentScore" -> <|
                "Comment"         -> "Do not populate directly. Autogenerated by decoder for sport_point subfield components",
                "Dimensions"      -> { },
                "FieldName"       -> "OpponentScore",
                "Index"           -> 6,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "opponent_score",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "RadarThreatCount" -> <|
                "Comment"         -> "Do not populate directly. Autogenerated by decoder for threat_alert subfield components.",
                "Dimensions"      -> { },
                "FieldName"       -> "RadarThreatCount",
                "Index"           -> 15,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "radar_threat_count",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "RadarThreatLevelMaximum" -> <|
                "Comment"         -> "Do not populate directly. Autogenerated by decoder for threat_alert subfield components.",
                "Dimensions"      -> { },
                "FieldName"       -> "RadarThreatLevelMaximum",
                "Index"           -> 14,
                "Interpreter"     -> { "fitEnum", "RadarThreatLevelType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "radar_threat_level_max",
                "NativeType"      -> "FIT_RADAR_THREAT_LEVEL_TYPE",
                "Type"            -> "RadarThreatLevelType"
            |>
            ,
            "RearGear" -> <|
                "Comment"         -> "Do not populate directly. Autogenerated by decoder for gear_change subfield components. Number of rear teeth.",
                "Dimensions"      -> { },
                "FieldName"       -> "RearGear",
                "Index"           -> 13,
                "Interpreter"     -> "fitUINT8Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "rear_gear",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "RearGearNumber" -> <|
                "Comment"         -> "Do not populate directly. Autogenerated by decoder for gear_change subfield components. Rear gear number. 1 is innermost.",
                "Dimensions"      -> { },
                "FieldName"       -> "RearGearNumber",
                "Index"           -> 12,
                "Interpreter"     -> "fitUINT8Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "rear_gear_num",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "Score" -> <|
                "Comment"         -> "Do not populate directly. Autogenerated by decoder for sport_point subfield components",
                "Dimensions"      -> { },
                "FieldName"       -> "Score",
                "Index"           -> 5,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "score",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
        |>
    |>
    ,
    "ExerciseTitle" -> <|
        "MessageName"   -> "ExerciseTitle",
        "MessageNumber" -> 264,
        "Size"          -> 52,
        "Fields"        -> <|
            "ExerciseCategory" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ExerciseCategory",
                "Index"           -> 51,
                "Interpreter"     -> { "fitEnum", "ExerciseCategory" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "exercise_category",
                "NativeType"      -> "FIT_EXERCISE_CATEGORY",
                "Type"            -> "ExerciseCategory"
            |>
            ,
            "ExerciseName" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ExerciseName",
                "Index"           -> 52,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "exercise_name",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 50,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "WorkoutStepName" -> <|
                "Dimensions"      -> { 48 },
                "FieldName"       -> "WorkoutStepName",
                "Index"           -> 2;;49,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "wkt_step_name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
        |>
    |>
    ,
    "ExtendedDisplayDataConceptConfiguration" -> <|
        "MessageName"   -> "ExtendedDisplayDataConceptConfiguration",
        "MessageNumber" -> 202,
        "Size"          -> 12,
        "Fields"        -> <|
            "ConceptField" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ConceptField",
                "Index"           -> 3,
                "Interpreter"     -> "fitByte",
                "Invalid"         -> 255,
                "NativeFieldName" -> "concept_field",
                "NativeType"      -> "FIT_BYTE",
                "Type"            -> "Byte"
            |>
            ,
            "ConceptIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ConceptIndex",
                "Index"           -> 5,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "concept_index",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "ConceptKey" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ConceptKey",
                "Index"           -> 7,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "concept_key",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "DataPage" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DataPage",
                "Index"           -> 6,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "data_page",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "DataUnits" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DataUnits",
                "Index"           -> 9,
                "Interpreter"     -> { "fitEnum", "ExtendedDisplayDataUnits" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "data_units",
                "NativeType"      -> "FIT_EXD_DATA_UNITS",
                "Type"            -> "ExtendedDisplayDataUnits"
            |>
            ,
            "Descriptor" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Descriptor",
                "Index"           -> 11,
                "Interpreter"     -> { "fitEnum", "ExtendedDisplayDescriptors" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "descriptor",
                "NativeType"      -> "FIT_EXD_DESCRIPTORS",
                "Type"            -> "ExtendedDisplayDescriptors"
            |>
            ,
            "FieldID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "FieldID",
                "Index"           -> 4,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "field_id",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "IsSigned" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "IsSigned",
                "Index"           -> 12,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "is_signed",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "Qualifier" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Qualifier",
                "Index"           -> 10,
                "Interpreter"     -> { "fitEnum", "ExtendedDisplayQualifiers" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "qualifier",
                "NativeType"      -> "FIT_EXD_QUALIFIERS",
                "Type"            -> "ExtendedDisplayQualifiers"
            |>
            ,
            "Scaling" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Scaling",
                "Index"           -> 8,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "scaling",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "ScreenIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ScreenIndex",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "screen_index",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
        |>
    |>
    ,
    "ExtendedDisplayDataFieldConfiguration" -> <|
        "MessageName"   -> "ExtendedDisplayDataFieldConfiguration",
        "MessageNumber" -> 201,
        "Size"          -> 7,
        "Fields"        -> <|
            "ConceptCount" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ConceptCount",
                "Index"           -> 5,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "concept_count",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "ConceptField" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ConceptField",
                "Index"           -> 3,
                "Interpreter"     -> "fitByte",
                "Invalid"         -> 255,
                "NativeFieldName" -> "concept_field",
                "NativeType"      -> "FIT_BYTE",
                "Type"            -> "Byte"
            |>
            ,
            "DisplayType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DisplayType",
                "Index"           -> 6,
                "Interpreter"     -> { "fitEnum", "ExtendedDisplayDisplayType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "display_type",
                "NativeType"      -> "FIT_EXD_DISPLAY_TYPE",
                "Type"            -> "ExtendedDisplayDisplayType"
            |>
            ,
            "FieldID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "FieldID",
                "Index"           -> 4,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "field_id",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "ScreenIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ScreenIndex",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "screen_index",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Title" -> <|
                "Dimensions"      -> { 1 },
                "FieldName"       -> "Title",
                "Index"           -> 7;;7,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "title",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
        |>
    |>
    ,
    "ExtendedDisplayScreenConfiguration" -> <|
        "MessageName"   -> "ExtendedDisplayScreenConfiguration",
        "MessageNumber" -> 200,
        "Size"          -> 5,
        "Fields"        -> <|
            "FieldCount" -> <|
                "Comment"         -> "number of fields in screen",
                "Dimensions"      -> { },
                "FieldName"       -> "FieldCount",
                "Index"           -> 3,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "field_count",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Layout" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Layout",
                "Index"           -> 4,
                "Interpreter"     -> { "fitEnum", "ExtendedDisplayLayout" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "layout",
                "NativeType"      -> "FIT_EXD_LAYOUT",
                "Type"            -> "ExtendedDisplayLayout"
            |>
            ,
            "ScreenEnabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ScreenEnabled",
                "Index"           -> 5,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "screen_enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "ScreenIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ScreenIndex",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "screen_index",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
        |>
    |>
    ,
    "FieldCapabilities" -> <|
        "MessageName"   -> "FieldCapabilities",
        "MessageNumber" -> 39,
        "Size"          -> 6,
        "Fields"        -> <|
            "Count" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Count",
                "Index"           -> 4,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "FieldNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "FieldNumber",
                "Index"           -> 6,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "field_num",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "File" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "File",
                "Index"           -> 5,
                "Interpreter"     -> { "fitEnum", "File" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "file",
                "NativeType"      -> "FIT_FILE",
                "Type"            -> "File"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "MessageNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageNumber",
                "Index"           -> 3,
                "Interpreter"     -> { "fitEnum", "MessageNumber" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "mesg_num",
                "NativeType"      -> "FIT_MESG_NUM",
                "Type"            -> "MessageNumber"
            |>
        |>
    |>
    ,
    "FieldDescription" -> <|
        "MessageName"   -> "FieldDescription",
        "MessageNumber" -> 206,
        "Size"          -> 89,
        "Fields"        -> <|
            "DeveloperDataIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DeveloperDataIndex",
                "Index"           -> 84,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "developer_data_index",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "FieldDefinitionNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "FieldDefinitionNumber",
                "Index"           -> 85,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "field_definition_number",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "FieldName" -> <|
                "Dimensions"      -> { 64 },
                "FieldName"       -> "FieldName",
                "Index"           -> 2;;65,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "field_name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "FitBaseTypeID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "FitBaseTypeID",
                "Index"           -> 86,
                "Interpreter"     -> { "fitEnum", "FitBaseType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "fit_base_type_id",
                "NativeType"      -> "FIT_FIT_BASE_TYPE",
                "Type"            -> "FitBaseType"
            |>
            ,
            "FitBaseUnitID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "FitBaseUnitID",
                "Index"           -> 82,
                "Interpreter"     -> { "fitEnum", "FitBaseUnit" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "fit_base_unit_id",
                "NativeType"      -> "FIT_FIT_BASE_UNIT",
                "Type"            -> "FitBaseUnit"
            |>
            ,
            "NativeFieldNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "NativeFieldNumber",
                "Index"           -> 89,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "native_field_num",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "NativeMessageNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "NativeMessageNumber",
                "Index"           -> 83,
                "Interpreter"     -> { "fitEnum", "MessageNumber" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "native_mesg_num",
                "NativeType"      -> "FIT_MESG_NUM",
                "Type"            -> "MessageNumber"
            |>
            ,
            "Offset" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Offset",
                "Index"           -> 88,
                "Interpreter"     -> "fitSINT8",
                "Invalid"         -> 127,
                "NativeFieldName" -> "offset",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "Scale" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Scale",
                "Index"           -> 87,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "scale",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Units" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "Units",
                "Index"           -> 66;;81,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "units",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
        |>
    |>
    ,
    "FileCapabilities" -> <|
        "MessageName"   -> "FileCapabilities",
        "MessageNumber" -> 37,
        "Size"          -> 22,
        "Fields"        -> <|
            "Directory" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "Directory",
                "Index"           -> 2;;17,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "directory",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "Flags" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Flags",
                "Index"           -> 22,
                "Interpreter"     -> { "fitEnum", "FileFlags" },
                "Invalid"         -> 0,
                "NativeFieldName" -> "flags",
                "NativeType"      -> "FIT_FILE_FLAGS",
                "Type"            -> "FileFlags"
            |>
            ,
            "MaximumCount" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumCount",
                "Index"           -> 20,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumSize" -> <|
                "Comment"         -> "1 * bytes + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumSize",
                "Index"           -> 18,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "max_size",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 19,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Type" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Type",
                "Index"           -> 21,
                "Interpreter"     -> { "fitEnum", "File" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "type",
                "NativeType"      -> "FIT_FILE",
                "Type"            -> "File"
            |>
        |>
    |>
    ,
    "FileCreator" -> <|
        "MessageName"   -> "FileCreator",
        "MessageNumber" -> 49,
        "Size"          -> 3,
        "Fields"        -> <|
            "HardwareVersion" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "HardwareVersion",
                "Index"           -> 3,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "hardware_version",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "SoftwareVersion" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SoftwareVersion",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "software_version",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
        |>
    |>
    ,
    "FileID" -> <|
        "MessageName"   -> "FileID",
        "MessageNumber" -> 0,
        "Size"          -> 27,
        "Fields"        -> <|
            "Manufacturer" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Manufacturer",
                "Index"           -> 24,
                "Interpreter"     -> { "fitEnum", "Manufacturer" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "manufacturer",
                "NativeType"      -> "FIT_MANUFACTURER",
                "Type"            -> "Manufacturer"
            |>
            ,
            "Number" -> <|
                "Comment"         -> "Only set for files that are not created/erased.",
                "Dimensions"      -> { },
                "FieldName"       -> "Number",
                "Index"           -> 26,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "number",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Product" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Product",
                "Index"           -> 25,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "product",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "ProductName" -> <|
                "Comment"         -> "Optional free form string to indicate the devices name or model",
                "Dimensions"      -> { 20 },
                "FieldName"       -> "ProductName",
                "Index"           -> 4;;23,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "product_name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "SerialNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SerialNumber",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT32Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "serial_number",
                "NativeType"      -> "FIT_UINT32Z",
                "Type"            -> "UnsignedInteger32Z"
            |>
            ,
            "TimeCreated" -> <|
                "Comment"         -> "Only set for files that are can be created/erased.",
                "Dimensions"      -> { },
                "FieldName"       -> "TimeCreated",
                "Index"           -> 3,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "time_created",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "Type" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Type",
                "Index"           -> 27,
                "Interpreter"     -> { "fitEnum", "File" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "type",
                "NativeType"      -> "FIT_FILE",
                "Type"            -> "File"
            |>
        |>
    |>
    ,
    "Goal" -> <|
        "MessageName"   -> "Goal",
        "MessageNumber" -> 15,
        "Size"          -> 14,
        "Fields"        -> <|
            "Enabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Enabled",
                "Index"           -> 13,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "EndDate" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "EndDate",
                "Index"           -> 3,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "end_date",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 6,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Recurrence" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Recurrence",
                "Index"           -> 12,
                "Interpreter"     -> { "fitEnum", "GoalRecurrence" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "recurrence",
                "NativeType"      -> "FIT_GOAL_RECURRENCE",
                "Type"            -> "GoalRecurrence"
            |>
            ,
            "RecurrenceValue" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "RecurrenceValue",
                "Index"           -> 7,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "recurrence_value",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Repeat" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Repeat",
                "Index"           -> 11,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "repeat",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "Source" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Source",
                "Index"           -> 14,
                "Interpreter"     -> { "fitEnum", "GoalSource" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "source",
                "NativeType"      -> "FIT_GOAL_SOURCE",
                "Type"            -> "GoalSource"
            |>
            ,
            "Sport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Sport",
                "Index"           -> 8,
                "Interpreter"     -> { "fitEnum", "Sport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sport",
                "NativeType"      -> "FIT_SPORT",
                "Type"            -> "Sport"
            |>
            ,
            "StartDate" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "StartDate",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "start_date",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "SubSport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SubSport",
                "Index"           -> 9,
                "Interpreter"     -> { "fitEnum", "SubSport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sub_sport",
                "NativeType"      -> "FIT_SUB_SPORT",
                "Type"            -> "SubSport"
            |>
            ,
            "TargetValue" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "TargetValue",
                "Index"           -> 5,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "target_value",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Type" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Type",
                "Index"           -> 10,
                "Interpreter"     -> { "fitEnum", "Goal" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "type",
                "NativeType"      -> "FIT_GOAL",
                "Type"            -> "Goal"
            |>
            ,
            "Value" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Value",
                "Index"           -> 4,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "value",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
        |>
    |>
    ,
    "HeartRate" -> <|
        "MessageName"   -> "HeartRate",
        "MessageNumber" -> 132,
        "Size"          -> 7,
        "Fields"        -> <|
            "EventTimestamp" -> <|
                "Comment"         -> "1024 * s + 0",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "EventTimestamp",
                "Index"           -> 3;;3,
                "Interpreter"     -> "fitUINT32A",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "event_timestamp",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "EventTimestamp12" -> <|
                "Dimensions"      -> { 1 },
                "FieldName"       -> "EventTimestamp12",
                "Index"           -> 7;;7,
                "Interpreter"     -> "fitByteA",
                "Invalid"         -> 255,
                "NativeFieldName" -> "event_timestamp_12",
                "NativeType"      -> "FIT_BYTE",
                "Type"            -> "Byte"
            |>
            ,
            "FilteredBeatsPerMinute" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "FilteredBeatsPerMinute",
                "Index"           -> 6;;6,
                "Interpreter"     -> { "fitQuantity", "fitUINT8A", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "filtered_bpm",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "FractionalTimestamp" -> <|
                "Comment"         -> "32768 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "FractionalTimestamp",
                "Index"           -> 4,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "fractional_timestamp",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Time256" -> <|
                "Comment"         -> "256 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Time256",
                "Index"           -> 5,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "time256",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Timestamp" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
        |>
    |>
    ,
    "HeartRateMonitorProfile" -> <|
        "MessageName"   -> "HeartRateMonitorProfile",
        "MessageNumber" -> 4,
        "Size"          -> 6,
        "Fields"        -> <|
            "Enabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Enabled",
                "Index"           -> 4,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "HeartRateMonitorANTID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "HeartRateMonitorANTID",
                "Index"           -> 3,
                "Interpreter"     -> "fitUINT16Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "hrm_ant_id",
                "NativeType"      -> "FIT_UINT16Z",
                "Type"            -> "UnsignedInteger16Z"
            |>
            ,
            "HeartRateMonitorANTIDTransmissionType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "HeartRateMonitorANTIDTransmissionType",
                "Index"           -> 6,
                "Interpreter"     -> "fitUINT8Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "hrm_ant_id_trans_type",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "LogHeartRateVariability" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "LogHeartRateVariability",
                "Index"           -> 5,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "log_hrv",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
        |>
    |>
    ,
    "HeartRateVariability" -> <|
        "MessageName"   -> "HeartRateVariability",
        "MessageNumber" -> 78,
        "Size"          -> 2,
        "Fields"        -> <|
            "Time" -> <|
                "Comment"         -> "1000 * s + 0, Time between beats",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "Time",
                "Index"           -> 2;;2,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Seconds", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "time",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
        |>
    |>
    ,
    "HeartRateZone" -> <|
        "MessageName"   -> "HeartRateZone",
        "MessageNumber" -> 8,
        "Size"          -> 19,
        "Fields"        -> <|
            "HighBeatsPerMinute" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "HighBeatsPerMinute",
                "Index"           -> 19,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "high_bpm",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 18,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Name" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "Name",
                "Index"           -> 2;;17,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
        |>
    |>
    ,
    "Lap" -> <|
        "MessageName"   -> "Lap",
        "MessageNumber" -> 19,
        "Size"          -> 100,
        "Fields"        -> <|
            "AverageAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageAltitude",
                "Index"           -> 48,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 5, 500 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_altitude",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageAscentSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageAscentSpeed",
                "Index"           -> 81,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_vam",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageCadence" -> <|
                "Comment"         -> "1 * rpm + 0, total_cycles / total_timer_time if non_zero_avg_cadence otherwise total_cycles / total_elapsed_time",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageCadence",
                "Index"           -> 86,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageFractionalCadence" -> <|
                "Comment"         -> "128 * rpm + 0, fractional part of the avg_cadence",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageFractionalCadence",
                "Index"           -> 98,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 128, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_fractional_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageGrade",
                "Index"           -> 50,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AverageHeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageHeartRate",
                "Index"           -> 84,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageNegativeGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageNegativeGrade",
                "Index"           -> 52,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_neg_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AverageNegativeVerticalSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageNegativeVerticalSpeed",
                "Index"           -> 56,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_neg_vertical_speed",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AveragePositiveGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AveragePositiveGrade",
                "Index"           -> 51,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_pos_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AveragePositiveVerticalSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AveragePositiveVerticalSpeed",
                "Index"           -> 55,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_pos_vertical_speed",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AveragePower" -> <|
                "Comment"         -> "1 * watts + 0, total_power / total_timer_time if non_zero_avg_power otherwise total_power / total_elapsed_time",
                "Dimensions"      -> { },
                "FieldName"       -> "AveragePower",
                "Index"           -> 38,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageSaturatedHemoglobinPercent" -> <|
                "Comment"         -> "10 * % + 0, Avg percentage of hemoglobin saturated with oxygen",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "AverageSaturatedHemoglobinPercent",
                "Index"           -> 78;;78,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Percent", 10, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_saturated_hemoglobin_percent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageSpeed",
                "Index"           -> 36,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_speed",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageStanceTime" -> <|
                "Comment"         -> "10 * ms + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageStanceTime",
                "Index"           -> 73,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Seconds", 10000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_stance_time",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageStanceTimePercent" -> <|
                "Comment"         -> "100 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageStanceTimePercent",
                "Index"           -> 72,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_stance_time_percent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageStrokeDistance" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageStrokeDistance",
                "Index"           -> 46,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_stroke_distance",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageTemperature" -> <|
                "Comment"         -> "1 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageTemperature",
                "Index"           -> 95,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "DegreesCelsius", 1, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "avg_temperature",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "AverageTotalHemoglobinConcentration" -> <|
                "Comment"         -> "100 * g/dL + 0, Avg saturated and unsaturated hemoglobin",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "AverageTotalHemoglobinConcentration",
                "Index"           -> 75;;75,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Deciliters"^(-1) * "Grams", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_total_hemoglobin_conc",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageVerticalOscillation" -> <|
                "Comment"         -> "10 * mm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageVerticalOscillation",
                "Index"           -> 71,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_vertical_oscillation",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "EndPositionLatitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "EndPositionLatitude",
                "Index"           -> 6,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "end_position_lat",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "EndPositionLongitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "EndPositionLongitude",
                "Index"           -> 7,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "end_position_long",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "EnhancedAverageAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "EnhancedAverageAltitude",
                "Index"           -> 30,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 5, 500 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "enhanced_avg_altitude",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "EnhancedAverageSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "EnhancedAverageSpeed",
                "Index"           -> 28,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "enhanced_avg_speed",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "EnhancedMaximumAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "EnhancedMaximumAltitude",
                "Index"           -> 32,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 5, 500 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "enhanced_max_altitude",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "EnhancedMaximumSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "EnhancedMaximumSpeed",
                "Index"           -> 29,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "enhanced_max_speed",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "EnhancedMinimumAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "EnhancedMinimumAltitude",
                "Index"           -> 31,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 5, 500 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "enhanced_min_altitude",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Event" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Event",
                "Index"           -> 82,
                "Interpreter"     -> { "fitEnum", "Event" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "event",
                "NativeType"      -> "FIT_EVENT",
                "Type"            -> "Event"
            |>
            ,
            "EventGroup" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "EventGroup",
                "Index"           -> 91,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "event_group",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "EventType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "EventType",
                "Index"           -> 83,
                "Interpreter"     -> { "fitEnum", "EventType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "event_type",
                "NativeType"      -> "FIT_EVENT_TYPE",
                "Type"            -> "EventType"
            |>
            ,
            "FirstLengthIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "FirstLengthIndex",
                "Index"           -> 45,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "first_length_index",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "GPSAccuracy" -> <|
                "Comment"         -> "1 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "GPSAccuracy",
                "Index"           -> 94,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Meters", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "gps_accuracy",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Intensity" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Intensity",
                "Index"           -> 88,
                "Interpreter"     -> { "fitEnum", "Intensity" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "intensity",
                "NativeType"      -> "FIT_INTENSITY",
                "Type"            -> "Intensity"
            |>
            ,
            "LapTrigger" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "LapTrigger",
                "Index"           -> 89,
                "Interpreter"     -> { "fitEnum", "LapTrigger" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "lap_trigger",
                "NativeType"      -> "FIT_LAP_TRIGGER",
                "Type"            -> "LapTrigger"
            |>
            ,
            "LeftRightBalance" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "LeftRightBalance",
                "Index"           -> 44,
                "Interpreter"     -> { "fitEnum", "LeftRightBalance100" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "left_right_balance",
                "NativeType"      -> "FIT_LEFT_RIGHT_BALANCE_100",
                "Type"            -> "LeftRightBalance100"
            |>
            ,
            "MaximumAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumAltitude",
                "Index"           -> 49,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 5, 500 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_altitude",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumCadence" -> <|
                "Comment"         -> "1 * rpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumCadence",
                "Index"           -> 87,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "max_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MaximumFractionalCadence" -> <|
                "Comment"         -> "128 * rpm + 0, fractional part of the max_cadence",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumFractionalCadence",
                "Index"           -> 99,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 128, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "max_fractional_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MaximumHeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumHeartRate",
                "Index"           -> 85,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "max_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MaximumNegativeGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumNegativeGrade",
                "Index"           -> 54,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "max_neg_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "MaximumNegativeVerticalSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumNegativeVerticalSpeed",
                "Index"           -> 58,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "max_neg_vertical_speed",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "MaximumPositiveGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumPositiveGrade",
                "Index"           -> 53,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "max_pos_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "MaximumPositiveVerticalSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumPositiveVerticalSpeed",
                "Index"           -> 57,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "max_pos_vertical_speed",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "MaximumPower" -> <|
                "Comment"         -> "1 * watts + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumPower",
                "Index"           -> 39,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumSaturatedHemoglobinPercent" -> <|
                "Comment"         -> "10 * % + 0, Max percentage of hemoglobin saturated with oxygen",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "MaximumSaturatedHemoglobinPercent",
                "Index"           -> 80;;80,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Percent", 10, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_saturated_hemoglobin_percent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumSpeed",
                "Index"           -> 37,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_speed",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumTemperature" -> <|
                "Comment"         -> "1 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumTemperature",
                "Index"           -> 96,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "DegreesCelsius", 1, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "max_temperature",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "MaximumTotalHemoglobinConcentration" -> <|
                "Comment"         -> "100 * g/dL + 0, Max saturated and unsaturated hemoglobin",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "MaximumTotalHemoglobinConcentration",
                "Index"           -> 77;;77,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Deciliters"^(-1) * "Grams", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_total_hemoglobin_conc",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 33,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "MinimumAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "MinimumAltitude",
                "Index"           -> 60,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 5, 500 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "min_altitude",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MinimumHeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MinimumHeartRate",
                "Index"           -> 97,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "min_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MinimumSaturatedHemoglobinPercent" -> <|
                "Comment"         -> "10 * % + 0, Min percentage of hemoglobin saturated with oxygen",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "MinimumSaturatedHemoglobinPercent",
                "Index"           -> 79;;79,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Percent", 10, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "min_saturated_hemoglobin_percent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MinimumTotalHemoglobinConcentration" -> <|
                "Comment"         -> "100 * g/dL + 0, Min saturated and unsaturated hemoglobin",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "MinimumTotalHemoglobinConcentration",
                "Index"           -> 76;;76,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Deciliters"^(-1) * "Grams", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "min_total_hemoglobin_conc",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "NormalizedPower" -> <|
                "Comment"         -> "1 * watts + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "NormalizedPower",
                "Index"           -> 43,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "normalized_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "NumberOfActiveLengths" -> <|
                "Comment"         -> "1 * lengths + 0, # of active lengths of swim pool",
                "Dimensions"      -> { },
                "FieldName"       -> "NumberOfActiveLengths",
                "Index"           -> 47,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "num_active_lengths",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "NumberOfLengths" -> <|
                "Comment"         -> "1 * lengths + 0, # of lengths of swim pool",
                "Dimensions"      -> { },
                "FieldName"       -> "NumberOfLengths",
                "Index"           -> 42,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "num_lengths",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "OpponentScore" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "OpponentScore",
                "Index"           -> 62,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "opponent_score",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "PlayerScore" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "PlayerScore",
                "Index"           -> 74,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "player_score",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "RepetitionNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "RepetitionNumber",
                "Index"           -> 59,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "repetition_num",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Sport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Sport",
                "Index"           -> 90,
                "Interpreter"     -> { "fitEnum", "Sport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sport",
                "NativeType"      -> "FIT_SPORT",
                "Type"            -> "Sport"
            |>
            ,
            "StartPositionLatitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "StartPositionLatitude",
                "Index"           -> 4,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "start_position_lat",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "StartPositionLongitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "StartPositionLongitude",
                "Index"           -> 5,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "start_position_long",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "StartTime" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "StartTime",
                "Index"           -> 3,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "start_time",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "StrokeCount" -> <|
                "Comment"         -> "1 * counts + 0, stroke_type enum used as the index",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "StrokeCount",
                "Index"           -> 63;;63,
                "Interpreter"     -> "fitUINT16A",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "stroke_count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "SubSport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SubSport",
                "Index"           -> 93,
                "Interpreter"     -> { "fitEnum", "SubSport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sub_sport",
                "NativeType"      -> "FIT_SUB_SPORT",
                "Type"            -> "SubSport"
            |>
            ,
            "SwimStroke" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SwimStroke",
                "Index"           -> 92,
                "Interpreter"     -> { "fitEnum", "SwimStroke" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "swim_stroke",
                "NativeType"      -> "FIT_SWIM_STROKE",
                "Type"            -> "SwimStroke"
            |>
            ,
            "TimeInCadenceZone" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "TimeInCadenceZone",
                "Index"           -> 20;;20,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_in_cadence_zone",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TimeInHeartRateZone" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { 5 },
                "FieldName"       -> "TimeInHeartRateZone",
                "Index"           -> 14;;18,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_in_hr_zone",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TimeInPowerZone" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { 7 },
                "FieldName"       -> "TimeInPowerZone",
                "Index"           -> 21;;27,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_in_power_zone",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TimeInSpeedZone" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "TimeInSpeedZone",
                "Index"           -> 19;;19,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_in_speed_zone",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0, Lap end time.",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "TotalAscent" -> <|
                "Comment"         -> "1 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalAscent",
                "Index"           -> 40,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_ascent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalCalories" -> <|
                "Comment"         -> "1 * kcal + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalCalories",
                "Index"           -> 34,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DietaryCalories", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_calories",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalCycles" -> <|
                "Comment"         -> "1 * cycles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalCycles",
                "Index"           -> 11,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Cycles", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_cycles",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalDescent" -> <|
                "Comment"         -> "1 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalDescent",
                "Index"           -> 41,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_descent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalDistance" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalDistance",
                "Index"           -> 10,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 100, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_distance",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalElapsedTime" -> <|
                "Comment"         -> "1000 * s + 0, Time (includes pauses)",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalElapsedTime",
                "Index"           -> 8,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_elapsed_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalFatCalories" -> <|
                "Comment"         -> "1 * kcal + 0, If New Leaf",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalFatCalories",
                "Index"           -> 35,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DietaryCalories", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_fat_calories",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalFractionalCycles" -> <|
                "Comment"         -> "128 * cycles + 0, fractional part of the total_cycles",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalFractionalCycles",
                "Index"           -> 100,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "total_fractional_cycles",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "TotalMovingTime" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalMovingTime",
                "Index"           -> 13,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_moving_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalTimerTime" -> <|
                "Comment"         -> "1000 * s + 0, Timer Time (excludes pauses)",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalTimerTime",
                "Index"           -> 9,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_timer_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalWork" -> <|
                "Comment"         -> "1 * J + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalWork",
                "Index"           -> 12,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Joules", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_work",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "WorkoutStepIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "WorkoutStepIndex",
                "Index"           -> 61,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "wkt_step_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "ZoneCount" -> <|
                "Comment"         -> "1 * counts + 0, zone number used as the index",
                "Dimensions"      -> { 7 },
                "FieldName"       -> "ZoneCount",
                "Index"           -> 64;;70,
                "Interpreter"     -> "fitUINT16A",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "zone_count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
        |>
    |>
    ,
    "Length" -> <|
        "MessageName"   -> "Length",
        "MessageNumber" -> 101,
        "Size"          -> 25,
        "Fields"        -> <|
            "AverageSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageSpeed",
                "Index"           -> 8,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_speed",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageSwimmingCadence" -> <|
                "Comment"         -> "1 * strokes/min + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageSwimmingCadence",
                "Index"           -> 23,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_swimming_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Event" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Event",
                "Index"           -> 20,
                "Interpreter"     -> { "fitEnum", "Event" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "event",
                "NativeType"      -> "FIT_EVENT",
                "Type"            -> "Event"
            |>
            ,
            "EventGroup" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "EventGroup",
                "Index"           -> 24,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "event_group",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "EventType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "EventType",
                "Index"           -> 21,
                "Interpreter"     -> { "fitEnum", "EventType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "event_type",
                "NativeType"      -> "FIT_EVENT_TYPE",
                "Type"            -> "EventType"
            |>
            ,
            "LengthType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "LengthType",
                "Index"           -> 25,
                "Interpreter"     -> { "fitEnum", "LengthType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "length_type",
                "NativeType"      -> "FIT_LENGTH_TYPE",
                "Type"            -> "LengthType"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 6,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "OpponentScore" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "OpponentScore",
                "Index"           -> 11,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "opponent_score",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "PlayerScore" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "PlayerScore",
                "Index"           -> 10,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "player_score",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "StartTime" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "StartTime",
                "Index"           -> 3,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "start_time",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "StrokeCount" -> <|
                "Comment"         -> "1 * counts + 0, stroke_type enum used as the index",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "StrokeCount",
                "Index"           -> 12;;12,
                "Interpreter"     -> "fitUINT16A",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "stroke_count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "SwimStroke" -> <|
                "Comment"         -> "1 * swim_stroke + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "SwimStroke",
                "Index"           -> 22,
                "Interpreter"     -> { "fitEnum", "SwimStroke" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "swim_stroke",
                "NativeType"      -> "FIT_SWIM_STROKE",
                "Type"            -> "SwimStroke"
            |>
            ,
            "Timestamp" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "TotalCalories" -> <|
                "Comment"         -> "1 * kcal + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalCalories",
                "Index"           -> 9,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DietaryCalories", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_calories",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalElapsedTime" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalElapsedTime",
                "Index"           -> 4,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_elapsed_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalStrokes" -> <|
                "Comment"         -> "1 * strokes + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalStrokes",
                "Index"           -> 7,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_strokes",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalTimerTime" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalTimerTime",
                "Index"           -> 5,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_timer_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "ZoneCount" -> <|
                "Comment"         -> "1 * counts + 0, zone number used as the index",
                "Dimensions"      -> { 7 },
                "FieldName"       -> "ZoneCount",
                "Index"           -> 13;;19,
                "Interpreter"     -> "fitUINT16A",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "zone_count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
        |>
    |>
    ,
    "MessageCapabilities" -> <|
        "MessageName"   -> "MessageCapabilities",
        "MessageNumber" -> 38,
        "Size"          -> 6,
        "Fields"        -> <|
            "Count" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Count",
                "Index"           -> 4,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "CountType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "CountType",
                "Index"           -> 6,
                "Interpreter"     -> { "fitEnum", "MessageCount" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "count_type",
                "NativeType"      -> "FIT_MESG_COUNT",
                "Type"            -> "MessageCount"
            |>
            ,
            "File" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "File",
                "Index"           -> 5,
                "Interpreter"     -> { "fitEnum", "File" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "file",
                "NativeType"      -> "FIT_FILE",
                "Type"            -> "File"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "MessageNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageNumber",
                "Index"           -> 3,
                "Interpreter"     -> { "fitEnum", "MessageNumber" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "mesg_num",
                "NativeType"      -> "FIT_MESG_NUM",
                "Type"            -> "MessageNumber"
            |>
        |>
    |>
    ,
    "MetabolicZone" -> <|
        "MessageName"   -> "MetabolicZone",
        "MessageNumber" -> 10,
        "Size"          -> 5,
        "Fields"        -> <|
            "Calories" -> <|
                "Comment"         -> "10 * kcal / min + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Calories",
                "Index"           -> 3,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DietaryCalories" / "Minutes", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "calories",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "FatCalories" -> <|
                "Comment"         -> "10 * kcal / min + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "FatCalories",
                "Index"           -> 5,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "DietaryCalories" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "fat_calories",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "HighBeatsPerMinute" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "HighBeatsPerMinute",
                "Index"           -> 4,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "high_bpm",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
        |>
    |>
    ,
    "Monitoring" -> <|
        "MessageName"   -> "Monitoring",
        "MessageNumber" -> 55,
        "Size"          -> 13,
        "Fields"        -> <|
            "ActiveTime" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "ActiveTime",
                "Index"           -> 5,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "active_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "ActiveTime16" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "ActiveTime16",
                "Index"           -> 10,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Seconds", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "active_time_16",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "ActivitySubtype" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ActivitySubtype",
                "Index"           -> 13,
                "Interpreter"     -> { "fitEnum", "ActivitySubtype" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "activity_subtype",
                "NativeType"      -> "FIT_ACTIVITY_SUBTYPE",
                "Type"            -> "ActivitySubtype"
            |>
            ,
            "ActivityType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ActivityType",
                "Index"           -> 12,
                "Interpreter"     -> { "fitEnum", "ActivityType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "activity_type",
                "NativeType"      -> "FIT_ACTIVITY_TYPE",
                "Type"            -> "ActivityType"
            |>
            ,
            "Calories" -> <|
                "Comment"         -> "1 * kcal + 0, Accumulated total calories. Maintained by MonitoringReader for each activity_type. See SDK documentation",
                "Dimensions"      -> { },
                "FieldName"       -> "Calories",
                "Index"           -> 7,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DietaryCalories", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "calories",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Cycles" -> <|
                "Comment"         -> "2 * cycles + 0, Accumulated cycles. Maintained by MonitoringReader for each activity_type. See SDK documentation.",
                "Dimensions"      -> { },
                "FieldName"       -> "Cycles",
                "Index"           -> 4,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Cycles", 2, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "cycles",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Cycles16" -> <|
                "Comment"         -> "1 * 2 * cycles (steps) + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Cycles16",
                "Index"           -> 9,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Steps", 2, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "cycles_16",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "DeviceIndex" -> <|
                "Comment"         -> "Associates this data to device_info message. Not required for file with single device (sensor).",
                "Dimensions"      -> { },
                "FieldName"       -> "DeviceIndex",
                "Index"           -> 11,
                "Interpreter"     -> { "fitEnum", "DeviceIndex" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "device_index",
                "NativeType"      -> "FIT_DEVICE_INDEX",
                "Type"            -> "DeviceIndex"
            |>
            ,
            "Distance" -> <|
                "Comment"         -> "100 * m + 0, Accumulated distance. Maintained by MonitoringReader for each activity_type. See SDK documentation.",
                "Dimensions"      -> { },
                "FieldName"       -> "Distance",
                "Index"           -> 3,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 100, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "distance",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Distance16" -> <|
                "Comment"         -> "1 * 100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Distance16",
                "Index"           -> 8,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "distance_16",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "LocalTimestamp" -> <|
                "Comment"         -> "Must align to logging interval, for example, time must be 00:00:00 for daily log.",
                "Dimensions"      -> { },
                "FieldName"       -> "LocalTimestamp",
                "Index"           -> 6,
                "Interpreter"     -> "fitLocalTimestamp",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "local_timestamp",
                "NativeType"      -> "FIT_LOCAL_DATE_TIME",
                "Type"            -> "LocalDateTime"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0, Must align to logging interval, for example, time must be 00:00:00 for daily log.",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
        |>
    |>
    ,
    "MonitoringInformation" -> <|
        "MessageName"   -> "MonitoringInformation",
        "MessageNumber" -> 103,
        "Size"          -> 3,
        "Fields"        -> <|
            "LocalTimestamp" -> <|
                "Comment"         -> "1 * s + 0, Use to convert activity timestamps to local time if device does not support time zone and daylight savings time correction.",
                "Dimensions"      -> { },
                "FieldName"       -> "LocalTimestamp",
                "Index"           -> 3,
                "Interpreter"     -> { "fitQuantity", "fitLocalTimestamp", "Seconds", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "local_timestamp",
                "NativeType"      -> "FIT_LOCAL_DATE_TIME",
                "Type"            -> "LocalDateTime"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
        |>
    |>
    ,
    "NMEASentence" -> <|
        "MessageName"   -> "NMEASentence",
        "MessageNumber" -> 177,
        "Size"          -> 86,
        "Fields"        -> <|
            "Sentence" -> <|
                "Comment"         -> "NMEA sentence",
                "Dimensions"      -> { 83 },
                "FieldName"       -> "Sentence",
                "Index"           -> 4;;86,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "sentence",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0, Timestamp message was output",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "TimestampMilliseconds" -> <|
                "Comment"         -> "1 * ms + 0, Fractional part of timestamp, added to timestamp",
                "Dimensions"      -> { },
                "FieldName"       -> "TimestampMilliseconds",
                "Index"           -> 3,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Seconds", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "timestamp_ms",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
        |>
    |>
    ,
    "PowerZone" -> <|
        "MessageName"   -> "PowerZone",
        "MessageNumber" -> 9,
        "Size"          -> 19,
        "Fields"        -> <|
            "HighValue" -> <|
                "Comment"         -> "1 * watts + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "HighValue",
                "Index"           -> 19,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "high_value",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 18,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Name" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "Name",
                "Index"           -> 2;;17,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
        |>
    |>
    ,
    "Record" -> <|
        "MessageName"   -> "Record",
        "MessageNumber" -> 20,
        "Size"          -> 85,
        "Fields"        -> <|
            "AbsolutePressure" -> <|
                "Comment"         -> "1 * Pa + 0, Includes atmospheric pressure",
                "Dimensions"      -> { },
                "FieldName"       -> "AbsolutePressure",
                "Index"           -> 11,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Pascals", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "absolute_pressure",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "AccumulatedPower" -> <|
                "Comment"         -> "1 * watts + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AccumulatedPower",
                "Index"           -> 8,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Watts", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "accumulated_power",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "ActivityType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ActivityType",
                "Index"           -> 60,
                "Interpreter"     -> { "fitEnum", "ActivityType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "activity_type",
                "NativeType"      -> "FIT_ACTIVITY_TYPE",
                "Type"            -> "ActivityType"
            |>
            ,
            "Altitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "Altitude",
                "Index"           -> 19,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 5, 500 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "altitude",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "BallSpeed" -> <|
                "Comment"         -> "100 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "BallSpeed",
                "Index"           -> 29,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "ball_speed",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "BatteryStateOfCharge" -> <|
                "Comment"         -> "2 * percent + 0, lev battery state of charge",
                "Dimensions"      -> { },
                "FieldName"       -> "BatteryStateOfCharge",
                "Index"           -> 81,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "battery_soc",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Cadence" -> <|
                "Comment"         -> "1 * rpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Cadence",
                "Index"           -> 45,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Cadence256" -> <|
                "Comment"         -> "256 * rpm + 0, Log cadence and fractional cadence for backwards compatability",
                "Dimensions"      -> { },
                "FieldName"       -> "Cadence256",
                "Index"           -> 30,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "RevolutionsPerMinute", 256, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "cadence256",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Calories" -> <|
                "Comment"         -> "1 * kcal + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Calories",
                "Index"           -> 25,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DietaryCalories", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "calories",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "CentralNervousSystemLoading" -> <|
                "Comment"         -> "1 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "CentralNervousSystemLoading",
                "Index"           -> 82,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "cns_load",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "CombinedPedalSmoothness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "CombinedPedalSmoothness",
                "Index"           -> 65,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "combined_pedal_smoothness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "CompressedAccumulatedPower" -> <|
                "Comment"         -> "1 * watts + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "CompressedAccumulatedPower",
                "Index"           -> 23,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "compressed_accumulated_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "CompressedSpeedDistance" -> <|
                "Dimensions"      -> { 3 },
                "FieldName"       -> "CompressedSpeedDistance",
                "Index"           -> 46;;48,
                "Interpreter"     -> "fitByteA",
                "Invalid"         -> 255,
                "NativeFieldName" -> "compressed_speed_distance",
                "NativeType"      -> "FIT_BYTE",
                "Type"            -> "Byte"
            |>
            ,
            "CoreTemperature" -> <|
                "Comment"         -> "100 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "CoreTemperature",
                "Index"           -> 43,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DegreesCelsius", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "core_temperature",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "CycleLength" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "CycleLength",
                "Index"           -> 50,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Meters", 100, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "cycle_length",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Cycles" -> <|
                "Comment"         -> "1 * cycles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Cycles",
                "Index"           -> 57,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Cycles", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "cycles",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Depth" -> <|
                "Comment"         -> "1000 * m + 0, 0 if above water",
                "Dimensions"      -> { },
                "FieldName"       -> "Depth",
                "Index"           -> 12,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "depth",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "DeviceIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DeviceIndex",
                "Index"           -> 70,
                "Interpreter"     -> { "fitEnum", "DeviceIndex" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "device_index",
                "NativeType"      -> "FIT_DEVICE_INDEX",
                "Type"            -> "DeviceIndex"
            |>
            ,
            "Distance" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Distance",
                "Index"           -> 5,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 100, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "distance",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "ElectricBikeAssistLevelPercent" -> <|
                "Comment"         -> "1 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "ElectricBikeAssistLevelPercent",
                "Index"           -> 85,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "ebike_assist_level_percent",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "ElectricBikeAssistMode" -> <|
                "Comment"         -> "1 * depends on sensor + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "ElectricBikeAssistMode",
                "Index"           -> 84,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "ebike_assist_mode",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "ElectricBikeBatteryLevel" -> <|
                "Comment"         -> "1 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "ElectricBikeBatteryLevel",
                "Index"           -> 83,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "ebike_battery_level",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "ElectricBikeTravelRange" -> <|
                "Comment"         -> "1 * km + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "ElectricBikeTravelRange",
                "Index"           -> 42,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 0.001, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "ebike_travel_range",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "EnhancedAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "EnhancedAltitude",
                "Index"           -> 10,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 5, 500 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "enhanced_altitude",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "EnhancedSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "EnhancedSpeed",
                "Index"           -> 9,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "enhanced_speed",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Flow" -> <|
                "Comment"         -> "The flow score estimates how long distance wise a cyclist deaccelerates over intervals where deacceleration is unnecessary such as smooth turns or small grade angle intervals.",
                "Dimensions"      -> { },
                "FieldName"       -> "Flow",
                "Index"           -> 18,
                "Interpreter"     -> "fitFloat32",
                "Invalid"         -> -9223372036854775808,
                "NativeFieldName" -> "flow",
                "NativeType"      -> "FIT_FLOAT32",
                "Type"            -> "Real32"
            |>
            ,
            "FractionalCadence" -> <|
                "Comment"         -> "128 * rpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "FractionalCadence",
                "Index"           -> 69,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 128, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "fractional_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "GPSAccuracy" -> <|
                "Comment"         -> "1 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "GPSAccuracy",
                "Index"           -> 59,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Meters", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "gps_accuracy",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Grade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Grade",
                "Index"           -> 22,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "Grit" -> <|
                "Comment"         -> "The grit score estimates how challenging a route could be for a cyclist in terms of time spent going over sharp turns or large grade slopes.",
                "Dimensions"      -> { },
                "FieldName"       -> "Grit",
                "Index"           -> 17,
                "Interpreter"     -> "fitFloat32",
                "Invalid"         -> -9223372036854775808,
                "NativeFieldName" -> "grit",
                "NativeType"      -> "FIT_FLOAT32",
                "Type"            -> "Real32"
            |>
            ,
            "HeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "HeartRate",
                "Index"           -> 44,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "LeftPedalSmoothness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "LeftPedalSmoothness",
                "Index"           -> 63,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "left_pedal_smoothness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "LeftPlatformCenterOffset" -> <|
                "Comment"         -> "1 * mm + 0, Left platform center offset",
                "Dimensions"      -> { },
                "FieldName"       -> "LeftPlatformCenterOffset",
                "Index"           -> 71,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "Meters", 1000, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "left_pco",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "LeftPowerPhase" -> <|
                "Comment"         -> "0.7111111 * degrees + 0, Left power phase angles. Data value indexes defined by power_phase_type.",
                "Dimensions"      -> { 2 },
                "FieldName"       -> "LeftPowerPhase",
                "Index"           -> 73;;74,
                "Interpreter"     -> { "fitQuantity", "fitUINT8A", "AngularDegrees", 0.7111111, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "left_power_phase",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "LeftPowerPhasePeak" -> <|
                "Comment"         -> "0.7111111 * degrees + 0, Left power phase peak angles. Data value indexes defined by power_phase_type.",
                "Dimensions"      -> { 2 },
                "FieldName"       -> "LeftPowerPhasePeak",
                "Index"           -> 75;;76,
                "Interpreter"     -> { "fitQuantity", "fitUINT8A", "AngularDegrees", 0.7111111, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "left_power_phase_peak",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "LeftRightBalance" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "LeftRightBalance",
                "Index"           -> 58,
                "Interpreter"     -> { "fitEnum", "LeftRightBalance" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "left_right_balance",
                "NativeType"      -> "FIT_LEFT_RIGHT_BALANCE",
                "Type"            -> "LeftRightBalance"
            |>
            ,
            "LeftTorqueEffectiveness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "LeftTorqueEffectiveness",
                "Index"           -> 61,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "left_torque_effectiveness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MotorPower" -> <|
                "Comment"         -> "1 * watts + 0, lev motor power",
                "Dimensions"      -> { },
                "FieldName"       -> "MotorPower",
                "Index"           -> 37,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "motor_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "N2Load" -> <|
                "Comment"         -> "1 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "N2Load",
                "Index"           -> 41,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "n2_load",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "NextStopDepth" -> <|
                "Comment"         -> "1000 * m + 0, 0 if above water",
                "Dimensions"      -> { },
                "FieldName"       -> "NextStopDepth",
                "Index"           -> 13,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "next_stop_depth",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "NextStopTime" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "NextStopTime",
                "Index"           -> 14,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "next_stop_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "NoDecompressionLimitTime" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "NoDecompressionLimitTime",
                "Index"           -> 16,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "ndl_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "PositionLatitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "PositionLatitude",
                "Index"           -> 3,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "position_lat",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "PositionLongitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "PositionLongitude",
                "Index"           -> 4,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "position_long",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "Power" -> <|
                "Comment"         -> "1 * watts + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Power",
                "Index"           -> 21,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Resistance" -> <|
                "Comment"         -> "Relative. 0 is none 254 is Max.",
                "Dimensions"      -> { },
                "FieldName"       -> "Resistance",
                "Index"           -> 49,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "resistance",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "RightPedalSmoothness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "RightPedalSmoothness",
                "Index"           -> 64,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "right_pedal_smoothness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "RightPlatformCenterOffset" -> <|
                "Comment"         -> "1 * mm + 0, Right platform center offset",
                "Dimensions"      -> { },
                "FieldName"       -> "RightPlatformCenterOffset",
                "Index"           -> 72,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "Meters", 1000, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "right_pco",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "RightPowerPhase" -> <|
                "Comment"         -> "0.7111111 * degrees + 0, Right power phase angles. Data value indexes defined by power_phase_type.",
                "Dimensions"      -> { 2 },
                "FieldName"       -> "RightPowerPhase",
                "Index"           -> 77;;78,
                "Interpreter"     -> { "fitQuantity", "fitUINT8A", "AngularDegrees", 0.7111111, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "right_power_phase",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "RightPowerPhasePeak" -> <|
                "Comment"         -> "0.7111111 * degrees + 0, Right power phase peak angles. Data value indexes defined by power_phase_type.",
                "Dimensions"      -> { 2 },
                "FieldName"       -> "RightPowerPhasePeak",
                "Index"           -> 79;;80,
                "Interpreter"     -> { "fitQuantity", "fitUINT8A", "AngularDegrees", 0.7111111, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "right_power_phase_peak",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "RightTorqueEffectiveness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "RightTorqueEffectiveness",
                "Index"           -> 62,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "right_torque_effectiveness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "SaturatedHemoglobinPercent" -> <|
                "Comment"         -> "10 * % + 0, Percentage of hemoglobin saturated with oxygen",
                "Dimensions"      -> { },
                "FieldName"       -> "SaturatedHemoglobinPercent",
                "Index"           -> 34,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 10, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "saturated_hemoglobin_percent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "SaturatedHemoglobinPercentMaximum" -> <|
                "Comment"         -> "10 * % + 0, Max percentage of hemoglobin saturated with oxygen",
                "Dimensions"      -> { },
                "FieldName"       -> "SaturatedHemoglobinPercentMaximum",
                "Index"           -> 36,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 10, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "saturated_hemoglobin_percent_max",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "SaturatedHemoglobinPercentMinimum" -> <|
                "Comment"         -> "10 * % + 0, Min percentage of hemoglobin saturated with oxygen",
                "Dimensions"      -> { },
                "FieldName"       -> "SaturatedHemoglobinPercentMinimum",
                "Index"           -> 35,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 10, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "saturated_hemoglobin_percent_min",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Speed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Speed",
                "Index"           -> 20,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "speed",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Speed1S" -> <|
                "Comment"         -> "16 * m/s + 0, Speed at 1s intervals. Timestamp field indicates time of last array element.",
                "Dimensions"      -> { 5 },
                "FieldName"       -> "Speed1S",
                "Index"           -> 52;;56,
                "Interpreter"     -> { "fitQuantity", "fitUINT8A", "MetersPerSecond", 16, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "speed_1s",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "StanceTime" -> <|
                "Comment"         -> "10 * ms + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "StanceTime",
                "Index"           -> 28,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Seconds", 10000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "stance_time",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "StanceTimeBalance" -> <|
                "Comment"         -> "100 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "StanceTimeBalance",
                "Index"           -> 39,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "stance_time_balance",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "StanceTimePercent" -> <|
                "Comment"         -> "100 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "StanceTimePercent",
                "Index"           -> 27,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "stance_time_percent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "StepLength" -> <|
                "Comment"         -> "10 * mm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "StepLength",
                "Index"           -> 40,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "step_length",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "StrokeType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "StrokeType",
                "Index"           -> 67,
                "Interpreter"     -> { "fitEnum", "StrokeType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "stroke_type",
                "NativeType"      -> "FIT_STROKE_TYPE",
                "Type"            -> "StrokeType"
            |>
            ,
            "Temperature" -> <|
                "Comment"         -> "1 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Temperature",
                "Index"           -> 51,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "DegreesCelsius", 1, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "temperature",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "Time128" -> <|
                "Comment"         -> "128 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Time128",
                "Index"           -> 66,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Seconds", 128, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "time128",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "TimeFromCourse" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TimeFromCourse",
                "Index"           -> 6,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "time_from_course",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "TimeToSurface" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TimeToSurface",
                "Index"           -> 15,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_to_surface",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalCycles" -> <|
                "Comment"         -> "1 * cycles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalCycles",
                "Index"           -> 7,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Cycles", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_cycles",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalHemoglobinConcentration" -> <|
                "Comment"         -> "100 * g/dL + 0, Total saturated and unsaturated hemoglobin",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalHemoglobinConcentration",
                "Index"           -> 31,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Deciliters"^(-1) * "Grams", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_hemoglobin_conc",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalHemoglobinConcentrationMaximum" -> <|
                "Comment"         -> "100 * g/dL + 0, Max saturated and unsaturated hemoglobin",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalHemoglobinConcentrationMaximum",
                "Index"           -> 33,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Deciliters"^(-1) * "Grams", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_hemoglobin_conc_max",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalHemoglobinConcentrationMinimum" -> <|
                "Comment"         -> "100 * g/dL + 0, Min saturated and unsaturated hemoglobin",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalHemoglobinConcentrationMinimum",
                "Index"           -> 32,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Deciliters"^(-1) * "Grams", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_hemoglobin_conc_min",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "VerticalOscillation" -> <|
                "Comment"         -> "10 * mm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "VerticalOscillation",
                "Index"           -> 26,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "vertical_oscillation",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "VerticalRatio" -> <|
                "Comment"         -> "100 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "VerticalRatio",
                "Index"           -> 38,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "vertical_ratio",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "VerticalSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "VerticalSpeed",
                "Index"           -> 24,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "vertical_speed",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "Zone" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Zone",
                "Index"           -> 68,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "zone",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
        |>
    |>
    ,
    "Schedule" -> <|
        "MessageName"   -> "Schedule",
        "MessageNumber" -> 28,
        "Size"          -> 8,
        "Fields"        -> <|
            "Completed" -> <|
                "Comment"         -> "TRUE if this activity has been started",
                "Dimensions"      -> { },
                "FieldName"       -> "Completed",
                "Index"           -> 7,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "completed",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "Manufacturer" -> <|
                "Comment"         -> "Corresponds to file_id of scheduled workout / course.",
                "Dimensions"      -> { },
                "FieldName"       -> "Manufacturer",
                "Index"           -> 5,
                "Interpreter"     -> { "fitEnum", "Manufacturer" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "manufacturer",
                "NativeType"      -> "FIT_MANUFACTURER",
                "Type"            -> "Manufacturer"
            |>
            ,
            "Product" -> <|
                "Comment"         -> "Corresponds to file_id of scheduled workout / course.",
                "Dimensions"      -> { },
                "FieldName"       -> "Product",
                "Index"           -> 6,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "product",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "ScheduledTime" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ScheduledTime",
                "Index"           -> 4,
                "Interpreter"     -> "fitLocalTimestamp",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "scheduled_time",
                "NativeType"      -> "FIT_LOCAL_DATE_TIME",
                "Type"            -> "LocalDateTime"
            |>
            ,
            "SerialNumber" -> <|
                "Comment"         -> "Corresponds to file_id of scheduled workout / course.",
                "Dimensions"      -> { },
                "FieldName"       -> "SerialNumber",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT32Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "serial_number",
                "NativeType"      -> "FIT_UINT32Z",
                "Type"            -> "UnsignedInteger32Z"
            |>
            ,
            "TimeCreated" -> <|
                "Comment"         -> "Corresponds to file_id of scheduled workout / course.",
                "Dimensions"      -> { },
                "FieldName"       -> "TimeCreated",
                "Index"           -> 3,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "time_created",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "Type" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Type",
                "Index"           -> 8,
                "Interpreter"     -> { "fitEnum", "Schedule" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "type",
                "NativeType"      -> "FIT_SCHEDULE",
                "Type"            -> "Schedule"
            |>
        |>
    |>
    ,
    "SegmentFile" -> <|
        "MessageName"   -> "SegmentFile",
        "MessageNumber" -> 151,
        "Size"          -> 8,
        "Fields"        -> <|
            "Enabled" -> <|
                "Comment"         -> "Enabled state of the segment file",
                "Dimensions"      -> { },
                "FieldName"       -> "Enabled",
                "Index"           -> 7,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "FileUUID" -> <|
                "Comment"         -> "UUID of the segment file",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "FileUUID",
                "Index"           -> 6;;6,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "file_uuid",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "LeaderActivityID" -> <|
                "Comment"         -> "Activity ID of each leader in the segment file",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "LeaderActivityID",
                "Index"           -> 4;;4,
                "Interpreter"     -> "fitUINT32A",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "leader_activity_id",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "LeaderGroupPrimaryKey" -> <|
                "Comment"         -> "Group primary key of each leader in the segment file",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "LeaderGroupPrimaryKey",
                "Index"           -> 3;;3,
                "Interpreter"     -> "fitUINT32A",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "leader_group_primary_key",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "LeaderType" -> <|
                "Comment"         -> "Leader type of each leader in the segment file",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "LeaderType",
                "Index"           -> 8;;8,
                "Interpreter"     -> { "fitEnum", "SegmentLeaderboardType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "leader_type",
                "NativeType"      -> "FIT_SEGMENT_LEADERBOARD_TYPE",
                "Type"            -> "SegmentLeaderboardType"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 5,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "UserProfilePrimaryKey" -> <|
                "Comment"         -> "Primary key of the user that created the segment file",
                "Dimensions"      -> { },
                "FieldName"       -> "UserProfilePrimaryKey",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "user_profile_primary_key",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
        |>
    |>
    ,
    "SegmentID" -> <|
        "MessageName"   -> "SegmentID",
        "MessageNumber" -> 148,
        "Size"          -> 94,
        "Fields"        -> <|
            "DefaultRaceLeader" -> <|
                "Comment"         -> "Index for the Leader Board entry selected as the default race participant",
                "Dimensions"      -> { },
                "FieldName"       -> "DefaultRaceLeader",
                "Index"           -> 92,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "default_race_leader",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "DeleteStatus" -> <|
                "Comment"         -> "Indicates if any segments should be deleted",
                "Dimensions"      -> { },
                "FieldName"       -> "DeleteStatus",
                "Index"           -> 93,
                "Interpreter"     -> { "fitEnum", "SegmentDeleteStatus" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "delete_status",
                "NativeType"      -> "FIT_SEGMENT_DELETE_STATUS",
                "Type"            -> "SegmentDeleteStatus"
            |>
            ,
            "DeviceID" -> <|
                "Comment"         -> "ID of the device that created the segment",
                "Dimensions"      -> { },
                "FieldName"       -> "DeviceID",
                "Index"           -> 39,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "device_id",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Enabled" -> <|
                "Comment"         -> "Segment enabled for evaluation",
                "Dimensions"      -> { },
                "FieldName"       -> "Enabled",
                "Index"           -> 91,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "Name" -> <|
                "Comment"         -> "Friendly name assigned to segment",
                "Dimensions"      -> { 50 },
                "FieldName"       -> "Name",
                "Index"           -> 40;;89,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "SelectionType" -> <|
                "Comment"         -> "Indicates how the segment was selected to be sent to the device",
                "Dimensions"      -> { },
                "FieldName"       -> "SelectionType",
                "Index"           -> 94,
                "Interpreter"     -> { "fitEnum", "SegmentSelectionType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "selection_type",
                "NativeType"      -> "FIT_SEGMENT_SELECTION_TYPE",
                "Type"            -> "SegmentSelectionType"
            |>
            ,
            "Sport" -> <|
                "Comment"         -> "Sport associated with the segment",
                "Dimensions"      -> { },
                "FieldName"       -> "Sport",
                "Index"           -> 90,
                "Interpreter"     -> { "fitEnum", "Sport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sport",
                "NativeType"      -> "FIT_SPORT",
                "Type"            -> "Sport"
            |>
            ,
            "UserProfilePrimaryKey" -> <|
                "Comment"         -> "Primary key of the user that created the segment",
                "Dimensions"      -> { },
                "FieldName"       -> "UserProfilePrimaryKey",
                "Index"           -> 38,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "user_profile_primary_key",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "UUID" -> <|
                "Comment"         -> "UUID of the segment",
                "Dimensions"      -> { 36 },
                "FieldName"       -> "UUID",
                "Index"           -> 2;;37,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "uuid",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
        |>
    |>
    ,
    "SegmentLap" -> <|
        "MessageName"   -> "SegmentLap",
        "MessageNumber" -> 142,
        "Size"          -> 131,
        "Fields"        -> <|
            "ActiveTime" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "ActiveTime",
                "Index"           -> 48,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "active_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "AverageAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageAltitude",
                "Index"           -> 60,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 5, 500 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_altitude",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageCadence" -> <|
                "Comment"         -> "1 * rpm + 0, total_cycles / total_timer_time if non_zero_avg_cadence otherwise total_cycles / total_elapsed_time",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageCadence",
                "Index"           -> 80,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageCombinedPedalSmoothness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageCombinedPedalSmoothness",
                "Index"           -> 94,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_combined_pedal_smoothness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageFractionalCadence" -> <|
                "Comment"         -> "128 * rpm + 0, fractional part of the avg_cadence",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageFractionalCadence",
                "Index"           -> 129,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 128, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_fractional_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageGrade",
                "Index"           -> 62,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AverageHeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageHeartRate",
                "Index"           -> 78,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageLeftPedalSmoothness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageLeftPedalSmoothness",
                "Index"           -> 92,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_left_pedal_smoothness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageLeftTorqueEffectiveness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageLeftTorqueEffectiveness",
                "Index"           -> 90,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_left_torque_effectiveness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageNegativeGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageNegativeGrade",
                "Index"           -> 64,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_neg_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AverageNegativeVerticalSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageNegativeVerticalSpeed",
                "Index"           -> 68,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_neg_vertical_speed",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AveragePositiveGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AveragePositiveGrade",
                "Index"           -> 63,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_pos_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AveragePositiveVerticalSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AveragePositiveVerticalSpeed",
                "Index"           -> 67,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_pos_vertical_speed",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AveragePower" -> <|
                "Comment"         -> "1 * watts + 0, total_power / total_timer_time if non_zero_avg_power otherwise total_power / total_elapsed_time",
                "Dimensions"      -> { },
                "FieldName"       -> "AveragePower",
                "Index"           -> 54,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageRightPedalSmoothness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageRightPedalSmoothness",
                "Index"           -> 93,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_right_pedal_smoothness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageRightTorqueEffectiveness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageRightTorqueEffectiveness",
                "Index"           -> 91,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_right_torque_effectiveness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageSpeed",
                "Index"           -> 52,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_speed",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageTemperature" -> <|
                "Comment"         -> "1 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageTemperature",
                "Index"           -> 86,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "DegreesCelsius", 1, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "avg_temperature",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "EndPositionLatitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "EndPositionLatitude",
                "Index"           -> 6,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "end_position_lat",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "EndPositionLongitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "EndPositionLongitude",
                "Index"           -> 7,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "end_position_long",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "Event" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Event",
                "Index"           -> 76,
                "Interpreter"     -> { "fitEnum", "Event" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "event",
                "NativeType"      -> "FIT_EVENT",
                "Type"            -> "Event"
            |>
            ,
            "EventGroup" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "EventGroup",
                "Index"           -> 83,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "event_group",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "EventType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "EventType",
                "Index"           -> 77,
                "Interpreter"     -> { "fitEnum", "EventType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "event_type",
                "NativeType"      -> "FIT_EVENT_TYPE",
                "Type"            -> "EventType"
            |>
            ,
            "FrontGearShiftCount" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "FrontGearShiftCount",
                "Index"           -> 74,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "front_gear_shift_count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "GPSAccuracy" -> <|
                "Comment"         -> "1 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "GPSAccuracy",
                "Index"           -> 85,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Meters", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "gps_accuracy",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "LeftRightBalance" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "LeftRightBalance",
                "Index"           -> 59,
                "Interpreter"     -> { "fitEnum", "LeftRightBalance100" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "left_right_balance",
                "NativeType"      -> "FIT_LEFT_RIGHT_BALANCE_100",
                "Type"            -> "LeftRightBalance100"
            |>
            ,
            "MaximumAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumAltitude",
                "Index"           -> 61,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 5, 500 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_altitude",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumCadence" -> <|
                "Comment"         -> "1 * rpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumCadence",
                "Index"           -> 81,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "max_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MaximumFractionalCadence" -> <|
                "Comment"         -> "128 * rpm + 0, fractional part of the max_cadence",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumFractionalCadence",
                "Index"           -> 130,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 128, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "max_fractional_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MaximumHeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumHeartRate",
                "Index"           -> 79,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "max_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MaximumNegativeGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumNegativeGrade",
                "Index"           -> 66,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "max_neg_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "MaximumNegativeVerticalSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumNegativeVerticalSpeed",
                "Index"           -> 70,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "max_neg_vertical_speed",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "MaximumPositiveGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumPositiveGrade",
                "Index"           -> 65,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "max_pos_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "MaximumPositiveVerticalSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumPositiveVerticalSpeed",
                "Index"           -> 69,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "max_pos_vertical_speed",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "MaximumPower" -> <|
                "Comment"         -> "1 * watts + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumPower",
                "Index"           -> 55,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumSpeed",
                "Index"           -> 53,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_speed",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumTemperature" -> <|
                "Comment"         -> "1 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumTemperature",
                "Index"           -> 87,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "DegreesCelsius", 1, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "max_temperature",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 49,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "MinimumAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "MinimumAltitude",
                "Index"           -> 72,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 5, 500 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "min_altitude",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MinimumHeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MinimumHeartRate",
                "Index"           -> 88,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "min_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Name" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "Name",
                "Index"           -> 16;;31,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "NormalizedPower" -> <|
                "Comment"         -> "1 * watts + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "NormalizedPower",
                "Index"           -> 58,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "normalized_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "NorthEastCornerLatitude" -> <|
                "Comment"         -> "1 * semicircles + 0, North east corner latitude.",
                "Dimensions"      -> { },
                "FieldName"       -> "NorthEastCornerLatitude",
                "Index"           -> 12,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "nec_lat",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "NorthEastCornerLongitude" -> <|
                "Comment"         -> "1 * semicircles + 0, North east corner longitude.",
                "Dimensions"      -> { },
                "FieldName"       -> "NorthEastCornerLongitude",
                "Index"           -> 13,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "nec_long",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "RearGearShiftCount" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "RearGearShiftCount",
                "Index"           -> 75,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "rear_gear_shift_count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "RepetitionNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "RepetitionNumber",
                "Index"           -> 71,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "repetition_num",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "SouthWestCornerLatitude" -> <|
                "Comment"         -> "1 * semicircles + 0, South west corner latitude.",
                "Dimensions"      -> { },
                "FieldName"       -> "SouthWestCornerLatitude",
                "Index"           -> 14,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "swc_lat",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "SouthWestCornerLongitude" -> <|
                "Comment"         -> "1 * semicircles + 0, South west corner latitude.",
                "Dimensions"      -> { },
                "FieldName"       -> "SouthWestCornerLongitude",
                "Index"           -> 15,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "swc_long",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "Sport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Sport",
                "Index"           -> 82,
                "Interpreter"     -> { "fitEnum", "Sport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sport",
                "NativeType"      -> "FIT_SPORT",
                "Type"            -> "Sport"
            |>
            ,
            "SportEvent" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SportEvent",
                "Index"           -> 89,
                "Interpreter"     -> { "fitEnum", "SportEvent" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sport_event",
                "NativeType"      -> "FIT_SPORT_EVENT",
                "Type"            -> "SportEvent"
            |>
            ,
            "StartPositionLatitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "StartPositionLatitude",
                "Index"           -> 4,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "start_position_lat",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "StartPositionLongitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "StartPositionLongitude",
                "Index"           -> 5,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "start_position_long",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "StartTime" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "StartTime",
                "Index"           -> 3,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "start_time",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "Status" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Status",
                "Index"           -> 95,
                "Interpreter"     -> { "fitEnum", "SegmentLapStatus" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "status",
                "NativeType"      -> "FIT_SEGMENT_LAP_STATUS",
                "Type"            -> "SegmentLapStatus"
            |>
            ,
            "SubSport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SubSport",
                "Index"           -> 84,
                "Interpreter"     -> { "fitEnum", "SubSport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sub_sport",
                "NativeType"      -> "FIT_SUB_SPORT",
                "Type"            -> "SubSport"
            |>
            ,
            "TimeInCadenceZone" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "TimeInCadenceZone",
                "Index"           -> 40;;40,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_in_cadence_zone",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TimeInHeartRateZone" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { 5 },
                "FieldName"       -> "TimeInHeartRateZone",
                "Index"           -> 34;;38,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_in_hr_zone",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TimeInPowerZone" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { 7 },
                "FieldName"       -> "TimeInPowerZone",
                "Index"           -> 41;;47,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_in_power_zone",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TimeInSpeedZone" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "TimeInSpeedZone",
                "Index"           -> 39;;39,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_in_speed_zone",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0, Lap end time.",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "TotalAscent" -> <|
                "Comment"         -> "1 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalAscent",
                "Index"           -> 56,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_ascent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalCalories" -> <|
                "Comment"         -> "1 * kcal + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalCalories",
                "Index"           -> 50,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DietaryCalories", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_calories",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalCycles" -> <|
                "Comment"         -> "1 * cycles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalCycles",
                "Index"           -> 11,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Cycles", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_cycles",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalDescent" -> <|
                "Comment"         -> "1 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalDescent",
                "Index"           -> 57,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_descent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalDistance" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalDistance",
                "Index"           -> 10,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 100, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_distance",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalElapsedTime" -> <|
                "Comment"         -> "1000 * s + 0, Time (includes pauses)",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalElapsedTime",
                "Index"           -> 8,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_elapsed_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalFatCalories" -> <|
                "Comment"         -> "1 * kcal + 0, If New Leaf",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalFatCalories",
                "Index"           -> 51,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DietaryCalories", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_fat_calories",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalFractionalCycles" -> <|
                "Comment"         -> "128 * cycles + 0, fractional part of the total_cycles",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalFractionalCycles",
                "Index"           -> 131,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "total_fractional_cycles",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "TotalMovingTime" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalMovingTime",
                "Index"           -> 33,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_moving_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalTimerTime" -> <|
                "Comment"         -> "1000 * s + 0, Timer Time (excludes pauses)",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalTimerTime",
                "Index"           -> 9,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_timer_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalWork" -> <|
                "Comment"         -> "1 * J + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalWork",
                "Index"           -> 32,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Joules", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_work",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "UUID" -> <|
                "Dimensions"      -> { 33 },
                "FieldName"       -> "UUID",
                "Index"           -> 96;;128,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "uuid",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "WorkoutStepIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "WorkoutStepIndex",
                "Index"           -> 73,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "wkt_step_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
        |>
    |>
    ,
    "SegmentLeaderboardEntry" -> <|
        "MessageName"   -> "SegmentLeaderboardEntry",
        "MessageNumber" -> 149,
        "Size"          -> 7,
        "Fields"        -> <|
            "ActivityID" -> <|
                "Comment"         -> "ID of the activity associated with this leader time",
                "Dimensions"      -> { },
                "FieldName"       -> "ActivityID",
                "Index"           -> 3,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "activity_id",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "GroupPrimaryKey" -> <|
                "Comment"         -> "Primary user ID of this leader",
                "Dimensions"      -> { },
                "FieldName"       -> "GroupPrimaryKey",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "group_primary_key",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 5,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Name" -> <|
                "Comment"         -> "Friendly name assigned to leader",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "Name",
                "Index"           -> 6;;6,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "SegmentTime" -> <|
                "Comment"         -> "1000 * s + 0, Segment Time (includes pauses)",
                "Dimensions"      -> { },
                "FieldName"       -> "SegmentTime",
                "Index"           -> 4,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "segment_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Type" -> <|
                "Comment"         -> "Leader classification",
                "Dimensions"      -> { },
                "FieldName"       -> "Type",
                "Index"           -> 7,
                "Interpreter"     -> { "fitEnum", "SegmentLeaderboardType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "type",
                "NativeType"      -> "FIT_SEGMENT_LEADERBOARD_TYPE",
                "Type"            -> "SegmentLeaderboardType"
            |>
        |>
    |>
    ,
    "SegmentPoint" -> <|
        "MessageName"   -> "SegmentPoint",
        "MessageNumber" -> 150,
        "Size"          -> 7,
        "Fields"        -> <|
            "Altitude" -> <|
                "Comment"         -> "5 * m + 500, Accumulated altitude along the segment at the described point",
                "Dimensions"      -> { },
                "FieldName"       -> "Altitude",
                "Index"           -> 7,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 5, 500 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "altitude",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Distance" -> <|
                "Comment"         -> "100 * m + 0, Accumulated distance along the segment at the described point",
                "Dimensions"      -> { },
                "FieldName"       -> "Distance",
                "Index"           -> 4,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 100, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "distance",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "LeaderTime" -> <|
                "Comment"         -> "1000 * s + 0, Accumualted time each leader board member required to reach the described point. This value is zero for all leader board members at the starting point of the segment.",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "LeaderTime",
                "Index"           -> 5;;5,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "leader_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 6,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "PositionLatitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "PositionLatitude",
                "Index"           -> 2,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "position_lat",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "PositionLongitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "PositionLongitude",
                "Index"           -> 3,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "position_long",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
        |>
    |>
    ,
    "Session" -> <|
        "MessageName"   -> "Session",
        "MessageNumber" -> 18,
        "Size"          -> 171,
        "Fields"        -> <|
            "AverageAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageAltitude",
                "Index"           -> 83,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 5, 500 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_altitude",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageAscentSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageAscentSpeed",
                "Index"           -> 123,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_vam",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageBallSpeed" -> <|
                "Comment"         -> "100 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageBallSpeed",
                "Index"           -> 107,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_ball_speed",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageCadence" -> <|
                "Comment"         -> "1 * rpm + 0, total_cycles / total_timer_time if non_zero_avg_cadence otherwise total_cycles / total_elapsed_time",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageCadence",
                "Index"           -> 134,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageCadencePosition" -> <|
                "Comment"         -> "1 * rpm + 0, Average cadence by position. Data value indexes defined by rider_position_type.",
                "Dimensions"      -> { 2 },
                "FieldName"       -> "AverageCadencePosition",
                "Index"           -> 164;;165,
                "Interpreter"     -> { "fitQuantity", "fitUINT8A", "RevolutionsPerMinute", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_cadence_position",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageCombinedPedalSmoothness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageCombinedPedalSmoothness",
                "Index"           -> 152,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_combined_pedal_smoothness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageCoreTemperature" -> <|
                "Comment"         -> "100 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageCoreTemperature",
                "Index"           -> 125,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DegreesCelsius", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_core_temperature",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageFlow" -> <|
                "Comment"         -> "1 * Flow + 0, The flow score estimates how long distance wise a cyclist deaccelerates over intervals where deacceleration is unnecessary such as smooth turns or small grade angle intervals.",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageFlow",
                "Index"           -> 62,
                "Interpreter"     -> "fitFloat32",
                "Invalid"         -> -9223372036854775808,
                "NativeFieldName" -> "avg_flow",
                "NativeType"      -> "FIT_FLOAT32",
                "Type"            -> "Real32"
            |>
            ,
            "AverageFractionalCadence" -> <|
                "Comment"         -> "128 * rpm + 0, fractional part of the avg_cadence",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageFractionalCadence",
                "Index"           -> 145,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 128, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_fractional_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageGrade",
                "Index"           -> 85,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AverageGrit" -> <|
                "Comment"         -> "1 * kGrit + 0, The grit score estimates how challenging a route could be for a cyclist in terms of time spent going over sharp turns or large grade slopes.",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageGrit",
                "Index"           -> 61,
                "Interpreter"     -> "fitFloat32",
                "Invalid"         -> -9223372036854775808,
                "NativeFieldName" -> "avg_grit",
                "NativeType"      -> "FIT_FLOAT32",
                "Type"            -> "Real32"
            |>
            ,
            "AverageHeartRate" -> <|
                "Comment"         -> "1 * bpm + 0, average heart rate (excludes pause time)",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageHeartRate",
                "Index"           -> 132,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageLapTime" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageLapTime",
                "Index"           -> 31,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "avg_lap_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "AverageLeftPedalSmoothness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageLeftPedalSmoothness",
                "Index"           -> 150,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_left_pedal_smoothness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageLeftPlatformCenterOffset" -> <|
                "Comment"         -> "1 * mm + 0, Average platform center offset Left",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageLeftPlatformCenterOffset",
                "Index"           -> 154,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "Meters", 1000, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "avg_left_pco",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "AverageLeftPowerPhase" -> <|
                "Comment"         -> "0.7111111 * degrees + 0, Average left power phase angles. Indexes defined by power_phase_type.",
                "Dimensions"      -> { 2 },
                "FieldName"       -> "AverageLeftPowerPhase",
                "Index"           -> 156;;157,
                "Interpreter"     -> { "fitQuantity", "fitUINT8A", "AngularDegrees", 0.7111111, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_left_power_phase",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageLeftPowerPhasePeak" -> <|
                "Comment"         -> "0.7111111 * degrees + 0, Average left power phase peak angles. Data value indexes defined by power_phase_type.",
                "Dimensions"      -> { 2 },
                "FieldName"       -> "AverageLeftPowerPhasePeak",
                "Index"           -> 158;;159,
                "Interpreter"     -> { "fitQuantity", "fitUINT8A", "AngularDegrees", 0.7111111, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_left_power_phase_peak",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageLeftTorqueEffectiveness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageLeftTorqueEffectiveness",
                "Index"           -> 148,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_left_torque_effectiveness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageLightElectricalVehicleMotorPower" -> <|
                "Comment"         -> "1 * watts + 0, lev average motor power during session",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageLightElectricalVehicleMotorPower",
                "Index"           -> 118,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_lev_motor_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageNegativeGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageNegativeGrade",
                "Index"           -> 87,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_neg_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AverageNegativeVerticalSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageNegativeVerticalSpeed",
                "Index"           -> 91,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_neg_vertical_speed",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AveragePositiveGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AveragePositiveGrade",
                "Index"           -> 86,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_pos_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AveragePositiveVerticalSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AveragePositiveVerticalSpeed",
                "Index"           -> 90,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "avg_pos_vertical_speed",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "AveragePower" -> <|
                "Comment"         -> "1 * watts + 0, total_power / total_timer_time if non_zero_avg_power otherwise total_power / total_elapsed_time",
                "Dimensions"      -> { },
                "FieldName"       -> "AveragePower",
                "Index"           -> 68,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AveragePowerPosition" -> <|
                "Comment"         -> "1 * watts + 0, Average power by position. Data value indexes defined by rider_position_type.",
                "Dimensions"      -> { 2 },
                "FieldName"       -> "AveragePowerPosition",
                "Index"           -> 49;;50,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_power_position",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageRightPedalSmoothness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageRightPedalSmoothness",
                "Index"           -> 151,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_right_pedal_smoothness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageRightPlatformCenterOffset" -> <|
                "Comment"         -> "1 * mm + 0, Average platform center offset Right",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageRightPlatformCenterOffset",
                "Index"           -> 155,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "Meters", 1000, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "avg_right_pco",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "AverageRightPowerPhase" -> <|
                "Comment"         -> "0.7111111 * degrees + 0, Average right power phase angles. Data value indexes defined by power_phase_type.",
                "Dimensions"      -> { 2 },
                "FieldName"       -> "AverageRightPowerPhase",
                "Index"           -> 160;;161,
                "Interpreter"     -> { "fitQuantity", "fitUINT8A", "AngularDegrees", 0.7111111, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_right_power_phase",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageRightPowerPhasePeak" -> <|
                "Comment"         -> "0.7111111 * degrees + 0, Average right power phase peak angles data value indexes defined by power_phase_type.",
                "Dimensions"      -> { 2 },
                "FieldName"       -> "AverageRightPowerPhasePeak",
                "Index"           -> 162;;163,
                "Interpreter"     -> { "fitQuantity", "fitUINT8A", "AngularDegrees", 0.7111111, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_right_power_phase_peak",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageRightTorqueEffectiveness" -> <|
                "Comment"         -> "2 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageRightTorqueEffectiveness",
                "Index"           -> 149,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "avg_right_torque_effectiveness",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "AverageSaturatedHemoglobinPercent" -> <|
                "Comment"         -> "10 * % + 0, Avg percentage of hemoglobin saturated with oxygen",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "AverageSaturatedHemoglobinPercent",
                "Index"           -> 114;;114,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Percent", 10, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_saturated_hemoglobin_percent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0, total_distance / total_timer_time",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageSpeed",
                "Index"           -> 66,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_speed",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageStanceTime" -> <|
                "Comment"         -> "10 * ms + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageStanceTime",
                "Index"           -> 110,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Seconds", 10000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_stance_time",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageStanceTimeBalance" -> <|
                "Comment"         -> "100 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageStanceTimeBalance",
                "Index"           -> 121,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_stance_time_balance",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageStanceTimePercent" -> <|
                "Comment"         -> "100 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageStanceTimePercent",
                "Index"           -> 109,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_stance_time_percent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageStepLength" -> <|
                "Comment"         -> "10 * mm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageStepLength",
                "Index"           -> 122,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_step_length",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageStrokeCount" -> <|
                "Comment"         -> "10 * strokes/lap + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageStrokeCount",
                "Index"           -> 14,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "avg_stroke_count",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "AverageStrokeDistance" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageStrokeDistance",
                "Index"           -> 79,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_stroke_distance",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageTemperature" -> <|
                "Comment"         -> "1 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageTemperature",
                "Index"           -> 142,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "DegreesCelsius", 1, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "avg_temperature",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "AverageTotalHemoglobinConcentration" -> <|
                "Comment"         -> "100 * g/dL + 0, Avg saturated and unsaturated hemoglobin",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "AverageTotalHemoglobinConcentration",
                "Index"           -> 111;;111,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Deciliters"^(-1) * "Grams", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_total_hemoglobin_conc",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageVerticalOscillation" -> <|
                "Comment"         -> "10 * mm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageVerticalOscillation",
                "Index"           -> 108,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_vertical_oscillation",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "AverageVerticalRatio" -> <|
                "Comment"         -> "100 * percent + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "AverageVerticalRatio",
                "Index"           -> 120,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "avg_vertical_ratio",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "BestLapIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "BestLapIndex",
                "Index"           -> 94,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "best_lap_index",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "EnhancedAverageAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "EnhancedAverageAltitude",
                "Index"           -> 55,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 5, 500 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "enhanced_avg_altitude",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "EnhancedAverageSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0, total_distance / total_timer_time",
                "Dimensions"      -> { },
                "FieldName"       -> "EnhancedAverageSpeed",
                "Index"           -> 53,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "enhanced_avg_speed",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "EnhancedMaximumAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "EnhancedMaximumAltitude",
                "Index"           -> 57,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 5, 500 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "enhanced_max_altitude",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "EnhancedMaximumSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "EnhancedMaximumSpeed",
                "Index"           -> 54,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "enhanced_max_speed",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "EnhancedMinimumAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "EnhancedMinimumAltitude",
                "Index"           -> 56,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 5, 500 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "enhanced_min_altitude",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Event" -> <|
                "Comment"         -> "session",
                "Dimensions"      -> { },
                "FieldName"       -> "Event",
                "Index"           -> 128,
                "Interpreter"     -> { "fitEnum", "Event" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "event",
                "NativeType"      -> "FIT_EVENT",
                "Type"            -> "Event"
            |>
            ,
            "EventGroup" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "EventGroup",
                "Index"           -> 137,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "event_group",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "EventType" -> <|
                "Comment"         -> "stop",
                "Dimensions"      -> { },
                "FieldName"       -> "EventType",
                "Index"           -> 129,
                "Interpreter"     -> { "fitEnum", "EventType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "event_type",
                "NativeType"      -> "FIT_EVENT_TYPE",
                "Type"            -> "EventType"
            |>
            ,
            "FirstLapIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "FirstLapIndex",
                "Index"           -> 72,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "first_lap_index",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "GPSAccuracy" -> <|
                "Comment"         -> "1 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "GPSAccuracy",
                "Index"           -> 141,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Meters", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "gps_accuracy",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "IntensityFactor" -> <|
                "Comment"         -> "1000 * if + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "IntensityFactor",
                "Index"           -> 77,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "intensity_factor",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "JumpCount" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "JumpCount",
                "Index"           -> 124,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "jump_count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "LeftRightBalance" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "LeftRightBalance",
                "Index"           -> 78,
                "Interpreter"     -> { "fitEnum", "LeftRightBalance100" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "left_right_balance",
                "NativeType"      -> "FIT_LEFT_RIGHT_BALANCE_100",
                "Type"            -> "LeftRightBalance100"
            |>
            ,
            "LightElectricalVehicleBatteryConsumption" -> <|
                "Comment"         -> "2 * percent + 0, lev battery consumption during session",
                "Dimensions"      -> { },
                "FieldName"       -> "LightElectricalVehicleBatteryConsumption",
                "Index"           -> 168,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Percent", 2, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "lev_battery_consumption",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MaximumAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumAltitude",
                "Index"           -> 84,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 5, 500 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_altitude",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumBallSpeed" -> <|
                "Comment"         -> "100 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumBallSpeed",
                "Index"           -> 106,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_ball_speed",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumCadence" -> <|
                "Comment"         -> "1 * rpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumCadence",
                "Index"           -> 135,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "max_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MaximumCadencePosition" -> <|
                "Comment"         -> "1 * rpm + 0, Maximum cadence by position. Data value indexes defined by rider_position_type.",
                "Dimensions"      -> { 2 },
                "FieldName"       -> "MaximumCadencePosition",
                "Index"           -> 166;;167,
                "Interpreter"     -> { "fitQuantity", "fitUINT8A", "RevolutionsPerMinute", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "max_cadence_position",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MaximumCoreTemperature" -> <|
                "Comment"         -> "100 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumCoreTemperature",
                "Index"           -> 127,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DegreesCelsius", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_core_temperature",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumFractionalCadence" -> <|
                "Comment"         -> "128 * rpm + 0, fractional part of the max_cadence",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumFractionalCadence",
                "Index"           -> 146,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "RevolutionsPerMinute", 128, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "max_fractional_cadence",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MaximumHeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumHeartRate",
                "Index"           -> 133,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "max_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MaximumLightElectricalVehicleMotorPower" -> <|
                "Comment"         -> "1 * watts + 0, lev maximum motor power during session",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumLightElectricalVehicleMotorPower",
                "Index"           -> 119,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_lev_motor_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumNegativeGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumNegativeGrade",
                "Index"           -> 89,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "max_neg_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "MaximumNegativeVerticalSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumNegativeVerticalSpeed",
                "Index"           -> 93,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "max_neg_vertical_speed",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "MaximumPositiveGrade" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumPositiveGrade",
                "Index"           -> 88,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "Percent", 100, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "max_pos_grade",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "MaximumPositiveVerticalSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumPositiveVerticalSpeed",
                "Index"           -> 92,
                "Interpreter"     -> { "fitQuantity", "fitSINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 32767,
                "NativeFieldName" -> "max_pos_vertical_speed",
                "NativeType"      -> "FIT_SINT16",
                "Type"            -> "SignedInteger16"
            |>
            ,
            "MaximumPower" -> <|
                "Comment"         -> "1 * watts + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumPower",
                "Index"           -> 69,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumPowerPosition" -> <|
                "Comment"         -> "1 * watts + 0, Maximum power by position. Data value indexes defined by rider_position_type.",
                "Dimensions"      -> { 2 },
                "FieldName"       -> "MaximumPowerPosition",
                "Index"           -> 51;;52,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_power_position",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumSaturatedHemoglobinPercent" -> <|
                "Comment"         -> "10 * % + 0, Max percentage of hemoglobin saturated with oxygen",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "MaximumSaturatedHemoglobinPercent",
                "Index"           -> 116;;116,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Percent", 10, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_saturated_hemoglobin_percent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumSpeed",
                "Index"           -> 67,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_speed",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MaximumTemperature" -> <|
                "Comment"         -> "1 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumTemperature",
                "Index"           -> 143,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "DegreesCelsius", 1, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "max_temperature",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "MaximumTotalHemoglobinConcentration" -> <|
                "Comment"         -> "100 * g/dL + 0, Max saturated and unsaturated hemoglobin",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "MaximumTotalHemoglobinConcentration",
                "Index"           -> 113;;113,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Deciliters"^(-1) * "Grams", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "max_total_hemoglobin_conc",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MessageIndex" -> <|
                "Comment"         -> "Selected bit is set for the current session.",
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 63,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "MinimumAltitude" -> <|
                "Comment"         -> "5 * m + 500",
                "Dimensions"      -> { },
                "FieldName"       -> "MinimumAltitude",
                "Index"           -> 95,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 5, 500 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "min_altitude",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MinimumCoreTemperature" -> <|
                "Comment"         -> "100 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MinimumCoreTemperature",
                "Index"           -> 126,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DegreesCelsius", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "min_core_temperature",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MinimumHeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MinimumHeartRate",
                "Index"           -> 144,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "min_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MinimumSaturatedHemoglobinPercent" -> <|
                "Comment"         -> "10 * % + 0, Min percentage of hemoglobin saturated with oxygen",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "MinimumSaturatedHemoglobinPercent",
                "Index"           -> 115;;115,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Percent", 10, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "min_saturated_hemoglobin_percent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MinimumTotalHemoglobinConcentration" -> <|
                "Comment"         -> "100 * g/dL + 0, Min saturated and unsaturated hemoglobin",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "MinimumTotalHemoglobinConcentration",
                "Index"           -> 112;;112,
                "Interpreter"     -> { "fitQuantity", "fitUINT16A", "Deciliters"^(-1) * "Grams", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "min_total_hemoglobin_conc",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "NormalizedPower" -> <|
                "Comment"         -> "1 * watts + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "NormalizedPower",
                "Index"           -> 75,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "normalized_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "NorthEastCornerLatitude" -> <|
                "Comment"         -> "1 * semicircles + 0, North east corner latitude",
                "Dimensions"      -> { },
                "FieldName"       -> "NorthEastCornerLatitude",
                "Index"           -> 10,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "nec_lat",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "NorthEastCornerLongitude" -> <|
                "Comment"         -> "1 * semicircles + 0, North east corner longitude",
                "Dimensions"      -> { },
                "FieldName"       -> "NorthEastCornerLongitude",
                "Index"           -> 11,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "nec_long",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "NumberOfActiveLengths" -> <|
                "Comment"         -> "1 * lengths + 0, # of active lengths of swim pool",
                "Dimensions"      -> { },
                "FieldName"       -> "NumberOfActiveLengths",
                "Index"           -> 82,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "num_active_lengths",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "NumberOfLaps" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "NumberOfLaps",
                "Index"           -> 73,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "num_laps",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "NumberOfLengths" -> <|
                "Comment"         -> "1 * lengths + 0, # of lengths of swim pool",
                "Dimensions"      -> { },
                "FieldName"       -> "NumberOfLengths",
                "Index"           -> 74,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "num_lengths",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "OpponentName" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "OpponentName",
                "Index"           -> 32;;47,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "opponent_name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "OpponentScore" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "OpponentScore",
                "Index"           -> 97,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "opponent_score",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "PlayerScore" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "PlayerScore",
                "Index"           -> 96,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "player_score",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "PoolLength" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "PoolLength",
                "Index"           -> 80,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "pool_length",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "PoolLengthUnit" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "PoolLengthUnit",
                "Index"           -> 140,
                "Interpreter"     -> { "fitEnum", "DisplayMeasure" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "pool_length_unit",
                "NativeType"      -> "FIT_DISPLAY_MEASURE",
                "Type"            -> "DisplayMeasure"
            |>
            ,
            "SouthWestCornerLatitude" -> <|
                "Comment"         -> "1 * semicircles + 0, South west corner latitude",
                "Dimensions"      -> { },
                "FieldName"       -> "SouthWestCornerLatitude",
                "Index"           -> 12,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "swc_lat",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "SouthWestCornerLongitude" -> <|
                "Comment"         -> "1 * semicircles + 0, South west corner longitude",
                "Dimensions"      -> { },
                "FieldName"       -> "SouthWestCornerLongitude",
                "Index"           -> 13,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "swc_long",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "Sport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Sport",
                "Index"           -> 130,
                "Interpreter"     -> { "fitEnum", "Sport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sport",
                "NativeType"      -> "FIT_SPORT",
                "Type"            -> "Sport"
            |>
            ,
            "SportIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SportIndex",
                "Index"           -> 153,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "sport_index",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "StandCount" -> <|
                "Comment"         -> "Number of transitions to the standing state",
                "Dimensions"      -> { },
                "FieldName"       -> "StandCount",
                "Index"           -> 117,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "stand_count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "StartPositionLatitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "StartPositionLatitude",
                "Index"           -> 4,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "start_position_lat",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "StartPositionLongitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "StartPositionLongitude",
                "Index"           -> 5,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "start_position_long",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "StartTime" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "StartTime",
                "Index"           -> 3,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "start_time",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "StrokeCount" -> <|
                "Comment"         -> "1 * counts + 0, stroke_type enum used as the index",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "StrokeCount",
                "Index"           -> 98;;98,
                "Interpreter"     -> "fitUINT16A",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "stroke_count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "SubSport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SubSport",
                "Index"           -> 131,
                "Interpreter"     -> { "fitEnum", "SubSport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sub_sport",
                "NativeType"      -> "FIT_SUB_SPORT",
                "Type"            -> "SubSport"
            |>
            ,
            "SwimStroke" -> <|
                "Comment"         -> "1 * swim_stroke + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "SwimStroke",
                "Index"           -> 139,
                "Interpreter"     -> { "fitEnum", "SwimStroke" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "swim_stroke",
                "NativeType"      -> "FIT_SWIM_STROKE",
                "Type"            -> "SwimStroke"
            |>
            ,
            "ThresholdPower" -> <|
                "Comment"         -> "1 * watts + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "ThresholdPower",
                "Index"           -> 81,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Watts", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "threshold_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TimeInCadenceZone" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "TimeInCadenceZone",
                "Index"           -> 23;;23,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_in_cadence_zone",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TimeInHeartRateZone" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { 5 },
                "FieldName"       -> "TimeInHeartRateZone",
                "Index"           -> 17;;21,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_in_hr_zone",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TimeInPowerZone" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { 7 },
                "FieldName"       -> "TimeInPowerZone",
                "Index"           -> 24;;30,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_in_power_zone",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TimeInSpeedZone" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { 1 },
                "FieldName"       -> "TimeInSpeedZone",
                "Index"           -> 22;;22,
                "Interpreter"     -> { "fitQuantity", "fitUINT32A", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_in_speed_zone",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0, Sesson end time.",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "TimeStanding" -> <|
                "Comment"         -> "1000 * s + 0, Total time spend in the standing position",
                "Dimensions"      -> { },
                "FieldName"       -> "TimeStanding",
                "Index"           -> 48,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "time_standing",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalAnaerobicTrainingEffect" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "TotalAnaerobicTrainingEffect",
                "Index"           -> 169,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "total_anaerobic_training_effect",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "TotalAscent" -> <|
                "Comment"         -> "1 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalAscent",
                "Index"           -> 70,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_ascent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalCalories" -> <|
                "Comment"         -> "1 * kcal + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalCalories",
                "Index"           -> 64,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DietaryCalories", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_calories",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalCycles" -> <|
                "Comment"         -> "1 * cycles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalCycles",
                "Index"           -> 9,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Cycles", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_cycles",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalDescent" -> <|
                "Comment"         -> "1 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalDescent",
                "Index"           -> 71,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_descent",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalDistance" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalDistance",
                "Index"           -> 8,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 100, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_distance",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalElapsedTime" -> <|
                "Comment"         -> "1000 * s + 0, Time (includes pauses)",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalElapsedTime",
                "Index"           -> 6,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_elapsed_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalFatCalories" -> <|
                "Comment"         -> "1 * kcal + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalFatCalories",
                "Index"           -> 65,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "DietaryCalories", 1, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "total_fat_calories",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "TotalFlow" -> <|
                "Comment"         -> "1 * Flow + 0, The flow score estimates how long distance wise a cyclist deaccelerates over intervals where deacceleration is unnecessary such as smooth turns or small grade angle intervals.",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalFlow",
                "Index"           -> 60,
                "Interpreter"     -> "fitFloat32",
                "Invalid"         -> -9223372036854775808,
                "NativeFieldName" -> "total_flow",
                "NativeType"      -> "FIT_FLOAT32",
                "Type"            -> "Real32"
            |>
            ,
            "TotalFractionalAscent" -> <|
                "Comment"         -> "100 * m + 0, fractional part of total_ascent",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalFractionalAscent",
                "Index"           -> 170,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Meters", 100, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "total_fractional_ascent",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "TotalFractionalCycles" -> <|
                "Comment"         -> "128 * cycles + 0, fractional part of the total_cycles",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalFractionalCycles",
                "Index"           -> 147,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "total_fractional_cycles",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "TotalFractionalDescent" -> <|
                "Comment"         -> "100 * m + 0, fractional part of total_descent",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalFractionalDescent",
                "Index"           -> 171,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Meters", 100, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "total_fractional_descent",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "TotalGrit" -> <|
                "Comment"         -> "1 * kGrit + 0, The grit score estimates how challenging a route could be for a cyclist in terms of time spent going over sharp turns or large grade slopes.",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalGrit",
                "Index"           -> 59,
                "Interpreter"     -> "fitFloat32",
                "Invalid"         -> -9223372036854775808,
                "NativeFieldName" -> "total_grit",
                "NativeType"      -> "FIT_FLOAT32",
                "Type"            -> "Real32"
            |>
            ,
            "TotalMovingTime" -> <|
                "Comment"         -> "1000 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalMovingTime",
                "Index"           -> 16,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_moving_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalTimerTime" -> <|
                "Comment"         -> "1000 * s + 0, Timer Time (excludes pauses)",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalTimerTime",
                "Index"           -> 7,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1000, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_timer_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TotalTrainingEffect" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "TotalTrainingEffect",
                "Index"           -> 136,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "total_training_effect",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "TotalWork" -> <|
                "Comment"         -> "1 * J + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TotalWork",
                "Index"           -> 15,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Joules", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "total_work",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TrainingLoadPeak" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "TrainingLoadPeak",
                "Index"           -> 58,
                "Interpreter"     -> "fitSINT32",
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "training_load_peak",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "TrainingStressScore" -> <|
                "Comment"         -> "10 * tss + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "TrainingStressScore",
                "Index"           -> 76,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "training_stress_score",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Trigger" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Trigger",
                "Index"           -> 138,
                "Interpreter"     -> { "fitEnum", "SessionTrigger" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "trigger",
                "NativeType"      -> "FIT_SESSION_TRIGGER",
                "Type"            -> "SessionTrigger"
            |>
            ,
            "ZoneCount" -> <|
                "Comment"         -> "1 * counts + 0, zone number used as the index",
                "Dimensions"      -> { 7 },
                "FieldName"       -> "ZoneCount",
                "Index"           -> 99;;105,
                "Interpreter"     -> "fitUINT16A",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "zone_count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
        |>
    |>
    ,
    "Set" -> <|
        "MessageName"   -> "Set",
        "MessageNumber" -> 225,
        "Size"          -> 2,
        "Fields"        -> <|
            "WeightDisplayUnit" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "WeightDisplayUnit",
                "Index"           -> 2,
                "Interpreter"     -> { "fitEnum", "FitBaseUnit" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "weight_display_unit",
                "NativeType"      -> "FIT_FIT_BASE_UNIT",
                "Type"            -> "FitBaseUnit"
            |>
        |>
    |>
    ,
    "SlaveDevice" -> <|
        "MessageName"   -> "SlaveDevice",
        "MessageNumber" -> 106,
        "Size"          -> 3,
        "Fields"        -> <|
            "Manufacturer" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Manufacturer",
                "Index"           -> 2,
                "Interpreter"     -> { "fitEnum", "Manufacturer" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "manufacturer",
                "NativeType"      -> "FIT_MANUFACTURER",
                "Type"            -> "Manufacturer"
            |>
            ,
            "Product" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Product",
                "Index"           -> 3,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "product",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
        |>
    |>
    ,
    "Software" -> <|
        "MessageName"   -> "Software",
        "MessageNumber" -> 35,
        "Size"          -> 19,
        "Fields"        -> <|
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 18,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "PartNumber" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "PartNumber",
                "Index"           -> 2;;17,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "part_number",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "Version" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Version",
                "Index"           -> 19,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "version",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
        |>
    |>
    ,
    "SpeedZone" -> <|
        "MessageName"   -> "SpeedZone",
        "MessageNumber" -> 53,
        "Size"          -> 19,
        "Fields"        -> <|
            "HighValue" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "HighValue",
                "Index"           -> 19,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "high_value",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 18,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Name" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "Name",
                "Index"           -> 2;;17,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
        |>
    |>
    ,
    "Sport" -> <|
        "MessageName"   -> "Sport",
        "MessageNumber" -> 12,
        "Size"          -> 19,
        "Fields"        -> <|
            "Name" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "Name",
                "Index"           -> 2;;17,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "Sport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Sport",
                "Index"           -> 18,
                "Interpreter"     -> { "fitEnum", "Sport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sport",
                "NativeType"      -> "FIT_SPORT",
                "Type"            -> "Sport"
            |>
            ,
            "SubSport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SubSport",
                "Index"           -> 19,
                "Interpreter"     -> { "fitEnum", "SubSport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sub_sport",
                "NativeType"      -> "FIT_SUB_SPORT",
                "Type"            -> "SubSport"
            |>
        |>
    |>
    ,
    "StrideAndDistanceMonitorProfile" -> <|
        "MessageName"   -> "StrideAndDistanceMonitorProfile",
        "MessageNumber" -> 5,
        "Size"          -> 9,
        "Fields"        -> <|
            "Enabled" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Enabled",
                "Index"           -> 6,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "enabled",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 3,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Odometer" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Odometer",
                "Index"           -> 2,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 100, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "odometer",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "OdometerRollover" -> <|
                "Comment"         -> "Rollover counter that can be used to extend the odometer",
                "Dimensions"      -> { },
                "FieldName"       -> "OdometerRollover",
                "Index"           -> 9,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "odometer_rollover",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "SpeedSource" -> <|
                "Comment"         -> "Use footpod for speed source instead of GPS",
                "Dimensions"      -> { },
                "FieldName"       -> "SpeedSource",
                "Index"           -> 7,
                "Interpreter"     -> "fitBool",
                "Invalid"         -> 255,
                "NativeFieldName" -> "speed_source",
                "NativeType"      -> "FIT_BOOL",
                "Type"            -> "Boolean"
            |>
            ,
            "StrideAndDistanceMonitorANTID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "StrideAndDistanceMonitorANTID",
                "Index"           -> 4,
                "Interpreter"     -> "fitUINT16Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "sdm_ant_id",
                "NativeType"      -> "FIT_UINT16Z",
                "Type"            -> "UnsignedInteger16Z"
            |>
            ,
            "StrideAndDistanceMonitorANTIDTransmissionType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "StrideAndDistanceMonitorANTIDTransmissionType",
                "Index"           -> 8,
                "Interpreter"     -> "fitUINT8Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "sdm_ant_id_trans_type",
                "NativeType"      -> "FIT_UINT8Z",
                "Type"            -> "UnsignedInteger8Z"
            |>
            ,
            "StrideAndDistanceMonitorCalibrationFactor" -> <|
                "Comment"         -> "10 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "StrideAndDistanceMonitorCalibrationFactor",
                "Index"           -> 5,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 10, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "sdm_cal_factor",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
        |>
    |>
    ,
    "Totals" -> <|
        "MessageName"   -> "Totals",
        "MessageNumber" -> 33,
        "Size"          -> 10,
        "Fields"        -> <|
            "ActiveTime" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "ActiveTime",
                "Index"           -> 7,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "active_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Calories" -> <|
                "Comment"         -> "1 * kcal + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Calories",
                "Index"           -> 5,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "DietaryCalories", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "calories",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Distance" -> <|
                "Comment"         -> "1 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Distance",
                "Index"           -> 4,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Meters", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "distance",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "ElapsedTime" -> <|
                "Comment"         -> "1 * s + 0, Includes pauses",
                "Dimensions"      -> { },
                "FieldName"       -> "ElapsedTime",
                "Index"           -> 6,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "elapsed_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 8,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Sessions" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Sessions",
                "Index"           -> 9,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "sessions",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "Sport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Sport",
                "Index"           -> 10,
                "Interpreter"     -> { "fitEnum", "Sport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sport",
                "NativeType"      -> "FIT_SPORT",
                "Type"            -> "Sport"
            |>
            ,
            "TimerTime" -> <|
                "Comment"         -> "1 * s + 0, Excludes pauses",
                "Dimensions"      -> { },
                "FieldName"       -> "TimerTime",
                "Index"           -> 3,
                "Interpreter"     -> { "fitQuantity", "fitUINT32", "Seconds", 1, 0 },
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "timer_time",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
        |>
    |>
    ,
    "TrainingFile" -> <|
        "MessageName"   -> "TrainingFile",
        "MessageNumber" -> 72,
        "Size"          -> 7,
        "Fields"        -> <|
            "Manufacturer" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Manufacturer",
                "Index"           -> 5,
                "Interpreter"     -> { "fitEnum", "Manufacturer" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "manufacturer",
                "NativeType"      -> "FIT_MANUFACTURER",
                "Type"            -> "Manufacturer"
            |>
            ,
            "Product" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Product",
                "Index"           -> 6,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "product",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "SerialNumber" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SerialNumber",
                "Index"           -> 3,
                "Interpreter"     -> "fitUINT32Z",
                "Invalid"         -> 0,
                "NativeFieldName" -> "serial_number",
                "NativeType"      -> "FIT_UINT32Z",
                "Type"            -> "UnsignedInteger32Z"
            |>
            ,
            "TimeCreated" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "TimeCreated",
                "Index"           -> 4,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "time_created",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "Timestamp" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "Type" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Type",
                "Index"           -> 7,
                "Interpreter"     -> { "fitEnum", "File" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "type",
                "NativeType"      -> "FIT_FILE",
                "Type"            -> "File"
            |>
        |>
    |>
    ,
    "UserProfile" -> <|
        "MessageName"   -> "UserProfile",
        "MessageNumber" -> 3,
        "Size"          -> 50,
        "Fields"        -> <|
            "ActivityClass" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ActivityClass",
                "Index"           -> 40,
                "Interpreter"     -> { "fitEnum", "ActivityClass" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "activity_class",
                "NativeType"      -> "FIT_ACTIVITY_CLASS",
                "Type"            -> "ActivityClass"
            |>
            ,
            "Age" -> <|
                "Comment"         -> "1 * years + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Age",
                "Index"           -> 27,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Years", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "age",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "DefaultMaximumBikingHeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "DefaultMaximumBikingHeartRate",
                "Index"           -> 34,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "default_max_biking_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "DefaultMaximumHeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "DefaultMaximumHeartRate",
                "Index"           -> 35,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "default_max_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "DefaultMaximumRunningHeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "DefaultMaximumRunningHeartRate",
                "Index"           -> 33,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "default_max_running_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "DepthSetting" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DepthSetting",
                "Index"           -> 50,
                "Interpreter"     -> { "fitEnum", "DisplayMeasure" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "depth_setting",
                "NativeType"      -> "FIT_DISPLAY_MEASURE",
                "Type"            -> "DisplayMeasure"
            |>
            ,
            "DistanceSetting" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DistanceSetting",
                "Index"           -> 38,
                "Interpreter"     -> { "fitEnum", "DisplayMeasure" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "dist_setting",
                "NativeType"      -> "FIT_DISPLAY_MEASURE",
                "Type"            -> "DisplayMeasure"
            |>
            ,
            "DiveCount" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DiveCount",
                "Index"           -> 20,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "dive_count",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "ElevationSetting" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ElevationSetting",
                "Index"           -> 30,
                "Interpreter"     -> { "fitEnum", "DisplayMeasure" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "elev_setting",
                "NativeType"      -> "FIT_DISPLAY_MEASURE",
                "Type"            -> "DisplayMeasure"
            |>
            ,
            "FriendlyName" -> <|
                "Dimensions"      -> { 16 },
                "FieldName"       -> "FriendlyName",
                "Index"           -> 2;;17,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "friendly_name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "Gender" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Gender",
                "Index"           -> 26,
                "Interpreter"     -> { "fitEnum", "Gender" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "gender",
                "NativeType"      -> "FIT_GENDER",
                "Type"            -> "Gender"
            |>
            ,
            "GlobalID" -> <|
                "Dimensions"      -> { 6 },
                "FieldName"       -> "GlobalID",
                "Index"           -> 43;;48,
                "Interpreter"     -> "fitByteA",
                "Invalid"         -> 255,
                "NativeFieldName" -> "global_id",
                "NativeType"      -> "FIT_BYTE",
                "Type"            -> "Byte"
            |>
            ,
            "HeartRateSetting" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "HeartRateSetting",
                "Index"           -> 36,
                "Interpreter"     -> { "fitEnum", "DisplayHeart" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "hr_setting",
                "NativeType"      -> "FIT_DISPLAY_HEART",
                "Type"            -> "DisplayHeart"
            |>
            ,
            "Height" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Height",
                "Index"           -> 28,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Meters", 100, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "height",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "HeightSetting" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "HeightSetting",
                "Index"           -> 49,
                "Interpreter"     -> { "fitEnum", "DisplayMeasure" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "height_setting",
                "NativeType"      -> "FIT_DISPLAY_MEASURE",
                "Type"            -> "DisplayMeasure"
            |>
            ,
            "Language" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Language",
                "Index"           -> 29,
                "Interpreter"     -> "fitLanguage",
                "Invalid"         -> 255,
                "NativeFieldName" -> "language",
                "NativeType"      -> "FIT_LANGUAGE",
                "Type"            -> "Language"
            |>
            ,
            "LocalID" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "LocalID",
                "Index"           -> 23,
                "Interpreter"     -> { "fitEnum", "UserLocalID" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "local_id",
                "NativeType"      -> "FIT_USER_LOCAL_ID",
                "Type"            -> "UserLocalID"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 21,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "PositionSetting" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "PositionSetting",
                "Index"           -> 41,
                "Interpreter"     -> { "fitEnum", "DisplayPosition" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "position_setting",
                "NativeType"      -> "FIT_DISPLAY_POSITION",
                "Type"            -> "DisplayPosition"
            |>
            ,
            "PowerSetting" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "PowerSetting",
                "Index"           -> 39,
                "Interpreter"     -> { "fitEnum", "DisplayPower" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "power_setting",
                "NativeType"      -> "FIT_DISPLAY_POWER",
                "Type"            -> "DisplayPower"
            |>
            ,
            "RestingHeartRate" -> <|
                "Comment"         -> "1 * bpm + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "RestingHeartRate",
                "Index"           -> 32,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Beats" / "Minutes", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "resting_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "SleepTime" -> <|
                "Comment"         -> "Typical bed time",
                "Dimensions"      -> { },
                "FieldName"       -> "SleepTime",
                "Index"           -> 19,
                "Interpreter"     -> "fitTimeOfDay",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "sleep_time",
                "NativeType"      -> "FIT_LOCALTIME_INTO_DAY",
                "Type"            -> "LocalTimeIntoDay"
            |>
            ,
            "SpeedSetting" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SpeedSetting",
                "Index"           -> 37,
                "Interpreter"     -> { "fitEnum", "DisplayMeasure" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "speed_setting",
                "NativeType"      -> "FIT_DISPLAY_MEASURE",
                "Type"            -> "DisplayMeasure"
            |>
            ,
            "TemperatureSetting" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "TemperatureSetting",
                "Index"           -> 42,
                "Interpreter"     -> { "fitEnum", "DisplayMeasure" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "temperature_setting",
                "NativeType"      -> "FIT_DISPLAY_MEASURE",
                "Type"            -> "DisplayMeasure"
            |>
            ,
            "UserRunningStepLength" -> <|
                "Comment"         -> "1000 * m + 0, User defined running step length set to 0 for auto length",
                "Dimensions"      -> { },
                "FieldName"       -> "UserRunningStepLength",
                "Index"           -> 24,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "user_running_step_length",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "UserWalkingStepLength" -> <|
                "Comment"         -> "1000 * m + 0, User defined walking step length set to 0 for auto length",
                "Dimensions"      -> { },
                "FieldName"       -> "UserWalkingStepLength",
                "Index"           -> 25,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "user_walking_step_length",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "WakeTime" -> <|
                "Comment"         -> "Typical wake time",
                "Dimensions"      -> { },
                "FieldName"       -> "WakeTime",
                "Index"           -> 18,
                "Interpreter"     -> "fitTimeOfDay",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "wake_time",
                "NativeType"      -> "FIT_LOCALTIME_INTO_DAY",
                "Type"            -> "LocalTimeIntoDay"
            |>
            ,
            "Weight" -> <|
                "Comment"         -> "10 * kg + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Weight",
                "Index"           -> 22,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Grams", 0.01, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "weight",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "WeightSetting" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "WeightSetting",
                "Index"           -> 31,
                "Interpreter"     -> { "fitEnum", "DisplayMeasure" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "weight_setting",
                "NativeType"      -> "FIT_DISPLAY_MEASURE",
                "Type"            -> "DisplayMeasure"
            |>
        |>
    |>
    ,
    "VideoDescription" -> <|
        "MessageName"   -> "VideoDescription",
        "MessageNumber" -> 186,
        "Size"          -> 131,
        "Fields"        -> <|
            "MessageCount" -> <|
                "Comment"         -> "Total number of description parts",
                "Dimensions"      -> { },
                "FieldName"       -> "MessageCount",
                "Index"           -> 131,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MessageIndex" -> <|
                "Comment"         -> "Long descriptions will be split into multiple parts",
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 130,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Text" -> <|
                "Dimensions"      -> { 128 },
                "FieldName"       -> "Text",
                "Index"           -> 2;;129,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "text",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
        |>
    |>
    ,
    "VideoTitle" -> <|
        "MessageName"   -> "VideoTitle",
        "MessageNumber" -> 185,
        "Size"          -> 83,
        "Fields"        -> <|
            "MessageCount" -> <|
                "Comment"         -> "Total number of title parts",
                "Dimensions"      -> { },
                "FieldName"       -> "MessageCount",
                "Index"           -> 83,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_count",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MessageIndex" -> <|
                "Comment"         -> "Long titles will be split into multiple parts",
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 82,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Text" -> <|
                "Dimensions"      -> { 80 },
                "FieldName"       -> "Text",
                "Index"           -> 2;;81,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "text",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
        |>
    |>
    ,
    "WeatherAlert" -> <|
        "MessageName"   -> "WeatherAlert",
        "MessageNumber" -> 129,
        "Size"          -> 18,
        "Fields"        -> <|
            "ExpireTime" -> <|
                "Comment"         -> "Time alert expires",
                "Dimensions"      -> { },
                "FieldName"       -> "ExpireTime",
                "Index"           -> 16,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "expire_time",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "IssueTime" -> <|
                "Comment"         -> "Time alert was issued",
                "Dimensions"      -> { },
                "FieldName"       -> "IssueTime",
                "Index"           -> 15,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "issue_time",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "ReportID" -> <|
                "Comment"         -> "Unique identifier from GCS report ID string, length is 12",
                "Dimensions"      -> { 12 },
                "FieldName"       -> "ReportID",
                "Index"           -> 3;;14,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "report_id",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "Severity" -> <|
                "Comment"         -> "Warning, Watch, Advisory, Statement",
                "Dimensions"      -> { },
                "FieldName"       -> "Severity",
                "Index"           -> 17,
                "Interpreter"     -> { "fitEnum", "WeatherSeverity" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "severity",
                "NativeType"      -> "FIT_WEATHER_SEVERITY",
                "Type"            -> "WeatherSeverity"
            |>
            ,
            "Timestamp" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "Type" -> <|
                "Comment"         -> "Tornado, Severe Thunderstorm, etc.",
                "Dimensions"      -> { },
                "FieldName"       -> "Type",
                "Index"           -> 18,
                "Interpreter"     -> { "fitEnum", "WeatherSevereType" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "type",
                "NativeType"      -> "FIT_WEATHER_SEVERE_TYPE",
                "Type"            -> "WeatherSevereType"
            |>
        |>
    |>
    ,
    "WeatherConditions" -> <|
        "MessageName"   -> "WeatherConditions",
        "MessageNumber" -> 128,
        "Size"          -> 80,
        "Fields"        -> <|
            "Condition" -> <|
                "Comment"         -> "Corresponds to GSC Response weatherIcon field",
                "Dimensions"      -> { },
                "FieldName"       -> "Condition",
                "Index"           -> 74,
                "Interpreter"     -> { "fitEnum", "WeatherStatus" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "condition",
                "NativeType"      -> "FIT_WEATHER_STATUS",
                "Type"            -> "WeatherStatus"
            |>
            ,
            "DayOfWeek" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DayOfWeek",
                "Index"           -> 78,
                "Interpreter"     -> { "fitEnum", "DayOfWeek" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "day_of_week",
                "NativeType"      -> "FIT_DAY_OF_WEEK",
                "Type"            -> "DayOfWeek"
            |>
            ,
            "HighTemperature" -> <|
                "Comment"         -> "1 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "HighTemperature",
                "Index"           -> 79,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "DegreesCelsius", 1, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "high_temperature",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "Location" -> <|
                "Comment"         -> "string corresponding to GCS response location string",
                "Dimensions"      -> { 64 },
                "FieldName"       -> "Location",
                "Index"           -> 3;;66,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "location",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "LowTemperature" -> <|
                "Comment"         -> "1 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "LowTemperature",
                "Index"           -> 80,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "DegreesCelsius", 1, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "low_temperature",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "ObservedAtTime" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ObservedAtTime",
                "Index"           -> 67,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "observed_at_time",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "ObservedLatitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "ObservedLatitude",
                "Index"           -> 68,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "observed_location_lat",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "ObservedLongitude" -> <|
                "Comment"         -> "1 * semicircles + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "ObservedLongitude",
                "Index"           -> 69,
                "Interpreter"     -> { "fitQuantity", "fitSINT32", "AngularDegrees", 1.19304647*^7, 0 },
                "Invalid"         -> 2147483647,
                "NativeFieldName" -> "observed_location_long",
                "NativeType"      -> "FIT_SINT32",
                "Type"            -> "SignedInteger32"
            |>
            ,
            "PrecipitationProbability" -> <|
                "Comment"         -> "range 0-100",
                "Dimensions"      -> { },
                "FieldName"       -> "PrecipitationProbability",
                "Index"           -> 75,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "precipitation_probability",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "RelativeHumidity" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "RelativeHumidity",
                "Index"           -> 77,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "relative_humidity",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Temperature" -> <|
                "Comment"         -> "1 * C + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Temperature",
                "Index"           -> 73,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "DegreesCelsius", 1, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "temperature",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "TemperatureFeelsLike" -> <|
                "Comment"         -> "1 * C + 0, Heat Index if GCS heatIdx above or equal to 90F or wind chill if GCS windChill below or equal to 32F",
                "Dimensions"      -> { },
                "FieldName"       -> "TemperatureFeelsLike",
                "Index"           -> 76,
                "Interpreter"     -> { "fitQuantity", "fitSINT8", "DegreesCelsius", 1, 0 },
                "Invalid"         -> 127,
                "NativeFieldName" -> "temperature_feels_like",
                "NativeType"      -> "FIT_SINT8",
                "Type"            -> "SignedInteger8"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "time of update for current conditions, else forecast time",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "WeatherReport" -> <|
                "Comment"         -> "Current or forecast",
                "Dimensions"      -> { },
                "FieldName"       -> "WeatherReport",
                "Index"           -> 72,
                "Interpreter"     -> { "fitEnum", "WeatherReport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "weather_report",
                "NativeType"      -> "FIT_WEATHER_REPORT",
                "Type"            -> "WeatherReport"
            |>
            ,
            "WindDirection" -> <|
                "Comment"         -> "1 * degrees + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "WindDirection",
                "Index"           -> 70,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "wind_direction",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "WindSpeed" -> <|
                "Comment"         -> "1000 * m/s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "WindSpeed",
                "Index"           -> 71,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "MetersPerSecond", 1000, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "wind_speed",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
        |>
    |>
    ,
    "WeightScale" -> <|
        "MessageName"   -> "WeightScale",
        "MessageNumber" -> 30,
        "Size"          -> 14,
        "Fields"        -> <|
            "ActiveMetabolicRate" -> <|
                "Comment"         -> "4 * kcal/day + 0, ~4kJ per kcal, 0.25 allows max 16384 kcal",
                "Dimensions"      -> { },
                "FieldName"       -> "ActiveMetabolicRate",
                "Index"           -> 10,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "active_met",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "BasalMetabolicRate" -> <|
                "Comment"         -> "4 * kcal/day + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "BasalMetabolicRate",
                "Index"           -> 9,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "basal_met",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "BoneMass" -> <|
                "Comment"         -> "100 * kg + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "BoneMass",
                "Index"           -> 7,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "bone_mass",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MetabolicAge" -> <|
                "Comment"         -> "1 * years + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MetabolicAge",
                "Index"           -> 13,
                "Interpreter"     -> { "fitQuantity", "fitUINT8", "Years", 1, 0 },
                "Invalid"         -> 255,
                "NativeFieldName" -> "metabolic_age",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "MuscleMass" -> <|
                "Comment"         -> "100 * kg + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "MuscleMass",
                "Index"           -> 8,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "muscle_mass",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "PercentFat" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "PercentFat",
                "Index"           -> 4,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "percent_fat",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "PercentHydration" -> <|
                "Comment"         -> "100 * % + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "PercentHydration",
                "Index"           -> 5,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Percent", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "percent_hydration",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "PhysiqueRating" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "PhysiqueRating",
                "Index"           -> 12,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "physique_rating",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Timestamp" -> <|
                "Comment"         -> "1 * s + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Timestamp",
                "Index"           -> 2,
                "Interpreter"     -> "fitDateTime",
                "Invalid"         -> 7135003695,
                "NativeFieldName" -> "timestamp",
                "NativeType"      -> "FIT_DATE_TIME",
                "Type"            -> "DateTime"
            |>
            ,
            "UserProfileIndex" -> <|
                "Comment"         -> "Associates this weight scale message to a user. This corresponds to the index of the user profile message in the weight scale file.",
                "Dimensions"      -> { },
                "FieldName"       -> "UserProfileIndex",
                "Index"           -> 11,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "user_profile_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "VisceralFatMass" -> <|
                "Comment"         -> "100 * kg + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "VisceralFatMass",
                "Index"           -> 6,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "visceral_fat_mass",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "VisceralFatRating" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "VisceralFatRating",
                "Index"           -> 14,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "visceral_fat_rating",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "Weight" -> <|
                "Comment"         -> "100 * kg + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "Weight",
                "Index"           -> 3,
                "Interpreter"     -> { "fitEnum", "Weight" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "weight",
                "NativeType"      -> "FIT_WEIGHT",
                "Type"            -> "Weight"
            |>
        |>
    |>
    ,
    "Workout" -> <|
        "MessageName"   -> "Workout",
        "MessageNumber" -> 26,
        "Size"          -> 107,
        "Fields"        -> <|
            "Capabilities" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Capabilities",
                "Index"           -> 2,
                "Interpreter"     -> { "fitEnum", "WorkoutCapabilities" },
                "Invalid"         -> 0,
                "NativeFieldName" -> "capabilities",
                "NativeType"      -> "FIT_WORKOUT_CAPABILITIES",
                "Type"            -> "WorkoutCapabilities"
            |>
            ,
            "NumberOfValidSteps" -> <|
                "Comment"         -> "number of valid steps",
                "Dimensions"      -> { },
                "FieldName"       -> "NumberOfValidSteps",
                "Index"           -> 103,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "num_valid_steps",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "PoolLength" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "PoolLength",
                "Index"           -> 104,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "pool_length",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "PoolLengthUnit" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "PoolLengthUnit",
                "Index"           -> 107,
                "Interpreter"     -> { "fitEnum", "DisplayMeasure" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "pool_length_unit",
                "NativeType"      -> "FIT_DISPLAY_MEASURE",
                "Type"            -> "DisplayMeasure"
            |>
            ,
            "Sport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Sport",
                "Index"           -> 105,
                "Interpreter"     -> { "fitEnum", "Sport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sport",
                "NativeType"      -> "FIT_SPORT",
                "Type"            -> "Sport"
            |>
            ,
            "SubSport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SubSport",
                "Index"           -> 106,
                "Interpreter"     -> { "fitEnum", "SubSport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sub_sport",
                "NativeType"      -> "FIT_SUB_SPORT",
                "Type"            -> "SubSport"
            |>
            ,
            "WorkoutName" -> <|
                "Dimensions"      -> { 100 },
                "FieldName"       -> "WorkoutName",
                "Index"           -> 3;;102,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "wkt_name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
        |>
    |>
    ,
    "WorkoutSession" -> <|
        "MessageName"   -> "WorkoutSession",
        "MessageNumber" -> 158,
        "Size"          -> 8,
        "Fields"        -> <|
            "FirstStepIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "FirstStepIndex",
                "Index"           -> 4,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "first_step_index",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "NumberOfValidSteps" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "NumberOfValidSteps",
                "Index"           -> 3,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "num_valid_steps",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "PoolLength" -> <|
                "Comment"         -> "100 * m + 0",
                "Dimensions"      -> { },
                "FieldName"       -> "PoolLength",
                "Index"           -> 5,
                "Interpreter"     -> { "fitQuantity", "fitUINT16", "Meters", 100, 0 },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "pool_length",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "PoolLengthUnit" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "PoolLengthUnit",
                "Index"           -> 8,
                "Interpreter"     -> { "fitEnum", "DisplayMeasure" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "pool_length_unit",
                "NativeType"      -> "FIT_DISPLAY_MEASURE",
                "Type"            -> "DisplayMeasure"
            |>
            ,
            "Sport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Sport",
                "Index"           -> 6,
                "Interpreter"     -> { "fitEnum", "Sport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sport",
                "NativeType"      -> "FIT_SPORT",
                "Type"            -> "Sport"
            |>
            ,
            "SubSport" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SubSport",
                "Index"           -> 7,
                "Interpreter"     -> { "fitEnum", "SubSport" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "sub_sport",
                "NativeType"      -> "FIT_SUB_SPORT",
                "Type"            -> "SubSport"
            |>
        |>
    |>
    ,
    "WorkoutStep" -> <|
        "MessageName"   -> "WorkoutStep",
        "MessageNumber" -> 27,
        "Size"          -> 113,
        "Fields"        -> <|
            "CustomTargetValueHigh" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "CustomTargetValueHigh",
                "Index"           -> 53,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "custom_target_value_high",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "CustomTargetValueLow" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "CustomTargetValueLow",
                "Index"           -> 52,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "custom_target_value_low",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "DurationType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DurationType",
                "Index"           -> 59,
                "Interpreter"     -> { "fitEnum", "WorkoutStepDuration" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "duration_type",
                "NativeType"      -> "FIT_WKT_STEP_DURATION",
                "Type"            -> "WorkoutStepDuration"
            |>
            ,
            "DurationValue" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "DurationValue",
                "Index"           -> 50,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "duration_value",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "Equipment" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Equipment",
                "Index"           -> 112,
                "Interpreter"     -> { "fitEnum", "WorkoutEquipment" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "equipment",
                "NativeType"      -> "FIT_WORKOUT_EQUIPMENT",
                "Type"            -> "WorkoutEquipment"
            |>
            ,
            "ExerciseCategory" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ExerciseCategory",
                "Index"           -> 58,
                "Interpreter"     -> { "fitEnum", "ExerciseCategory" },
                "Invalid"         -> 65535,
                "NativeFieldName" -> "exercise_category",
                "NativeType"      -> "FIT_EXERCISE_CATEGORY",
                "Type"            -> "ExerciseCategory"
            |>
            ,
            "Intensity" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "Intensity",
                "Index"           -> 61,
                "Interpreter"     -> { "fitEnum", "Intensity" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "intensity",
                "NativeType"      -> "FIT_INTENSITY",
                "Type"            -> "Intensity"
            |>
            ,
            "MessageIndex" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MessageIndex",
                "Index"           -> 57,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "message_index",
                "NativeType"      -> "FIT_MESSAGE_INDEX",
                "Type"            -> "MessageIndex"
            |>
            ,
            "Notes" -> <|
                "Dimensions"      -> { 50 },
                "FieldName"       -> "Notes",
                "Index"           -> 62;;111,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "notes",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
            ,
            "SecondaryCustomTargetValueHigh" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SecondaryCustomTargetValueHigh",
                "Index"           -> 56,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "secondary_custom_target_value_high",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "SecondaryCustomTargetValueLow" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SecondaryCustomTargetValueLow",
                "Index"           -> 55,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "secondary_custom_target_value_low",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "SecondaryTargetType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SecondaryTargetType",
                "Index"           -> 113,
                "Interpreter"     -> { "fitEnum", "WorkoutStepTarget" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "secondary_target_type",
                "NativeType"      -> "FIT_WKT_STEP_TARGET",
                "Type"            -> "WorkoutStepTarget"
            |>
            ,
            "SecondaryTargetValue" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "SecondaryTargetValue",
                "Index"           -> 54,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "secondary_target_value",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "TargetType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "TargetType",
                "Index"           -> 60,
                "Interpreter"     -> { "fitEnum", "WorkoutStepTarget" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "target_type",
                "NativeType"      -> "FIT_WKT_STEP_TARGET",
                "Type"            -> "WorkoutStepTarget"
            |>
            ,
            "TargetValue" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "TargetValue",
                "Index"           -> 51,
                "Interpreter"     -> "fitUINT32",
                "Invalid"         -> 4294967295,
                "NativeFieldName" -> "target_value",
                "NativeType"      -> "FIT_UINT32",
                "Type"            -> "UnsignedInteger32"
            |>
            ,
            "WorkoutStepName" -> <|
                "Dimensions"      -> { 48 },
                "FieldName"       -> "WorkoutStepName",
                "Index"           -> 2;;49,
                "Interpreter"     -> "fitString",
                "Invalid"         -> 0,
                "NativeFieldName" -> "wkt_step_name",
                "NativeType"      -> "FIT_STRING",
                "Type"            -> "String"
            |>
        |>
    |>
    ,
    "ZonesTarget" -> <|
        "MessageName"   -> "ZonesTarget",
        "MessageNumber" -> 7,
        "Size"          -> 6,
        "Fields"        -> <|
            "FunctionalThresholdPower" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "FunctionalThresholdPower",
                "Index"           -> 2,
                "Interpreter"     -> "fitUINT16",
                "Invalid"         -> 65535,
                "NativeFieldName" -> "functional_threshold_power",
                "NativeType"      -> "FIT_UINT16",
                "Type"            -> "UnsignedInteger16"
            |>
            ,
            "HeartRateCalculationType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "HeartRateCalculationType",
                "Index"           -> 5,
                "Interpreter"     -> { "fitEnum", "HeartRateZoneCalculation" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "hr_calc_type",
                "NativeType"      -> "FIT_HR_ZONE_CALC",
                "Type"            -> "HeartRateZoneCalculation"
            |>
            ,
            "MaximumHeartRate" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "MaximumHeartRate",
                "Index"           -> 3,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "max_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
            ,
            "PowerCalculationType" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "PowerCalculationType",
                "Index"           -> 6,
                "Interpreter"     -> { "fitEnum", "PowerZoneCalculation" },
                "Invalid"         -> 255,
                "NativeFieldName" -> "pwr_calc_type",
                "NativeType"      -> "FIT_PWR_ZONE_CALC",
                "Type"            -> "PowerZoneCalculation"
            |>
            ,
            "ThresholdHeartRate" -> <|
                "Dimensions"      -> { },
                "FieldName"       -> "ThresholdHeartRate",
                "Index"           -> 4,
                "Interpreter"     -> "fitUINT8",
                "Invalid"         -> 255,
                "NativeFieldName" -> "threshold_heart_rate",
                "NativeType"      -> "FIT_UINT8",
                "Type"            -> "UnsignedInteger8"
            |>
        |>
    |>
|>