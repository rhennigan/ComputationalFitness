(* This file is auto-generated. Do not edit manually. *)
<|
    "AccelerometerData" -> <|
        "AccelerationX" -> <|
            "Comment"         -> "1 * counts + 0, These are the raw ADC reading. Maximum number of samples is 30 in each message. The samples may span across seconds. A conversion will need to be done on this data once read.",
            "Dimensions"      -> { 1 },
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
            "Index"           -> 3;;3,
            "Interpreter"     -> "fitFloat32A",
            "NativeFieldName" -> "calibrated_accel_x",
            "NativeType"      -> "FIT_FLOAT32",
            "Type"            -> "Real32"
        |>
        ,
        "CalibratedAccelerationY" -> <|
            "Comment"         -> "1 * g + 0, Calibrated accel reading",
            "Dimensions"      -> { 1 },
            "Index"           -> 4;;4,
            "Interpreter"     -> "fitFloat32A",
            "NativeFieldName" -> "calibrated_accel_y",
            "NativeType"      -> "FIT_FLOAT32",
            "Type"            -> "Real32"
        |>
        ,
        "CalibratedAccelerationZ" -> <|
            "Comment"         -> "1 * g + 0, Calibrated accel reading",
            "Dimensions"      -> { 1 },
            "Index"           -> 5;;5,
            "Interpreter"     -> "fitFloat32A",
            "NativeFieldName" -> "calibrated_accel_z",
            "NativeType"      -> "FIT_FLOAT32",
            "Type"            -> "Real32"
        |>
        ,
        "CompressedCalibratedAccelerationX" -> <|
            "Comment"         -> "1 * mG + 0, Calibrated accel reading",
            "Dimensions"      -> { 1 },
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
            "Index"           -> 7;;7,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "sample_time_offset",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "Timestamp" -> <|
            "Comment"         -> "1 * s + 0, Whole second part of the timestamp",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "TimestampMilliseconds" -> <|
            "Comment"         -> "1 * ms + 0, Millisecond part of the timestamp.",
            "Dimensions"      -> { },
            "Index"           -> 6,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "timestamp_ms",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
    |>
    ,
    "Activity" -> <|
        "Event" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 4,
            "Interpreter"     -> { "fitEnum", "LocalDateTime" },
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "local_timestamp",
            "NativeType"      -> "FIT_LOCAL_DATE_TIME",
            "Type"            -> "LocalDateTime"
        |>
        ,
        "NumberOfSessions" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "TotalTimerTime" -> <|
            "Comment"         -> "1000 * s + 0, Exclude pauses",
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_timer_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Type" -> <|
            "Dimensions"      -> { },
            "Index"           -> 6,
            "Interpreter"     -> { "fitEnum", "Activity" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "type",
            "NativeType"      -> "FIT_ACTIVITY",
            "Type"            -> "Activity"
        |>
    |>
    ,
    "ANTReceive" -> <|
        "ChannelNumber" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
    |>
    ,
    "ANTTransmit" -> <|
        "ChannelNumber" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
    |>
    ,
    "AviationAttitude" -> <|
        "AccelerationLateral" -> <|
            "Comment"         -> "100 * m/s^2 + 0, Range -78.4 to +78.4 (-8 Gs to 8 Gs)",
            "Dimensions"      -> { 1 },
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
            "Index"           -> 13;;13,
            "Interpreter"     -> "fitUINT8A",
            "Invalid"         -> 255,
            "NativeFieldName" -> "attitude_stage_complete",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "Pitch" -> <|
            "Comment"         -> "10430.38 * radians + 0, Range -PI/2 to +PI/2",
            "Dimensions"      -> { 1 },
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
            "Index"           -> 3;;3,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "system_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Timestamp" -> <|
            "Comment"         -> "1 * s + 0, Timestamp message was output",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "TimestampMilliseconds" -> <|
            "Comment"         -> "1 * ms + 0, Fractional part of timestamp, added to timestamp",
            "Dimensions"      -> { },
            "Index"           -> 4,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "timestamp_ms",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "Track" -> <|
            "Comment"         -> "10430.38 * radians + 0, Track Angle/Heading Range 0 - 2pi",
            "Dimensions"      -> { 1 },
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
            "Index"           -> 11;;11,
            "Interpreter"     -> { "fitEnum", "AttitudeValidity" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "validity",
            "NativeType"      -> "FIT_ATTITUDE_VALIDITY",
            "Type"            -> "AttitudeValidity"
        |>
    |>
    ,
    "BikeProfile" -> <|
        "AutomaticPowerZero" -> <|
            "Dimensions"      -> { },
            "Index"           -> 31,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "auto_power_zero",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "AutomaticWheelCalibration" -> <|
            "Dimensions"      -> { },
            "Index"           -> 30,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "auto_wheel_cal",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "AutomaticWheelSize" -> <|
            "Comment"         -> "1000 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 25,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "auto_wheelsize",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "BikeCadANTID" -> <|
            "Dimensions"      -> { },
            "Index"           -> 21,
            "Interpreter"     -> "fitUINT16Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "bike_cad_ant_id",
            "NativeType"      -> "FIT_UINT16Z",
            "Type"            -> "UnsignedInteger16z"
        |>
        ,
        "BikeCadANTIDTransmissionType" -> <|
            "Dimensions"      -> { },
            "Index"           -> 40,
            "Interpreter"     -> "fitUINT8Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "bike_cad_ant_id_trans_type",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "BikePowerANTID" -> <|
            "Dimensions"      -> { },
            "Index"           -> 23,
            "Interpreter"     -> "fitUINT16Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "bike_power_ant_id",
            "NativeType"      -> "FIT_UINT16Z",
            "Type"            -> "UnsignedInteger16z"
        |>
        ,
        "BikePowerANTIDTransmissionType" -> <|
            "Dimensions"      -> { },
            "Index"           -> 42,
            "Interpreter"     -> "fitUINT8Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "bike_power_ant_id_trans_type",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "BikeSpeedANTID" -> <|
            "Dimensions"      -> { },
            "Index"           -> 20,
            "Interpreter"     -> "fitUINT16Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "bike_spd_ant_id",
            "NativeType"      -> "FIT_UINT16Z",
            "Type"            -> "UnsignedInteger16z"
        |>
        ,
        "BikeSpeedANTIDTransmissionType" -> <|
            "Dimensions"      -> { },
            "Index"           -> 39,
            "Interpreter"     -> "fitUINT8Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "bike_spd_ant_id_trans_type",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "BikeSpeedCadenceANTID" -> <|
            "Dimensions"      -> { },
            "Index"           -> 22,
            "Interpreter"     -> "fitUINT16Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "bike_spdcad_ant_id",
            "NativeType"      -> "FIT_UINT16Z",
            "Type"            -> "UnsignedInteger16z"
        |>
        ,
        "BikeSpeedCadenceANTIDTransmissionType" -> <|
            "Dimensions"      -> { },
            "Index"           -> 41,
            "Interpreter"     -> "fitUINT8Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "bike_spdcad_ant_id_trans_type",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "BikeWeight" -> <|
            "Comment"         -> "10 * kg + 0",
            "Dimensions"      -> { },
            "Index"           -> 26,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "bike_weight",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "CadenceEnabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 34,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "cad_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "CrankLength" -> <|
            "Comment"         -> "2 * mm + -110",
            "Dimensions"      -> { },
            "Index"           -> 37,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "crank_length",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "CustomWheelSize" -> <|
            "Comment"         -> "1000 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 24,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "custom_wheelsize",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "Enabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 38,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "FrontGear" -> <|
            "Comment"         -> "Number of teeth on each gear 0 is innermost",
            "Dimensions"      -> { 1 },
            "Index"           -> 45;;45,
            "Interpreter"     -> "fitUINT8ZA",
            "Invalid"         -> 0,
            "NativeFieldName" -> "front_gear",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "FrontGearNumber" -> <|
            "Comment"         -> "Number of front gears",
            "Dimensions"      -> { },
            "Index"           -> 44,
            "Interpreter"     -> "fitUINT8Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "front_gear_num",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "ID" -> <|
            "Dimensions"      -> { },
            "Index"           -> 32,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "id",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 19,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Name" -> <|
            "Dimensions"      -> { 16 },
            "Index"           -> 2;;17,
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
            "Index"           -> 18,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "odometer",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "OdometerRollover" -> <|
            "Comment"         -> "Rollover counter that can be used to extend the odometer",
            "Dimensions"      -> { },
            "Index"           -> 43,
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
            "Index"           -> 27,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "power_cal_factor",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "PowerEnabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 36,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "power_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "RearGear" -> <|
            "Comment"         -> "Number of teeth on each gear 0 is innermost",
            "Dimensions"      -> { 1 },
            "Index"           -> 47;;47,
            "Interpreter"     -> "fitUINT8ZA",
            "Invalid"         -> 0,
            "NativeFieldName" -> "rear_gear",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "RearGearNumber" -> <|
            "Comment"         -> "Number of rear gears",
            "Dimensions"      -> { },
            "Index"           -> 46,
            "Interpreter"     -> "fitUINT8Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "rear_gear_num",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "ShimanoDI2Enabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 48,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "shimano_di2_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "SpeedCadenceEnabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 35,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "spdcad_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "SpeedEnabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 33,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "spd_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "Sport" -> <|
            "Dimensions"      -> { },
            "Index"           -> 28,
            "Interpreter"     -> { "fitEnum", "Sport" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "sport",
            "NativeType"      -> "FIT_SPORT",
            "Type"            -> "Sport"
        |>
        ,
        "SubSport" -> <|
            "Dimensions"      -> { },
            "Index"           -> 29,
            "Interpreter"     -> { "fitEnum", "SubSport" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "sub_sport",
            "NativeType"      -> "FIT_SUB_SPORT",
            "Type"            -> "SubSport"
        |>
    |>
    ,
    "BloodPressure" -> <|
        "DiastolicPressure" -> <|
            "Comment"         -> "1 * mmHg + 0",
            "Dimensions"      -> { },
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
            "Index"           -> 10,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "HeartRateType" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "UserProfileIndex" -> <|
            "Comment"         -> "Associates this blood pressure message to a user. This corresponds to the index of the user profile message in the blood pressure file.",
            "Dimensions"      -> { },
            "Index"           -> 9,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "user_profile_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
    |>
    ,
    "CadenceZone" -> <|
        "HighValue" -> <|
            "Comment"         -> "1 * rpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 19,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "high_value",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 18,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Name" -> <|
            "Dimensions"      -> { 16 },
            "Index"           -> 2;;17,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "name",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
    |>
    ,
    "Capabilities" -> <|
        "ConnectivitySupported" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2;;5,
            "Interpreter"     -> "fitUINT8ZA",
            "Invalid"         -> 0,
            "NativeFieldName" -> "languages",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "Sports" -> <|
            "Comment"         -> "Use sport_bits_x types where x is index of array.",
            "Dimensions"      -> { 1 },
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
            "Index"           -> 6,
            "Interpreter"     -> { "fitEnum", "WorkoutCapabilities" },
            "Invalid"         -> 0,
            "NativeFieldName" -> "workouts_supported",
            "NativeType"      -> "FIT_WORKOUT_CAPABILITIES",
            "Type"            -> "WorkoutCapabilities"
        |>
    |>
    ,
    "Connectivity" -> <|
        "ANTEnabled" -> <|
            "Comment"         -> "Use ANT for connectivity features",
            "Dimensions"      -> { },
            "Index"           -> 28,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "ant_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "AutomaticActivityUploadEnabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 32,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "auto_activity_upload_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "BluetoothEnabled" -> <|
            "Comment"         -> "Use Bluetooth for connectivity features",
            "Dimensions"      -> { },
            "Index"           -> 26,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "bluetooth_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "BluetoothLEEnabled" -> <|
            "Comment"         -> "Use Bluetooth Low Energy for connectivity features",
            "Dimensions"      -> { },
            "Index"           -> 27,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "bluetooth_le_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "CourseDownloadEnabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 33,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "course_download_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "GPSEphemerisDownloadEnabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 35,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "gps_ephemeris_download_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "GroupTrackEnabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 37,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "grouptrack_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "IncidentDetectionEnabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 36,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "incident_detection_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "LiveTrackingEnabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 29,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "live_tracking_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "Name" -> <|
            "Dimensions"      -> { 24 },
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
            "Index"           -> 31,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "weather_alerts_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "WeatherConditionsEnabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 30,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "weather_conditions_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "WorkoutDownloadEnabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 34,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "workout_download_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
    |>
    ,
    "Course" -> <|
        "Capabilities" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 20,
            "Interpreter"     -> { "fitEnum", "SubSport" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "sub_sport",
            "NativeType"      -> "FIT_SUB_SPORT",
            "Type"            -> "SubSport"
        |>
    |>
    ,
    "CoursePoint" -> <|
        "Distance" -> <|
            "Comment"         -> "100 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 5,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "distance",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Favorite" -> <|
            "Dimensions"      -> { },
            "Index"           -> 24,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "favorite",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 22,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Name" -> <|
            "Dimensions"      -> { 16 },
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
            "Index"           -> 3,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "position_lat",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "PositionLongitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 4,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "position_long",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "Timestamp" -> <|
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "Type" -> <|
            "Dimensions"      -> { },
            "Index"           -> 23,
            "Interpreter"     -> { "fitEnum", "CoursePoint" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "type",
            "NativeType"      -> "FIT_COURSE_POINT",
            "Type"            -> "CoursePoint"
        |>
    |>
    ,
    "DeveloperDataID" -> <|
        "ApplicationID" -> <|
            "Dimensions"      -> { 16 },
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
            "Index"           -> 35,
            "Interpreter"     -> { "fitEnum", "Manufacturer" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "manufacturer_id",
            "NativeType"      -> "FIT_MANUFACTURER",
            "Type"            -> "Manufacturer"
        |>
    |>
    ,
    "DeviceAuxiliaryBatteryInformation" -> <|
        "BatteryIdentifier" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 3,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "battery_voltage",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "DeviceIndex" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
    |>
    ,
    "DeviceInformation" -> <|
        "ANTDeviceNumber" -> <|
            "Dimensions"      -> { },
            "Index"           -> 29,
            "Interpreter"     -> "fitUINT16Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "ant_device_number",
            "NativeType"      -> "FIT_UINT16Z",
            "Type"            -> "UnsignedInteger16z"
        |>
        ,
        "ANTNetwork" -> <|
            "Dimensions"      -> { },
            "Index"           -> 37,
            "Interpreter"     -> { "fitEnum", "ANTNetwork" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "ant_network",
            "NativeType"      -> "FIT_ANT_NETWORK",
            "Type"            -> "ANTNetwork"
        |>
        ,
        "ANTTransmissionType" -> <|
            "Dimensions"      -> { },
            "Index"           -> 36,
            "Interpreter"     -> "fitUINT8Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "ant_transmission_type",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "BatteryLevel" -> <|
            "Comment"         -> "1 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 39,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "battery_level",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "BatteryStatus" -> <|
            "Dimensions"      -> { },
            "Index"           -> 33,
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
            "Index"           -> 28,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "battery_voltage",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "CumulativeOperatingTime" -> <|
            "Comment"         -> "1 * s + 0, Reset by new battery or charge.",
            "Dimensions"      -> { },
            "Index"           -> 4,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "cum_operating_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Descriptor" -> <|
            "Comment"         -> "Used to describe the sensor or location",
            "Dimensions"      -> { 1 },
            "Index"           -> 35;;35,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "descriptor",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
        ,
        "DeviceIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 30,
            "Interpreter"     -> { "fitEnum", "DeviceIndex" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "device_index",
            "NativeType"      -> "FIT_DEVICE_INDEX",
            "Type"            -> "DeviceIndex"
        |>
        ,
        "DeviceType" -> <|
            "Dimensions"      -> { },
            "Index"           -> 31,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "device_type",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "HardwareVersion" -> <|
            "Dimensions"      -> { },
            "Index"           -> 32,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "hardware_version",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "Manufacturer" -> <|
            "Dimensions"      -> { },
            "Index"           -> 25,
            "Interpreter"     -> { "fitEnum", "Manufacturer" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "manufacturer",
            "NativeType"      -> "FIT_MANUFACTURER",
            "Type"            -> "Manufacturer"
        |>
        ,
        "Product" -> <|
            "Dimensions"      -> { },
            "Index"           -> 26,
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
            "Index"           -> 5;;24,
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
            "Index"           -> 34,
            "Interpreter"     -> { "fitEnum", "BodyLocation" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "sensor_position",
            "NativeType"      -> "FIT_BODY_LOCATION",
            "Type"            -> "BodyLocation"
        |>
        ,
        "SerialNumber" -> <|
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> "fitUINT32Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "serial_number",
            "NativeType"      -> "FIT_UINT32Z",
            "Type"            -> "UnsignedInteger32z"
        |>
        ,
        "SoftwareVersion" -> <|
            "Dimensions"      -> { },
            "Index"           -> 27,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "software_version",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "SourceType" -> <|
            "Dimensions"      -> { },
            "Index"           -> 38,
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
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
    |>
    ,
    "DeviceSettings" -> <|
        "ActiveTimeZone" -> <|
            "Comment"         -> "Index into time zone arrays.",
            "Dimensions"      -> { },
            "Index"           -> 10,
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
            "Index"           -> 16,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "activity_tracker_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "AutoSyncMinimumSteps" -> <|
            "Comment"         -> "1 * steps + 0, Minimum steps before an autosync can occur",
            "Dimensions"      -> { },
            "Index"           -> 8,
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
            "Index"           -> 9,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "autosync_min_time",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "BacklightMode" -> <|
            "Comment"         -> "Mode for backlight",
            "Dimensions"      -> { },
            "Index"           -> 15,
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
            "Index"           -> 5,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "clock_time",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "DateMode" -> <|
            "Comment"         -> "Display mode for the date",
            "Dimensions"      -> { },
            "Index"           -> 18,
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
            "Index"           -> 7;;7,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "default_page",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "DisplayOrientation" -> <|
            "Dimensions"      -> { },
            "Index"           -> 19,
            "Interpreter"     -> { "fitEnum", "DisplayOrientation" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "display_orientation",
            "NativeType"      -> "FIT_DISPLAY_ORIENTATION",
            "Type"            -> "DisplayOrientation"
        |>
        ,
        "MountingSide" -> <|
            "Dimensions"      -> { },
            "Index"           -> 20,
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
            "Index"           -> 17,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "move_alert_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "PagesEnabled" -> <|
            "Comment"         -> "Bitfield to configure enabled screens for each supported loop",
            "Dimensions"      -> { 1 },
            "Index"           -> 6;;6,
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
            "Index"           -> 21,
            "Interpreter"     -> { "fitEnum", "TapSensitivity" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "tap_sensitivity",
            "NativeType"      -> "FIT_TAP_SENSITIVITY",
            "Type"            -> "TapSensitivity"
        |>
        ,
        "TimeMode" -> <|
            "Comment"         -> "Display mode for the time",
            "Dimensions"      -> { 2 },
            "Index"           -> 11;;12,
            "Interpreter"     -> { "fitEnum", "TimeMode" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "time_mode",
            "NativeType"      -> "FIT_TIME_MODE",
            "Type"            -> "TimeMode"
        |>
        ,
        "TimeOffset" -> <|
            "Comment"         -> "1 * s + 0, Offset from system time.",
            "Dimensions"      -> { 2 },
            "Index"           -> 3;;4,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_offset",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TimeZoneOffset" -> <|
            "Comment"         -> "4 * hr + 0, timezone offset in 1/4 hour increments",
            "Dimensions"      -> { 2 },
            "Index"           -> 13;;14,
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
            "Index"           -> 2,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "utc_offset",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
    |>
    ,
    "DiveSettings" -> <|
        "HeartRateSource" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2;;17,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "name",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
    |>
    ,
    "Event" -> <|
        "Data" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 11,
            "Interpreter"     -> "fitUINT8Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "front_gear",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "FrontGearNumber" -> <|
            "Comment"         -> "Do not populate directly. Autogenerated by decoder for gear_change subfield components. Front gear number. 1 is innermost.",
            "Dimensions"      -> { },
            "Index"           -> 10,
            "Interpreter"     -> "fitUINT8Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "front_gear_num",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "OpponentScore" -> <|
            "Comment"         -> "Do not populate directly. Autogenerated by decoder for sport_point subfield components",
            "Dimensions"      -> { },
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
            "Index"           -> 13,
            "Interpreter"     -> "fitUINT8Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "rear_gear",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "RearGearNumber" -> <|
            "Comment"         -> "Do not populate directly. Autogenerated by decoder for gear_change subfield components. Rear gear number. 1 is innermost.",
            "Dimensions"      -> { },
            "Index"           -> 12,
            "Interpreter"     -> "fitUINT8Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "rear_gear_num",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "Score" -> <|
            "Comment"         -> "Do not populate directly. Autogenerated by decoder for sport_point subfield components",
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
    |>
    ,
    "ExerciseTitle" -> <|
        "ExerciseCategory" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 50,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "WorkoutStepName" -> <|
            "Dimensions"      -> { 48 },
            "Index"           -> 2;;49,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "wkt_step_name",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
    |>
    ,
    "ExtendedDisplayDataConceptConfiguration" -> <|
        "ConceptField" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 12,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "is_signed",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "Qualifier" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "screen_index",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
    |>
    ,
    "ExtendedDisplayDataFieldConfiguration" -> <|
        "ConceptCount" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 7;;7,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "title",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
    |>
    ,
    "ExtendedDisplayScreenConfiguration" -> <|
        "FieldCount" -> <|
            "Comment"         -> "number of fields in screen",
            "Dimensions"      -> { },
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
            "Index"           -> 5,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "screen_enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "ScreenIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "screen_index",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
    |>
    ,
    "FieldCapabilities" -> <|
        "Count" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "MessageNumber" -> <|
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> { "fitEnum", "MessageNumber" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "mesg_num",
            "NativeType"      -> "FIT_MESG_NUM",
            "Type"            -> "MessageNumber"
        |>
    |>
    ,
    "FieldDescription" -> <|
        "DeveloperDataIndex" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 66;;81,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "units",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
    |>
    ,
    "FileCapabilities" -> <|
        "Directory" -> <|
            "Dimensions"      -> { 16 },
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
            "Index"           -> 19,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Type" -> <|
            "Dimensions"      -> { },
            "Index"           -> 21,
            "Interpreter"     -> { "fitEnum", "File" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "type",
            "NativeType"      -> "FIT_FILE",
            "Type"            -> "File"
        |>
    |>
    ,
    "FileCreator" -> <|
        "HardwareVersion" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "software_version",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
    |>
    ,
    "FileID" -> <|
        "Manufacturer" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitUINT32Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "serial_number",
            "NativeType"      -> "FIT_UINT32Z",
            "Type"            -> "UnsignedInteger32z"
        |>
        ,
        "TimeCreated" -> <|
            "Comment"         -> "Only set for files that are can be created/erased.",
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_created",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "Type" -> <|
            "Dimensions"      -> { },
            "Index"           -> 27,
            "Interpreter"     -> { "fitEnum", "File" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "type",
            "NativeType"      -> "FIT_FILE",
            "Type"            -> "File"
        |>
    |>
    ,
    "Goal" -> <|
        "Enabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 13,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "EndDate" -> <|
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "end_date",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 6,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Recurrence" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 11,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "repeat",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "Source" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "start_date",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "SubSport" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 4,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "value",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
    |>
    ,
    "HeartRate" -> <|
        "EventTimestamp" -> <|
            "Comment"         -> "1024 * s + 0",
            "Dimensions"      -> { 1 },
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
            "Index"           -> 6;;6,
            "Interpreter"     -> "fitUINT8A",
            "Invalid"         -> 255,
            "NativeFieldName" -> "filtered_bpm",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "FractionalTimestamp" -> <|
            "Comment"         -> "32768 * s + 0",
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
    |>
    ,
    "HeartRateMonitorProfile" -> <|
        "Enabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 4,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "HeartRateMonitorANTID" -> <|
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> "fitUINT16Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "hrm_ant_id",
            "NativeType"      -> "FIT_UINT16Z",
            "Type"            -> "UnsignedInteger16z"
        |>
        ,
        "HeartRateMonitorANTIDTransmissionType" -> <|
            "Dimensions"      -> { },
            "Index"           -> 6,
            "Interpreter"     -> "fitUINT8Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "hrm_ant_id_trans_type",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "LogHeartRateVariability" -> <|
            "Dimensions"      -> { },
            "Index"           -> 5,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "log_hrv",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
    |>
    ,
    "HeartRateVariability" -> <|
        "Time" -> <|
            "Comment"         -> "1000 * s + 0, Time between beats",
            "Dimensions"      -> { 1 },
            "Index"           -> 2;;2,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "time",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
    |>
    ,
    "HeartRateZone" -> <|
        "HighBeatsPerMinute" -> <|
            "Comment"         -> "1 * bpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 19,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "high_bpm",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 18,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Name" -> <|
            "Dimensions"      -> { 16 },
            "Index"           -> 2;;17,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "name",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
    |>
    ,
    "Lap" -> <|
        "AverageAltitude" -> <|
            "Comment"         -> "5 * m + 500",
            "Dimensions"      -> { },
            "Index"           -> 38,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_altitude",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageAverageAscentSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 65,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_vam",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageCadence" -> <|
            "Comment"         -> "1 * rpm + 0, total_cycles / total_timer_time if non_zero_avg_cadence otherwise total_cycles / total_elapsed_time",
            "Dimensions"      -> { },
            "Index"           -> 70,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageFractionalCadence" -> <|
            "Comment"         -> "128 * rpm + 0, fractional part of the avg_cadence",
            "Dimensions"      -> { },
            "Index"           -> 82,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_fractional_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 40,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AverageHeartRate" -> <|
            "Comment"         -> "1 * bpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 68,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageNegativeGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 42,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_neg_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AverageNegativeVerticalSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 46,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_neg_vertical_speed",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AveragePositiveGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 41,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_pos_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AveragePositiveVerticalSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 45,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_pos_vertical_speed",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AveragePower" -> <|
            "Comment"         -> "1 * watts + 0, total_power / total_timer_time if non_zero_avg_power otherwise total_power / total_elapsed_time",
            "Dimensions"      -> { },
            "Index"           -> 28,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageSaturatedHemoglobinPercent" -> <|
            "Comment"         -> "10 * % + 0, Avg percentage of hemoglobin saturated with oxygen",
            "Dimensions"      -> { 1 },
            "Index"           -> 62;;62,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_saturated_hemoglobin_percent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 26,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_speed",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageStanceTime" -> <|
            "Comment"         -> "10 * ms + 0",
            "Dimensions"      -> { },
            "Index"           -> 57,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_stance_time",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageStanceTimePercent" -> <|
            "Comment"         -> "100 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 56,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_stance_time_percent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageStrokeDistance" -> <|
            "Comment"         -> "100 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 36,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_stroke_distance",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageTemperature" -> <|
            "Comment"         -> "1 * C + 0",
            "Dimensions"      -> { },
            "Index"           -> 79,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "avg_temperature",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "AverageTotalHemoglobinConcentration" -> <|
            "Comment"         -> "100 * g/dL + 0, Avg saturated and unsaturated hemoglobin",
            "Dimensions"      -> { 1 },
            "Index"           -> 59;;59,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_total_hemoglobin_conc",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageVerticalOscillation" -> <|
            "Comment"         -> "10 * mm + 0",
            "Dimensions"      -> { },
            "Index"           -> 55,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_vertical_oscillation",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "EndPositionLatitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 6,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "end_position_lat",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "EndPositionLongitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 7,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "end_position_long",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "EnhancedAverageAltitude" -> <|
            "Comment"         -> "5 * m + 500",
            "Dimensions"      -> { },
            "Index"           -> 20,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "enhanced_avg_altitude",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "EnhancedAverageSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 18,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "enhanced_avg_speed",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "EnhancedMaximumAltitude" -> <|
            "Comment"         -> "5 * m + 500",
            "Dimensions"      -> { },
            "Index"           -> 22,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "enhanced_max_altitude",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "EnhancedMaximumSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 19,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "enhanced_max_speed",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "EnhancedMinimumAltitude" -> <|
            "Comment"         -> "5 * m + 500",
            "Dimensions"      -> { },
            "Index"           -> 21,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "enhanced_min_altitude",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Event" -> <|
            "Dimensions"      -> { },
            "Index"           -> 66,
            "Interpreter"     -> { "fitEnum", "Event" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "event",
            "NativeType"      -> "FIT_EVENT",
            "Type"            -> "Event"
        |>
        ,
        "EventGroup" -> <|
            "Dimensions"      -> { },
            "Index"           -> 75,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "event_group",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "EventType" -> <|
            "Dimensions"      -> { },
            "Index"           -> 67,
            "Interpreter"     -> { "fitEnum", "EventType" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "event_type",
            "NativeType"      -> "FIT_EVENT_TYPE",
            "Type"            -> "EventType"
        |>
        ,
        "FirstLengthIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 35,
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
            "Index"           -> 78,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "gps_accuracy",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "Intensity" -> <|
            "Dimensions"      -> { },
            "Index"           -> 72,
            "Interpreter"     -> { "fitEnum", "Intensity" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "intensity",
            "NativeType"      -> "FIT_INTENSITY",
            "Type"            -> "Intensity"
        |>
        ,
        "LapTrigger" -> <|
            "Dimensions"      -> { },
            "Index"           -> 73,
            "Interpreter"     -> { "fitEnum", "LapTrigger" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "lap_trigger",
            "NativeType"      -> "FIT_LAP_TRIGGER",
            "Type"            -> "LapTrigger"
        |>
        ,
        "LeftRightBalance" -> <|
            "Dimensions"      -> { },
            "Index"           -> 34,
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
            "Index"           -> 39,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_altitude",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumCadence" -> <|
            "Comment"         -> "1 * rpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 71,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "max_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MaximumFractionalCadence" -> <|
            "Comment"         -> "128 * rpm + 0, fractional part of the max_cadence",
            "Dimensions"      -> { },
            "Index"           -> 83,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "max_fractional_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MaximumHeartRate" -> <|
            "Comment"         -> "1 * bpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 69,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "max_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MaximumNegativeGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 44,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "max_neg_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "MaximumNegativeVerticalSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 48,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "max_neg_vertical_speed",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "MaximumPositiveGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 43,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "max_pos_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "MaximumPositiveVerticalSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 47,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "max_pos_vertical_speed",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "MaximumPower" -> <|
            "Comment"         -> "1 * watts + 0",
            "Dimensions"      -> { },
            "Index"           -> 29,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumSaturatedHemoglobinPercent" -> <|
            "Comment"         -> "10 * % + 0, Max percentage of hemoglobin saturated with oxygen",
            "Dimensions"      -> { 1 },
            "Index"           -> 64;;64,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_saturated_hemoglobin_percent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 27,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_speed",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumTemperature" -> <|
            "Comment"         -> "1 * C + 0",
            "Dimensions"      -> { },
            "Index"           -> 80,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "max_temperature",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "MaximumTotalHemoglobinConcentration" -> <|
            "Comment"         -> "100 * g/dL + 0, Max saturated and unsaturated hemoglobin",
            "Dimensions"      -> { 1 },
            "Index"           -> 61;;61,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_total_hemoglobin_conc",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 23,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "MinimumAltitude" -> <|
            "Comment"         -> "5 * m + 500",
            "Dimensions"      -> { },
            "Index"           -> 50,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "min_altitude",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MinimumHeartRate" -> <|
            "Comment"         -> "1 * bpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 81,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "min_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MinimumSaturatedHemoglobinPercent" -> <|
            "Comment"         -> "10 * % + 0, Min percentage of hemoglobin saturated with oxygen",
            "Dimensions"      -> { 1 },
            "Index"           -> 63;;63,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "min_saturated_hemoglobin_percent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MinimumTotalHemoglobinConcentration" -> <|
            "Comment"         -> "100 * g/dL + 0, Min saturated and unsaturated hemoglobin",
            "Dimensions"      -> { 1 },
            "Index"           -> 60;;60,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "min_total_hemoglobin_conc",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "NormalizedPower" -> <|
            "Comment"         -> "1 * watts + 0",
            "Dimensions"      -> { },
            "Index"           -> 33,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "normalized_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "NumberActiveLengths" -> <|
            "Comment"         -> "1 * lengths + 0, # of active lengths of swim pool",
            "Dimensions"      -> { },
            "Index"           -> 37,
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
            "Index"           -> 32,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "num_lengths",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "OpponentScore" -> <|
            "Dimensions"      -> { },
            "Index"           -> 52,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "opponent_score",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "PlayerScore" -> <|
            "Dimensions"      -> { },
            "Index"           -> 58,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "player_score",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "RepetitionNumber" -> <|
            "Dimensions"      -> { },
            "Index"           -> 49,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "repetition_num",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "Sport" -> <|
            "Dimensions"      -> { },
            "Index"           -> 74,
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
            "Index"           -> 4,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "start_position_lat",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "StartPositionLongitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 5,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "start_position_long",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "StartTime" -> <|
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "start_time",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "StrokeCount" -> <|
            "Comment"         -> "1 * counts + 0, stroke_type enum used as the index",
            "Dimensions"      -> { 1 },
            "Index"           -> 53;;53,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "stroke_count",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "SubSport" -> <|
            "Dimensions"      -> { },
            "Index"           -> 77,
            "Interpreter"     -> { "fitEnum", "SubSport" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "sub_sport",
            "NativeType"      -> "FIT_SUB_SPORT",
            "Type"            -> "SubSport"
        |>
        ,
        "SwimStroke" -> <|
            "Dimensions"      -> { },
            "Index"           -> 76,
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
            "Index"           -> 16;;16,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_in_cadence_zone",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TimeInHeartRateZone" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { 1 },
            "Index"           -> 14;;14,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_in_hr_zone",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TimeInPowerZone" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { 1 },
            "Index"           -> 17;;17,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_in_power_zone",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TimeInSpeedZone" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { 1 },
            "Index"           -> 15;;15,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_in_speed_zone",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Timestamp" -> <|
            "Comment"         -> "1 * s + 0, Lap end time.",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "TotalAscent" -> <|
            "Comment"         -> "1 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 30,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_ascent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalCalories" -> <|
            "Comment"         -> "1 * kcal + 0",
            "Dimensions"      -> { },
            "Index"           -> 24,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_calories",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalCycles" -> <|
            "Comment"         -> "1 * cycles + 0",
            "Dimensions"      -> { },
            "Index"           -> 11,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_cycles",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalDescent" -> <|
            "Comment"         -> "1 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 31,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_descent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalDistance" -> <|
            "Comment"         -> "100 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 10,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_distance",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalElapsedTime" -> <|
            "Comment"         -> "1000 * s + 0, Time (includes pauses)",
            "Dimensions"      -> { },
            "Index"           -> 8,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_elapsed_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalFatCalories" -> <|
            "Comment"         -> "1 * kcal + 0, If New Leaf",
            "Dimensions"      -> { },
            "Index"           -> 25,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_fat_calories",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalFractionalCycles" -> <|
            "Comment"         -> "128 * cycles + 0, fractional part of the total_cycles",
            "Dimensions"      -> { },
            "Index"           -> 84,
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
            "Index"           -> 13,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_moving_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalTimerTime" -> <|
            "Comment"         -> "1000 * s + 0, Timer Time (excludes pauses)",
            "Dimensions"      -> { },
            "Index"           -> 9,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_timer_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalWork" -> <|
            "Comment"         -> "1 * J + 0",
            "Dimensions"      -> { },
            "Index"           -> 12,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_work",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "WorkoutStepIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 51,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "wkt_step_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "ZoneCount" -> <|
            "Comment"         -> "1 * counts + 0, zone number used as the index",
            "Dimensions"      -> { 1 },
            "Index"           -> 54;;54,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "zone_count",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
    |>
    ,
    "Length" -> <|
        "AverageSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 8,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_speed",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageSwimmingCadence" -> <|
            "Comment"         -> "1 * strokes/min + 0",
            "Dimensions"      -> { },
            "Index"           -> 17,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_swimming_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "Event" -> <|
            "Dimensions"      -> { },
            "Index"           -> 14,
            "Interpreter"     -> { "fitEnum", "Event" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "event",
            "NativeType"      -> "FIT_EVENT",
            "Type"            -> "Event"
        |>
        ,
        "EventGroup" -> <|
            "Dimensions"      -> { },
            "Index"           -> 18,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "event_group",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "EventType" -> <|
            "Dimensions"      -> { },
            "Index"           -> 15,
            "Interpreter"     -> { "fitEnum", "EventType" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "event_type",
            "NativeType"      -> "FIT_EVENT_TYPE",
            "Type"            -> "EventType"
        |>
        ,
        "LengthType" -> <|
            "Dimensions"      -> { },
            "Index"           -> 19,
            "Interpreter"     -> { "fitEnum", "LengthType" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "length_type",
            "NativeType"      -> "FIT_LENGTH_TYPE",
            "Type"            -> "LengthType"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 6,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "OpponentScore" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 3,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "start_time",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "StrokeCount" -> <|
            "Comment"         -> "1 * counts + 0, stroke_type enum used as the index",
            "Dimensions"      -> { 1 },
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
            "Index"           -> 16,
            "Interpreter"     -> { "fitEnum", "SwimStroke" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "swim_stroke",
            "NativeType"      -> "FIT_SWIM_STROKE",
            "Type"            -> "SwimStroke"
        |>
        ,
        "Timestamp" -> <|
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "TotalCalories" -> <|
            "Comment"         -> "1 * kcal + 0",
            "Dimensions"      -> { },
            "Index"           -> 9,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_calories",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalElapsedTime" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 4,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_elapsed_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalStrokes" -> <|
            "Comment"         -> "1 * strokes + 0",
            "Dimensions"      -> { },
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
            "Index"           -> 5,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_timer_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "ZoneCount" -> <|
            "Comment"         -> "1 * counts + 0, zone number used as the index",
            "Dimensions"      -> { 1 },
            "Index"           -> 13;;13,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "zone_count",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
    |>
    ,
    "MessageCapabilities" -> <|
        "Count" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "MessageNumber" -> <|
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> { "fitEnum", "MessageNumber" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "mesg_num",
            "NativeType"      -> "FIT_MESG_NUM",
            "Type"            -> "MessageNumber"
        |>
    |>
    ,
    "MetabolicZone" -> <|
        "Calories" -> <|
            "Comment"         -> "10 * kcal / min + 0",
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "calories",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "FatCalories" -> <|
            "Comment"         -> "10 * kcal / min + 0",
            "Dimensions"      -> { },
            "Index"           -> 5,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "fat_calories",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "HighBeatsPerMinute" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
    |>
    ,
    "Monitoring" -> <|
        "ActiveTime" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 5,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "active_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "ActiveTime16" -> <|
            "Comment"         -> "1 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 10,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "active_time_16",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "ActivitySubtype" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 7,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "calories",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "Cycles" -> <|
            "Comment"         -> "2 * cycles + 0, Accumulated cycles. Maintained by MonitoringReader for each activity_type. See SDK documentation.",
            "Dimensions"      -> { },
            "Index"           -> 4,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "cycles",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Cycles16" -> <|
            "Comment"         -> "1 * 2 * cycles (steps) + 0",
            "Dimensions"      -> { },
            "Index"           -> 9,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "cycles_16",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "DeviceIndex" -> <|
            "Comment"         -> "Associates this data to device_info message. Not required for file with single device (sensor).",
            "Dimensions"      -> { },
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
            "Index"           -> 3,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "distance",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Distance16" -> <|
            "Comment"         -> "1 * 100 * m + 0",
            "Dimensions"      -> { },
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
            "Index"           -> 6,
            "Interpreter"     -> { "fitEnum", "LocalDateTime" },
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "local_timestamp",
            "NativeType"      -> "FIT_LOCAL_DATE_TIME",
            "Type"            -> "LocalDateTime"
        |>
        ,
        "Timestamp" -> <|
            "Comment"         -> "1 * s + 0, Must align to logging interval, for example, time must be 00:00:00 for daily log.",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
    |>
    ,
    "MonitoringInformation" -> <|
        "LocalTimestamp" -> <|
            "Comment"         -> "1 * s + 0, Use to convert activity timestamps to local time if device does not support time zone and daylight savings time correction.",
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> { "fitEnum", "LocalDateTime" },
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "local_timestamp",
            "NativeType"      -> "FIT_LOCAL_DATE_TIME",
            "Type"            -> "LocalDateTime"
        |>
        ,
        "Timestamp" -> <|
            "Comment"         -> "1 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
    |>
    ,
    "NMEASentence" -> <|
        "Sentence" -> <|
            "Comment"         -> "NMEA sentence",
            "Dimensions"      -> { 83 },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "TimestampMilliseconds" -> <|
            "Comment"         -> "1 * ms + 0, Fractional part of timestamp, added to timestamp",
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "timestamp_ms",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
    |>
    ,
    "PowerZone" -> <|
        "HighValue" -> <|
            "Comment"         -> "1 * watts + 0",
            "Dimensions"      -> { },
            "Index"           -> 19,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "high_value",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 18,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Name" -> <|
            "Dimensions"      -> { 16 },
            "Index"           -> 2;;17,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "name",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
    |>
    ,
    "Record" -> <|
        "AbsolutePressure" -> <|
            "Comment"         -> "1 * Pa + 0, Includes atmospheric pressure",
            "Dimensions"      -> { },
            "Index"           -> 11,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "absolute_pressure",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "AccumulatedPower" -> <|
            "Comment"         -> "1 * watts + 0",
            "Dimensions"      -> { },
            "Index"           -> 8,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "accumulated_power",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "ActivityType" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 19,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "altitude",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "BallSpeed" -> <|
            "Comment"         -> "100 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 29,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "ball_speed",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "BatteryStateOfCharge" -> <|
            "Comment"         -> "2 * percent + 0, lev battery state of charge",
            "Dimensions"      -> { },
            "Index"           -> 81,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "battery_soc",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "Cadence" -> <|
            "Comment"         -> "1 * rpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 45,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "Cadence256" -> <|
            "Comment"         -> "256 * rpm + 0, Log cadence and fractional cadence for backwards compatability",
            "Dimensions"      -> { },
            "Index"           -> 30,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "cadence256",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "Calories" -> <|
            "Comment"         -> "1 * kcal + 0",
            "Dimensions"      -> { },
            "Index"           -> 25,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "calories",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "CentralNervousSystemLoading" -> <|
            "Comment"         -> "1 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 82,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "cns_load",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "CombinedPedalSmoothness" -> <|
            "Comment"         -> "2 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 65,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "combined_pedal_smoothness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "CompressedAccumulatedPower" -> <|
            "Comment"         -> "1 * watts + 0",
            "Dimensions"      -> { },
            "Index"           -> 23,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "compressed_accumulated_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "CompressedSpeedDistance" -> <|
            "Dimensions"      -> { 3 },
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
            "Index"           -> 43,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "core_temperature",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "CycleLength" -> <|
            "Comment"         -> "100 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 50,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "cycle_length",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "Cycles" -> <|
            "Comment"         -> "1 * cycles + 0",
            "Dimensions"      -> { },
            "Index"           -> 57,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "cycles",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "Depth" -> <|
            "Comment"         -> "1000 * m + 0, 0 if above water",
            "Dimensions"      -> { },
            "Index"           -> 12,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "depth",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "DeviceIndex" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 5,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "distance",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "ElectricBikeAssistLevelPercent" -> <|
            "Comment"         -> "1 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 85,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "ebike_assist_level_percent",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "ElectricBikeAssistMode" -> <|
            "Comment"         -> "1 * depends on sensor + 0",
            "Dimensions"      -> { },
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
            "Index"           -> 83,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "ebike_battery_level",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "ElectricBikeTravelRange" -> <|
            "Comment"         -> "1 * km + 0",
            "Dimensions"      -> { },
            "Index"           -> 42,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "ebike_travel_range",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "EnhancedAltitude" -> <|
            "Comment"         -> "5 * m + 500",
            "Dimensions"      -> { },
            "Index"           -> 10,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "enhanced_altitude",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "EnhancedSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 9,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "enhanced_speed",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Flow" -> <|
            "Comment"         -> "The flow score estimates how long distance wise a cyclist deaccelerates over intervals where deacceleration is unnecessary such as smooth turns or small grade angle intervals.",
            "Dimensions"      -> { },
            "Index"           -> 18,
            "Interpreter"     -> "fitFloat32",
            "NativeFieldName" -> "flow",
            "NativeType"      -> "FIT_FLOAT32",
            "Type"            -> "Real32"
        |>
        ,
        "FractionalCadence" -> <|
            "Comment"         -> "128 * rpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 69,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "fractional_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "GPSAccuracy" -> <|
            "Comment"         -> "1 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 59,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "gps_accuracy",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "Grade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 22,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "Grit" -> <|
            "Comment"         -> "The grit score estimates how challenging a route could be for a cyclist in terms of time spent going over sharp turns or large grade slopes.",
            "Dimensions"      -> { },
            "Index"           -> 17,
            "Interpreter"     -> "fitFloat32",
            "NativeFieldName" -> "grit",
            "NativeType"      -> "FIT_FLOAT32",
            "Type"            -> "Real32"
        |>
        ,
        "HeartRate" -> <|
            "Comment"         -> "1 * bpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 44,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "LeftPedalSmoothness" -> <|
            "Comment"         -> "2 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 63,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "left_pedal_smoothness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "LeftPlatformCenterOffset" -> <|
            "Comment"         -> "1 * mm + 0, Left platform center offset",
            "Dimensions"      -> { },
            "Index"           -> 71,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "left_pco",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "LeftPowerPhase" -> <|
            "Comment"         -> "0.7111111 * degrees + 0, Left power phase angles. Data value indexes defined by power_phase_type.",
            "Dimensions"      -> { 2 },
            "Index"           -> 73;;74,
            "Interpreter"     -> "fitUINT8A",
            "Invalid"         -> 255,
            "NativeFieldName" -> "left_power_phase",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "LeftPowerPhasePeak" -> <|
            "Comment"         -> "0.7111111 * degrees + 0, Left power phase peak angles. Data value indexes defined by power_phase_type.",
            "Dimensions"      -> { 2 },
            "Index"           -> 75;;76,
            "Interpreter"     -> "fitUINT8A",
            "Invalid"         -> 255,
            "NativeFieldName" -> "left_power_phase_peak",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "LeftRightBalance" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 61,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "left_torque_effectiveness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MotorPower" -> <|
            "Comment"         -> "1 * watts + 0, lev motor power",
            "Dimensions"      -> { },
            "Index"           -> 37,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "motor_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "NextStopDepth" -> <|
            "Comment"         -> "1000 * m + 0, 0 if above water",
            "Dimensions"      -> { },
            "Index"           -> 13,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "next_stop_depth",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "NextStopTime" -> <|
            "Comment"         -> "1 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 14,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "next_stop_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "NitrogenLoad" -> <|
            "Comment"         -> "1 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 41,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "n2_load",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "NoDecompressionLimitTime" -> <|
            "Comment"         -> "1 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 16,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "ndl_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "PositionLatitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "position_lat",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "PositionLongitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 4,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "position_long",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "Power" -> <|
            "Comment"         -> "1 * watts + 0",
            "Dimensions"      -> { },
            "Index"           -> 21,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "Resistance" -> <|
            "Comment"         -> "Relative. 0 is none 254 is Max.",
            "Dimensions"      -> { },
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
            "Index"           -> 64,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "right_pedal_smoothness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "RightPlatformCenterOffset" -> <|
            "Comment"         -> "1 * mm + 0, Right platform center offset",
            "Dimensions"      -> { },
            "Index"           -> 72,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "right_pco",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "RightPowerPhase" -> <|
            "Comment"         -> "0.7111111 * degrees + 0, Right power phase angles. Data value indexes defined by power_phase_type.",
            "Dimensions"      -> { 2 },
            "Index"           -> 77;;78,
            "Interpreter"     -> "fitUINT8A",
            "Invalid"         -> 255,
            "NativeFieldName" -> "right_power_phase",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "RightPowerPhasePeak" -> <|
            "Comment"         -> "0.7111111 * degrees + 0, Right power phase peak angles. Data value indexes defined by power_phase_type.",
            "Dimensions"      -> { 2 },
            "Index"           -> 79;;80,
            "Interpreter"     -> "fitUINT8A",
            "Invalid"         -> 255,
            "NativeFieldName" -> "right_power_phase_peak",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "RightTorqueEffectiveness" -> <|
            "Comment"         -> "2 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 62,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "right_torque_effectiveness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "SaturatedHemoglobinPercent" -> <|
            "Comment"         -> "10 * % + 0, Percentage of hemoglobin saturated with oxygen",
            "Dimensions"      -> { },
            "Index"           -> 34,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "saturated_hemoglobin_percent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "SaturatedHemoglobinPercentMaximum" -> <|
            "Comment"         -> "10 * % + 0, Max percentage of hemoglobin saturated with oxygen",
            "Dimensions"      -> { },
            "Index"           -> 36,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "saturated_hemoglobin_percent_max",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "SaturatedHemoglobinPercentMinimum" -> <|
            "Comment"         -> "10 * % + 0, Min percentage of hemoglobin saturated with oxygen",
            "Dimensions"      -> { },
            "Index"           -> 35,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "saturated_hemoglobin_percent_min",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "Speed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 20,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "speed",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "Speed1S" -> <|
            "Comment"         -> "16 * m/s + 0, Speed at 1s intervals. Timestamp field indicates time of last array element.",
            "Dimensions"      -> { 5 },
            "Index"           -> 52;;56,
            "Interpreter"     -> "fitUINT8A",
            "Invalid"         -> 255,
            "NativeFieldName" -> "speed_1s",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "StanceTime" -> <|
            "Comment"         -> "10 * ms + 0",
            "Dimensions"      -> { },
            "Index"           -> 28,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "stance_time",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "StanceTimeBalance" -> <|
            "Comment"         -> "100 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 39,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "stance_time_balance",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "StanceTimePercent" -> <|
            "Comment"         -> "100 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 27,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "stance_time_percent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "StepLength" -> <|
            "Comment"         -> "10 * mm + 0",
            "Dimensions"      -> { },
            "Index"           -> 40,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "step_length",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "StrokeType" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 51,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "temperature",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "Time128" -> <|
            "Comment"         -> "128 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 66,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "time128",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "TimeFromCourse" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 6,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "time_from_course",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "Timestamp" -> <|
            "Comment"         -> "1 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "TimeToSurface" -> <|
            "Comment"         -> "1 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 15,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_to_surface",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalCycles" -> <|
            "Comment"         -> "1 * cycles + 0",
            "Dimensions"      -> { },
            "Index"           -> 7,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_cycles",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalHemoglobinConcentration" -> <|
            "Comment"         -> "100 * g/dL + 0, Total saturated and unsaturated hemoglobin",
            "Dimensions"      -> { },
            "Index"           -> 31,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_hemoglobin_conc",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalHemoglobinConcentrationMaximum" -> <|
            "Comment"         -> "100 * g/dL + 0, Max saturated and unsaturated hemoglobin",
            "Dimensions"      -> { },
            "Index"           -> 33,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_hemoglobin_conc_max",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalHemoglobinConcentrationMinimum" -> <|
            "Comment"         -> "100 * g/dL + 0, Min saturated and unsaturated hemoglobin",
            "Dimensions"      -> { },
            "Index"           -> 32,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_hemoglobin_conc_min",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "VerticalOscillation" -> <|
            "Comment"         -> "10 * mm + 0",
            "Dimensions"      -> { },
            "Index"           -> 26,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "vertical_oscillation",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "VerticalRatio" -> <|
            "Comment"         -> "100 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 38,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "vertical_ratio",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "VerticalSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 24,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "vertical_speed",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "Zone" -> <|
            "Dimensions"      -> { },
            "Index"           -> 68,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "zone",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
    |>
    ,
    "Schedule" -> <|
        "Completed" -> <|
            "Comment"         -> "TRUE if this activity has been started",
            "Dimensions"      -> { },
            "Index"           -> 7,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "completed",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "Manufacturer" -> <|
            "Comment"         -> "Corresponds to file_id of scheduled workout / course.",
            "Dimensions"      -> { },
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
            "Index"           -> 4,
            "Interpreter"     -> { "fitEnum", "LocalDateTime" },
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "scheduled_time",
            "NativeType"      -> "FIT_LOCAL_DATE_TIME",
            "Type"            -> "LocalDateTime"
        |>
        ,
        "SerialNumber" -> <|
            "Comment"         -> "Corresponds to file_id of scheduled workout / course.",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitUINT32Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "serial_number",
            "NativeType"      -> "FIT_UINT32Z",
            "Type"            -> "UnsignedInteger32z"
        |>
        ,
        "TimeCreated" -> <|
            "Comment"         -> "Corresponds to file_id of scheduled workout / course.",
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_created",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "Type" -> <|
            "Dimensions"      -> { },
            "Index"           -> 8,
            "Interpreter"     -> { "fitEnum", "Schedule" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "type",
            "NativeType"      -> "FIT_SCHEDULE",
            "Type"            -> "Schedule"
        |>
    |>
    ,
    "SegmentFile" -> <|
        "Enabled" -> <|
            "Comment"         -> "Enabled state of the segment file",
            "Dimensions"      -> { },
            "Index"           -> 7,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "FileUUID" -> <|
            "Comment"         -> "UUID of the segment file",
            "Dimensions"      -> { 1 },
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
            "Index"           -> 5,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "UserProfilePrimaryKey" -> <|
            "Comment"         -> "Primary key of the user that created the segment file",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "user_profile_primary_key",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
    |>
    ,
    "SegmentID" -> <|
        "DefaultRaceLeader" -> <|
            "Comment"         -> "Index for the Leader Board entry selected as the default race participant",
            "Dimensions"      -> { },
            "Index"           -> 8,
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
            "Index"           -> 9,
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
            "Index"           -> 3,
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
            "Index"           -> 7,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "Name" -> <|
            "Comment"         -> "Friendly name assigned to segment",
            "Dimensions"      -> { 1 },
            "Index"           -> 4;;4,
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
            "Index"           -> 10,
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
            "Index"           -> 6,
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
            "Index"           -> 2,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "user_profile_primary_key",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "UUID" -> <|
            "Comment"         -> "UUID of the segment",
            "Dimensions"      -> { 1 },
            "Index"           -> 5;;5,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "uuid",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
    |>
    ,
    "SegmentLap" -> <|
        "ActiveTime" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 38,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "active_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "AverageAltitude" -> <|
            "Comment"         -> "5 * m + 500",
            "Dimensions"      -> { },
            "Index"           -> 50,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_altitude",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageCadence" -> <|
            "Comment"         -> "1 * rpm + 0, total_cycles / total_timer_time if non_zero_avg_cadence otherwise total_cycles / total_elapsed_time",
            "Dimensions"      -> { },
            "Index"           -> 70,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageCombinedPedalSmoothness" -> <|
            "Comment"         -> "2 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 84,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_combined_pedal_smoothness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageFractionalCadence" -> <|
            "Comment"         -> "128 * rpm + 0, fractional part of the avg_cadence",
            "Dimensions"      -> { },
            "Index"           -> 119,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_fractional_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 52,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AverageHeartRate" -> <|
            "Comment"         -> "1 * bpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 68,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageLeftPedalSmoothness" -> <|
            "Comment"         -> "2 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 82,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_left_pedal_smoothness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageLeftTorqueEffectiveness" -> <|
            "Comment"         -> "2 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 80,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_left_torque_effectiveness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageNegativeGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 54,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_neg_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AverageNegativeVerticalSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 58,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_neg_vertical_speed",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AveragePositiveGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 53,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_pos_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AveragePositiveVerticalSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 57,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_pos_vertical_speed",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AveragePower" -> <|
            "Comment"         -> "1 * watts + 0, total_power / total_timer_time if non_zero_avg_power otherwise total_power / total_elapsed_time",
            "Dimensions"      -> { },
            "Index"           -> 44,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageRightPedalSmoothness" -> <|
            "Comment"         -> "2 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 83,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_right_pedal_smoothness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageRightTorqueEffectiveness" -> <|
            "Comment"         -> "2 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 81,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_right_torque_effectiveness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 42,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_speed",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageTemperature" -> <|
            "Comment"         -> "1 * C + 0",
            "Dimensions"      -> { },
            "Index"           -> 76,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "avg_temperature",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "EndPositionLatitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 6,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "end_position_lat",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "EndPositionLongitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 7,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "end_position_long",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "Event" -> <|
            "Dimensions"      -> { },
            "Index"           -> 66,
            "Interpreter"     -> { "fitEnum", "Event" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "event",
            "NativeType"      -> "FIT_EVENT",
            "Type"            -> "Event"
        |>
        ,
        "EventGroup" -> <|
            "Dimensions"      -> { },
            "Index"           -> 73,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "event_group",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "EventType" -> <|
            "Dimensions"      -> { },
            "Index"           -> 67,
            "Interpreter"     -> { "fitEnum", "EventType" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "event_type",
            "NativeType"      -> "FIT_EVENT_TYPE",
            "Type"            -> "EventType"
        |>
        ,
        "FrontGearShiftCount" -> <|
            "Dimensions"      -> { },
            "Index"           -> 64,
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
            "Index"           -> 75,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "gps_accuracy",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "LeftRightBalance" -> <|
            "Dimensions"      -> { },
            "Index"           -> 49,
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
            "Index"           -> 51,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_altitude",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumCadence" -> <|
            "Comment"         -> "1 * rpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 71,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "max_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MaximumFractionalCadence" -> <|
            "Comment"         -> "128 * rpm + 0, fractional part of the max_cadence",
            "Dimensions"      -> { },
            "Index"           -> 120,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "max_fractional_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MaximumHeartRate" -> <|
            "Comment"         -> "1 * bpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 69,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "max_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MaximumNegativeGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 56,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "max_neg_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "MaximumNegativeVerticalSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 60,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "max_neg_vertical_speed",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "MaximumPositiveGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 55,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "max_pos_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "MaximumPositiveVerticalSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 59,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "max_pos_vertical_speed",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "MaximumPower" -> <|
            "Comment"         -> "1 * watts + 0",
            "Dimensions"      -> { },
            "Index"           -> 45,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 43,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_speed",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumTemperature" -> <|
            "Comment"         -> "1 * C + 0",
            "Dimensions"      -> { },
            "Index"           -> 77,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "max_temperature",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 39,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "MinimumAltitude" -> <|
            "Comment"         -> "5 * m + 500",
            "Dimensions"      -> { },
            "Index"           -> 62,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "min_altitude",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MinimumHeartRate" -> <|
            "Comment"         -> "1 * bpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 78,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "min_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "Name" -> <|
            "Dimensions"      -> { 16 },
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
            "Index"           -> 48,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "normalized_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "NorthEastCornerLatitude" -> <|
            "Comment"         -> "1 * semicircles + 0, North east corner latitude.",
            "Dimensions"      -> { },
            "Index"           -> 12,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "nec_lat",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "NorthEastCornerLongitude" -> <|
            "Comment"         -> "1 * semicircles + 0, North east corner longitude.",
            "Dimensions"      -> { },
            "Index"           -> 13,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "nec_long",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "RearGearShiftCount" -> <|
            "Dimensions"      -> { },
            "Index"           -> 65,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "rear_gear_shift_count",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "RepetitionNumber" -> <|
            "Dimensions"      -> { },
            "Index"           -> 61,
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
            "Index"           -> 14,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "swc_lat",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "SouthWestCornerLongitude" -> <|
            "Comment"         -> "1 * semicircles + 0, South west corner latitude.",
            "Dimensions"      -> { },
            "Index"           -> 15,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "swc_long",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "Sport" -> <|
            "Dimensions"      -> { },
            "Index"           -> 72,
            "Interpreter"     -> { "fitEnum", "Sport" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "sport",
            "NativeType"      -> "FIT_SPORT",
            "Type"            -> "Sport"
        |>
        ,
        "SportEvent" -> <|
            "Dimensions"      -> { },
            "Index"           -> 79,
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
            "Index"           -> 4,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "start_position_lat",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "StartPositionLongitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 5,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "start_position_long",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "StartTime" -> <|
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "start_time",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "Status" -> <|
            "Dimensions"      -> { },
            "Index"           -> 85,
            "Interpreter"     -> { "fitEnum", "SegmentLapStatus" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "status",
            "NativeType"      -> "FIT_SEGMENT_LAP_STATUS",
            "Type"            -> "SegmentLapStatus"
        |>
        ,
        "SubSport" -> <|
            "Dimensions"      -> { },
            "Index"           -> 74,
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
            "Index"           -> 36;;36,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_in_cadence_zone",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TimeInHeartRateZone" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { 1 },
            "Index"           -> 34;;34,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_in_hr_zone",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TimeInPowerZone" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { 1 },
            "Index"           -> 37;;37,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_in_power_zone",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TimeInSpeedZone" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { 1 },
            "Index"           -> 35;;35,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_in_speed_zone",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Timestamp" -> <|
            "Comment"         -> "1 * s + 0, Lap end time.",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "TotalAscent" -> <|
            "Comment"         -> "1 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 46,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_ascent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalCalories" -> <|
            "Comment"         -> "1 * kcal + 0",
            "Dimensions"      -> { },
            "Index"           -> 40,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_calories",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalCycles" -> <|
            "Comment"         -> "1 * cycles + 0",
            "Dimensions"      -> { },
            "Index"           -> 11,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_cycles",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalDescent" -> <|
            "Comment"         -> "1 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 47,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_descent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalDistance" -> <|
            "Comment"         -> "100 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 10,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_distance",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalElapsedTime" -> <|
            "Comment"         -> "1000 * s + 0, Time (includes pauses)",
            "Dimensions"      -> { },
            "Index"           -> 8,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_elapsed_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalFatCalories" -> <|
            "Comment"         -> "1 * kcal + 0, If New Leaf",
            "Dimensions"      -> { },
            "Index"           -> 41,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_fat_calories",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalFractionalCycles" -> <|
            "Comment"         -> "128 * cycles + 0, fractional part of the total_cycles",
            "Dimensions"      -> { },
            "Index"           -> 121,
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
            "Index"           -> 33,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_moving_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalTimerTime" -> <|
            "Comment"         -> "1000 * s + 0, Timer Time (excludes pauses)",
            "Dimensions"      -> { },
            "Index"           -> 9,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_timer_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalWork" -> <|
            "Comment"         -> "1 * J + 0",
            "Dimensions"      -> { },
            "Index"           -> 32,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_work",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "UUID" -> <|
            "Dimensions"      -> { 33 },
            "Index"           -> 86;;118,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "uuid",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
        ,
        "WorkoutStepIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 63,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "wkt_step_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
    |>
    ,
    "SegmentLeaderboardEntry" -> <|
        "ActivityID" -> <|
            "Comment"         -> "ID of the activity associated with this leader time",
            "Dimensions"      -> { },
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
            "Index"           -> 5,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Name" -> <|
            "Comment"         -> "Friendly name assigned to leader",
            "Dimensions"      -> { 1 },
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
            "Index"           -> 4,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "segment_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Type" -> <|
            "Comment"         -> "Leader classification",
            "Dimensions"      -> { },
            "Index"           -> 7,
            "Interpreter"     -> { "fitEnum", "SegmentLeaderboardType" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "type",
            "NativeType"      -> "FIT_SEGMENT_LEADERBOARD_TYPE",
            "Type"            -> "SegmentLeaderboardType"
        |>
    |>
    ,
    "SegmentPoint" -> <|
        "Altitude" -> <|
            "Comment"         -> "5 * m + 500, Accumulated altitude along the segment at the described point",
            "Dimensions"      -> { },
            "Index"           -> 7,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "altitude",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "Distance" -> <|
            "Comment"         -> "100 * m + 0, Accumulated distance along the segment at the described point",
            "Dimensions"      -> { },
            "Index"           -> 4,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "distance",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "LeaderTime" -> <|
            "Comment"         -> "1000 * s + 0, Accumualted time each leader board member required to reach the described point. This value is zero for all leader board members at the starting point of the segment.",
            "Dimensions"      -> { 1 },
            "Index"           -> 5;;5,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "leader_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 6,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "PositionLatitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "position_lat",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "PositionLongitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "position_long",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
    |>
    ,
    "Session" -> <|
        "AverageAltitude" -> <|
            "Comment"         -> "5 * m + 500",
            "Dimensions"      -> { },
            "Index"           -> 73,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_altitude",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageAverageAscentSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 107,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_vam",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageBallSpeed" -> <|
            "Comment"         -> "100 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 91,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_ball_speed",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageCadence" -> <|
            "Comment"         -> "1 * rpm + 0, total_cycles / total_timer_time if non_zero_avg_cadence otherwise total_cycles / total_elapsed_time",
            "Dimensions"      -> { },
            "Index"           -> 118,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageCadencePosition" -> <|
            "Comment"         -> "1 * rpm + 0, Average cadence by position. Data value indexes defined by rider_position_type.",
            "Dimensions"      -> { 2 },
            "Index"           -> 148;;149,
            "Interpreter"     -> "fitUINT8A",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_cadence_position",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageCombinedPedalSmoothness" -> <|
            "Comment"         -> "2 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 136,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_combined_pedal_smoothness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageCoreTemperature" -> <|
            "Comment"         -> "100 * C + 0",
            "Dimensions"      -> { },
            "Index"           -> 109,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_core_temperature",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageFlow" -> <|
            "Comment"         -> "1 * Flow + 0, The flow score estimates how long distance wise a cyclist deaccelerates over intervals where deacceleration is unnecessary such as smooth turns or small grade angle intervals.",
            "Dimensions"      -> { },
            "Index"           -> 52,
            "Interpreter"     -> "fitFloat32",
            "NativeFieldName" -> "avg_flow",
            "NativeType"      -> "FIT_FLOAT32",
            "Type"            -> "Real32"
        |>
        ,
        "AverageFractionalCadence" -> <|
            "Comment"         -> "128 * rpm + 0, fractional part of the avg_cadence",
            "Dimensions"      -> { },
            "Index"           -> 129,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_fractional_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 75,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AverageGrit" -> <|
            "Comment"         -> "1 * kGrit + 0, The grit score estimates how challenging a route could be for a cyclist in terms of time spent going over sharp turns or large grade slopes.",
            "Dimensions"      -> { },
            "Index"           -> 51,
            "Interpreter"     -> "fitFloat32",
            "NativeFieldName" -> "avg_grit",
            "NativeType"      -> "FIT_FLOAT32",
            "Type"            -> "Real32"
        |>
        ,
        "AverageHeartRate" -> <|
            "Comment"         -> "1 * bpm + 0, average heart rate (excludes pause time)",
            "Dimensions"      -> { },
            "Index"           -> 116,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageLapTime" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 21,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "avg_lap_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "AverageLeftPedalSmoothness" -> <|
            "Comment"         -> "2 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 134,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_left_pedal_smoothness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageLeftPlatformCenterOffset" -> <|
            "Comment"         -> "1 * mm + 0, Average platform center offset Left",
            "Dimensions"      -> { },
            "Index"           -> 138,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "avg_left_pco",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "AverageLeftPowerPhase" -> <|
            "Comment"         -> "0.7111111 * degrees + 0, Average left power phase angles. Indexes defined by power_phase_type.",
            "Dimensions"      -> { 2 },
            "Index"           -> 140;;141,
            "Interpreter"     -> "fitUINT8A",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_left_power_phase",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageLeftPowerPhasePeak" -> <|
            "Comment"         -> "0.7111111 * degrees + 0, Average left power phase peak angles. Data value indexes defined by power_phase_type.",
            "Dimensions"      -> { 2 },
            "Index"           -> 142;;143,
            "Interpreter"     -> "fitUINT8A",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_left_power_phase_peak",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageLeftTorqueEffectiveness" -> <|
            "Comment"         -> "2 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 132,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_left_torque_effectiveness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageLightElectricalVehicleMotorPower" -> <|
            "Comment"         -> "1 * watts + 0, lev average motor power during session",
            "Dimensions"      -> { },
            "Index"           -> 102,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_lev_motor_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageNegativeGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 77,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_neg_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AverageNegativeVerticalSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 81,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_neg_vertical_speed",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AveragePositiveGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 76,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_pos_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AveragePositiveVerticalSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 80,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "avg_pos_vertical_speed",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "AveragePower" -> <|
            "Comment"         -> "1 * watts + 0, total_power / total_timer_time if non_zero_avg_power otherwise total_power / total_elapsed_time",
            "Dimensions"      -> { },
            "Index"           -> 58,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AveragePowerPosition" -> <|
            "Comment"         -> "1 * watts + 0, Average power by position. Data value indexes defined by rider_position_type.",
            "Dimensions"      -> { 2 },
            "Index"           -> 39;;40,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_power_position",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageRightPedalSmoothness" -> <|
            "Comment"         -> "2 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 135,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_right_pedal_smoothness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageRightPlatformCenterOffset" -> <|
            "Comment"         -> "1 * mm + 0, Average platform center offset Right",
            "Dimensions"      -> { },
            "Index"           -> 139,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "avg_right_pco",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "AverageRightPowerPhase" -> <|
            "Comment"         -> "0.7111111 * degrees + 0, Average right power phase angles. Data value indexes defined by power_phase_type.",
            "Dimensions"      -> { 2 },
            "Index"           -> 144;;145,
            "Interpreter"     -> "fitUINT8A",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_right_power_phase",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageRightPowerPhasePeak" -> <|
            "Comment"         -> "0.7111111 * degrees + 0, Average right power phase peak angles data value indexes defined by power_phase_type.",
            "Dimensions"      -> { 2 },
            "Index"           -> 146;;147,
            "Interpreter"     -> "fitUINT8A",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_right_power_phase_peak",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageRightTorqueEffectiveness" -> <|
            "Comment"         -> "2 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 133,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "avg_right_torque_effectiveness",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "AverageSaturatedHemoglobinPercent" -> <|
            "Comment"         -> "10 * % + 0, Avg percentage of hemoglobin saturated with oxygen",
            "Dimensions"      -> { 1 },
            "Index"           -> 98;;98,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_saturated_hemoglobin_percent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0, total_distance / total_timer_time",
            "Dimensions"      -> { },
            "Index"           -> 56,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_speed",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageStanceTime" -> <|
            "Comment"         -> "10 * ms + 0",
            "Dimensions"      -> { },
            "Index"           -> 94,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_stance_time",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageStanceTimeBalance" -> <|
            "Comment"         -> "100 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 105,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_stance_time_balance",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageStanceTimePercent" -> <|
            "Comment"         -> "100 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 93,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_stance_time_percent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageStepLength" -> <|
            "Comment"         -> "10 * mm + 0",
            "Dimensions"      -> { },
            "Index"           -> 106,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_step_length",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageStrokeCount" -> <|
            "Comment"         -> "10 * strokes/lap + 0",
            "Dimensions"      -> { },
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
            "Index"           -> 69,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_stroke_distance",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageTemperature" -> <|
            "Comment"         -> "1 * C + 0",
            "Dimensions"      -> { },
            "Index"           -> 126,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "avg_temperature",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "AverageTotalHemoglobinConcentration" -> <|
            "Comment"         -> "100 * g/dL + 0, Avg saturated and unsaturated hemoglobin",
            "Dimensions"      -> { 1 },
            "Index"           -> 95;;95,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_total_hemoglobin_conc",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageVerticalOscillation" -> <|
            "Comment"         -> "10 * mm + 0",
            "Dimensions"      -> { },
            "Index"           -> 92,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_vertical_oscillation",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "AverageVerticalRatio" -> <|
            "Comment"         -> "100 * percent + 0",
            "Dimensions"      -> { },
            "Index"           -> 104,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "avg_vertical_ratio",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "BestLapIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 84,
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
            "Index"           -> 45,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "enhanced_avg_altitude",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "EnhancedAverageSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0, total_distance / total_timer_time",
            "Dimensions"      -> { },
            "Index"           -> 43,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "enhanced_avg_speed",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "EnhancedMaximumAltitude" -> <|
            "Comment"         -> "5 * m + 500",
            "Dimensions"      -> { },
            "Index"           -> 47,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "enhanced_max_altitude",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "EnhancedMaximumSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 44,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "enhanced_max_speed",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "EnhancedMinimumAltitude" -> <|
            "Comment"         -> "5 * m + 500",
            "Dimensions"      -> { },
            "Index"           -> 46,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "enhanced_min_altitude",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Event" -> <|
            "Comment"         -> "session",
            "Dimensions"      -> { },
            "Index"           -> 112,
            "Interpreter"     -> { "fitEnum", "Event" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "event",
            "NativeType"      -> "FIT_EVENT",
            "Type"            -> "Event"
        |>
        ,
        "EventGroup" -> <|
            "Dimensions"      -> { },
            "Index"           -> 121,
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
            "Index"           -> 113,
            "Interpreter"     -> { "fitEnum", "EventType" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "event_type",
            "NativeType"      -> "FIT_EVENT_TYPE",
            "Type"            -> "EventType"
        |>
        ,
        "FirstLapIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 62,
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
            "Index"           -> 125,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "gps_accuracy",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "IntensityFactor" -> <|
            "Comment"         -> "1000 * if + 0",
            "Dimensions"      -> { },
            "Index"           -> 67,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "intensity_factor",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "JumpCount" -> <|
            "Dimensions"      -> { },
            "Index"           -> 108,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "jump_count",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "LeftRightBalance" -> <|
            "Dimensions"      -> { },
            "Index"           -> 68,
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
            "Index"           -> 152,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "lev_battery_consumption",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MaximumAltitude" -> <|
            "Comment"         -> "5 * m + 500",
            "Dimensions"      -> { },
            "Index"           -> 74,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_altitude",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumBallSpeed" -> <|
            "Comment"         -> "100 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 90,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_ball_speed",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumCadence" -> <|
            "Comment"         -> "1 * rpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 119,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "max_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MaximumCadencePosition" -> <|
            "Comment"         -> "1 * rpm + 0, Maximum cadence by position. Data value indexes defined by rider_position_type.",
            "Dimensions"      -> { 2 },
            "Index"           -> 150;;151,
            "Interpreter"     -> "fitUINT8A",
            "Invalid"         -> 255,
            "NativeFieldName" -> "max_cadence_position",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MaximumCoreTemperature" -> <|
            "Comment"         -> "100 * C + 0",
            "Dimensions"      -> { },
            "Index"           -> 111,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_core_temperature",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumFractionalCadence" -> <|
            "Comment"         -> "128 * rpm + 0, fractional part of the max_cadence",
            "Dimensions"      -> { },
            "Index"           -> 130,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "max_fractional_cadence",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MaximumHeartRate" -> <|
            "Comment"         -> "1 * bpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 117,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "max_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MaximumLightElectricalVehicleMotorPower" -> <|
            "Comment"         -> "1 * watts + 0, lev maximum motor power during session",
            "Dimensions"      -> { },
            "Index"           -> 103,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_lev_motor_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumNegativeGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 79,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "max_neg_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "MaximumNegativeVerticalSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 83,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "max_neg_vertical_speed",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "MaximumPositiveGrade" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 78,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "max_pos_grade",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "MaximumPositiveVerticalSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 82,
            "Interpreter"     -> "fitSINT16",
            "Invalid"         -> 32767,
            "NativeFieldName" -> "max_pos_vertical_speed",
            "NativeType"      -> "FIT_SINT16",
            "Type"            -> "SignedInteger16"
        |>
        ,
        "MaximumPower" -> <|
            "Comment"         -> "1 * watts + 0",
            "Dimensions"      -> { },
            "Index"           -> 59,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumPowerPosition" -> <|
            "Comment"         -> "1 * watts + 0, Maximum power by position. Data value indexes defined by rider_position_type.",
            "Dimensions"      -> { 2 },
            "Index"           -> 41;;42,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_power_position",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumSaturatedHemoglobinPercent" -> <|
            "Comment"         -> "10 * % + 0, Max percentage of hemoglobin saturated with oxygen",
            "Dimensions"      -> { 1 },
            "Index"           -> 100;;100,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_saturated_hemoglobin_percent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumSpeed" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 57,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_speed",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MaximumTemperature" -> <|
            "Comment"         -> "1 * C + 0",
            "Dimensions"      -> { },
            "Index"           -> 127,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "max_temperature",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "MaximumTotalHemoglobinConcentration" -> <|
            "Comment"         -> "100 * g/dL + 0, Max saturated and unsaturated hemoglobin",
            "Dimensions"      -> { 1 },
            "Index"           -> 97;;97,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "max_total_hemoglobin_conc",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MessageIndex" -> <|
            "Comment"         -> "Selected bit is set for the current session.",
            "Dimensions"      -> { },
            "Index"           -> 53,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "MinimumAltitude" -> <|
            "Comment"         -> "5 * m + 500",
            "Dimensions"      -> { },
            "Index"           -> 85,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "min_altitude",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MinimumCoreTemperature" -> <|
            "Comment"         -> "100 * C + 0",
            "Dimensions"      -> { },
            "Index"           -> 110,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "min_core_temperature",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MinimumHeartRate" -> <|
            "Comment"         -> "1 * bpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 128,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "min_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MinimumSaturatedHemoglobinPercent" -> <|
            "Comment"         -> "10 * % + 0, Min percentage of hemoglobin saturated with oxygen",
            "Dimensions"      -> { 1 },
            "Index"           -> 99;;99,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "min_saturated_hemoglobin_percent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MinimumTotalHemoglobinConcentration" -> <|
            "Comment"         -> "100 * g/dL + 0, Min saturated and unsaturated hemoglobin",
            "Dimensions"      -> { 1 },
            "Index"           -> 96;;96,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "min_total_hemoglobin_conc",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "NormalizedPower" -> <|
            "Comment"         -> "1 * watts + 0",
            "Dimensions"      -> { },
            "Index"           -> 65,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "normalized_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "NorthEastCornerLatitude" -> <|
            "Comment"         -> "1 * semicircles + 0, North east corner latitude",
            "Dimensions"      -> { },
            "Index"           -> 10,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "nec_lat",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "NorthEastCornerLongitude" -> <|
            "Comment"         -> "1 * semicircles + 0, North east corner longitude",
            "Dimensions"      -> { },
            "Index"           -> 11,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "nec_long",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "NumberActiveLengths" -> <|
            "Comment"         -> "1 * lengths + 0, # of active lengths of swim pool",
            "Dimensions"      -> { },
            "Index"           -> 72,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "num_active_lengths",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "NumberLaps" -> <|
            "Dimensions"      -> { },
            "Index"           -> 63,
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
            "Index"           -> 64,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "num_lengths",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "OpponentName" -> <|
            "Dimensions"      -> { 16 },
            "Index"           -> 22;;37,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "opponent_name",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
        ,
        "OpponentScore" -> <|
            "Dimensions"      -> { },
            "Index"           -> 87,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "opponent_score",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "PlayerScore" -> <|
            "Dimensions"      -> { },
            "Index"           -> 86,
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
            "Index"           -> 70,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "pool_length",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "PoolLengthUnit" -> <|
            "Dimensions"      -> { },
            "Index"           -> 124,
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
            "Index"           -> 12,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "swc_lat",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "SouthWestCornerLongitude" -> <|
            "Comment"         -> "1 * semicircles + 0, South west corner longitude",
            "Dimensions"      -> { },
            "Index"           -> 13,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "swc_long",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "Sport" -> <|
            "Dimensions"      -> { },
            "Index"           -> 114,
            "Interpreter"     -> { "fitEnum", "Sport" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "sport",
            "NativeType"      -> "FIT_SPORT",
            "Type"            -> "Sport"
        |>
        ,
        "SportIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 137,
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
            "Index"           -> 101,
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
            "Index"           -> 4,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "start_position_lat",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "StartPositionLongitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 5,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "start_position_long",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "StartTime" -> <|
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "start_time",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "StrokeCount" -> <|
            "Comment"         -> "1 * counts + 0, stroke_type enum used as the index",
            "Dimensions"      -> { 1 },
            "Index"           -> 88;;88,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "stroke_count",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "SubSport" -> <|
            "Dimensions"      -> { },
            "Index"           -> 115,
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
            "Index"           -> 123,
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
            "Index"           -> 71,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "threshold_power",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TimeInCadenceZone" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { 1 },
            "Index"           -> 19;;19,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_in_cadence_zone",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TimeInHeartRateZone" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { 1 },
            "Index"           -> 17;;17,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_in_hr_zone",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TimeInPowerZone" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { 1 },
            "Index"           -> 20;;20,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_in_power_zone",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TimeInSpeedZone" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { 1 },
            "Index"           -> 18;;18,
            "Interpreter"     -> "fitUINT32A",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_in_speed_zone",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Timestamp" -> <|
            "Comment"         -> "1 * s + 0, Sesson end time.",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "TimeStanding" -> <|
            "Comment"         -> "1000 * s + 0, Total time spend in the standing position",
            "Dimensions"      -> { },
            "Index"           -> 38,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_standing",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalAnaerobicTrainingEffect" -> <|
            "Dimensions"      -> { },
            "Index"           -> 153,
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
            "Index"           -> 60,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_ascent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalCalories" -> <|
            "Comment"         -> "1 * kcal + 0",
            "Dimensions"      -> { },
            "Index"           -> 54,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_calories",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalCycles" -> <|
            "Comment"         -> "1 * cycles + 0",
            "Dimensions"      -> { },
            "Index"           -> 9,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_cycles",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalDescent" -> <|
            "Comment"         -> "1 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 61,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_descent",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalDistance" -> <|
            "Comment"         -> "100 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 8,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_distance",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalElapsedTime" -> <|
            "Comment"         -> "1000 * s + 0, Time (includes pauses)",
            "Dimensions"      -> { },
            "Index"           -> 6,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_elapsed_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalFatCalories" -> <|
            "Comment"         -> "1 * kcal + 0",
            "Dimensions"      -> { },
            "Index"           -> 55,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "total_fat_calories",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "TotalFlow" -> <|
            "Comment"         -> "1 * Flow + 0, The flow score estimates how long distance wise a cyclist deaccelerates over intervals where deacceleration is unnecessary such as smooth turns or small grade angle intervals.",
            "Dimensions"      -> { },
            "Index"           -> 50,
            "Interpreter"     -> "fitFloat32",
            "NativeFieldName" -> "total_flow",
            "NativeType"      -> "FIT_FLOAT32",
            "Type"            -> "Real32"
        |>
        ,
        "TotalFractionalAscent" -> <|
            "Comment"         -> "100 * m + 0, fractional part of total_ascent",
            "Dimensions"      -> { },
            "Index"           -> 154,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "total_fractional_ascent",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "TotalFractionalCycles" -> <|
            "Comment"         -> "128 * cycles + 0, fractional part of the total_cycles",
            "Dimensions"      -> { },
            "Index"           -> 131,
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
            "Index"           -> 155,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "total_fractional_descent",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "TotalGrit" -> <|
            "Comment"         -> "1 * kGrit + 0, The grit score estimates how challenging a route could be for a cyclist in terms of time spent going over sharp turns or large grade slopes.",
            "Dimensions"      -> { },
            "Index"           -> 49,
            "Interpreter"     -> "fitFloat32",
            "NativeFieldName" -> "total_grit",
            "NativeType"      -> "FIT_FLOAT32",
            "Type"            -> "Real32"
        |>
        ,
        "TotalMovingTime" -> <|
            "Comment"         -> "1000 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 16,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_moving_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalTimerTime" -> <|
            "Comment"         -> "1000 * s + 0, Timer Time (excludes pauses)",
            "Dimensions"      -> { },
            "Index"           -> 7,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_timer_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TotalTrainingEffect" -> <|
            "Dimensions"      -> { },
            "Index"           -> 120,
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
            "Index"           -> 15,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "total_work",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "TrainingLoadPeak" -> <|
            "Dimensions"      -> { },
            "Index"           -> 48,
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
            "Index"           -> 66,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "training_stress_score",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "Trigger" -> <|
            "Dimensions"      -> { },
            "Index"           -> 122,
            "Interpreter"     -> { "fitEnum", "SessionTrigger" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "trigger",
            "NativeType"      -> "FIT_SESSION_TRIGGER",
            "Type"            -> "SessionTrigger"
        |>
        ,
        "ZoneCount" -> <|
            "Comment"         -> "1 * counts + 0, zone number used as the index",
            "Dimensions"      -> { 1 },
            "Index"           -> 89;;89,
            "Interpreter"     -> "fitUINT16A",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "zone_count",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
    |>
    ,
    "Set" -> <|
        "WeightDisplayUnit" -> <|
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> { "fitEnum", "FitBaseUnit" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "weight_display_unit",
            "NativeType"      -> "FIT_FIT_BASE_UNIT",
            "Type"            -> "FitBaseUnit"
        |>
    |>
    ,
    "SlaveDevice" -> <|
        "Manufacturer" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 3,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "product",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
    |>
    ,
    "Software" -> <|
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 18,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "PartNumber" -> <|
            "Dimensions"      -> { 16 },
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
            "Index"           -> 19,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "version",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
    |>
    ,
    "SpeedZone" -> <|
        "HighValue" -> <|
            "Comment"         -> "1000 * m/s + 0",
            "Dimensions"      -> { },
            "Index"           -> 19,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "high_value",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 18,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Name" -> <|
            "Dimensions"      -> { 16 },
            "Index"           -> 2;;17,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "name",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
    |>
    ,
    "Sport" -> <|
        "Name" -> <|
            "Dimensions"      -> { 16 },
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
            "Index"           -> 19,
            "Interpreter"     -> { "fitEnum", "SubSport" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "sub_sport",
            "NativeType"      -> "FIT_SUB_SPORT",
            "Type"            -> "SubSport"
        |>
    |>
    ,
    "StrideAndDistanceMonitorProfile" -> <|
        "Enabled" -> <|
            "Dimensions"      -> { },
            "Index"           -> 6,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "enabled",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 3,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Odometer" -> <|
            "Comment"         -> "100 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "odometer",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "OdometerRollover" -> <|
            "Comment"         -> "Rollover counter that can be used to extend the odometer",
            "Dimensions"      -> { },
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
            "Index"           -> 7,
            "Interpreter"     -> "fitBool",
            "Invalid"         -> 255,
            "NativeFieldName" -> "speed_source",
            "NativeType"      -> "FIT_BOOL",
            "Type"            -> "Bool"
        |>
        ,
        "StrideAndDistanceMonitorANTID" -> <|
            "Dimensions"      -> { },
            "Index"           -> 4,
            "Interpreter"     -> "fitUINT16Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "sdm_ant_id",
            "NativeType"      -> "FIT_UINT16Z",
            "Type"            -> "UnsignedInteger16z"
        |>
        ,
        "StrideAndDistanceMonitorANTIDTransmissionType" -> <|
            "Dimensions"      -> { },
            "Index"           -> 8,
            "Interpreter"     -> "fitUINT8Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "sdm_ant_id_trans_type",
            "NativeType"      -> "FIT_UINT8Z",
            "Type"            -> "UnsignedInteger8z"
        |>
        ,
        "StrideAndDistanceMonitorCalibrationFactor" -> <|
            "Comment"         -> "10 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 5,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "sdm_cal_factor",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
    |>
    ,
    "Totals" -> <|
        "ActiveTime" -> <|
            "Comment"         -> "1 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 7,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "active_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Calories" -> <|
            "Comment"         -> "1 * kcal + 0",
            "Dimensions"      -> { },
            "Index"           -> 5,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "calories",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Distance" -> <|
            "Comment"         -> "1 * m + 0",
            "Dimensions"      -> { },
            "Index"           -> 4,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "distance",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "ElapsedTime" -> <|
            "Comment"         -> "1 * s + 0, Includes pauses",
            "Dimensions"      -> { },
            "Index"           -> 6,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "elapsed_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "MessageIndex" -> <|
            "Dimensions"      -> { },
            "Index"           -> 8,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Sessions" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 3,
            "Interpreter"     -> "fitUINT32",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timer_time",
            "NativeType"      -> "FIT_UINT32",
            "Type"            -> "UnsignedInteger32"
        |>
        ,
        "Timestamp" -> <|
            "Comment"         -> "1 * s + 0",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
    |>
    ,
    "TrainingFile" -> <|
        "Manufacturer" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 3,
            "Interpreter"     -> "fitUINT32Z",
            "Invalid"         -> 0,
            "NativeFieldName" -> "serial_number",
            "NativeType"      -> "FIT_UINT32Z",
            "Type"            -> "UnsignedInteger32z"
        |>
        ,
        "TimeCreated" -> <|
            "Dimensions"      -> { },
            "Index"           -> 4,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "time_created",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "Timestamp" -> <|
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "Type" -> <|
            "Dimensions"      -> { },
            "Index"           -> 7,
            "Interpreter"     -> { "fitEnum", "File" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "type",
            "NativeType"      -> "FIT_FILE",
            "Type"            -> "File"
        |>
    |>
    ,
    "UserProfile" -> <|
        "ActivityClass" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 27,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "age",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "DefaultMaximumBikingHeartRate" -> <|
            "Comment"         -> "1 * bpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 34,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "default_max_biking_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "DefaultMaximumHeartRate" -> <|
            "Comment"         -> "1 * bpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 35,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "default_max_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "DefaultMaximumRunningHeartRate" -> <|
            "Comment"         -> "1 * bpm + 0",
            "Dimensions"      -> { },
            "Index"           -> 33,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "default_max_running_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "DepthSetting" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 28,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "height",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "HeightSetting" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 29,
            "Interpreter"     -> { "fitEnum", "Language" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "language",
            "NativeType"      -> "FIT_LANGUAGE",
            "Type"            -> "Language"
        |>
        ,
        "LocalID" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 21,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "PositionSetting" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 32,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "resting_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "SleepTime" -> <|
            "Comment"         -> "Typical bed time",
            "Dimensions"      -> { },
            "Index"           -> 19,
            "Interpreter"     -> { "fitEnum", "LocalTimeIntoDay" },
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "sleep_time",
            "NativeType"      -> "FIT_LOCALTIME_INTO_DAY",
            "Type"            -> "LocalTimeIntoDay"
        |>
        ,
        "SpeedSetting" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 24,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "user_running_step_length",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "UserWalkingStepLength" -> <|
            "Comment"         -> "1000 * m + 0, User defined walking step length set to 0 for auto length",
            "Dimensions"      -> { },
            "Index"           -> 25,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "user_walking_step_length",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "WakeTime" -> <|
            "Comment"         -> "Typical wake time",
            "Dimensions"      -> { },
            "Index"           -> 18,
            "Interpreter"     -> { "fitEnum", "LocalTimeIntoDay" },
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "wake_time",
            "NativeType"      -> "FIT_LOCALTIME_INTO_DAY",
            "Type"            -> "LocalTimeIntoDay"
        |>
        ,
        "Weight" -> <|
            "Comment"         -> "10 * kg + 0",
            "Dimensions"      -> { },
            "Index"           -> 22,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "weight",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "WeightSetting" -> <|
            "Dimensions"      -> { },
            "Index"           -> 31,
            "Interpreter"     -> { "fitEnum", "DisplayMeasure" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "weight_setting",
            "NativeType"      -> "FIT_DISPLAY_MEASURE",
            "Type"            -> "DisplayMeasure"
        |>
    |>
    ,
    "VideoDescription" -> <|
        "MessageCount" -> <|
            "Comment"         -> "Total number of description parts",
            "Dimensions"      -> { },
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
            "Index"           -> 130,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Text" -> <|
            "Dimensions"      -> { 128 },
            "Index"           -> 2;;129,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "text",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
    |>
    ,
    "VideoTitle" -> <|
        "MessageCount" -> <|
            "Comment"         -> "Total number of title parts",
            "Dimensions"      -> { },
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
            "Index"           -> 82,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Text" -> <|
            "Dimensions"      -> { 80 },
            "Index"           -> 2;;81,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "text",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
    |>
    ,
    "WeatherAlert" -> <|
        "ExpireTime" -> <|
            "Comment"         -> "Time alert expires",
            "Dimensions"      -> { },
            "Index"           -> 16,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "expire_time",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "IssueTime" -> <|
            "Comment"         -> "Time alert was issued",
            "Dimensions"      -> { },
            "Index"           -> 15,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "issue_time",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "ReportID" -> <|
            "Comment"         -> "Unique identifier from GCS report ID string, length is 12",
            "Dimensions"      -> { 12 },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "Type" -> <|
            "Comment"         -> "Tornado, Severe Thunderstorm, etc.",
            "Dimensions"      -> { },
            "Index"           -> 18,
            "Interpreter"     -> { "fitEnum", "WeatherSevereType" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "type",
            "NativeType"      -> "FIT_WEATHER_SEVERE_TYPE",
            "Type"            -> "WeatherSevereType"
        |>
    |>
    ,
    "WeatherConditions" -> <|
        "Condition" -> <|
            "Comment"         -> "Corresponds to GSC Response weatherIcon field",
            "Dimensions"      -> { },
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
            "Index"           -> 79,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "high_temperature",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "Location" -> <|
            "Comment"         -> "string corresponding to GCS response location string",
            "Dimensions"      -> { 64 },
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
            "Index"           -> 80,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "low_temperature",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "ObservedAtTime" -> <|
            "Dimensions"      -> { },
            "Index"           -> 67,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "observed_at_time",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "ObservedLatitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 68,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "observed_location_lat",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "ObservedLongitude" -> <|
            "Comment"         -> "1 * semicircles + 0",
            "Dimensions"      -> { },
            "Index"           -> 69,
            "Interpreter"     -> "fitSINT32",
            "Invalid"         -> 2147483647,
            "NativeFieldName" -> "observed_location_long",
            "NativeType"      -> "FIT_SINT32",
            "Type"            -> "SignedInteger32"
        |>
        ,
        "PrecipitationProbability" -> <|
            "Comment"         -> "range 0-100",
            "Dimensions"      -> { },
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
            "Index"           -> 73,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "temperature",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "TemperatureFeelsLike" -> <|
            "Comment"         -> "1 * C + 0, Heat Index if GCS heatIdx above or equal to 90F or wind chill if GCS windChill below or equal to 32F",
            "Dimensions"      -> { },
            "Index"           -> 76,
            "Interpreter"     -> "fitSINT8",
            "Invalid"         -> 127,
            "NativeFieldName" -> "temperature_feels_like",
            "NativeType"      -> "FIT_SINT8",
            "Type"            -> "SignedInteger8"
        |>
        ,
        "Timestamp" -> <|
            "Comment"         -> "time of update for current conditions, else forecast time",
            "Dimensions"      -> { },
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "WeatherReport" -> <|
            "Comment"         -> "Current or forecast",
            "Dimensions"      -> { },
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
            "Index"           -> 71,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "wind_speed",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
    |>
    ,
    "WeightScale" -> <|
        "ActiveMetabolicRate" -> <|
            "Comment"         -> "4 * kcal/day + 0, ~4kJ per kcal, 0.25 allows max 16384 kcal",
            "Dimensions"      -> { },
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
            "Index"           -> 13,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "metabolic_age",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
        ,
        "MuscleMass" -> <|
            "Comment"         -> "100 * kg + 0",
            "Dimensions"      -> { },
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
            "Index"           -> 4,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "percent_fat",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "PercentHydration" -> <|
            "Comment"         -> "100 * % + 0",
            "Dimensions"      -> { },
            "Index"           -> 5,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "percent_hydration",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "PhysiqueRating" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> "fitDateTime",
            "Invalid"         -> 4294967295,
            "NativeFieldName" -> "timestamp",
            "NativeType"      -> "FIT_DATE_TIME",
            "Type"            -> "DateTime"
        |>
        ,
        "UserProfileIndex" -> <|
            "Comment"         -> "Associates this weight scale message to a user. This corresponds to the index of the user profile message in the weight scale file.",
            "Dimensions"      -> { },
            "Index"           -> 11,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "user_profile_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "VisceralFatMass" -> <|
            "Comment"         -> "100 * kg + 0",
            "Dimensions"      -> { },
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
            "Index"           -> 3,
            "Interpreter"     -> { "fitEnum", "Weight" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "weight",
            "NativeType"      -> "FIT_WEIGHT",
            "Type"            -> "Weight"
        |>
    |>
    ,
    "Workout" -> <|
        "Capabilities" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 104,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "pool_length",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "PoolLengthUnit" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 3;;102,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "wkt_name",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
    |>
    ,
    "WorkoutSession" -> <|
        "FirstStepIndex" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 2,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "NumberOfValidSteps" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 5,
            "Interpreter"     -> "fitUINT16",
            "Invalid"         -> 65535,
            "NativeFieldName" -> "pool_length",
            "NativeType"      -> "FIT_UINT16",
            "Type"            -> "UnsignedInteger16"
        |>
        ,
        "PoolLengthUnit" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 7,
            "Interpreter"     -> { "fitEnum", "SubSport" },
            "Invalid"         -> 255,
            "NativeFieldName" -> "sub_sport",
            "NativeType"      -> "FIT_SUB_SPORT",
            "Type"            -> "SubSport"
        |>
    |>
    ,
    "WorkoutStep" -> <|
        "CustomTargetValueHigh" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 57,
            "Interpreter"     -> { "fitEnum", "MessageIndex" },
            "Invalid"         -> 65535,
            "NativeFieldName" -> "message_index",
            "NativeType"      -> "FIT_MESSAGE_INDEX",
            "Type"            -> "MessageIndex"
        |>
        ,
        "Notes" -> <|
            "Dimensions"      -> { 50 },
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
            "Index"           -> 2;;49,
            "Interpreter"     -> "fitString",
            "Invalid"         -> 0,
            "NativeFieldName" -> "wkt_step_name",
            "NativeType"      -> "FIT_STRING",
            "Type"            -> "String"
        |>
    |>
    ,
    "ZonesTarget" -> <|
        "FunctionalThresholdPower" -> <|
            "Dimensions"      -> { },
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
            "Index"           -> 4,
            "Interpreter"     -> "fitUINT8",
            "Invalid"         -> 255,
            "NativeFieldName" -> "threshold_heart_rate",
            "NativeType"      -> "FIT_UINT8",
            "Type"            -> "UnsignedInteger8"
        |>
    |>
|>