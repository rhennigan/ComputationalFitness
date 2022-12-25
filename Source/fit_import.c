#define _CRT_SECURE_NO_WARNINGS

#include "fit_import.h"

DLLEXPORT mint WolframLibrary_getVersion() {
    return WolframLibraryVersion;
}

DLLEXPORT int WolframLibrary_initialize(WolframLibraryData libData) {
    return 0;
}

DLLEXPORT void WolframLibrary_uninitialize(WolframLibraryData libData) {
    return;
}

DLLEXPORT int constantzero(
    WolframLibraryData libData,
    mint Argc,
    MArgument *Args,
    MArgument Res
) {
    MArgument_setInteger(Res, 0);
    return LIBRARY_NO_ERROR;
}


DLLEXPORT int FITFileType (
    WolframLibraryData libData,
    mint Argc,
    MArgument *Args,
    MArgument Res
) {
    char *path;
    FILE *file;
    mint res;
    FIT_UINT8 buf[8];
    FIT_CONVERT_RETURN convert_return = FIT_CONVERT_CONTINUE;
    FIT_UINT32 buf_size;
    FIT_UINT32 mesg_index = 0;

    path = MArgument_getUTF8String(Args[0]);

    #if defined(FIT_CONVERT_MULTI_THREAD)
        FIT_CONVERT_STATE state;
    #endif

    // printf("Testing file conversion using %s file...\n", path);

    #if defined(FIT_CONVERT_MULTI_THREAD)
        FitConvert_Init(&state, FIT_TRUE);
    #else
        FitConvert_Init(FIT_TRUE);
    #endif

    if((file = fopen(path, "rb")) == NULL)
    {
        // printf("Error opening file %s.\n", path);
        return FIT_IMPORT_ERROR_OPEN_FILE;
    }

    while(!feof(file) && (convert_return == FIT_CONVERT_CONTINUE))
    {
        for(buf_size=0;(buf_size < sizeof(buf)) && !feof(file); buf_size++)
        {
            buf[buf_size] = (FIT_UINT8)getc(file);
        }

        do
        {
            #if defined(FIT_CONVERT_MULTI_THREAD)
                convert_return = FitConvert_Read(&state, buf, buf_size);
            #else
                convert_return = FitConvert_Read(buf, buf_size);
            #endif

            switch (convert_return)
            {
                case FIT_CONVERT_MESSAGE_AVAILABLE:
                {
                    #if defined(FIT_CONVERT_MULTI_THREAD)
                        const FIT_UINT8 *mesg = FitConvert_GetMessageData(&state);
                        FIT_UINT16 mesg_num = FitConvert_GetMessageNumber(&state);
                    #else
                        const FIT_UINT8 *mesg = FitConvert_GetMessageData();
                        FIT_UINT16 mesg_num = FitConvert_GetMessageNumber();
                    #endif

                    switch(mesg_num)
                    {
                        case FIT_MESG_NUM_FILE_ID:
                        {
                            const FIT_FILE_ID_MESG *id = (FIT_FILE_ID_MESG *) mesg;
                            res = id->type;
                            convert_return = FIT_CONVERT_END_OF_FILE;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }

                    break;
                }

                default:
                    break;
            }
        } while (convert_return == FIT_CONVERT_MESSAGE_AVAILABLE);
    }

    #if defined(RETURN_PARTIAL_DATA)
    fclose(file);
    // FIXME: this can be undefined:
    MArgument_setInteger(Res, res);
    return LIBRARY_NO_ERROR;
    #endif

    if (convert_return == FIT_CONVERT_ERROR)
    {
        // Error decoding file
        fclose(file);
        return FIT_IMPORT_ERROR_CONVERSION;
    }

    if (convert_return == FIT_CONVERT_CONTINUE)
    {
        // Unexpected end of file
        fclose(file);
        return FIT_IMPORT_ERROR_UNEXPECTED_EOF;
    }

    if (convert_return == FIT_CONVERT_DATA_TYPE_NOT_SUPPORTED)
    {
        // File is not FIT
        fclose(file);
        return FIT_IMPORT_ERROR_NOT_FIT_FILE;
    }

    if (convert_return == FIT_CONVERT_PROTOCOL_VERSION_NOT_SUPPORTED)
    {
        // Protocol version not supported
        fclose(file);
        return FIT_IMPORT_ERROR_UNSUPPORTED_PROTOCOL;
    }

    if (convert_return == FIT_CONVERT_END_OF_FILE)
        // printf("File converted successfully.\n");

    fclose(file);

    MArgument_setInteger(Res, res);

    return LIBRARY_NO_ERROR;
}


DLLEXPORT int FITImport(
    WolframLibraryData libData,
    mint Argc,
    MArgument *Args,
    MArgument Res
) {
    mint err = 0;
    char *path;
    int length;
    MTensor data;
    mint dims[2];
    FILE *file;
    FIT_UINT8 buf[8];
    FIT_CONVERT_RETURN convert_return = FIT_CONVERT_CONTINUE;
    FIT_UINT32 buf_size;
    FIT_UINT32 mesg_index = 0;

    path = MArgument_getUTF8String(Args[0]);
    length = count_usable_fit_messages(path, &err);
    if (err) {
        return err;
    }

    dims[0] = length;
    dims[1] = MESSAGE_TENSOR_ROW_WIDTH;
    err = libData->MTensor_new(MType_Integer, 2, dims, &data);
    if (err) {
        return FIT_IMPORT_ERROR_INTERNAL;
    }

    mint pos[2];
    int idx = 0;
    int col = 0;

    FIT_UINT16 last_hrv = FIT_UINT16_INVALID;

    #if defined(FIT_CONVERT_MULTI_THREAD)
        FIT_CONVERT_STATE state;
    #endif

    // printf("Testing file conversion using %s file...\n", path);

    #if defined(FIT_CONVERT_MULTI_THREAD)
        FitConvert_Init(&state, FIT_TRUE);
    #else
        FitConvert_Init(FIT_TRUE);
    #endif

    if((file = fopen(path, "rb")) == NULL)
    {
        // printf("Error opening file %s.\n", path);
        return FIT_IMPORT_ERROR_OPEN_FILE;
    }

    while(!feof(file) && (convert_return == FIT_CONVERT_CONTINUE))
    {
        for(buf_size=0;(buf_size < sizeof(buf)) && !feof(file); buf_size++)
        {
            buf[buf_size] = (FIT_UINT8)getc(file);
        }

        do
        {
            #if defined(FIT_CONVERT_MULTI_THREAD)
                convert_return = FitConvert_Read(&state, buf, buf_size);
            #else
                convert_return = FitConvert_Read(buf, buf_size);
            #endif

            switch (convert_return)
            {
                case FIT_CONVERT_MESSAGE_AVAILABLE:
                {
                #if defined(FIT_CONVERT_MULTI_THREAD)
                    const FIT_UINT8 *mesg = FitConvert_GetMessageData(&state);
                    FIT_UINT16 mesg_num = FitConvert_GetMessageNumber(&state);
                #else
                    const FIT_UINT8 *mesg = FitConvert_GetMessageData();
                    FIT_UINT16 mesg_num = FitConvert_GetMessageNumber();
                #endif

                mesg_index++;
                // printf("Mesg %d (%d) - ", mesg_index++, mesg_num);

                switch(mesg_num)
                {
                    case FIT_MESG_NUM_ACTIVITY:
                    {
                        const FIT_ACTIVITY_MESG *activity = (FIT_ACTIVITY_MESG *) mesg;
                        idx++;
                        import_activity(libData, data, idx, activity);
                        {
                            FIT_ACTIVITY_MESG old_mesg;
                            old_mesg.num_sessions = 1;
                            #if defined(FIT_CONVERT_MULTI_THREAD)
                            FitConvert_RestoreFields(&state, &old_mesg);
                            #else
                            FitConvert_RestoreFields(&old_mesg);
                            #endif
                            // printf("Restored num_sessions=1 - Activity: timestamp=%u, type=%u, event=%u, event_type=%u, num_sessions=%u\n", activity->timestamp, activity->type, activity->event, activity->event_type, activity->num_sessions);
                        }
                        break;
                    }

// --- START MESSAGE IMPORT CASES ---
// This section is auto-generated. Do not edit manually.

                    case FIT_MESG_NUM_FILE_ID:
                    {
                        const FIT_FILE_ID_MESG *new = (FIT_FILE_ID_MESG *) mesg;
                        idx++;
                        import_file_id(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_FILE_CREATOR:
                    {
                        const FIT_FILE_CREATOR_MESG *new = (FIT_FILE_CREATOR_MESG *) mesg;
                        idx++;
                        import_file_creator(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_TIMESTAMP_CORRELATION:
                    {
                        const FIT_TIMESTAMP_CORRELATION_MESG *new = (FIT_TIMESTAMP_CORRELATION_MESG *) mesg;
                        idx++;
                        import_timestamp_correlation(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_SOFTWARE:
                    {
                        const FIT_SOFTWARE_MESG *new = (FIT_SOFTWARE_MESG *) mesg;
                        idx++;
                        import_software(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_SLAVE_DEVICE:
                    {
                        const FIT_SLAVE_DEVICE_MESG *new = (FIT_SLAVE_DEVICE_MESG *) mesg;
                        idx++;
                        import_slave_device(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_CAPABILITIES:
                    {
                        const FIT_CAPABILITIES_MESG *new = (FIT_CAPABILITIES_MESG *) mesg;
                        idx++;
                        import_capabilities(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_FILE_CAPABILITIES:
                    {
                        const FIT_FILE_CAPABILITIES_MESG *new = (FIT_FILE_CAPABILITIES_MESG *) mesg;
                        idx++;
                        import_file_capabilities(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_MESG_CAPABILITIES:
                    {
                        const FIT_MESG_CAPABILITIES_MESG *new = (FIT_MESG_CAPABILITIES_MESG *) mesg;
                        idx++;
                        import_mesg_capabilities(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_FIELD_CAPABILITIES:
                    {
                        const FIT_FIELD_CAPABILITIES_MESG *new = (FIT_FIELD_CAPABILITIES_MESG *) mesg;
                        idx++;
                        import_field_capabilities(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_DEVICE_SETTINGS:
                    {
                        const FIT_DEVICE_SETTINGS_MESG *new = (FIT_DEVICE_SETTINGS_MESG *) mesg;
                        idx++;
                        import_device_settings(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_USER_PROFILE:
                    {
                        const FIT_USER_PROFILE_MESG *new = (FIT_USER_PROFILE_MESG *) mesg;
                        idx++;
                        import_user_profile(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_HRM_PROFILE:
                    {
                        const FIT_HRM_PROFILE_MESG *new = (FIT_HRM_PROFILE_MESG *) mesg;
                        idx++;
                        import_hrm_profile(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_SDM_PROFILE:
                    {
                        const FIT_SDM_PROFILE_MESG *new = (FIT_SDM_PROFILE_MESG *) mesg;
                        idx++;
                        import_sdm_profile(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_BIKE_PROFILE:
                    {
                        const FIT_BIKE_PROFILE_MESG *new = (FIT_BIKE_PROFILE_MESG *) mesg;
                        idx++;
                        import_bike_profile(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_CONNECTIVITY:
                    {
                        const FIT_CONNECTIVITY_MESG *new = (FIT_CONNECTIVITY_MESG *) mesg;
                        idx++;
                        import_connectivity(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_WATCHFACE_SETTINGS:
                    {
                        const FIT_WATCHFACE_SETTINGS_MESG *new = (FIT_WATCHFACE_SETTINGS_MESG *) mesg;
                        idx++;
                        import_watchface_settings(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_OHR_SETTINGS:
                    {
                        const FIT_OHR_SETTINGS_MESG *new = (FIT_OHR_SETTINGS_MESG *) mesg;
                        idx++;
                        import_ohr_settings(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_ZONES_TARGET:
                    {
                        const FIT_ZONES_TARGET_MESG *new = (FIT_ZONES_TARGET_MESG *) mesg;
                        idx++;
                        import_zones_target(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_SPORT:
                    {
                        const FIT_SPORT_MESG *new = (FIT_SPORT_MESG *) mesg;
                        idx++;
                        import_sport(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_HR_ZONE:
                    {
                        const FIT_HR_ZONE_MESG *new = (FIT_HR_ZONE_MESG *) mesg;
                        idx++;
                        import_hr_zone(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_SPEED_ZONE:
                    {
                        const FIT_SPEED_ZONE_MESG *new = (FIT_SPEED_ZONE_MESG *) mesg;
                        idx++;
                        import_speed_zone(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_CADENCE_ZONE:
                    {
                        const FIT_CADENCE_ZONE_MESG *new = (FIT_CADENCE_ZONE_MESG *) mesg;
                        idx++;
                        import_cadence_zone(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_POWER_ZONE:
                    {
                        const FIT_POWER_ZONE_MESG *new = (FIT_POWER_ZONE_MESG *) mesg;
                        idx++;
                        import_power_zone(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_MET_ZONE:
                    {
                        const FIT_MET_ZONE_MESG *new = (FIT_MET_ZONE_MESG *) mesg;
                        idx++;
                        import_met_zone(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_DIVE_SETTINGS:
                    {
                        const FIT_DIVE_SETTINGS_MESG *new = (FIT_DIVE_SETTINGS_MESG *) mesg;
                        idx++;
                        import_dive_settings(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_DIVE_ALARM:
                    {
                        const FIT_DIVE_ALARM_MESG *new = (FIT_DIVE_ALARM_MESG *) mesg;
                        idx++;
                        import_dive_alarm(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_DIVE_GAS:
                    {
                        const FIT_DIVE_GAS_MESG *new = (FIT_DIVE_GAS_MESG *) mesg;
                        idx++;
                        import_dive_gas(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_GOAL:
                    {
                        const FIT_GOAL_MESG *new = (FIT_GOAL_MESG *) mesg;
                        idx++;
                        import_goal(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_SESSION:
                    {
                        const FIT_SESSION_MESG *new = (FIT_SESSION_MESG *) mesg;
                        idx++;
                        import_session(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_LAP:
                    {
                        const FIT_LAP_MESG *new = (FIT_LAP_MESG *) mesg;
                        idx++;
                        import_lap(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_LENGTH:
                    {
                        const FIT_LENGTH_MESG *new = (FIT_LENGTH_MESG *) mesg;
                        idx++;
                        import_length(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_RECORD:
                    {
                        const FIT_RECORD_MESG *new = (FIT_RECORD_MESG *) mesg;
                        idx++;
                        import_record(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_EVENT:
                    {
                        const FIT_EVENT_MESG *new = (FIT_EVENT_MESG *) mesg;
                        idx++;
                        import_event(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_DEVICE_INFO:
                    {
                        const FIT_DEVICE_INFO_MESG *new = (FIT_DEVICE_INFO_MESG *) mesg;
                        idx++;
                        import_device_info(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_DEVICE_AUX_BATTERY_INFO:
                    {
                        const FIT_DEVICE_AUX_BATTERY_INFO_MESG *new = (FIT_DEVICE_AUX_BATTERY_INFO_MESG *) mesg;
                        idx++;
                        import_device_aux_battery_info(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_TRAINING_FILE:
                    {
                        const FIT_TRAINING_FILE_MESG *new = (FIT_TRAINING_FILE_MESG *) mesg;
                        idx++;
                        import_training_file(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_WEATHER_CONDITIONS:
                    {
                        const FIT_WEATHER_CONDITIONS_MESG *new = (FIT_WEATHER_CONDITIONS_MESG *) mesg;
                        idx++;
                        import_weather_conditions(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_WEATHER_ALERT:
                    {
                        const FIT_WEATHER_ALERT_MESG *new = (FIT_WEATHER_ALERT_MESG *) mesg;
                        idx++;
                        import_weather_alert(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_GPS_METADATA:
                    {
                        const FIT_GPS_METADATA_MESG *new = (FIT_GPS_METADATA_MESG *) mesg;
                        idx++;
                        import_gps_metadata(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_CAMERA_EVENT:
                    {
                        const FIT_CAMERA_EVENT_MESG *new = (FIT_CAMERA_EVENT_MESG *) mesg;
                        idx++;
                        import_camera_event(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_GYROSCOPE_DATA:
                    {
                        const FIT_GYROSCOPE_DATA_MESG *new = (FIT_GYROSCOPE_DATA_MESG *) mesg;
                        idx++;
                        import_gyroscope_data(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_ACCELEROMETER_DATA:
                    {
                        const FIT_ACCELEROMETER_DATA_MESG *new = (FIT_ACCELEROMETER_DATA_MESG *) mesg;
                        idx++;
                        import_accelerometer_data(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_MAGNETOMETER_DATA:
                    {
                        const FIT_MAGNETOMETER_DATA_MESG *new = (FIT_MAGNETOMETER_DATA_MESG *) mesg;
                        idx++;
                        import_magnetometer_data(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_BAROMETER_DATA:
                    {
                        const FIT_BAROMETER_DATA_MESG *new = (FIT_BAROMETER_DATA_MESG *) mesg;
                        idx++;
                        import_barometer_data(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_THREE_D_SENSOR_CALIBRATION:
                    {
                        const FIT_THREE_D_SENSOR_CALIBRATION_MESG *new = (FIT_THREE_D_SENSOR_CALIBRATION_MESG *) mesg;
                        idx++;
                        import_three_d_sensor_calibration(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_ONE_D_SENSOR_CALIBRATION:
                    {
                        const FIT_ONE_D_SENSOR_CALIBRATION_MESG *new = (FIT_ONE_D_SENSOR_CALIBRATION_MESG *) mesg;
                        idx++;
                        import_one_d_sensor_calibration(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_VIDEO_FRAME:
                    {
                        const FIT_VIDEO_FRAME_MESG *new = (FIT_VIDEO_FRAME_MESG *) mesg;
                        idx++;
                        import_video_frame(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_OBDII_DATA:
                    {
                        const FIT_OBDII_DATA_MESG *new = (FIT_OBDII_DATA_MESG *) mesg;
                        idx++;
                        import_obdii_data(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_NMEA_SENTENCE:
                    {
                        const FIT_NMEA_SENTENCE_MESG *new = (FIT_NMEA_SENTENCE_MESG *) mesg;
                        idx++;
                        import_nmea_sentence(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_AVIATION_ATTITUDE:
                    {
                        const FIT_AVIATION_ATTITUDE_MESG *new = (FIT_AVIATION_ATTITUDE_MESG *) mesg;
                        idx++;
                        import_aviation_attitude(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_VIDEO:
                    {
                        const FIT_VIDEO_MESG *new = (FIT_VIDEO_MESG *) mesg;
                        idx++;
                        import_video(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_VIDEO_TITLE:
                    {
                        const FIT_VIDEO_TITLE_MESG *new = (FIT_VIDEO_TITLE_MESG *) mesg;
                        idx++;
                        import_video_title(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_VIDEO_DESCRIPTION:
                    {
                        const FIT_VIDEO_DESCRIPTION_MESG *new = (FIT_VIDEO_DESCRIPTION_MESG *) mesg;
                        idx++;
                        import_video_description(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_VIDEO_CLIP:
                    {
                        const FIT_VIDEO_CLIP_MESG *new = (FIT_VIDEO_CLIP_MESG *) mesg;
                        idx++;
                        import_video_clip(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_SET:
                    {
                        const FIT_SET_MESG *new = (FIT_SET_MESG *) mesg;
                        idx++;
                        import_set(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_JUMP:
                    {
                        const FIT_JUMP_MESG *new = (FIT_JUMP_MESG *) mesg;
                        idx++;
                        import_jump(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_CLIMB_PRO:
                    {
                        const FIT_CLIMB_PRO_MESG *new = (FIT_CLIMB_PRO_MESG *) mesg;
                        idx++;
                        import_climb_pro(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_FIELD_DESCRIPTION:
                    {
                        const FIT_FIELD_DESCRIPTION_MESG *new = (FIT_FIELD_DESCRIPTION_MESG *) mesg;
                        idx++;
                        import_field_description(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_DEVELOPER_DATA_ID:
                    {
                        const FIT_DEVELOPER_DATA_ID_MESG *new = (FIT_DEVELOPER_DATA_ID_MESG *) mesg;
                        idx++;
                        import_developer_data_id(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_COURSE:
                    {
                        const FIT_COURSE_MESG *new = (FIT_COURSE_MESG *) mesg;
                        idx++;
                        import_course(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_COURSE_POINT:
                    {
                        const FIT_COURSE_POINT_MESG *new = (FIT_COURSE_POINT_MESG *) mesg;
                        idx++;
                        import_course_point(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_SEGMENT_ID:
                    {
                        const FIT_SEGMENT_ID_MESG *new = (FIT_SEGMENT_ID_MESG *) mesg;
                        idx++;
                        import_segment_id(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_SEGMENT_LEADERBOARD_ENTRY:
                    {
                        const FIT_SEGMENT_LEADERBOARD_ENTRY_MESG *new = (FIT_SEGMENT_LEADERBOARD_ENTRY_MESG *) mesg;
                        idx++;
                        import_segment_leaderboard_entry(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_SEGMENT_POINT:
                    {
                        const FIT_SEGMENT_POINT_MESG *new = (FIT_SEGMENT_POINT_MESG *) mesg;
                        idx++;
                        import_segment_point(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_SEGMENT_LAP:
                    {
                        const FIT_SEGMENT_LAP_MESG *new = (FIT_SEGMENT_LAP_MESG *) mesg;
                        idx++;
                        import_segment_lap(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_SEGMENT_FILE:
                    {
                        const FIT_SEGMENT_FILE_MESG *new = (FIT_SEGMENT_FILE_MESG *) mesg;
                        idx++;
                        import_segment_file(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_WORKOUT:
                    {
                        const FIT_WORKOUT_MESG *new = (FIT_WORKOUT_MESG *) mesg;
                        idx++;
                        import_workout(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_WORKOUT_SESSION:
                    {
                        const FIT_WORKOUT_SESSION_MESG *new = (FIT_WORKOUT_SESSION_MESG *) mesg;
                        idx++;
                        import_workout_session(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_WORKOUT_STEP:
                    {
                        const FIT_WORKOUT_STEP_MESG *new = (FIT_WORKOUT_STEP_MESG *) mesg;
                        idx++;
                        import_workout_step(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_EXERCISE_TITLE:
                    {
                        const FIT_EXERCISE_TITLE_MESG *new = (FIT_EXERCISE_TITLE_MESG *) mesg;
                        idx++;
                        import_exercise_title(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_SCHEDULE:
                    {
                        const FIT_SCHEDULE_MESG *new = (FIT_SCHEDULE_MESG *) mesg;
                        idx++;
                        import_schedule(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_TOTALS:
                    {
                        const FIT_TOTALS_MESG *new = (FIT_TOTALS_MESG *) mesg;
                        idx++;
                        import_totals(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_WEIGHT_SCALE:
                    {
                        const FIT_WEIGHT_SCALE_MESG *new = (FIT_WEIGHT_SCALE_MESG *) mesg;
                        idx++;
                        import_weight_scale(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_BLOOD_PRESSURE:
                    {
                        const FIT_BLOOD_PRESSURE_MESG *new = (FIT_BLOOD_PRESSURE_MESG *) mesg;
                        idx++;
                        import_blood_pressure(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_MONITORING_INFO:
                    {
                        const FIT_MONITORING_INFO_MESG *new = (FIT_MONITORING_INFO_MESG *) mesg;
                        idx++;
                        import_monitoring_info(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_MONITORING:
                    {
                        const FIT_MONITORING_MESG *new = (FIT_MONITORING_MESG *) mesg;
                        idx++;
                        import_monitoring(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_HR:
                    {
                        const FIT_HR_MESG *new = (FIT_HR_MESG *) mesg;
                        idx++;
                        import_hr(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_STRESS_LEVEL:
                    {
                        const FIT_STRESS_LEVEL_MESG *new = (FIT_STRESS_LEVEL_MESG *) mesg;
                        idx++;
                        import_stress_level(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_MEMO_GLOB:
                    {
                        const FIT_MEMO_GLOB_MESG *new = (FIT_MEMO_GLOB_MESG *) mesg;
                        idx++;
                        import_memo_glob(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_ANT_CHANNEL_ID:
                    {
                        const FIT_ANT_CHANNEL_ID_MESG *new = (FIT_ANT_CHANNEL_ID_MESG *) mesg;
                        idx++;
                        import_ant_channel_id(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_ANT_RX:
                    {
                        const FIT_ANT_RX_MESG *new = (FIT_ANT_RX_MESG *) mesg;
                        idx++;
                        import_ant_rx(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_ANT_TX:
                    {
                        const FIT_ANT_TX_MESG *new = (FIT_ANT_TX_MESG *) mesg;
                        idx++;
                        import_ant_tx(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_EXD_SCREEN_CONFIGURATION:
                    {
                        const FIT_EXD_SCREEN_CONFIGURATION_MESG *new = (FIT_EXD_SCREEN_CONFIGURATION_MESG *) mesg;
                        idx++;
                        import_exd_screen_configuration(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_EXD_DATA_FIELD_CONFIGURATION:
                    {
                        const FIT_EXD_DATA_FIELD_CONFIGURATION_MESG *new = (FIT_EXD_DATA_FIELD_CONFIGURATION_MESG *) mesg;
                        idx++;
                        import_exd_data_field_configuration(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_EXD_DATA_CONCEPT_CONFIGURATION:
                    {
                        const FIT_EXD_DATA_CONCEPT_CONFIGURATION_MESG *new = (FIT_EXD_DATA_CONCEPT_CONFIGURATION_MESG *) mesg;
                        idx++;
                        import_exd_data_concept_configuration(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_DIVE_SUMMARY:
                    {
                        const FIT_DIVE_SUMMARY_MESG *new = (FIT_DIVE_SUMMARY_MESG *) mesg;
                        idx++;
                        import_dive_summary(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_HRV:
                    {
                        const FIT_HRV_MESG *new = (FIT_HRV_MESG *) mesg;
                        idx++;
                        import_hrv(libData, data, idx, new);
                        break;
                    }

                    case FIT_MESG_NUM_WXF_EXPRESSION:
                    {
                        const FIT_WXF_EXPRESSION_MESG *new = (FIT_WXF_EXPRESSION_MESG *) mesg;
                        idx++;
                        import_wxf_expression(libData, data, idx, new);
                        break;
                    }
// --- END MESSAGE IMPORT CASES ---
                    default:
                    {
                        break;
                    }
                }
                break;
                }

                default:
                break;
            }
        } while (convert_return == FIT_CONVERT_MESSAGE_AVAILABLE);
    }

    #if defined(RETURN_PARTIAL_DATA)
    // TODO: append a custom message that indicates the error type
    fclose(file);
    MArgument_setMTensor(Res, data);
    return LIBRARY_NO_ERROR;
    #endif

    if (convert_return == FIT_CONVERT_ERROR)
    {
        // Error decoding file
        fclose(file);
        return FIT_IMPORT_ERROR_CONVERSION;
    }

    if (convert_return == FIT_CONVERT_CONTINUE)
    {
        // Unexpected end of file
        fclose(file);
        return FIT_IMPORT_ERROR_UNEXPECTED_EOF;
    }

    if (convert_return == FIT_CONVERT_DATA_TYPE_NOT_SUPPORTED)
    {
        // File is not FIT
        fclose(file);
        return FIT_IMPORT_ERROR_NOT_FIT_FILE;
    }

    if (convert_return == FIT_CONVERT_PROTOCOL_VERSION_NOT_SUPPORTED)
    {
        // Protocol version not supported
        fclose(file);
        return FIT_IMPORT_ERROR_UNSUPPORTED_PROTOCOL;
    }

    if (convert_return == FIT_CONVERT_END_OF_FILE)
        // File converted successfully

    fclose(file);

    MArgument_setMTensor(Res, data);
    return LIBRARY_NO_ERROR;
}

DLLEXPORT int FITMessageTypes (
    WolframLibraryData libData,
    mint Argc,
    MArgument *Args,
    MArgument Res
) {
    mint err = 0;
    char *path;
    int length;
    MTensor data;
    mint dims[2];
    FILE *file;
    FIT_UINT8 buf[8];
    FIT_CONVERT_RETURN convert_return = FIT_CONVERT_CONTINUE;
    FIT_UINT32 buf_size;
    FIT_UINT32 mesg_index = 0;

    path = MArgument_getUTF8String(Args[0]);
    length = count_fit_messages(path, &err);
    if (err) {
        return err;
    }

    dims[0] = length;
    dims[1] = 8;
    err = libData->MTensor_new(MType_Integer, 2, dims, &data);
    if (err) {
        return FIT_IMPORT_ERROR_INTERNAL;
    }

    mint pos[2];
    int idx = 0;
    int col = 0;

    #if defined(FIT_CONVERT_MULTI_THREAD)
        FIT_CONVERT_STATE state;
    #endif

    // printf("Testing file conversion using %s file...\n", path);

    #if defined(FIT_CONVERT_MULTI_THREAD)
        FitConvert_Init(&state, FIT_TRUE);
    #else
        FitConvert_Init(FIT_TRUE);
    #endif

    if((file = fopen(path, "rb")) == NULL)
    {
        // printf("Error opening file %s.\n", path);
        return FIT_IMPORT_ERROR_OPEN_FILE;
    }

    while(!feof(file) && (convert_return == FIT_CONVERT_CONTINUE))
    {
        for(buf_size=0;(buf_size < sizeof(buf)) && !feof(file); buf_size++)
        {
            buf[buf_size] = (FIT_UINT8)getc(file);
        }

        do
        {
            #if defined(FIT_CONVERT_MULTI_THREAD)
                convert_return = FitConvert_Read(&state, buf, buf_size);
            #else
                convert_return = FitConvert_Read(buf, buf_size);
            #endif

            switch (convert_return)
            {
                case FIT_CONVERT_MESSAGE_AVAILABLE:
                {
                    #if defined(FIT_CONVERT_MULTI_THREAD)
                        const FIT_UINT8 *mesg = FitConvert_GetMessageData(&state);
                        FIT_UINT16 mesg_num = FitConvert_GetMessageNumber(&state);
                    #else
                        const FIT_UINT8 *mesg = FitConvert_GetMessageData();
                        FIT_UINT16 mesg_num = FitConvert_GetMessageNumber();
                    #endif

                    mesg_index++;
                    // printf("Mesg %d (%d) - ", mesg_index++, mesg_num);
                    FIT_UINT16 size = Fit_GetMesgSize(mesg_num);
                    const FIT_MESG_DEF mesg_def = * Fit_GetMesgDef(mesg_num);
                    FIT_UINT8 arch = mesg_def.arch;
                    FIT_UINT8 fields = mesg_def.num_fields;
                    idx++;
                    pos[0] = idx;
                    pos[1] = 0;
                    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_MESSAGE_INFORMATION);
                    ImportInteger(2, libData, data, pos, mesg_num);
                    ImportInteger(3, libData, data, pos, size);
                    ImportInteger(4, libData, data, pos, arch);
                    ImportInteger(5, libData, data, pos, fields);
                    ImportInteger(6, libData, data, pos, mesg_index);
                    ImportInteger(7, libData, data, pos, DONE);

                    break;
                }

                default:
                    break;
            }
        } while (convert_return == FIT_CONVERT_MESSAGE_AVAILABLE);
    }

    #if defined(RETURN_PARTIAL_DATA)
    fclose(file);
    MArgument_setMTensor(Res, data);
    return LIBRARY_NO_ERROR;
    #endif

    if (convert_return == FIT_CONVERT_ERROR)
    {
        // Error decoding file
        fclose(file);
        return FIT_IMPORT_ERROR_CONVERSION;
    }

    if (convert_return == FIT_CONVERT_CONTINUE)
    {
        // Unexpected end of file
        fclose(file);
        return FIT_IMPORT_ERROR_UNEXPECTED_EOF;
    }

    if (convert_return == FIT_CONVERT_DATA_TYPE_NOT_SUPPORTED)
    {
        // File is not FIT
        fclose(file);
        return FIT_IMPORT_ERROR_NOT_FIT_FILE;
    }

    if (convert_return == FIT_CONVERT_PROTOCOL_VERSION_NOT_SUPPORTED)
    {
        // Protocol version not supported
        fclose(file);
        return FIT_IMPORT_ERROR_UNSUPPORTED_PROTOCOL;
    }

    if (convert_return == FIT_CONVERT_END_OF_FILE)
        // printf("File converted successfully.\n");

    fclose(file);

    MArgument_setMTensor(Res, data);
    return LIBRARY_NO_ERROR;
}


static void import_unknown(WolframLibraryData libData, MTensor data, int idx, int mesgNum, const FIT_UINT8 *mesg)
{
    mint pos[2];
    pos[0] = idx;
    pos[1] = 0;
    pos[1]++; libData->MTensor_setInteger(data, pos, mesgNum);
    for (int i = 0; i < MESSAGE_TENSOR_ROW_WIDTH - 1; i++)
    {
        pos[1]++;
        libData->MTensor_setInteger(data, pos, mesg[i]);
    }
}


static int count_usable_fit_messages(char* input, mint *err)
{
   FILE *file;
   FIT_UINT8 buf[8];
   FIT_CONVERT_RETURN convert_return = FIT_CONVERT_CONTINUE;
   FIT_UINT32 buf_size;
   int mesg_count = 0;
   #if defined(FIT_CONVERT_MULTI_THREAD)
      FIT_CONVERT_STATE state;
   #endif

   #if defined(FIT_CONVERT_MULTI_THREAD)
      FitConvert_Init(&state, FIT_TRUE);
   #else
      FitConvert_Init(FIT_TRUE);
   #endif

   if((file = fopen(input, "rb")) == NULL)
   {
      *err = FIT_IMPORT_ERROR_OPEN_FILE;
      return 0;
   }

   while(!feof(file) && (convert_return == FIT_CONVERT_CONTINUE))
   {
      for(buf_size=0;(buf_size < sizeof(buf)) && !feof(file); buf_size++)
      {
         buf[buf_size] = (FIT_UINT8)getc(file);
      }

      do
      {
         #if defined(FIT_CONVERT_MULTI_THREAD)
            convert_return = FitConvert_Read(&state, buf, buf_size);
         #else
            convert_return = FitConvert_Read(buf, buf_size);
         #endif

         switch (convert_return)
         {
            case FIT_CONVERT_MESSAGE_AVAILABLE:
            {
               #if defined(FIT_CONVERT_MULTI_THREAD)
                  const FIT_UINT8 *mesg = FitConvert_GetMessageData(&state);
                  FIT_UINT16 mesg_num = FitConvert_GetMessageNumber(&state);
               #else
                  const FIT_UINT8 *mesg = FitConvert_GetMessageData();
                  FIT_UINT16 mesg_num = FitConvert_GetMessageNumber();
               #endif

               switch(mesg_num)
               {
// --- START MESSAGE COUNT CASES ---
// This section is auto-generated. Do not edit manually.

                    case FIT_MESG_NUM_FILE_ID:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_FILE_CREATOR:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_TIMESTAMP_CORRELATION:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_SOFTWARE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_SLAVE_DEVICE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_CAPABILITIES:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_FILE_CAPABILITIES:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_MESG_CAPABILITIES:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_FIELD_CAPABILITIES:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_DEVICE_SETTINGS:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_USER_PROFILE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_HRM_PROFILE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_SDM_PROFILE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_BIKE_PROFILE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_CONNECTIVITY:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_WATCHFACE_SETTINGS:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_OHR_SETTINGS:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_ZONES_TARGET:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_SPORT:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_HR_ZONE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_SPEED_ZONE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_CADENCE_ZONE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_POWER_ZONE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_MET_ZONE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_DIVE_SETTINGS:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_DIVE_ALARM:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_DIVE_GAS:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_GOAL:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_ACTIVITY:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_SESSION:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_LAP:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_LENGTH:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_RECORD:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_EVENT:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_DEVICE_INFO:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_DEVICE_AUX_BATTERY_INFO:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_TRAINING_FILE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_WEATHER_CONDITIONS:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_WEATHER_ALERT:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_GPS_METADATA:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_CAMERA_EVENT:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_GYROSCOPE_DATA:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_ACCELEROMETER_DATA:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_MAGNETOMETER_DATA:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_BAROMETER_DATA:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_THREE_D_SENSOR_CALIBRATION:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_ONE_D_SENSOR_CALIBRATION:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_VIDEO_FRAME:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_OBDII_DATA:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_NMEA_SENTENCE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_AVIATION_ATTITUDE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_VIDEO:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_VIDEO_TITLE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_VIDEO_DESCRIPTION:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_VIDEO_CLIP:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_SET:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_JUMP:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_CLIMB_PRO:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_FIELD_DESCRIPTION:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_DEVELOPER_DATA_ID:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_COURSE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_COURSE_POINT:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_SEGMENT_ID:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_SEGMENT_LEADERBOARD_ENTRY:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_SEGMENT_POINT:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_SEGMENT_LAP:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_SEGMENT_FILE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_WORKOUT:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_WORKOUT_SESSION:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_WORKOUT_STEP:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_EXERCISE_TITLE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_SCHEDULE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_TOTALS:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_WEIGHT_SCALE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_BLOOD_PRESSURE:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_MONITORING_INFO:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_MONITORING:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_HR:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_STRESS_LEVEL:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_MEMO_GLOB:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_ANT_CHANNEL_ID:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_ANT_RX:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_ANT_TX:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_EXD_SCREEN_CONFIGURATION:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_EXD_DATA_FIELD_CONFIGURATION:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_EXD_DATA_CONCEPT_CONFIGURATION:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_DIVE_SUMMARY:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_HRV:
                    {
                        mesg_count++;
                        break;
                    }

                    case FIT_MESG_NUM_WXF_EXPRESSION:
                    {
                        mesg_count++;
                        break;
                    }
// --- END MESSAGE COUNT CASES ---
                  default:
                    break;
               }
               break;
            }

            default:
               break;
         }
      } while (convert_return == FIT_CONVERT_MESSAGE_AVAILABLE);
   }

   #if defined(RETURN_PARTIAL_DATA)
   fclose(file);
   return mesg_count;
   #endif

   if (convert_return == FIT_CONVERT_ERROR)
    {
        // Error decoding file
        fclose(file);
        *err = FIT_IMPORT_ERROR_CONVERSION;
        return 0;
    }

    if (convert_return == FIT_CONVERT_CONTINUE)
    {
        // Unexpected end of file
        fclose(file);
        *err = FIT_IMPORT_ERROR_UNEXPECTED_EOF;
        return 0;
    }

    if (convert_return == FIT_CONVERT_DATA_TYPE_NOT_SUPPORTED)
    {
        // File is not FIT
        fclose(file);
        *err = FIT_IMPORT_ERROR_NOT_FIT_FILE;
        return 0;
    }

    if (convert_return == FIT_CONVERT_PROTOCOL_VERSION_NOT_SUPPORTED)
    {
        // Protocol version not supported
        fclose(file);
        *err = FIT_IMPORT_ERROR_UNSUPPORTED_PROTOCOL;
        return 0;
    }

   fclose(file);

   return mesg_count;
}


static int count_fit_messages(char* input, mint* err)
{
   FILE *file;
   FIT_UINT8 buf[8];
   FIT_CONVERT_RETURN convert_return = FIT_CONVERT_CONTINUE;
   FIT_UINT32 buf_size;
   int mesg_count = 0;
   #if defined(FIT_CONVERT_MULTI_THREAD)
      FIT_CONVERT_STATE state;
   #endif

   #if defined(FIT_CONVERT_MULTI_THREAD)
      FitConvert_Init(&state, FIT_TRUE);
   #else
      FitConvert_Init(FIT_TRUE);
   #endif

   if((file = fopen(input, "rb")) == NULL)
   {
      *err = FIT_IMPORT_ERROR_OPEN_FILE;
      return 0;
   }

   while(!feof(file) && (convert_return == FIT_CONVERT_CONTINUE))
   {
      for(buf_size=0;(buf_size < sizeof(buf)) && !feof(file); buf_size++)
      {
         buf[buf_size] = (FIT_UINT8)getc(file);
      }

      do
      {
         #if defined(FIT_CONVERT_MULTI_THREAD)
            convert_return = FitConvert_Read(&state, buf, buf_size);
         #else
            convert_return = FitConvert_Read(buf, buf_size);
         #endif

         switch (convert_return)
         {
            case FIT_CONVERT_MESSAGE_AVAILABLE:
            {
               #if defined(FIT_CONVERT_MULTI_THREAD)
                  const FIT_UINT8 *mesg = FitConvert_GetMessageData(&state);
                  FIT_UINT16 mesg_num = FitConvert_GetMessageNumber(&state);
               #else
                  const FIT_UINT8 *mesg = FitConvert_GetMessageData();
                  FIT_UINT16 mesg_num = FitConvert_GetMessageNumber();
               #endif

               mesg_count++;
               break;
            }

            default:
               break;
         }
      } while (convert_return == FIT_CONVERT_MESSAGE_AVAILABLE);
   }

   #if defined(RETURN_PARTIAL_DATA)
   fclose(file);
   return mesg_count;
   #endif

   if (convert_return == FIT_CONVERT_ERROR)
    {
        // Error decoding file
        fclose(file);
        *err = FIT_IMPORT_ERROR_CONVERSION;
        return 0;
    }

    if (convert_return == FIT_CONVERT_CONTINUE)
    {
        // Unexpected end of file
        fclose(file);
        *err = FIT_IMPORT_ERROR_UNEXPECTED_EOF;
        return 0;
    }

    if (convert_return == FIT_CONVERT_DATA_TYPE_NOT_SUPPORTED)
    {
        // File is not FIT
        fclose(file);
        *err = FIT_IMPORT_ERROR_NOT_FIT_FILE;
        return 0;
    }

    if (convert_return == FIT_CONVERT_PROTOCOL_VERSION_NOT_SUPPORTED)
    {
        // Protocol version not supported
        fclose(file);
        *err = FIT_IMPORT_ERROR_UNSUPPORTED_PROTOCOL;
        return 0;
    }

   fclose(file);

   return mesg_count;
}



// TODO: Define a message that tracks changes to each field per message type and append to the end of the message list.

// --- START MESSAGE IMPORT FUNCTIONS ---
// This section is auto-generated. Do not edit manually.
static void import_file_id(WolframLibraryData libData, MTensor data, int idx, const FIT_FILE_ID_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_FILE_ID);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->serial_number);
    ImportInteger(4, libData, data, pos, WLTimestamp(mesg->time_created));
    ImportInteger(5, libData, data, pos, mesg->manufacturer);
    ImportInteger(6, libData, data, pos, mesg->product);
    ImportInteger(7, libData, data, pos, mesg->number);
    ImportInteger(8, libData, data, pos, mesg->type);
    ImportString(9, libData, data, pos, mesg->product_name, FIT_FILE_ID_MESG_PRODUCT_NAME_COUNT);
    ImportFinish(59, libData, data, pos);
}

static void import_file_creator(WolframLibraryData libData, MTensor data, int idx, const FIT_FILE_CREATOR_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_FILE_CREATOR);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->software_version);
    ImportInteger(4, libData, data, pos, mesg->hardware_version);
    ImportFinish(5, libData, data, pos);
}

static void import_timestamp_correlation(WolframLibraryData libData, MTensor data, int idx, const FIT_TIMESTAMP_CORRELATION_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_TIMESTAMP_CORRELATION);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, WLTimestamp(mesg->system_timestamp));
    ImportInteger(5, libData, data, pos, WLTimestamp(mesg->local_timestamp));
    ImportInteger(6, libData, data, pos, mesg->fractional_timestamp);
    ImportInteger(7, libData, data, pos, mesg->fractional_system_timestamp);
    ImportInteger(8, libData, data, pos, mesg->timestamp_ms);
    ImportInteger(9, libData, data, pos, mesg->system_timestamp_ms);
    ImportFinish(10, libData, data, pos);
}

static void import_software(WolframLibraryData libData, MTensor data, int idx, const FIT_SOFTWARE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_SOFTWARE);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->part_number, FIT_SOFTWARE_MESG_PART_NUMBER_COUNT);
    ImportInteger(19, libData, data, pos, mesg->message_index);
    ImportInteger(20, libData, data, pos, mesg->version);
    ImportFinish(21, libData, data, pos);
}

static void import_slave_device(WolframLibraryData libData, MTensor data, int idx, const FIT_SLAVE_DEVICE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_SLAVE_DEVICE);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->manufacturer);
    ImportInteger(4, libData, data, pos, mesg->product);
    ImportFinish(5, libData, data, pos);
}

static void import_capabilities(WolframLibraryData libData, MTensor data, int idx, const FIT_CAPABILITIES_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_CAPABILITIES);
    ImportInteger(2, libData, data, pos, idx);
    ImportIntegerSequence(3, libData, data, pos, mesg->languages, FIT_CAPABILITIES_MESG_LANGUAGES_COUNT);
    ImportInteger(7, libData, data, pos, mesg->workouts_supported);
    ImportInteger(8, libData, data, pos, mesg->connectivity_supported);
    ImportIntegerSequence(9, libData, data, pos, mesg->sports, FIT_CAPABILITIES_MESG_SPORTS_COUNT);
    ImportFinish(10, libData, data, pos);
}

static void import_file_capabilities(WolframLibraryData libData, MTensor data, int idx, const FIT_FILE_CAPABILITIES_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_FILE_CAPABILITIES);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->directory, FIT_FILE_CAPABILITIES_MESG_DIRECTORY_COUNT);
    ImportInteger(19, libData, data, pos, mesg->max_size);
    ImportInteger(20, libData, data, pos, mesg->message_index);
    ImportInteger(21, libData, data, pos, mesg->max_count);
    ImportInteger(22, libData, data, pos, mesg->type);
    ImportInteger(23, libData, data, pos, mesg->flags);
    ImportFinish(24, libData, data, pos);
}

static void import_mesg_capabilities(WolframLibraryData libData, MTensor data, int idx, const FIT_MESG_CAPABILITIES_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_MESG_CAPABILITIES);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->message_index);
    ImportInteger(4, libData, data, pos, mesg->mesg_num);
    ImportInteger(5, libData, data, pos, mesg->count);
    ImportInteger(6, libData, data, pos, mesg->file);
    ImportInteger(7, libData, data, pos, mesg->count_type);
    ImportFinish(8, libData, data, pos);
}

static void import_field_capabilities(WolframLibraryData libData, MTensor data, int idx, const FIT_FIELD_CAPABILITIES_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_FIELD_CAPABILITIES);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->message_index);
    ImportInteger(4, libData, data, pos, mesg->mesg_num);
    ImportInteger(5, libData, data, pos, mesg->count);
    ImportInteger(6, libData, data, pos, mesg->file);
    ImportInteger(7, libData, data, pos, mesg->field_num);
    ImportFinish(8, libData, data, pos);
}

static void import_device_settings(WolframLibraryData libData, MTensor data, int idx, const FIT_DEVICE_SETTINGS_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_DEVICE_SETTINGS);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->utc_offset);
    ImportIntegerSequence(4, libData, data, pos, mesg->time_offset, FIT_DEVICE_SETTINGS_MESG_TIME_OFFSET_COUNT);
    ImportInteger(5, libData, data, pos, WLTimestamp(mesg->clock_time));
    ImportInteger(6, libData, data, pos, mesg->auto_activity_detect);
    ImportIntegerSequence(7, libData, data, pos, mesg->pages_enabled, FIT_DEVICE_SETTINGS_MESG_PAGES_ENABLED_COUNT);
    ImportIntegerSequence(8, libData, data, pos, mesg->default_page, FIT_DEVICE_SETTINGS_MESG_DEFAULT_PAGE_COUNT);
    ImportInteger(9, libData, data, pos, mesg->autosync_min_steps);
    ImportInteger(10, libData, data, pos, mesg->autosync_min_time);
    ImportInteger(11, libData, data, pos, mesg->active_time_zone);
    ImportIntegerSequence(12, libData, data, pos, mesg->time_mode, FIT_DEVICE_SETTINGS_MESG_TIME_MODE_COUNT);
    ImportIntegerSequence(13, libData, data, pos, mesg->time_zone_offset, FIT_DEVICE_SETTINGS_MESG_TIME_ZONE_OFFSET_COUNT);
    ImportInteger(14, libData, data, pos, mesg->backlight_mode);
    ImportInteger(15, libData, data, pos, mesg->activity_tracker_enabled);
    ImportInteger(16, libData, data, pos, mesg->move_alert_enabled);
    ImportInteger(17, libData, data, pos, mesg->date_mode);
    ImportInteger(18, libData, data, pos, mesg->display_orientation);
    ImportInteger(19, libData, data, pos, mesg->mounting_side);
    ImportInteger(20, libData, data, pos, mesg->lactate_threshold_autodetect_enabled);
    ImportInteger(21, libData, data, pos, mesg->ble_auto_upload_enabled);
    ImportInteger(22, libData, data, pos, mesg->auto_sync_frequency);
    ImportInteger(23, libData, data, pos, mesg->number_of_screens);
    ImportInteger(24, libData, data, pos, mesg->smart_notification_display_orientation);
    ImportInteger(25, libData, data, pos, mesg->tap_interface);
    ImportInteger(26, libData, data, pos, mesg->tap_sensitivity);
    ImportFinish(27, libData, data, pos);
}

static void import_user_profile(WolframLibraryData libData, MTensor data, int idx, const FIT_USER_PROFILE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_USER_PROFILE);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->friendly_name, FIT_USER_PROFILE_MESG_FRIENDLY_NAME_COUNT);
    ImportInteger(19, libData, data, pos, mesg->wake_time);
    ImportInteger(20, libData, data, pos, mesg->sleep_time);
    ImportInteger(21, libData, data, pos, mesg->dive_count);
    ImportInteger(22, libData, data, pos, mesg->message_index);
    ImportInteger(23, libData, data, pos, mesg->weight);
    ImportInteger(24, libData, data, pos, mesg->local_id);
    ImportInteger(25, libData, data, pos, mesg->user_running_step_length);
    ImportInteger(26, libData, data, pos, mesg->user_walking_step_length);
    ImportInteger(27, libData, data, pos, mesg->gender);
    ImportInteger(28, libData, data, pos, mesg->age);
    ImportInteger(29, libData, data, pos, mesg->height);
    ImportInteger(30, libData, data, pos, mesg->language);
    ImportInteger(31, libData, data, pos, mesg->elev_setting);
    ImportInteger(32, libData, data, pos, mesg->weight_setting);
    ImportInteger(33, libData, data, pos, mesg->resting_heart_rate);
    ImportInteger(34, libData, data, pos, mesg->default_max_running_heart_rate);
    ImportInteger(35, libData, data, pos, mesg->default_max_biking_heart_rate);
    ImportInteger(36, libData, data, pos, mesg->default_max_heart_rate);
    ImportInteger(37, libData, data, pos, mesg->hr_setting);
    ImportInteger(38, libData, data, pos, mesg->speed_setting);
    ImportInteger(39, libData, data, pos, mesg->dist_setting);
    ImportInteger(40, libData, data, pos, mesg->power_setting);
    ImportInteger(41, libData, data, pos, mesg->activity_class);
    ImportInteger(42, libData, data, pos, mesg->position_setting);
    ImportInteger(43, libData, data, pos, mesg->temperature_setting);
    ImportIntegerSequence(44, libData, data, pos, mesg->global_id, FIT_USER_PROFILE_MESG_GLOBAL_ID_COUNT);
    ImportInteger(50, libData, data, pos, mesg->height_setting);
    ImportInteger(51, libData, data, pos, mesg->depth_setting);
    ImportFinish(52, libData, data, pos);
}

static void import_hrm_profile(WolframLibraryData libData, MTensor data, int idx, const FIT_HRM_PROFILE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_HRM_PROFILE);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->message_index);
    ImportInteger(4, libData, data, pos, mesg->hrm_ant_id);
    ImportInteger(5, libData, data, pos, mesg->enabled);
    ImportInteger(6, libData, data, pos, mesg->log_hrv);
    ImportInteger(7, libData, data, pos, mesg->hrm_ant_id_trans_type);
    ImportFinish(8, libData, data, pos);
}

static void import_sdm_profile(WolframLibraryData libData, MTensor data, int idx, const FIT_SDM_PROFILE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_SDM_PROFILE);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->odometer);
    ImportInteger(4, libData, data, pos, mesg->message_index);
    ImportInteger(5, libData, data, pos, mesg->sdm_ant_id);
    ImportInteger(6, libData, data, pos, mesg->sdm_cal_factor);
    ImportInteger(7, libData, data, pos, mesg->enabled);
    ImportInteger(8, libData, data, pos, mesg->speed_source);
    ImportInteger(9, libData, data, pos, mesg->sdm_ant_id_trans_type);
    ImportInteger(10, libData, data, pos, mesg->odometer_rollover);
    ImportFinish(11, libData, data, pos);
}

static void import_bike_profile(WolframLibraryData libData, MTensor data, int idx, const FIT_BIKE_PROFILE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_BIKE_PROFILE);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->name, FIT_BIKE_PROFILE_MESG_NAME_COUNT);
    ImportInteger(35, libData, data, pos, mesg->odometer);
    ImportInteger(36, libData, data, pos, mesg->message_index);
    ImportInteger(37, libData, data, pos, mesg->bike_spd_ant_id);
    ImportInteger(38, libData, data, pos, mesg->bike_cad_ant_id);
    ImportInteger(39, libData, data, pos, mesg->bike_spdcad_ant_id);
    ImportInteger(40, libData, data, pos, mesg->bike_power_ant_id);
    ImportInteger(41, libData, data, pos, mesg->custom_wheelsize);
    ImportInteger(42, libData, data, pos, mesg->auto_wheelsize);
    ImportInteger(43, libData, data, pos, mesg->bike_weight);
    ImportInteger(44, libData, data, pos, mesg->power_cal_factor);
    ImportInteger(45, libData, data, pos, mesg->sport);
    ImportInteger(46, libData, data, pos, mesg->sub_sport);
    ImportInteger(47, libData, data, pos, mesg->auto_wheel_cal);
    ImportInteger(48, libData, data, pos, mesg->auto_power_zero);
    ImportInteger(49, libData, data, pos, mesg->id);
    ImportInteger(50, libData, data, pos, mesg->spd_enabled);
    ImportInteger(51, libData, data, pos, mesg->cad_enabled);
    ImportInteger(52, libData, data, pos, mesg->spdcad_enabled);
    ImportInteger(53, libData, data, pos, mesg->power_enabled);
    ImportInteger(54, libData, data, pos, mesg->crank_length);
    ImportInteger(55, libData, data, pos, mesg->enabled);
    ImportInteger(56, libData, data, pos, mesg->bike_spd_ant_id_trans_type);
    ImportInteger(57, libData, data, pos, mesg->bike_cad_ant_id_trans_type);
    ImportInteger(58, libData, data, pos, mesg->bike_spdcad_ant_id_trans_type);
    ImportInteger(59, libData, data, pos, mesg->bike_power_ant_id_trans_type);
    ImportInteger(60, libData, data, pos, mesg->odometer_rollover);
    ImportInteger(61, libData, data, pos, mesg->front_gear_num);
    ImportIntegerSequence(62, libData, data, pos, mesg->front_gear, FIT_BIKE_PROFILE_MESG_FRONT_GEAR_COUNT);
    ImportInteger(65, libData, data, pos, mesg->rear_gear_num);
    ImportIntegerSequence(66, libData, data, pos, mesg->rear_gear, FIT_BIKE_PROFILE_MESG_REAR_GEAR_COUNT);
    ImportInteger(81, libData, data, pos, mesg->shimano_di2_enabled);
    ImportFinish(82, libData, data, pos);
}

static void import_connectivity(WolframLibraryData libData, MTensor data, int idx, const FIT_CONNECTIVITY_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_CONNECTIVITY);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->name, FIT_CONNECTIVITY_MESG_NAME_COUNT);
    ImportInteger(27, libData, data, pos, mesg->bluetooth_enabled);
    ImportInteger(28, libData, data, pos, mesg->bluetooth_le_enabled);
    ImportInteger(29, libData, data, pos, mesg->ant_enabled);
    ImportInteger(30, libData, data, pos, mesg->live_tracking_enabled);
    ImportInteger(31, libData, data, pos, mesg->weather_conditions_enabled);
    ImportInteger(32, libData, data, pos, mesg->weather_alerts_enabled);
    ImportInteger(33, libData, data, pos, mesg->auto_activity_upload_enabled);
    ImportInteger(34, libData, data, pos, mesg->course_download_enabled);
    ImportInteger(35, libData, data, pos, mesg->workout_download_enabled);
    ImportInteger(36, libData, data, pos, mesg->gps_ephemeris_download_enabled);
    ImportInteger(37, libData, data, pos, mesg->incident_detection_enabled);
    ImportInteger(38, libData, data, pos, mesg->grouptrack_enabled);
    ImportFinish(39, libData, data, pos);
}

static void import_watchface_settings(WolframLibraryData libData, MTensor data, int idx, const FIT_WATCHFACE_SETTINGS_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_WATCHFACE_SETTINGS);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->message_index);
    ImportInteger(4, libData, data, pos, mesg->mode);
    ImportInteger(5, libData, data, pos, mesg->layout);
    ImportFinish(6, libData, data, pos);
}

static void import_ohr_settings(WolframLibraryData libData, MTensor data, int idx, const FIT_OHR_SETTINGS_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_OHR_SETTINGS);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->enabled);
    ImportFinish(5, libData, data, pos);
}

static void import_zones_target(WolframLibraryData libData, MTensor data, int idx, const FIT_ZONES_TARGET_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_ZONES_TARGET);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->functional_threshold_power);
    ImportInteger(4, libData, data, pos, mesg->max_heart_rate);
    ImportInteger(5, libData, data, pos, mesg->threshold_heart_rate);
    ImportInteger(6, libData, data, pos, mesg->hr_calc_type);
    ImportInteger(7, libData, data, pos, mesg->pwr_calc_type);
    ImportFinish(8, libData, data, pos);
}

static void import_sport(WolframLibraryData libData, MTensor data, int idx, const FIT_SPORT_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_SPORT);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->name, FIT_SPORT_MESG_NAME_COUNT);
    ImportInteger(19, libData, data, pos, mesg->sport);
    ImportInteger(20, libData, data, pos, mesg->sub_sport);
    ImportFinish(21, libData, data, pos);
}

static void import_hr_zone(WolframLibraryData libData, MTensor data, int idx, const FIT_HR_ZONE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_HR_ZONE);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->name, FIT_HR_ZONE_MESG_NAME_COUNT);
    ImportInteger(19, libData, data, pos, mesg->message_index);
    ImportInteger(20, libData, data, pos, mesg->high_bpm);
    ImportFinish(21, libData, data, pos);
}

static void import_speed_zone(WolframLibraryData libData, MTensor data, int idx, const FIT_SPEED_ZONE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_SPEED_ZONE);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->name, FIT_SPEED_ZONE_MESG_NAME_COUNT);
    ImportInteger(19, libData, data, pos, mesg->message_index);
    ImportInteger(20, libData, data, pos, mesg->high_value);
    ImportFinish(21, libData, data, pos);
}

static void import_cadence_zone(WolframLibraryData libData, MTensor data, int idx, const FIT_CADENCE_ZONE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_CADENCE_ZONE);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->name, FIT_CADENCE_ZONE_MESG_NAME_COUNT);
    ImportInteger(19, libData, data, pos, mesg->message_index);
    ImportInteger(20, libData, data, pos, mesg->high_value);
    ImportFinish(21, libData, data, pos);
}

static void import_power_zone(WolframLibraryData libData, MTensor data, int idx, const FIT_POWER_ZONE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_POWER_ZONE);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->name, FIT_POWER_ZONE_MESG_NAME_COUNT);
    ImportInteger(19, libData, data, pos, mesg->message_index);
    ImportInteger(20, libData, data, pos, mesg->high_value);
    ImportFinish(21, libData, data, pos);
}

static void import_met_zone(WolframLibraryData libData, MTensor data, int idx, const FIT_MET_ZONE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_MET_ZONE);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->message_index);
    ImportInteger(4, libData, data, pos, mesg->calories);
    ImportInteger(5, libData, data, pos, mesg->high_bpm);
    ImportInteger(6, libData, data, pos, mesg->fat_calories);
    ImportFinish(7, libData, data, pos);
}

static void import_dive_settings(WolframLibraryData libData, MTensor data, int idx, const FIT_DIVE_SETTINGS_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_DIVE_SETTINGS);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->name, FIT_DIVE_SETTINGS_MESG_NAME_COUNT);
    ImportFloat(19, libData, data, pos, mesg->water_density);
    ImportFloat(20, libData, data, pos, mesg->bottom_depth);
    ImportInteger(21, libData, data, pos, mesg->bottom_time);
    ImportInteger(22, libData, data, pos, mesg->apnea_countdown_time);
    ImportInteger(23, libData, data, pos, mesg->message_index);
    ImportInteger(24, libData, data, pos, mesg->repeat_dive_interval);
    ImportInteger(25, libData, data, pos, mesg->safety_stop_time);
    ImportInteger(26, libData, data, pos, mesg->model);
    ImportInteger(27, libData, data, pos, mesg->gf_low);
    ImportInteger(28, libData, data, pos, mesg->gf_high);
    ImportInteger(29, libData, data, pos, mesg->water_type);
    ImportInteger(30, libData, data, pos, mesg->po2_warn);
    ImportInteger(31, libData, data, pos, mesg->po2_critical);
    ImportInteger(32, libData, data, pos, mesg->po2_deco);
    ImportInteger(33, libData, data, pos, mesg->safety_stop_enabled);
    ImportInteger(34, libData, data, pos, mesg->apnea_countdown_enabled);
    ImportInteger(35, libData, data, pos, mesg->backlight_mode);
    ImportInteger(36, libData, data, pos, mesg->backlight_brightness);
    ImportInteger(37, libData, data, pos, mesg->backlight_timeout);
    ImportInteger(38, libData, data, pos, mesg->heart_rate_source_type);
    ImportInteger(39, libData, data, pos, mesg->heart_rate_source);
    ImportFinish(40, libData, data, pos);
}

static void import_dive_alarm(WolframLibraryData libData, MTensor data, int idx, const FIT_DIVE_ALARM_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_DIVE_ALARM);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->depth);
    ImportInteger(4, libData, data, pos, mesg->time);
    ImportInteger(5, libData, data, pos, mesg->message_index);
    ImportInteger(6, libData, data, pos, mesg->enabled);
    ImportInteger(7, libData, data, pos, mesg->alarm_type);
    ImportInteger(8, libData, data, pos, mesg->sound);
    ImportIntegerSequence(9, libData, data, pos, mesg->dive_types, FIT_DIVE_ALARM_MESG_DIVE_TYPES_COUNT);
    ImportFinish(10, libData, data, pos);
}

static void import_dive_gas(WolframLibraryData libData, MTensor data, int idx, const FIT_DIVE_GAS_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_DIVE_GAS);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->message_index);
    ImportInteger(4, libData, data, pos, mesg->helium_content);
    ImportInteger(5, libData, data, pos, mesg->oxygen_content);
    ImportInteger(6, libData, data, pos, mesg->status);
    ImportFinish(7, libData, data, pos);
}

static void import_goal(WolframLibraryData libData, MTensor data, int idx, const FIT_GOAL_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_GOAL);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->start_date));
    ImportInteger(4, libData, data, pos, WLTimestamp(mesg->end_date));
    ImportInteger(5, libData, data, pos, mesg->value);
    ImportInteger(6, libData, data, pos, mesg->target_value);
    ImportInteger(7, libData, data, pos, mesg->message_index);
    ImportInteger(8, libData, data, pos, mesg->recurrence_value);
    ImportInteger(9, libData, data, pos, mesg->sport);
    ImportInteger(10, libData, data, pos, mesg->sub_sport);
    ImportInteger(11, libData, data, pos, mesg->type);
    ImportInteger(12, libData, data, pos, mesg->repeat);
    ImportInteger(13, libData, data, pos, mesg->recurrence);
    ImportInteger(14, libData, data, pos, mesg->enabled);
    ImportInteger(15, libData, data, pos, mesg->source);
    ImportFinish(16, libData, data, pos);
}

static void import_activity(WolframLibraryData libData, MTensor data, int idx, const FIT_ACTIVITY_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_ACTIVITY);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->total_timer_time);
    ImportInteger(5, libData, data, pos, WLTimestamp(mesg->local_timestamp));
    ImportInteger(6, libData, data, pos, mesg->num_sessions);
    ImportInteger(7, libData, data, pos, mesg->type);
    ImportInteger(8, libData, data, pos, mesg->event);
    ImportInteger(9, libData, data, pos, mesg->event_type);
    ImportInteger(10, libData, data, pos, mesg->event_group);
    ImportFinish(11, libData, data, pos);
}

static void import_session(WolframLibraryData libData, MTensor data, int idx, const FIT_SESSION_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_SESSION);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, WLTimestamp(mesg->start_time));
    ImportInteger(5, libData, data, pos, mesg->start_position_lat);
    ImportInteger(6, libData, data, pos, mesg->start_position_long);
    ImportInteger(7, libData, data, pos, mesg->total_elapsed_time);
    ImportInteger(8, libData, data, pos, mesg->total_timer_time);
    ImportInteger(9, libData, data, pos, mesg->total_distance);
    ImportInteger(10, libData, data, pos, mesg->total_cycles);
    ImportInteger(11, libData, data, pos, mesg->nec_lat);
    ImportInteger(12, libData, data, pos, mesg->nec_long);
    ImportInteger(13, libData, data, pos, mesg->swc_lat);
    ImportInteger(14, libData, data, pos, mesg->swc_long);
    ImportInteger(15, libData, data, pos, mesg->avg_stroke_count);
    ImportInteger(16, libData, data, pos, mesg->total_work);
    ImportInteger(17, libData, data, pos, mesg->total_moving_time);
    ImportIntegerSequence(18, libData, data, pos, mesg->time_in_hr_zone, FIT_SESSION_MESG_TIME_IN_HR_ZONE_COUNT);
    ImportIntegerSequence(23, libData, data, pos, mesg->time_in_speed_zone, FIT_SESSION_MESG_TIME_IN_SPEED_ZONE_COUNT);
    ImportIntegerSequence(24, libData, data, pos, mesg->time_in_cadence_zone, FIT_SESSION_MESG_TIME_IN_CADENCE_ZONE_COUNT);
    ImportIntegerSequence(25, libData, data, pos, mesg->time_in_power_zone, FIT_SESSION_MESG_TIME_IN_POWER_ZONE_COUNT);
    ImportInteger(32, libData, data, pos, mesg->avg_lap_time);
    ImportString(33, libData, data, pos, mesg->opponent_name, FIT_SESSION_MESG_OPPONENT_NAME_COUNT);
    ImportInteger(49, libData, data, pos, mesg->time_standing);
    ImportIntegerSequence(50, libData, data, pos, mesg->avg_power_position, FIT_SESSION_MESG_AVG_POWER_POSITION_COUNT);
    ImportIntegerSequence(52, libData, data, pos, mesg->max_power_position, FIT_SESSION_MESG_MAX_POWER_POSITION_COUNT);
    ImportInteger(54, libData, data, pos, mesg->enhanced_avg_speed);
    ImportInteger(55, libData, data, pos, mesg->enhanced_max_speed);
    ImportInteger(56, libData, data, pos, mesg->enhanced_avg_altitude);
    ImportInteger(57, libData, data, pos, mesg->enhanced_min_altitude);
    ImportInteger(58, libData, data, pos, mesg->enhanced_max_altitude);
    ImportInteger(59, libData, data, pos, mesg->training_load_peak);
    ImportFloat(60, libData, data, pos, mesg->total_grit);
    ImportFloat(61, libData, data, pos, mesg->total_flow);
    ImportFloat(62, libData, data, pos, mesg->avg_grit);
    ImportFloat(63, libData, data, pos, mesg->avg_flow);
    ImportInteger(64, libData, data, pos, mesg->message_index);
    ImportInteger(65, libData, data, pos, mesg->total_calories);
    ImportInteger(66, libData, data, pos, mesg->total_fat_calories);
    ImportInteger(67, libData, data, pos, mesg->avg_speed);
    ImportInteger(68, libData, data, pos, mesg->max_speed);
    ImportInteger(69, libData, data, pos, mesg->avg_power);
    ImportInteger(70, libData, data, pos, mesg->max_power);
    ImportInteger(71, libData, data, pos, mesg->total_ascent);
    ImportInteger(72, libData, data, pos, mesg->total_descent);
    ImportInteger(73, libData, data, pos, mesg->first_lap_index);
    ImportInteger(74, libData, data, pos, mesg->num_laps);
    ImportInteger(75, libData, data, pos, mesg->num_lengths);
    ImportInteger(76, libData, data, pos, mesg->normalized_power);
    ImportInteger(77, libData, data, pos, mesg->training_stress_score);
    ImportInteger(78, libData, data, pos, mesg->intensity_factor);
    ImportInteger(79, libData, data, pos, mesg->left_right_balance);
    ImportInteger(80, libData, data, pos, mesg->avg_stroke_distance);
    ImportInteger(81, libData, data, pos, mesg->pool_length);
    ImportInteger(82, libData, data, pos, mesg->threshold_power);
    ImportInteger(83, libData, data, pos, mesg->num_active_lengths);
    ImportInteger(84, libData, data, pos, mesg->avg_altitude);
    ImportInteger(85, libData, data, pos, mesg->max_altitude);
    ImportInteger(86, libData, data, pos, mesg->avg_grade);
    ImportInteger(87, libData, data, pos, mesg->avg_pos_grade);
    ImportInteger(88, libData, data, pos, mesg->avg_neg_grade);
    ImportInteger(89, libData, data, pos, mesg->max_pos_grade);
    ImportInteger(90, libData, data, pos, mesg->max_neg_grade);
    ImportInteger(91, libData, data, pos, mesg->avg_pos_vertical_speed);
    ImportInteger(92, libData, data, pos, mesg->avg_neg_vertical_speed);
    ImportInteger(93, libData, data, pos, mesg->max_pos_vertical_speed);
    ImportInteger(94, libData, data, pos, mesg->max_neg_vertical_speed);
    ImportInteger(95, libData, data, pos, mesg->best_lap_index);
    ImportInteger(96, libData, data, pos, mesg->min_altitude);
    ImportInteger(97, libData, data, pos, mesg->player_score);
    ImportInteger(98, libData, data, pos, mesg->opponent_score);
    ImportIntegerSequence(99, libData, data, pos, mesg->stroke_count, FIT_SESSION_MESG_STROKE_COUNT_COUNT);
    ImportIntegerSequence(100, libData, data, pos, mesg->zone_count, FIT_SESSION_MESG_ZONE_COUNT_COUNT);
    ImportInteger(107, libData, data, pos, mesg->max_ball_speed);
    ImportInteger(108, libData, data, pos, mesg->avg_ball_speed);
    ImportInteger(109, libData, data, pos, mesg->avg_vertical_oscillation);
    ImportInteger(110, libData, data, pos, mesg->avg_stance_time_percent);
    ImportInteger(111, libData, data, pos, mesg->avg_stance_time);
    ImportIntegerSequence(112, libData, data, pos, mesg->avg_total_hemoglobin_conc, FIT_SESSION_MESG_AVG_TOTAL_HEMOGLOBIN_CONC_COUNT);
    ImportIntegerSequence(113, libData, data, pos, mesg->min_total_hemoglobin_conc, FIT_SESSION_MESG_MIN_TOTAL_HEMOGLOBIN_CONC_COUNT);
    ImportIntegerSequence(114, libData, data, pos, mesg->max_total_hemoglobin_conc, FIT_SESSION_MESG_MAX_TOTAL_HEMOGLOBIN_CONC_COUNT);
    ImportIntegerSequence(115, libData, data, pos, mesg->avg_saturated_hemoglobin_percent, FIT_SESSION_MESG_AVG_SATURATED_HEMOGLOBIN_PERCENT_COUNT);
    ImportIntegerSequence(116, libData, data, pos, mesg->min_saturated_hemoglobin_percent, FIT_SESSION_MESG_MIN_SATURATED_HEMOGLOBIN_PERCENT_COUNT);
    ImportIntegerSequence(117, libData, data, pos, mesg->max_saturated_hemoglobin_percent, FIT_SESSION_MESG_MAX_SATURATED_HEMOGLOBIN_PERCENT_COUNT);
    ImportInteger(118, libData, data, pos, mesg->stand_count);
    ImportInteger(119, libData, data, pos, mesg->avg_lev_motor_power);
    ImportInteger(120, libData, data, pos, mesg->max_lev_motor_power);
    ImportInteger(121, libData, data, pos, mesg->avg_vertical_ratio);
    ImportInteger(122, libData, data, pos, mesg->avg_stance_time_balance);
    ImportInteger(123, libData, data, pos, mesg->avg_step_length);
    ImportInteger(124, libData, data, pos, mesg->avg_vam);
    ImportInteger(125, libData, data, pos, mesg->jump_count);
    ImportInteger(126, libData, data, pos, mesg->avg_core_temperature);
    ImportInteger(127, libData, data, pos, mesg->min_core_temperature);
    ImportInteger(128, libData, data, pos, mesg->max_core_temperature);
    ImportInteger(129, libData, data, pos, mesg->event);
    ImportInteger(130, libData, data, pos, mesg->event_type);
    ImportInteger(131, libData, data, pos, mesg->sport);
    ImportInteger(132, libData, data, pos, mesg->sub_sport);
    ImportInteger(133, libData, data, pos, mesg->avg_heart_rate);
    ImportInteger(134, libData, data, pos, mesg->max_heart_rate);
    ImportInteger(135, libData, data, pos, mesg->avg_cadence);
    ImportInteger(136, libData, data, pos, mesg->max_cadence);
    ImportInteger(137, libData, data, pos, mesg->total_training_effect);
    ImportInteger(138, libData, data, pos, mesg->event_group);
    ImportInteger(139, libData, data, pos, mesg->trigger);
    ImportInteger(140, libData, data, pos, mesg->swim_stroke);
    ImportInteger(141, libData, data, pos, mesg->pool_length_unit);
    ImportInteger(142, libData, data, pos, mesg->gps_accuracy);
    ImportInteger(143, libData, data, pos, mesg->avg_temperature);
    ImportInteger(144, libData, data, pos, mesg->max_temperature);
    ImportInteger(145, libData, data, pos, mesg->min_heart_rate);
    ImportInteger(146, libData, data, pos, mesg->avg_fractional_cadence);
    ImportInteger(147, libData, data, pos, mesg->max_fractional_cadence);
    ImportInteger(148, libData, data, pos, mesg->total_fractional_cycles);
    ImportInteger(149, libData, data, pos, mesg->avg_left_torque_effectiveness);
    ImportInteger(150, libData, data, pos, mesg->avg_right_torque_effectiveness);
    ImportInteger(151, libData, data, pos, mesg->avg_left_pedal_smoothness);
    ImportInteger(152, libData, data, pos, mesg->avg_right_pedal_smoothness);
    ImportInteger(153, libData, data, pos, mesg->avg_combined_pedal_smoothness);
    ImportInteger(154, libData, data, pos, mesg->sport_index);
    ImportInteger(155, libData, data, pos, mesg->avg_left_pco);
    ImportInteger(156, libData, data, pos, mesg->avg_right_pco);
    ImportIntegerSequence(157, libData, data, pos, mesg->avg_left_power_phase, FIT_SESSION_MESG_AVG_LEFT_POWER_PHASE_COUNT);
    ImportIntegerSequence(159, libData, data, pos, mesg->avg_left_power_phase_peak, FIT_SESSION_MESG_AVG_LEFT_POWER_PHASE_PEAK_COUNT);
    ImportIntegerSequence(161, libData, data, pos, mesg->avg_right_power_phase, FIT_SESSION_MESG_AVG_RIGHT_POWER_PHASE_COUNT);
    ImportIntegerSequence(163, libData, data, pos, mesg->avg_right_power_phase_peak, FIT_SESSION_MESG_AVG_RIGHT_POWER_PHASE_PEAK_COUNT);
    ImportIntegerSequence(165, libData, data, pos, mesg->avg_cadence_position, FIT_SESSION_MESG_AVG_CADENCE_POSITION_COUNT);
    ImportIntegerSequence(167, libData, data, pos, mesg->max_cadence_position, FIT_SESSION_MESG_MAX_CADENCE_POSITION_COUNT);
    ImportInteger(169, libData, data, pos, mesg->lev_battery_consumption);
    ImportInteger(170, libData, data, pos, mesg->total_anaerobic_training_effect);
    ImportInteger(171, libData, data, pos, mesg->total_fractional_ascent);
    ImportInteger(172, libData, data, pos, mesg->total_fractional_descent);
    ImportFinish(173, libData, data, pos);
}

static void import_lap(WolframLibraryData libData, MTensor data, int idx, const FIT_LAP_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_LAP);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, WLTimestamp(mesg->start_time));
    ImportInteger(5, libData, data, pos, mesg->start_position_lat);
    ImportInteger(6, libData, data, pos, mesg->start_position_long);
    ImportInteger(7, libData, data, pos, mesg->end_position_lat);
    ImportInteger(8, libData, data, pos, mesg->end_position_long);
    ImportInteger(9, libData, data, pos, mesg->total_elapsed_time);
    ImportInteger(10, libData, data, pos, mesg->total_timer_time);
    ImportInteger(11, libData, data, pos, mesg->total_distance);
    ImportInteger(12, libData, data, pos, mesg->total_cycles);
    ImportInteger(13, libData, data, pos, mesg->total_work);
    ImportInteger(14, libData, data, pos, mesg->total_moving_time);
    ImportIntegerSequence(15, libData, data, pos, mesg->time_in_hr_zone, FIT_LAP_MESG_TIME_IN_HR_ZONE_COUNT);
    ImportIntegerSequence(20, libData, data, pos, mesg->time_in_speed_zone, FIT_LAP_MESG_TIME_IN_SPEED_ZONE_COUNT);
    ImportIntegerSequence(21, libData, data, pos, mesg->time_in_cadence_zone, FIT_LAP_MESG_TIME_IN_CADENCE_ZONE_COUNT);
    ImportIntegerSequence(22, libData, data, pos, mesg->time_in_power_zone, FIT_LAP_MESG_TIME_IN_POWER_ZONE_COUNT);
    ImportInteger(29, libData, data, pos, mesg->time_standing);
    ImportInteger(30, libData, data, pos, mesg->enhanced_avg_speed);
    ImportInteger(31, libData, data, pos, mesg->enhanced_max_speed);
    ImportInteger(32, libData, data, pos, mesg->enhanced_avg_altitude);
    ImportInteger(33, libData, data, pos, mesg->enhanced_min_altitude);
    ImportInteger(34, libData, data, pos, mesg->enhanced_max_altitude);
    ImportFloat(35, libData, data, pos, mesg->total_grit);
    ImportFloat(36, libData, data, pos, mesg->total_flow);
    ImportFloat(37, libData, data, pos, mesg->avg_grit);
    ImportFloat(38, libData, data, pos, mesg->avg_flow);
    ImportInteger(39, libData, data, pos, mesg->message_index);
    ImportInteger(40, libData, data, pos, mesg->total_calories);
    ImportInteger(41, libData, data, pos, mesg->total_fat_calories);
    ImportInteger(42, libData, data, pos, mesg->avg_speed);
    ImportInteger(43, libData, data, pos, mesg->max_speed);
    ImportInteger(44, libData, data, pos, mesg->avg_power);
    ImportInteger(45, libData, data, pos, mesg->max_power);
    ImportInteger(46, libData, data, pos, mesg->total_ascent);
    ImportInteger(47, libData, data, pos, mesg->total_descent);
    ImportInteger(48, libData, data, pos, mesg->num_lengths);
    ImportInteger(49, libData, data, pos, mesg->normalized_power);
    ImportInteger(50, libData, data, pos, mesg->left_right_balance);
    ImportInteger(51, libData, data, pos, mesg->first_length_index);
    ImportInteger(52, libData, data, pos, mesg->avg_stroke_distance);
    ImportInteger(53, libData, data, pos, mesg->num_active_lengths);
    ImportInteger(54, libData, data, pos, mesg->avg_altitude);
    ImportInteger(55, libData, data, pos, mesg->max_altitude);
    ImportInteger(56, libData, data, pos, mesg->avg_grade);
    ImportInteger(57, libData, data, pos, mesg->avg_pos_grade);
    ImportInteger(58, libData, data, pos, mesg->avg_neg_grade);
    ImportInteger(59, libData, data, pos, mesg->max_pos_grade);
    ImportInteger(60, libData, data, pos, mesg->max_neg_grade);
    ImportInteger(61, libData, data, pos, mesg->avg_pos_vertical_speed);
    ImportInteger(62, libData, data, pos, mesg->avg_neg_vertical_speed);
    ImportInteger(63, libData, data, pos, mesg->max_pos_vertical_speed);
    ImportInteger(64, libData, data, pos, mesg->max_neg_vertical_speed);
    ImportInteger(65, libData, data, pos, mesg->repetition_num);
    ImportInteger(66, libData, data, pos, mesg->min_altitude);
    ImportInteger(67, libData, data, pos, mesg->wkt_step_index);
    ImportInteger(68, libData, data, pos, mesg->opponent_score);
    ImportIntegerSequence(69, libData, data, pos, mesg->stroke_count, FIT_LAP_MESG_STROKE_COUNT_COUNT);
    ImportIntegerSequence(70, libData, data, pos, mesg->zone_count, FIT_LAP_MESG_ZONE_COUNT_COUNT);
    ImportInteger(77, libData, data, pos, mesg->avg_vertical_oscillation);
    ImportInteger(78, libData, data, pos, mesg->avg_stance_time_percent);
    ImportInteger(79, libData, data, pos, mesg->avg_stance_time);
    ImportInteger(80, libData, data, pos, mesg->player_score);
    ImportIntegerSequence(81, libData, data, pos, mesg->avg_total_hemoglobin_conc, FIT_LAP_MESG_AVG_TOTAL_HEMOGLOBIN_CONC_COUNT);
    ImportIntegerSequence(82, libData, data, pos, mesg->min_total_hemoglobin_conc, FIT_LAP_MESG_MIN_TOTAL_HEMOGLOBIN_CONC_COUNT);
    ImportIntegerSequence(83, libData, data, pos, mesg->max_total_hemoglobin_conc, FIT_LAP_MESG_MAX_TOTAL_HEMOGLOBIN_CONC_COUNT);
    ImportIntegerSequence(84, libData, data, pos, mesg->avg_saturated_hemoglobin_percent, FIT_LAP_MESG_AVG_SATURATED_HEMOGLOBIN_PERCENT_COUNT);
    ImportIntegerSequence(85, libData, data, pos, mesg->min_saturated_hemoglobin_percent, FIT_LAP_MESG_MIN_SATURATED_HEMOGLOBIN_PERCENT_COUNT);
    ImportIntegerSequence(86, libData, data, pos, mesg->max_saturated_hemoglobin_percent, FIT_LAP_MESG_MAX_SATURATED_HEMOGLOBIN_PERCENT_COUNT);
    ImportInteger(87, libData, data, pos, mesg->stand_count);
    ImportIntegerSequence(88, libData, data, pos, mesg->avg_power_position, FIT_LAP_MESG_AVG_POWER_POSITION_COUNT);
    ImportIntegerSequence(89, libData, data, pos, mesg->max_power_position, FIT_LAP_MESG_MAX_POWER_POSITION_COUNT);
    ImportInteger(90, libData, data, pos, mesg->avg_lev_motor_power);
    ImportInteger(91, libData, data, pos, mesg->max_lev_motor_power);
    ImportInteger(92, libData, data, pos, mesg->avg_vertical_ratio);
    ImportInteger(93, libData, data, pos, mesg->avg_stance_time_balance);
    ImportInteger(94, libData, data, pos, mesg->avg_step_length);
    ImportInteger(95, libData, data, pos, mesg->avg_vam);
    ImportInteger(96, libData, data, pos, mesg->jump_count);
    ImportInteger(97, libData, data, pos, mesg->avg_core_temperature);
    ImportInteger(98, libData, data, pos, mesg->min_core_temperature);
    ImportInteger(99, libData, data, pos, mesg->max_core_temperature);
    ImportInteger(100, libData, data, pos, mesg->event);
    ImportInteger(101, libData, data, pos, mesg->event_type);
    ImportInteger(102, libData, data, pos, mesg->avg_heart_rate);
    ImportInteger(103, libData, data, pos, mesg->max_heart_rate);
    ImportInteger(104, libData, data, pos, mesg->avg_cadence);
    ImportInteger(105, libData, data, pos, mesg->max_cadence);
    ImportInteger(106, libData, data, pos, mesg->intensity);
    ImportInteger(107, libData, data, pos, mesg->lap_trigger);
    ImportInteger(108, libData, data, pos, mesg->sport);
    ImportInteger(109, libData, data, pos, mesg->event_group);
    ImportInteger(110, libData, data, pos, mesg->swim_stroke);
    ImportInteger(111, libData, data, pos, mesg->sub_sport);
    ImportInteger(112, libData, data, pos, mesg->gps_accuracy);
    ImportInteger(113, libData, data, pos, mesg->avg_temperature);
    ImportInteger(114, libData, data, pos, mesg->max_temperature);
    ImportInteger(115, libData, data, pos, mesg->min_heart_rate);
    ImportInteger(116, libData, data, pos, mesg->avg_fractional_cadence);
    ImportInteger(117, libData, data, pos, mesg->max_fractional_cadence);
    ImportInteger(118, libData, data, pos, mesg->total_fractional_cycles);
    ImportInteger(119, libData, data, pos, mesg->avg_left_torque_effectiveness);
    ImportInteger(120, libData, data, pos, mesg->avg_right_torque_effectiveness);
    ImportInteger(121, libData, data, pos, mesg->avg_left_pedal_smoothness);
    ImportInteger(122, libData, data, pos, mesg->avg_right_pedal_smoothness);
    ImportInteger(123, libData, data, pos, mesg->avg_combined_pedal_smoothness);
    ImportInteger(124, libData, data, pos, mesg->avg_left_pco);
    ImportInteger(125, libData, data, pos, mesg->avg_right_pco);
    ImportIntegerSequence(126, libData, data, pos, mesg->avg_left_power_phase, FIT_LAP_MESG_AVG_LEFT_POWER_PHASE_COUNT);
    ImportIntegerSequence(127, libData, data, pos, mesg->avg_left_power_phase_peak, FIT_LAP_MESG_AVG_LEFT_POWER_PHASE_PEAK_COUNT);
    ImportIntegerSequence(128, libData, data, pos, mesg->avg_right_power_phase, FIT_LAP_MESG_AVG_RIGHT_POWER_PHASE_COUNT);
    ImportIntegerSequence(129, libData, data, pos, mesg->avg_right_power_phase_peak, FIT_LAP_MESG_AVG_RIGHT_POWER_PHASE_PEAK_COUNT);
    ImportIntegerSequence(130, libData, data, pos, mesg->avg_cadence_position, FIT_LAP_MESG_AVG_CADENCE_POSITION_COUNT);
    ImportIntegerSequence(131, libData, data, pos, mesg->max_cadence_position, FIT_LAP_MESG_MAX_CADENCE_POSITION_COUNT);
    ImportInteger(132, libData, data, pos, mesg->lev_battery_consumption);
    ImportInteger(133, libData, data, pos, mesg->total_fractional_ascent);
    ImportInteger(134, libData, data, pos, mesg->total_fractional_descent);
    ImportFinish(135, libData, data, pos);
}

static void import_length(WolframLibraryData libData, MTensor data, int idx, const FIT_LENGTH_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_LENGTH);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, WLTimestamp(mesg->start_time));
    ImportInteger(5, libData, data, pos, mesg->total_elapsed_time);
    ImportInteger(6, libData, data, pos, mesg->total_timer_time);
    ImportInteger(7, libData, data, pos, mesg->message_index);
    ImportInteger(8, libData, data, pos, mesg->total_strokes);
    ImportInteger(9, libData, data, pos, mesg->avg_speed);
    ImportInteger(10, libData, data, pos, mesg->total_calories);
    ImportInteger(11, libData, data, pos, mesg->player_score);
    ImportInteger(12, libData, data, pos, mesg->opponent_score);
    ImportIntegerSequence(13, libData, data, pos, mesg->stroke_count, FIT_LENGTH_MESG_STROKE_COUNT_COUNT);
    ImportIntegerSequence(14, libData, data, pos, mesg->zone_count, FIT_LENGTH_MESG_ZONE_COUNT_COUNT);
    ImportInteger(21, libData, data, pos, mesg->event);
    ImportInteger(22, libData, data, pos, mesg->event_type);
    ImportInteger(23, libData, data, pos, mesg->swim_stroke);
    ImportInteger(24, libData, data, pos, mesg->avg_swimming_cadence);
    ImportInteger(25, libData, data, pos, mesg->event_group);
    ImportInteger(26, libData, data, pos, mesg->length_type);
    ImportFinish(27, libData, data, pos);
}

static void import_record(WolframLibraryData libData, MTensor data, int idx, const FIT_RECORD_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_RECORD);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->position_lat);
    ImportInteger(5, libData, data, pos, mesg->position_long);
    ImportInteger(6, libData, data, pos, mesg->distance);
    ImportInteger(7, libData, data, pos, mesg->time_from_course);
    ImportInteger(8, libData, data, pos, mesg->total_cycles);
    ImportInteger(9, libData, data, pos, mesg->accumulated_power);
    ImportInteger(10, libData, data, pos, mesg->enhanced_speed);
    ImportInteger(11, libData, data, pos, mesg->enhanced_altitude);
    ImportInteger(12, libData, data, pos, mesg->absolute_pressure);
    ImportInteger(13, libData, data, pos, mesg->depth);
    ImportInteger(14, libData, data, pos, mesg->next_stop_depth);
    ImportInteger(15, libData, data, pos, mesg->next_stop_time);
    ImportInteger(16, libData, data, pos, mesg->time_to_surface);
    ImportInteger(17, libData, data, pos, mesg->ndl_time);
    ImportFloat(18, libData, data, pos, mesg->grit);
    ImportFloat(19, libData, data, pos, mesg->flow);
    ImportInteger(20, libData, data, pos, mesg->altitude);
    ImportInteger(21, libData, data, pos, mesg->speed);
    ImportInteger(22, libData, data, pos, mesg->power);
    ImportInteger(23, libData, data, pos, mesg->grade);
    ImportInteger(24, libData, data, pos, mesg->compressed_accumulated_power);
    ImportInteger(25, libData, data, pos, mesg->vertical_speed);
    ImportInteger(26, libData, data, pos, mesg->calories);
    ImportInteger(27, libData, data, pos, mesg->vertical_oscillation);
    ImportInteger(28, libData, data, pos, mesg->stance_time_percent);
    ImportInteger(29, libData, data, pos, mesg->stance_time);
    ImportInteger(30, libData, data, pos, mesg->ball_speed);
    ImportInteger(31, libData, data, pos, mesg->cadence256);
    ImportInteger(32, libData, data, pos, mesg->total_hemoglobin_conc);
    ImportInteger(33, libData, data, pos, mesg->total_hemoglobin_conc_min);
    ImportInteger(34, libData, data, pos, mesg->total_hemoglobin_conc_max);
    ImportInteger(35, libData, data, pos, mesg->saturated_hemoglobin_percent);
    ImportInteger(36, libData, data, pos, mesg->saturated_hemoglobin_percent_min);
    ImportInteger(37, libData, data, pos, mesg->saturated_hemoglobin_percent_max);
    ImportInteger(38, libData, data, pos, mesg->motor_power);
    ImportInteger(39, libData, data, pos, mesg->vertical_ratio);
    ImportInteger(40, libData, data, pos, mesg->stance_time_balance);
    ImportInteger(41, libData, data, pos, mesg->step_length);
    ImportInteger(42, libData, data, pos, mesg->n2_load);
    ImportInteger(43, libData, data, pos, mesg->ebike_travel_range);
    ImportInteger(44, libData, data, pos, mesg->core_temperature);
    ImportInteger(45, libData, data, pos, mesg->heart_rate);
    ImportInteger(46, libData, data, pos, mesg->cadence);
    ImportIntegerSequence(47, libData, data, pos, mesg->compressed_speed_distance, FIT_RECORD_MESG_COMPRESSED_SPEED_DISTANCE_COUNT);
    ImportInteger(50, libData, data, pos, mesg->resistance);
    ImportInteger(51, libData, data, pos, mesg->cycle_length);
    ImportInteger(52, libData, data, pos, mesg->temperature);
    ImportIntegerSequence(53, libData, data, pos, mesg->speed_1s, FIT_RECORD_MESG_SPEED_1S_COUNT);
    ImportInteger(58, libData, data, pos, mesg->cycles);
    ImportInteger(59, libData, data, pos, mesg->left_right_balance);
    ImportInteger(60, libData, data, pos, mesg->gps_accuracy);
    ImportInteger(61, libData, data, pos, mesg->activity_type);
    ImportInteger(62, libData, data, pos, mesg->left_torque_effectiveness);
    ImportInteger(63, libData, data, pos, mesg->right_torque_effectiveness);
    ImportInteger(64, libData, data, pos, mesg->left_pedal_smoothness);
    ImportInteger(65, libData, data, pos, mesg->right_pedal_smoothness);
    ImportInteger(66, libData, data, pos, mesg->combined_pedal_smoothness);
    ImportInteger(67, libData, data, pos, mesg->time128);
    ImportInteger(68, libData, data, pos, mesg->stroke_type);
    ImportInteger(69, libData, data, pos, mesg->zone);
    ImportInteger(70, libData, data, pos, mesg->fractional_cadence);
    ImportInteger(71, libData, data, pos, mesg->device_index);
    ImportInteger(72, libData, data, pos, mesg->left_pco);
    ImportInteger(73, libData, data, pos, mesg->right_pco);
    ImportIntegerSequence(74, libData, data, pos, mesg->left_power_phase, FIT_RECORD_MESG_LEFT_POWER_PHASE_COUNT);
    ImportIntegerSequence(76, libData, data, pos, mesg->left_power_phase_peak, FIT_RECORD_MESG_LEFT_POWER_PHASE_PEAK_COUNT);
    ImportIntegerSequence(78, libData, data, pos, mesg->right_power_phase, FIT_RECORD_MESG_RIGHT_POWER_PHASE_COUNT);
    ImportIntegerSequence(80, libData, data, pos, mesg->right_power_phase_peak, FIT_RECORD_MESG_RIGHT_POWER_PHASE_PEAK_COUNT);
    ImportInteger(82, libData, data, pos, mesg->battery_soc);
    ImportInteger(83, libData, data, pos, mesg->cns_load);
    ImportInteger(84, libData, data, pos, mesg->ebike_battery_level);
    ImportInteger(85, libData, data, pos, mesg->ebike_assist_mode);
    ImportInteger(86, libData, data, pos, mesg->ebike_assist_level_percent);
    ImportFinish(87, libData, data, pos);
}

static void import_event(WolframLibraryData libData, MTensor data, int idx, const FIT_EVENT_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_EVENT);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->data);
    ImportInteger(5, libData, data, pos, mesg->data16);
    ImportInteger(6, libData, data, pos, mesg->score);
    ImportInteger(7, libData, data, pos, mesg->opponent_score);
    ImportInteger(8, libData, data, pos, mesg->event);
    ImportInteger(9, libData, data, pos, mesg->event_type);
    ImportInteger(10, libData, data, pos, mesg->event_group);
    ImportInteger(11, libData, data, pos, mesg->front_gear_num);
    ImportInteger(12, libData, data, pos, mesg->front_gear);
    ImportInteger(13, libData, data, pos, mesg->rear_gear_num);
    ImportInteger(14, libData, data, pos, mesg->rear_gear);
    ImportInteger(15, libData, data, pos, mesg->device_index);
    ImportInteger(16, libData, data, pos, mesg->radar_threat_level_max);
    ImportInteger(17, libData, data, pos, mesg->radar_threat_count);
    ImportInteger(18, libData, data, pos, mesg->radar_threat_avg_approach_speed);
    ImportInteger(19, libData, data, pos, mesg->radar_threat_max_approach_speed);
    ImportFinish(20, libData, data, pos);
}

static void import_device_info(WolframLibraryData libData, MTensor data, int idx, const FIT_DEVICE_INFO_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_DEVICE_INFO);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->serial_number);
    ImportInteger(5, libData, data, pos, mesg->cum_operating_time);
    ImportString(6, libData, data, pos, mesg->descriptor, FIT_DEVICE_INFO_MESG_DESCRIPTOR_COUNT);
    ImportString(26, libData, data, pos, mesg->product_name, FIT_DEVICE_INFO_MESG_PRODUCT_NAME_COUNT);
    ImportInteger(46, libData, data, pos, mesg->manufacturer);
    ImportInteger(47, libData, data, pos, mesg->product);
    ImportInteger(48, libData, data, pos, mesg->software_version);
    ImportInteger(49, libData, data, pos, mesg->battery_voltage);
    ImportInteger(50, libData, data, pos, mesg->ant_device_number);
    ImportInteger(51, libData, data, pos, mesg->device_index);
    ImportInteger(52, libData, data, pos, mesg->device_type);
    ImportInteger(53, libData, data, pos, mesg->hardware_version);
    ImportInteger(54, libData, data, pos, mesg->battery_status);
    ImportInteger(55, libData, data, pos, mesg->sensor_position);
    ImportInteger(56, libData, data, pos, mesg->ant_transmission_type);
    ImportInteger(57, libData, data, pos, mesg->ant_network);
    ImportInteger(58, libData, data, pos, mesg->source_type);
    ImportInteger(59, libData, data, pos, mesg->battery_level);
    ImportFinish(60, libData, data, pos);
}

static void import_device_aux_battery_info(WolframLibraryData libData, MTensor data, int idx, const FIT_DEVICE_AUX_BATTERY_INFO_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_DEVICE_AUX_BATTERY_INFO);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->battery_voltage);
    ImportInteger(5, libData, data, pos, mesg->device_index);
    ImportInteger(6, libData, data, pos, mesg->battery_status);
    ImportInteger(7, libData, data, pos, mesg->battery_identifier);
    ImportFinish(8, libData, data, pos);
}

static void import_training_file(WolframLibraryData libData, MTensor data, int idx, const FIT_TRAINING_FILE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_TRAINING_FILE);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->serial_number);
    ImportInteger(5, libData, data, pos, WLTimestamp(mesg->time_created));
    ImportInteger(6, libData, data, pos, mesg->manufacturer);
    ImportInteger(7, libData, data, pos, mesg->product);
    ImportInteger(8, libData, data, pos, mesg->type);
    ImportFinish(9, libData, data, pos);
}

static void import_weather_conditions(WolframLibraryData libData, MTensor data, int idx, const FIT_WEATHER_CONDITIONS_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_WEATHER_CONDITIONS);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportString(4, libData, data, pos, mesg->location, FIT_WEATHER_CONDITIONS_MESG_LOCATION_COUNT);
    ImportInteger(68, libData, data, pos, WLTimestamp(mesg->observed_at_time));
    ImportInteger(69, libData, data, pos, mesg->observed_location_lat);
    ImportInteger(70, libData, data, pos, mesg->observed_location_long);
    ImportInteger(71, libData, data, pos, mesg->wind_direction);
    ImportInteger(72, libData, data, pos, mesg->wind_speed);
    ImportInteger(73, libData, data, pos, mesg->weather_report);
    ImportInteger(74, libData, data, pos, mesg->temperature);
    ImportInteger(75, libData, data, pos, mesg->condition);
    ImportInteger(76, libData, data, pos, mesg->precipitation_probability);
    ImportInteger(77, libData, data, pos, mesg->temperature_feels_like);
    ImportInteger(78, libData, data, pos, mesg->relative_humidity);
    ImportInteger(79, libData, data, pos, mesg->day_of_week);
    ImportInteger(80, libData, data, pos, mesg->high_temperature);
    ImportInteger(81, libData, data, pos, mesg->low_temperature);
    ImportFinish(82, libData, data, pos);
}

static void import_weather_alert(WolframLibraryData libData, MTensor data, int idx, const FIT_WEATHER_ALERT_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_WEATHER_ALERT);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportString(4, libData, data, pos, mesg->report_id, FIT_WEATHER_ALERT_MESG_REPORT_ID_COUNT);
    ImportInteger(16, libData, data, pos, WLTimestamp(mesg->issue_time));
    ImportInteger(17, libData, data, pos, WLTimestamp(mesg->expire_time));
    ImportInteger(18, libData, data, pos, mesg->severity);
    ImportInteger(19, libData, data, pos, mesg->type);
    ImportFinish(20, libData, data, pos);
}

static void import_gps_metadata(WolframLibraryData libData, MTensor data, int idx, const FIT_GPS_METADATA_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_GPS_METADATA);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->position_lat);
    ImportInteger(5, libData, data, pos, mesg->position_long);
    ImportInteger(6, libData, data, pos, mesg->enhanced_altitude);
    ImportInteger(7, libData, data, pos, mesg->enhanced_speed);
    ImportInteger(8, libData, data, pos, WLTimestamp(mesg->utc_timestamp));
    ImportInteger(9, libData, data, pos, mesg->timestamp_ms);
    ImportInteger(10, libData, data, pos, mesg->heading);
    ImportIntegerSequence(11, libData, data, pos, mesg->velocity, FIT_GPS_METADATA_MESG_VELOCITY_COUNT);
    ImportFinish(14, libData, data, pos);
}

static void import_camera_event(WolframLibraryData libData, MTensor data, int idx, const FIT_CAMERA_EVENT_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_CAMERA_EVENT);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->timestamp_ms);
    ImportInteger(5, libData, data, pos, mesg->camera_event_type);
    ImportString(6, libData, data, pos, mesg->camera_file_uuid, FIT_CAMERA_EVENT_MESG_CAMERA_FILE_UUID_COUNT);
    ImportInteger(7, libData, data, pos, mesg->camera_orientation);
    ImportFinish(8, libData, data, pos);
}

static void import_gyroscope_data(WolframLibraryData libData, MTensor data, int idx, const FIT_GYROSCOPE_DATA_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_GYROSCOPE_DATA);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportFloatSequence(4, libData, data, pos, mesg->calibrated_gyro_x, FIT_GYROSCOPE_DATA_MESG_CALIBRATED_GYRO_X_COUNT);
    ImportFloatSequence(5, libData, data, pos, mesg->calibrated_gyro_y, FIT_GYROSCOPE_DATA_MESG_CALIBRATED_GYRO_Y_COUNT);
    ImportFloatSequence(6, libData, data, pos, mesg->calibrated_gyro_z, FIT_GYROSCOPE_DATA_MESG_CALIBRATED_GYRO_Z_COUNT);
    ImportInteger(7, libData, data, pos, mesg->timestamp_ms);
    ImportIntegerSequence(8, libData, data, pos, mesg->sample_time_offset, FIT_GYROSCOPE_DATA_MESG_SAMPLE_TIME_OFFSET_COUNT);
    ImportIntegerSequence(9, libData, data, pos, mesg->gyro_x, FIT_GYROSCOPE_DATA_MESG_GYRO_X_COUNT);
    ImportIntegerSequence(10, libData, data, pos, mesg->gyro_y, FIT_GYROSCOPE_DATA_MESG_GYRO_Y_COUNT);
    ImportIntegerSequence(11, libData, data, pos, mesg->gyro_z, FIT_GYROSCOPE_DATA_MESG_GYRO_Z_COUNT);
    ImportFinish(12, libData, data, pos);
}

static void import_accelerometer_data(WolframLibraryData libData, MTensor data, int idx, const FIT_ACCELEROMETER_DATA_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_ACCELEROMETER_DATA);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportFloatSequence(4, libData, data, pos, mesg->calibrated_accel_x, FIT_ACCELEROMETER_DATA_MESG_CALIBRATED_ACCEL_X_COUNT);
    ImportFloatSequence(5, libData, data, pos, mesg->calibrated_accel_y, FIT_ACCELEROMETER_DATA_MESG_CALIBRATED_ACCEL_Y_COUNT);
    ImportFloatSequence(6, libData, data, pos, mesg->calibrated_accel_z, FIT_ACCELEROMETER_DATA_MESG_CALIBRATED_ACCEL_Z_COUNT);
    ImportInteger(7, libData, data, pos, mesg->timestamp_ms);
    ImportIntegerSequence(8, libData, data, pos, mesg->sample_time_offset, FIT_ACCELEROMETER_DATA_MESG_SAMPLE_TIME_OFFSET_COUNT);
    ImportIntegerSequence(9, libData, data, pos, mesg->accel_x, FIT_ACCELEROMETER_DATA_MESG_ACCEL_X_COUNT);
    ImportIntegerSequence(10, libData, data, pos, mesg->accel_y, FIT_ACCELEROMETER_DATA_MESG_ACCEL_Y_COUNT);
    ImportIntegerSequence(11, libData, data, pos, mesg->accel_z, FIT_ACCELEROMETER_DATA_MESG_ACCEL_Z_COUNT);
    ImportIntegerSequence(12, libData, data, pos, mesg->compressed_calibrated_accel_x, FIT_ACCELEROMETER_DATA_MESG_COMPRESSED_CALIBRATED_ACCEL_X_COUNT);
    ImportIntegerSequence(13, libData, data, pos, mesg->compressed_calibrated_accel_y, FIT_ACCELEROMETER_DATA_MESG_COMPRESSED_CALIBRATED_ACCEL_Y_COUNT);
    ImportIntegerSequence(14, libData, data, pos, mesg->compressed_calibrated_accel_z, FIT_ACCELEROMETER_DATA_MESG_COMPRESSED_CALIBRATED_ACCEL_Z_COUNT);
    ImportFinish(15, libData, data, pos);
}

static void import_magnetometer_data(WolframLibraryData libData, MTensor data, int idx, const FIT_MAGNETOMETER_DATA_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_MAGNETOMETER_DATA);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportFloatSequence(4, libData, data, pos, mesg->calibrated_mag_x, FIT_MAGNETOMETER_DATA_MESG_CALIBRATED_MAG_X_COUNT);
    ImportFloatSequence(5, libData, data, pos, mesg->calibrated_mag_y, FIT_MAGNETOMETER_DATA_MESG_CALIBRATED_MAG_Y_COUNT);
    ImportFloatSequence(6, libData, data, pos, mesg->calibrated_mag_z, FIT_MAGNETOMETER_DATA_MESG_CALIBRATED_MAG_Z_COUNT);
    ImportInteger(7, libData, data, pos, mesg->timestamp_ms);
    ImportIntegerSequence(8, libData, data, pos, mesg->sample_time_offset, FIT_MAGNETOMETER_DATA_MESG_SAMPLE_TIME_OFFSET_COUNT);
    ImportIntegerSequence(9, libData, data, pos, mesg->mag_x, FIT_MAGNETOMETER_DATA_MESG_MAG_X_COUNT);
    ImportIntegerSequence(10, libData, data, pos, mesg->mag_y, FIT_MAGNETOMETER_DATA_MESG_MAG_Y_COUNT);
    ImportIntegerSequence(11, libData, data, pos, mesg->mag_z, FIT_MAGNETOMETER_DATA_MESG_MAG_Z_COUNT);
    ImportFinish(12, libData, data, pos);
}

static void import_barometer_data(WolframLibraryData libData, MTensor data, int idx, const FIT_BAROMETER_DATA_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_BAROMETER_DATA);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportIntegerSequence(4, libData, data, pos, mesg->baro_pres, FIT_BAROMETER_DATA_MESG_BARO_PRES_COUNT);
    ImportInteger(5, libData, data, pos, mesg->timestamp_ms);
    ImportIntegerSequence(6, libData, data, pos, mesg->sample_time_offset, FIT_BAROMETER_DATA_MESG_SAMPLE_TIME_OFFSET_COUNT);
    ImportFinish(7, libData, data, pos);
}

static void import_three_d_sensor_calibration(WolframLibraryData libData, MTensor data, int idx, const FIT_THREE_D_SENSOR_CALIBRATION_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_THREE_D_SENSOR_CALIBRATION);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->calibration_factor);
    ImportInteger(5, libData, data, pos, mesg->calibration_divisor);
    ImportInteger(6, libData, data, pos, mesg->level_shift);
    ImportIntegerSequence(7, libData, data, pos, mesg->offset_cal, FIT_THREE_D_SENSOR_CALIBRATION_MESG_OFFSET_CAL_COUNT);
    ImportIntegerSequence(10, libData, data, pos, mesg->orientation_matrix, FIT_THREE_D_SENSOR_CALIBRATION_MESG_ORIENTATION_MATRIX_COUNT);
    ImportInteger(19, libData, data, pos, mesg->sensor_type);
    ImportFinish(20, libData, data, pos);
}

static void import_one_d_sensor_calibration(WolframLibraryData libData, MTensor data, int idx, const FIT_ONE_D_SENSOR_CALIBRATION_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_ONE_D_SENSOR_CALIBRATION);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->calibration_factor);
    ImportInteger(5, libData, data, pos, mesg->calibration_divisor);
    ImportInteger(6, libData, data, pos, mesg->level_shift);
    ImportInteger(7, libData, data, pos, mesg->offset_cal);
    ImportInteger(8, libData, data, pos, mesg->sensor_type);
    ImportFinish(9, libData, data, pos);
}

static void import_video_frame(WolframLibraryData libData, MTensor data, int idx, const FIT_VIDEO_FRAME_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_VIDEO_FRAME);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->frame_number);
    ImportInteger(5, libData, data, pos, mesg->timestamp_ms);
    ImportFinish(6, libData, data, pos);
}

static void import_obdii_data(WolframLibraryData libData, MTensor data, int idx, const FIT_OBDII_DATA_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_OBDII_DATA);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportIntegerSequence(4, libData, data, pos, mesg->system_time, FIT_OBDII_DATA_MESG_SYSTEM_TIME_COUNT);
    ImportInteger(5, libData, data, pos, WLTimestamp(mesg->start_timestamp));
    ImportInteger(6, libData, data, pos, mesg->timestamp_ms);
    ImportIntegerSequence(7, libData, data, pos, mesg->time_offset, FIT_OBDII_DATA_MESG_TIME_OFFSET_COUNT);
    ImportInteger(8, libData, data, pos, mesg->start_timestamp_ms);
    ImportInteger(9, libData, data, pos, mesg->pid);
    ImportIntegerSequence(10, libData, data, pos, mesg->raw_data, FIT_OBDII_DATA_MESG_RAW_DATA_COUNT);
    ImportIntegerSequence(11, libData, data, pos, mesg->pid_data_size, FIT_OBDII_DATA_MESG_PID_DATA_SIZE_COUNT);
    ImportFinish(12, libData, data, pos);
}

static void import_nmea_sentence(WolframLibraryData libData, MTensor data, int idx, const FIT_NMEA_SENTENCE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_NMEA_SENTENCE);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->timestamp_ms);
    ImportString(5, libData, data, pos, mesg->sentence, FIT_NMEA_SENTENCE_MESG_SENTENCE_COUNT);
    ImportFinish(88, libData, data, pos);
}

static void import_aviation_attitude(WolframLibraryData libData, MTensor data, int idx, const FIT_AVIATION_ATTITUDE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_AVIATION_ATTITUDE);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportIntegerSequence(4, libData, data, pos, mesg->system_time, FIT_AVIATION_ATTITUDE_MESG_SYSTEM_TIME_COUNT);
    ImportInteger(5, libData, data, pos, mesg->timestamp_ms);
    ImportIntegerSequence(6, libData, data, pos, mesg->pitch, FIT_AVIATION_ATTITUDE_MESG_PITCH_COUNT);
    ImportIntegerSequence(7, libData, data, pos, mesg->roll, FIT_AVIATION_ATTITUDE_MESG_ROLL_COUNT);
    ImportIntegerSequence(8, libData, data, pos, mesg->accel_lateral, FIT_AVIATION_ATTITUDE_MESG_ACCEL_LATERAL_COUNT);
    ImportIntegerSequence(9, libData, data, pos, mesg->accel_normal, FIT_AVIATION_ATTITUDE_MESG_ACCEL_NORMAL_COUNT);
    ImportIntegerSequence(10, libData, data, pos, mesg->turn_rate, FIT_AVIATION_ATTITUDE_MESG_TURN_RATE_COUNT);
    ImportIntegerSequence(11, libData, data, pos, mesg->track, FIT_AVIATION_ATTITUDE_MESG_TRACK_COUNT);
    ImportIntegerSequence(12, libData, data, pos, mesg->validity, FIT_AVIATION_ATTITUDE_MESG_VALIDITY_COUNT);
    ImportIntegerSequence(13, libData, data, pos, mesg->stage, FIT_AVIATION_ATTITUDE_MESG_STAGE_COUNT);
    ImportIntegerSequence(14, libData, data, pos, mesg->attitude_stage_complete, FIT_AVIATION_ATTITUDE_MESG_ATTITUDE_STAGE_COMPLETE_COUNT);
    ImportFinish(15, libData, data, pos);
}

static void import_video(WolframLibraryData libData, MTensor data, int idx, const FIT_VIDEO_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_VIDEO);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->duration);
    ImportString(4, libData, data, pos, mesg->url, FIT_VIDEO_MESG_URL_COUNT);
    ImportString(5, libData, data, pos, mesg->hosting_provider, FIT_VIDEO_MESG_HOSTING_PROVIDER_COUNT);
    ImportFinish(6, libData, data, pos);
}

static void import_video_title(WolframLibraryData libData, MTensor data, int idx, const FIT_VIDEO_TITLE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_VIDEO_TITLE);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->text, FIT_VIDEO_TITLE_MESG_TEXT_COUNT);
    ImportInteger(83, libData, data, pos, mesg->message_index);
    ImportInteger(84, libData, data, pos, mesg->message_count);
    ImportFinish(85, libData, data, pos);
}

static void import_video_description(WolframLibraryData libData, MTensor data, int idx, const FIT_VIDEO_DESCRIPTION_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_VIDEO_DESCRIPTION);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->text, FIT_VIDEO_DESCRIPTION_MESG_TEXT_COUNT);
    ImportInteger(131, libData, data, pos, mesg->message_index);
    ImportInteger(132, libData, data, pos, mesg->message_count);
    ImportFinish(133, libData, data, pos);
}

static void import_video_clip(WolframLibraryData libData, MTensor data, int idx, const FIT_VIDEO_CLIP_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_VIDEO_CLIP);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->start_timestamp));
    ImportInteger(4, libData, data, pos, WLTimestamp(mesg->end_timestamp));
    ImportInteger(5, libData, data, pos, mesg->clip_start);
    ImportInteger(6, libData, data, pos, mesg->clip_end);
    ImportInteger(7, libData, data, pos, mesg->clip_number);
    ImportInteger(8, libData, data, pos, mesg->start_timestamp_ms);
    ImportInteger(9, libData, data, pos, mesg->end_timestamp_ms);
    ImportFinish(10, libData, data, pos);
}

static void import_set(WolframLibraryData libData, MTensor data, int idx, const FIT_SET_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_SET);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->duration);
    ImportInteger(5, libData, data, pos, WLTimestamp(mesg->start_time));
    ImportInteger(6, libData, data, pos, mesg->repetitions);
    ImportInteger(7, libData, data, pos, mesg->weight);
    ImportIntegerSequence(8, libData, data, pos, mesg->category, FIT_SET_MESG_CATEGORY_COUNT);
    ImportIntegerSequence(9, libData, data, pos, mesg->category_subtype, FIT_SET_MESG_CATEGORY_SUBTYPE_COUNT);
    ImportInteger(10, libData, data, pos, mesg->weight_display_unit);
    ImportInteger(11, libData, data, pos, mesg->message_index);
    ImportInteger(12, libData, data, pos, mesg->wkt_step_index);
    ImportInteger(13, libData, data, pos, mesg->set_type);
    ImportFinish(14, libData, data, pos);
}

static void import_jump(WolframLibraryData libData, MTensor data, int idx, const FIT_JUMP_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_JUMP);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportFloat(4, libData, data, pos, mesg->distance);
    ImportFloat(5, libData, data, pos, mesg->height);
    ImportFloat(6, libData, data, pos, mesg->hang_time);
    ImportFloat(7, libData, data, pos, mesg->score);
    ImportInteger(8, libData, data, pos, mesg->position_lat);
    ImportInteger(9, libData, data, pos, mesg->position_long);
    ImportInteger(10, libData, data, pos, mesg->enhanced_speed);
    ImportInteger(11, libData, data, pos, mesg->speed);
    ImportInteger(12, libData, data, pos, mesg->rotations);
    ImportFinish(13, libData, data, pos);
}

static void import_climb_pro(WolframLibraryData libData, MTensor data, int idx, const FIT_CLIMB_PRO_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_CLIMB_PRO);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->position_lat);
    ImportInteger(5, libData, data, pos, mesg->position_long);
    ImportFloat(6, libData, data, pos, mesg->current_dist);
    ImportInteger(7, libData, data, pos, mesg->climb_number);
    ImportInteger(8, libData, data, pos, mesg->climb_pro_event);
    ImportInteger(9, libData, data, pos, mesg->climb_category);
    ImportFinish(10, libData, data, pos);
}

static void import_field_description(WolframLibraryData libData, MTensor data, int idx, const FIT_FIELD_DESCRIPTION_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_FIELD_DESCRIPTION);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->field_name, FIT_FIELD_DESCRIPTION_MESG_FIELD_NAME_COUNT);
    ImportString(67, libData, data, pos, mesg->units, FIT_FIELD_DESCRIPTION_MESG_UNITS_COUNT);
    ImportInteger(83, libData, data, pos, mesg->fit_base_unit_id);
    ImportInteger(84, libData, data, pos, mesg->native_mesg_num);
    ImportInteger(85, libData, data, pos, mesg->developer_data_index);
    ImportInteger(86, libData, data, pos, mesg->field_definition_number);
    ImportInteger(87, libData, data, pos, mesg->fit_base_type_id);
    ImportInteger(88, libData, data, pos, mesg->array);
    ImportString(89, libData, data, pos, mesg->components, FIT_FIELD_DESCRIPTION_MESG_COMPONENTS_COUNT);
    ImportInteger(90, libData, data, pos, mesg->scale);
    ImportInteger(91, libData, data, pos, mesg->offset);
    ImportString(92, libData, data, pos, mesg->bits, FIT_FIELD_DESCRIPTION_MESG_BITS_COUNT);
    ImportString(93, libData, data, pos, mesg->accumulate, FIT_FIELD_DESCRIPTION_MESG_ACCUMULATE_COUNT);
    ImportInteger(94, libData, data, pos, mesg->native_field_num);
    ImportFinish(95, libData, data, pos);
}

static void import_developer_data_id(WolframLibraryData libData, MTensor data, int idx, const FIT_DEVELOPER_DATA_ID_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_DEVELOPER_DATA_ID);
    ImportInteger(2, libData, data, pos, idx);
    ImportIntegerSequence(3, libData, data, pos, mesg->developer_id, FIT_DEVELOPER_DATA_ID_MESG_DEVELOPER_ID_COUNT);
    ImportIntegerSequence(19, libData, data, pos, mesg->application_id, FIT_DEVELOPER_DATA_ID_MESG_APPLICATION_ID_COUNT);
    ImportInteger(35, libData, data, pos, mesg->application_version);
    ImportInteger(36, libData, data, pos, mesg->manufacturer_id);
    ImportInteger(37, libData, data, pos, mesg->developer_data_index);
    ImportFinish(38, libData, data, pos);
}

static void import_course(WolframLibraryData libData, MTensor data, int idx, const FIT_COURSE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_COURSE);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->name, FIT_COURSE_MESG_NAME_COUNT);
    ImportInteger(19, libData, data, pos, mesg->capabilities);
    ImportInteger(20, libData, data, pos, mesg->sport);
    ImportInteger(21, libData, data, pos, mesg->sub_sport);
    ImportFinish(22, libData, data, pos);
}

static void import_course_point(WolframLibraryData libData, MTensor data, int idx, const FIT_COURSE_POINT_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_COURSE_POINT);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->position_lat);
    ImportInteger(5, libData, data, pos, mesg->position_long);
    ImportInteger(6, libData, data, pos, mesg->distance);
    ImportString(7, libData, data, pos, mesg->name, FIT_COURSE_POINT_MESG_NAME_COUNT);
    ImportInteger(23, libData, data, pos, mesg->message_index);
    ImportInteger(24, libData, data, pos, mesg->type);
    ImportInteger(25, libData, data, pos, mesg->favorite);
    ImportFinish(26, libData, data, pos);
}

static void import_segment_id(WolframLibraryData libData, MTensor data, int idx, const FIT_SEGMENT_ID_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_SEGMENT_ID);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->uuid, FIT_SEGMENT_ID_MESG_UUID_COUNT);
    ImportInteger(39, libData, data, pos, mesg->user_profile_primary_key);
    ImportInteger(40, libData, data, pos, mesg->device_id);
    ImportString(41, libData, data, pos, mesg->name, FIT_SEGMENT_ID_MESG_NAME_COUNT);
    ImportInteger(91, libData, data, pos, mesg->sport);
    ImportInteger(92, libData, data, pos, mesg->enabled);
    ImportInteger(93, libData, data, pos, mesg->default_race_leader);
    ImportInteger(94, libData, data, pos, mesg->delete_status);
    ImportInteger(95, libData, data, pos, mesg->selection_type);
    ImportFinish(96, libData, data, pos);
}

static void import_segment_leaderboard_entry(WolframLibraryData libData, MTensor data, int idx, const FIT_SEGMENT_LEADERBOARD_ENTRY_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_SEGMENT_LEADERBOARD_ENTRY);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->group_primary_key);
    ImportInteger(4, libData, data, pos, mesg->activity_id);
    ImportInteger(5, libData, data, pos, mesg->segment_time);
    ImportInteger(6, libData, data, pos, mesg->message_index);
    ImportString(7, libData, data, pos, mesg->name, FIT_SEGMENT_LEADERBOARD_ENTRY_MESG_NAME_COUNT);
    ImportInteger(8, libData, data, pos, mesg->type);
    ImportString(9, libData, data, pos, mesg->activity_id_string, FIT_SEGMENT_LEADERBOARD_ENTRY_MESG_ACTIVITY_ID_STRING_COUNT);
    ImportFinish(10, libData, data, pos);
}

static void import_segment_point(WolframLibraryData libData, MTensor data, int idx, const FIT_SEGMENT_POINT_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_SEGMENT_POINT);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->position_lat);
    ImportInteger(4, libData, data, pos, mesg->position_long);
    ImportInteger(5, libData, data, pos, mesg->distance);
    ImportIntegerSequence(6, libData, data, pos, mesg->leader_time, FIT_SEGMENT_POINT_MESG_LEADER_TIME_COUNT);
    ImportInteger(7, libData, data, pos, mesg->message_index);
    ImportInteger(8, libData, data, pos, mesg->altitude);
    ImportFinish(9, libData, data, pos);
}

static void import_segment_lap(WolframLibraryData libData, MTensor data, int idx, const FIT_SEGMENT_LAP_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_SEGMENT_LAP);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, WLTimestamp(mesg->start_time));
    ImportInteger(5, libData, data, pos, mesg->start_position_lat);
    ImportInteger(6, libData, data, pos, mesg->start_position_long);
    ImportInteger(7, libData, data, pos, mesg->end_position_lat);
    ImportInteger(8, libData, data, pos, mesg->end_position_long);
    ImportInteger(9, libData, data, pos, mesg->total_elapsed_time);
    ImportInteger(10, libData, data, pos, mesg->total_timer_time);
    ImportInteger(11, libData, data, pos, mesg->total_distance);
    ImportInteger(12, libData, data, pos, mesg->total_cycles);
    ImportInteger(13, libData, data, pos, mesg->nec_lat);
    ImportInteger(14, libData, data, pos, mesg->nec_long);
    ImportInteger(15, libData, data, pos, mesg->swc_lat);
    ImportInteger(16, libData, data, pos, mesg->swc_long);
    ImportString(17, libData, data, pos, mesg->name, FIT_SEGMENT_LAP_MESG_NAME_COUNT);
    ImportInteger(41, libData, data, pos, mesg->total_work);
    ImportInteger(42, libData, data, pos, mesg->total_moving_time);
    ImportIntegerSequence(43, libData, data, pos, mesg->time_in_hr_zone, FIT_SEGMENT_LAP_MESG_TIME_IN_HR_ZONE_COUNT);
    ImportIntegerSequence(48, libData, data, pos, mesg->time_in_speed_zone, FIT_SEGMENT_LAP_MESG_TIME_IN_SPEED_ZONE_COUNT);
    ImportIntegerSequence(49, libData, data, pos, mesg->time_in_cadence_zone, FIT_SEGMENT_LAP_MESG_TIME_IN_CADENCE_ZONE_COUNT);
    ImportIntegerSequence(50, libData, data, pos, mesg->time_in_power_zone, FIT_SEGMENT_LAP_MESG_TIME_IN_POWER_ZONE_COUNT);
    ImportInteger(57, libData, data, pos, mesg->active_time);
    ImportInteger(58, libData, data, pos, mesg->time_standing);
    ImportIntegerSequence(59, libData, data, pos, mesg->avg_power_position, FIT_SEGMENT_LAP_MESG_AVG_POWER_POSITION_COUNT);
    ImportIntegerSequence(61, libData, data, pos, mesg->max_power_position, FIT_SEGMENT_LAP_MESG_MAX_POWER_POSITION_COUNT);
    ImportFloat(63, libData, data, pos, mesg->total_grit);
    ImportFloat(64, libData, data, pos, mesg->total_flow);
    ImportFloat(65, libData, data, pos, mesg->avg_grit);
    ImportFloat(66, libData, data, pos, mesg->avg_flow);
    ImportInteger(67, libData, data, pos, mesg->message_index);
    ImportInteger(68, libData, data, pos, mesg->total_calories);
    ImportInteger(69, libData, data, pos, mesg->total_fat_calories);
    ImportInteger(70, libData, data, pos, mesg->avg_speed);
    ImportInteger(71, libData, data, pos, mesg->max_speed);
    ImportInteger(72, libData, data, pos, mesg->avg_power);
    ImportInteger(73, libData, data, pos, mesg->max_power);
    ImportInteger(74, libData, data, pos, mesg->total_ascent);
    ImportInteger(75, libData, data, pos, mesg->total_descent);
    ImportInteger(76, libData, data, pos, mesg->normalized_power);
    ImportInteger(77, libData, data, pos, mesg->left_right_balance);
    ImportInteger(78, libData, data, pos, mesg->avg_altitude);
    ImportInteger(79, libData, data, pos, mesg->max_altitude);
    ImportInteger(80, libData, data, pos, mesg->avg_grade);
    ImportInteger(81, libData, data, pos, mesg->avg_pos_grade);
    ImportInteger(82, libData, data, pos, mesg->avg_neg_grade);
    ImportInteger(83, libData, data, pos, mesg->max_pos_grade);
    ImportInteger(84, libData, data, pos, mesg->max_neg_grade);
    ImportInteger(85, libData, data, pos, mesg->avg_pos_vertical_speed);
    ImportInteger(86, libData, data, pos, mesg->avg_neg_vertical_speed);
    ImportInteger(87, libData, data, pos, mesg->max_pos_vertical_speed);
    ImportInteger(88, libData, data, pos, mesg->max_neg_vertical_speed);
    ImportInteger(89, libData, data, pos, mesg->repetition_num);
    ImportInteger(90, libData, data, pos, mesg->min_altitude);
    ImportInteger(91, libData, data, pos, mesg->wkt_step_index);
    ImportInteger(92, libData, data, pos, mesg->front_gear_shift_count);
    ImportInteger(93, libData, data, pos, mesg->rear_gear_shift_count);
    ImportInteger(94, libData, data, pos, mesg->stand_count);
    ImportInteger(95, libData, data, pos, mesg->manufacturer);
    ImportInteger(96, libData, data, pos, mesg->event);
    ImportInteger(97, libData, data, pos, mesg->event_type);
    ImportInteger(98, libData, data, pos, mesg->avg_heart_rate);
    ImportInteger(99, libData, data, pos, mesg->max_heart_rate);
    ImportInteger(100, libData, data, pos, mesg->avg_cadence);
    ImportInteger(101, libData, data, pos, mesg->max_cadence);
    ImportInteger(102, libData, data, pos, mesg->sport);
    ImportInteger(103, libData, data, pos, mesg->event_group);
    ImportInteger(104, libData, data, pos, mesg->sub_sport);
    ImportInteger(105, libData, data, pos, mesg->gps_accuracy);
    ImportInteger(106, libData, data, pos, mesg->avg_temperature);
    ImportInteger(107, libData, data, pos, mesg->max_temperature);
    ImportInteger(108, libData, data, pos, mesg->min_heart_rate);
    ImportInteger(109, libData, data, pos, mesg->sport_event);
    ImportInteger(110, libData, data, pos, mesg->avg_left_torque_effectiveness);
    ImportInteger(111, libData, data, pos, mesg->avg_right_torque_effectiveness);
    ImportInteger(112, libData, data, pos, mesg->avg_left_pedal_smoothness);
    ImportInteger(113, libData, data, pos, mesg->avg_right_pedal_smoothness);
    ImportInteger(114, libData, data, pos, mesg->avg_combined_pedal_smoothness);
    ImportInteger(115, libData, data, pos, mesg->status);
    ImportString(116, libData, data, pos, mesg->uuid, FIT_SEGMENT_LAP_MESG_UUID_COUNT);
    ImportInteger(149, libData, data, pos, mesg->avg_fractional_cadence);
    ImportInteger(150, libData, data, pos, mesg->max_fractional_cadence);
    ImportInteger(151, libData, data, pos, mesg->total_fractional_cycles);
    ImportInteger(152, libData, data, pos, mesg->avg_left_pco);
    ImportInteger(153, libData, data, pos, mesg->avg_right_pco);
    ImportIntegerSequence(154, libData, data, pos, mesg->avg_left_power_phase, FIT_SEGMENT_LAP_MESG_AVG_LEFT_POWER_PHASE_COUNT);
    ImportIntegerSequence(156, libData, data, pos, mesg->avg_left_power_phase_peak, FIT_SEGMENT_LAP_MESG_AVG_LEFT_POWER_PHASE_PEAK_COUNT);
    ImportIntegerSequence(158, libData, data, pos, mesg->avg_right_power_phase, FIT_SEGMENT_LAP_MESG_AVG_RIGHT_POWER_PHASE_COUNT);
    ImportIntegerSequence(160, libData, data, pos, mesg->avg_right_power_phase_peak, FIT_SEGMENT_LAP_MESG_AVG_RIGHT_POWER_PHASE_PEAK_COUNT);
    ImportIntegerSequence(162, libData, data, pos, mesg->avg_cadence_position, FIT_SEGMENT_LAP_MESG_AVG_CADENCE_POSITION_COUNT);
    ImportIntegerSequence(164, libData, data, pos, mesg->max_cadence_position, FIT_SEGMENT_LAP_MESG_MAX_CADENCE_POSITION_COUNT);
    ImportInteger(166, libData, data, pos, mesg->total_fractional_ascent);
    ImportInteger(167, libData, data, pos, mesg->total_fractional_descent);
    ImportFinish(168, libData, data, pos);
}

static void import_segment_file(WolframLibraryData libData, MTensor data, int idx, const FIT_SEGMENT_FILE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_SEGMENT_FILE);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->user_profile_primary_key);
    ImportIntegerSequence(4, libData, data, pos, mesg->leader_group_primary_key, FIT_SEGMENT_FILE_MESG_LEADER_GROUP_PRIMARY_KEY_COUNT);
    ImportIntegerSequence(5, libData, data, pos, mesg->leader_activity_id, FIT_SEGMENT_FILE_MESG_LEADER_ACTIVITY_ID_COUNT);
    ImportInteger(6, libData, data, pos, mesg->message_index);
    ImportString(7, libData, data, pos, mesg->file_uuid, FIT_SEGMENT_FILE_MESG_FILE_UUID_COUNT);
    ImportInteger(8, libData, data, pos, mesg->enabled);
    ImportIntegerSequence(9, libData, data, pos, mesg->leader_type, FIT_SEGMENT_FILE_MESG_LEADER_TYPE_COUNT);
    ImportString(10, libData, data, pos, mesg->leader_activity_id_string, FIT_SEGMENT_FILE_MESG_LEADER_ACTIVITY_ID_STRING_COUNT);
    ImportInteger(11, libData, data, pos, mesg->default_race_leader);
    ImportFinish(12, libData, data, pos);
}

static void import_workout(WolframLibraryData libData, MTensor data, int idx, const FIT_WORKOUT_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_WORKOUT);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->capabilities);
    ImportString(4, libData, data, pos, mesg->wkt_name, FIT_WORKOUT_MESG_WKT_NAME_COUNT);
    ImportInteger(104, libData, data, pos, mesg->num_valid_steps);
    ImportInteger(105, libData, data, pos, mesg->pool_length);
    ImportInteger(106, libData, data, pos, mesg->sport);
    ImportInteger(107, libData, data, pos, mesg->sub_sport);
    ImportInteger(108, libData, data, pos, mesg->pool_length_unit);
    ImportFinish(109, libData, data, pos);
}

static void import_workout_session(WolframLibraryData libData, MTensor data, int idx, const FIT_WORKOUT_SESSION_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_WORKOUT_SESSION);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->message_index);
    ImportInteger(4, libData, data, pos, mesg->num_valid_steps);
    ImportInteger(5, libData, data, pos, mesg->first_step_index);
    ImportInteger(6, libData, data, pos, mesg->pool_length);
    ImportInteger(7, libData, data, pos, mesg->sport);
    ImportInteger(8, libData, data, pos, mesg->sub_sport);
    ImportInteger(9, libData, data, pos, mesg->pool_length_unit);
    ImportFinish(10, libData, data, pos);
}

static void import_workout_step(WolframLibraryData libData, MTensor data, int idx, const FIT_WORKOUT_STEP_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_WORKOUT_STEP);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->wkt_step_name, FIT_WORKOUT_STEP_MESG_WKT_STEP_NAME_COUNT);
    ImportInteger(51, libData, data, pos, mesg->duration_value);
    ImportInteger(52, libData, data, pos, mesg->target_value);
    ImportInteger(53, libData, data, pos, mesg->custom_target_value_low);
    ImportInteger(54, libData, data, pos, mesg->custom_target_value_high);
    ImportInteger(55, libData, data, pos, mesg->secondary_target_value);
    ImportInteger(56, libData, data, pos, mesg->secondary_custom_target_value_low);
    ImportInteger(57, libData, data, pos, mesg->secondary_custom_target_value_high);
    ImportInteger(58, libData, data, pos, mesg->message_index);
    ImportInteger(59, libData, data, pos, mesg->exercise_category);
    ImportInteger(60, libData, data, pos, mesg->exercise_name);
    ImportInteger(61, libData, data, pos, mesg->exercise_weight);
    ImportInteger(62, libData, data, pos, mesg->weight_display_unit);
    ImportInteger(63, libData, data, pos, mesg->duration_type);
    ImportInteger(64, libData, data, pos, mesg->target_type);
    ImportInteger(65, libData, data, pos, mesg->intensity);
    ImportString(66, libData, data, pos, mesg->notes, FIT_WORKOUT_STEP_MESG_NOTES_COUNT);
    ImportInteger(116, libData, data, pos, mesg->equipment);
    ImportInteger(117, libData, data, pos, mesg->secondary_target_type);
    ImportFinish(118, libData, data, pos);
}

static void import_exercise_title(WolframLibraryData libData, MTensor data, int idx, const FIT_EXERCISE_TITLE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_EXERCISE_TITLE);
    ImportInteger(2, libData, data, pos, idx);
    ImportString(3, libData, data, pos, mesg->wkt_step_name, FIT_EXERCISE_TITLE_MESG_WKT_STEP_NAME_COUNT);
    ImportInteger(51, libData, data, pos, mesg->message_index);
    ImportInteger(52, libData, data, pos, mesg->exercise_category);
    ImportInteger(53, libData, data, pos, mesg->exercise_name);
    ImportFinish(54, libData, data, pos);
}

static void import_schedule(WolframLibraryData libData, MTensor data, int idx, const FIT_SCHEDULE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_SCHEDULE);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->serial_number);
    ImportInteger(4, libData, data, pos, WLTimestamp(mesg->time_created));
    ImportInteger(5, libData, data, pos, WLTimestamp(mesg->scheduled_time));
    ImportInteger(6, libData, data, pos, mesg->manufacturer);
    ImportInteger(7, libData, data, pos, mesg->product);
    ImportInteger(8, libData, data, pos, mesg->completed);
    ImportInteger(9, libData, data, pos, mesg->type);
    ImportFinish(10, libData, data, pos);
}

static void import_totals(WolframLibraryData libData, MTensor data, int idx, const FIT_TOTALS_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_TOTALS);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->timer_time);
    ImportInteger(5, libData, data, pos, mesg->distance);
    ImportInteger(6, libData, data, pos, mesg->calories);
    ImportInteger(7, libData, data, pos, mesg->elapsed_time);
    ImportInteger(8, libData, data, pos, mesg->active_time);
    ImportInteger(9, libData, data, pos, mesg->message_index);
    ImportInteger(10, libData, data, pos, mesg->sessions);
    ImportInteger(11, libData, data, pos, mesg->sport);
    ImportInteger(12, libData, data, pos, mesg->sport_index);
    ImportFinish(13, libData, data, pos);
}

static void import_weight_scale(WolframLibraryData libData, MTensor data, int idx, const FIT_WEIGHT_SCALE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_WEIGHT_SCALE);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->weight);
    ImportInteger(5, libData, data, pos, mesg->percent_fat);
    ImportInteger(6, libData, data, pos, mesg->percent_hydration);
    ImportInteger(7, libData, data, pos, mesg->visceral_fat_mass);
    ImportInteger(8, libData, data, pos, mesg->bone_mass);
    ImportInteger(9, libData, data, pos, mesg->muscle_mass);
    ImportInteger(10, libData, data, pos, mesg->basal_met);
    ImportInteger(11, libData, data, pos, mesg->active_met);
    ImportInteger(12, libData, data, pos, mesg->user_profile_index);
    ImportInteger(13, libData, data, pos, mesg->physique_rating);
    ImportInteger(14, libData, data, pos, mesg->metabolic_age);
    ImportInteger(15, libData, data, pos, mesg->visceral_fat_rating);
    ImportFinish(16, libData, data, pos);
}

static void import_blood_pressure(WolframLibraryData libData, MTensor data, int idx, const FIT_BLOOD_PRESSURE_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_BLOOD_PRESSURE);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->systolic_pressure);
    ImportInteger(5, libData, data, pos, mesg->diastolic_pressure);
    ImportInteger(6, libData, data, pos, mesg->mean_arterial_pressure);
    ImportInteger(7, libData, data, pos, mesg->map_3_sample_mean);
    ImportInteger(8, libData, data, pos, mesg->map_morning_values);
    ImportInteger(9, libData, data, pos, mesg->map_evening_values);
    ImportInteger(10, libData, data, pos, mesg->user_profile_index);
    ImportInteger(11, libData, data, pos, mesg->heart_rate);
    ImportInteger(12, libData, data, pos, mesg->heart_rate_type);
    ImportInteger(13, libData, data, pos, mesg->status);
    ImportFinish(14, libData, data, pos);
}

static void import_monitoring_info(WolframLibraryData libData, MTensor data, int idx, const FIT_MONITORING_INFO_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_MONITORING_INFO);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, WLTimestamp(mesg->local_timestamp));
    ImportIntegerSequence(5, libData, data, pos, mesg->cycles_to_distance, FIT_MONITORING_INFO_MESG_CYCLES_TO_DISTANCE_COUNT);
    ImportIntegerSequence(6, libData, data, pos, mesg->cycles_to_calories, FIT_MONITORING_INFO_MESG_CYCLES_TO_CALORIES_COUNT);
    ImportInteger(7, libData, data, pos, mesg->resting_metabolic_rate);
    ImportIntegerSequence(8, libData, data, pos, mesg->activity_type, FIT_MONITORING_INFO_MESG_ACTIVITY_TYPE_COUNT);
    ImportFinish(9, libData, data, pos);
}

static void import_monitoring(WolframLibraryData libData, MTensor data, int idx, const FIT_MONITORING_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_MONITORING);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->distance);
    ImportInteger(5, libData, data, pos, mesg->cycles);
    ImportInteger(6, libData, data, pos, mesg->active_time);
    ImportInteger(7, libData, data, pos, WLTimestamp(mesg->local_timestamp));
    ImportIntegerSequence(8, libData, data, pos, mesg->activity_time, FIT_MONITORING_MESG_ACTIVITY_TIME_COUNT);
    ImportInteger(16, libData, data, pos, mesg->duration);
    ImportInteger(17, libData, data, pos, mesg->ascent);
    ImportInteger(18, libData, data, pos, mesg->descent);
    ImportInteger(19, libData, data, pos, mesg->calories);
    ImportInteger(20, libData, data, pos, mesg->distance_16);
    ImportInteger(21, libData, data, pos, mesg->cycles_16);
    ImportInteger(22, libData, data, pos, mesg->active_time_16);
    ImportInteger(23, libData, data, pos, mesg->temperature);
    ImportInteger(24, libData, data, pos, mesg->temperature_min);
    ImportInteger(25, libData, data, pos, mesg->temperature_max);
    ImportInteger(26, libData, data, pos, mesg->active_calories);
    ImportInteger(27, libData, data, pos, mesg->timestamp_16);
    ImportInteger(28, libData, data, pos, mesg->duration_min);
    ImportInteger(29, libData, data, pos, mesg->moderate_activity_minutes);
    ImportInteger(30, libData, data, pos, mesg->vigorous_activity_minutes);
    ImportInteger(31, libData, data, pos, mesg->device_index);
    ImportInteger(32, libData, data, pos, mesg->activity_type);
    ImportInteger(33, libData, data, pos, mesg->activity_subtype);
    ImportInteger(34, libData, data, pos, mesg->activity_level);
    ImportInteger(35, libData, data, pos, mesg->current_activity_type_intensity);
    ImportInteger(36, libData, data, pos, mesg->timestamp_min_8);
    ImportInteger(37, libData, data, pos, mesg->heart_rate);
    ImportInteger(38, libData, data, pos, mesg->intensity);
    ImportFinish(39, libData, data, pos);
}

static void import_hr(WolframLibraryData libData, MTensor data, int idx, const FIT_HR_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_HR);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportIntegerSequence(4, libData, data, pos, mesg->event_timestamp, FIT_HR_MESG_EVENT_TIMESTAMP_COUNT);
    ImportInteger(5, libData, data, pos, mesg->fractional_timestamp);
    ImportInteger(6, libData, data, pos, mesg->time256);
    ImportIntegerSequence(7, libData, data, pos, mesg->filtered_bpm, FIT_HR_MESG_FILTERED_BPM_COUNT);
    ImportIntegerSequence(8, libData, data, pos, mesg->event_timestamp_12, FIT_HR_MESG_EVENT_TIMESTAMP_12_COUNT);
    ImportFinish(9, libData, data, pos);
}

static void import_stress_level(WolframLibraryData libData, MTensor data, int idx, const FIT_STRESS_LEVEL_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_STRESS_LEVEL);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->stress_level_time));
    ImportInteger(4, libData, data, pos, mesg->stress_level_value);
    ImportFinish(5, libData, data, pos);
}

static void import_memo_glob(WolframLibraryData libData, MTensor data, int idx, const FIT_MEMO_GLOB_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_MEMO_GLOB);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->part_index);
    ImportInteger(4, libData, data, pos, mesg->mesg_num);
    ImportInteger(5, libData, data, pos, mesg->parent_index);
    ImportIntegerSequence(6, libData, data, pos, mesg->memo, FIT_MEMO_GLOB_MESG_MEMO_COUNT);
    ImportInteger(56, libData, data, pos, mesg->field_num);
    ImportIntegerSequence(57, libData, data, pos, mesg->data, FIT_MEMO_GLOB_MESG_DATA_COUNT);
    ImportFinish(107, libData, data, pos);
}

static void import_ant_channel_id(WolframLibraryData libData, MTensor data, int idx, const FIT_ANT_CHANNEL_ID_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_ANT_CHANNEL_ID);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->device_number);
    ImportInteger(4, libData, data, pos, mesg->channel_number);
    ImportInteger(5, libData, data, pos, mesg->device_type);
    ImportInteger(6, libData, data, pos, mesg->transmission_type);
    ImportInteger(7, libData, data, pos, mesg->device_index);
    ImportFinish(8, libData, data, pos);
}

static void import_ant_rx(WolframLibraryData libData, MTensor data, int idx, const FIT_ANT_RX_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_ANT_RX);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportIntegerSequence(4, libData, data, pos, mesg->data, FIT_ANT_RX_MESG_DATA_COUNT);
    ImportInteger(12, libData, data, pos, mesg->fractional_timestamp);
    ImportInteger(13, libData, data, pos, mesg->mesg_id);
    ImportIntegerSequence(14, libData, data, pos, mesg->mesg_data, FIT_ANT_RX_MESG_MESG_DATA_COUNT);
    ImportInteger(23, libData, data, pos, mesg->channel_number);
    ImportFinish(24, libData, data, pos);
}

static void import_ant_tx(WolframLibraryData libData, MTensor data, int idx, const FIT_ANT_TX_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_ANT_TX);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportIntegerSequence(4, libData, data, pos, mesg->data, FIT_ANT_TX_MESG_DATA_COUNT);
    ImportInteger(12, libData, data, pos, mesg->fractional_timestamp);
    ImportInteger(13, libData, data, pos, mesg->mesg_id);
    ImportIntegerSequence(14, libData, data, pos, mesg->mesg_data, FIT_ANT_TX_MESG_MESG_DATA_COUNT);
    ImportInteger(23, libData, data, pos, mesg->channel_number);
    ImportFinish(24, libData, data, pos);
}

static void import_exd_screen_configuration(WolframLibraryData libData, MTensor data, int idx, const FIT_EXD_SCREEN_CONFIGURATION_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_EXD_SCREEN_CONFIGURATION);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->screen_index);
    ImportInteger(4, libData, data, pos, mesg->field_count);
    ImportInteger(5, libData, data, pos, mesg->layout);
    ImportInteger(6, libData, data, pos, mesg->screen_enabled);
    ImportFinish(7, libData, data, pos);
}

static void import_exd_data_field_configuration(WolframLibraryData libData, MTensor data, int idx, const FIT_EXD_DATA_FIELD_CONFIGURATION_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_EXD_DATA_FIELD_CONFIGURATION);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->screen_index);
    ImportInteger(4, libData, data, pos, mesg->concept_field);
    ImportInteger(5, libData, data, pos, mesg->field_id);
    ImportInteger(6, libData, data, pos, mesg->concept_count);
    ImportInteger(7, libData, data, pos, mesg->display_type);
    ImportString(8, libData, data, pos, mesg->title, FIT_EXD_DATA_FIELD_CONFIGURATION_MESG_TITLE_COUNT);
    ImportFinish(9, libData, data, pos);
}

static void import_exd_data_concept_configuration(WolframLibraryData libData, MTensor data, int idx, const FIT_EXD_DATA_CONCEPT_CONFIGURATION_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_EXD_DATA_CONCEPT_CONFIGURATION);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, mesg->screen_index);
    ImportInteger(4, libData, data, pos, mesg->concept_field);
    ImportInteger(5, libData, data, pos, mesg->field_id);
    ImportInteger(6, libData, data, pos, mesg->concept_index);
    ImportInteger(7, libData, data, pos, mesg->data_page);
    ImportInteger(8, libData, data, pos, mesg->concept_key);
    ImportInteger(9, libData, data, pos, mesg->scaling);
    ImportInteger(10, libData, data, pos, mesg->data_units);
    ImportInteger(11, libData, data, pos, mesg->qualifier);
    ImportInteger(12, libData, data, pos, mesg->descriptor);
    ImportInteger(13, libData, data, pos, mesg->is_signed);
    ImportFinish(14, libData, data, pos);
}

static void import_dive_summary(WolframLibraryData libData, MTensor data, int idx, const FIT_DIVE_SUMMARY_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_DIVE_SUMMARY);
    ImportInteger(2, libData, data, pos, idx);
    ImportInteger(3, libData, data, pos, WLTimestamp(mesg->timestamp));
    ImportInteger(4, libData, data, pos, mesg->avg_depth);
    ImportInteger(5, libData, data, pos, mesg->max_depth);
    ImportInteger(6, libData, data, pos, mesg->surface_interval);
    ImportInteger(7, libData, data, pos, mesg->dive_number);
    ImportInteger(8, libData, data, pos, mesg->bottom_time);
    ImportInteger(9, libData, data, pos, mesg->avg_ascent_rate);
    ImportInteger(10, libData, data, pos, mesg->avg_descent_rate);
    ImportInteger(11, libData, data, pos, mesg->max_ascent_rate);
    ImportInteger(12, libData, data, pos, mesg->max_descent_rate);
    ImportInteger(13, libData, data, pos, mesg->hang_time);
    ImportInteger(14, libData, data, pos, mesg->reference_mesg);
    ImportInteger(15, libData, data, pos, mesg->reference_index);
    ImportInteger(16, libData, data, pos, mesg->start_n2);
    ImportInteger(17, libData, data, pos, mesg->end_n2);
    ImportInteger(18, libData, data, pos, mesg->o2_toxicity);
    ImportInteger(19, libData, data, pos, mesg->start_cns);
    ImportInteger(20, libData, data, pos, mesg->end_cns);
    ImportFinish(21, libData, data, pos);
}

static void import_hrv(WolframLibraryData libData, MTensor data, int idx, const FIT_HRV_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_HRV);
    ImportInteger(2, libData, data, pos, idx);
    ImportIntegerSequence(3, libData, data, pos, mesg->time, FIT_HRV_MESG_TIME_COUNT);
    ImportFinish(4, libData, data, pos);
}

static void import_wxf_expression(WolframLibraryData libData, MTensor data, int idx, const FIT_WXF_EXPRESSION_MESG *mesg)
{
    mint pos[2] = {idx, 0};
    ImportInteger(1, libData, data, pos, FIT_MESG_NUM_WXF_EXPRESSION);
    ImportInteger(2, libData, data, pos, idx);
    ImportIntegerSequence(3, libData, data, pos, mesg->uuid, FIT_WXF_EXPRESSION_MESG_UUID_COUNT);
    ImportIntegerSequence(7, libData, data, pos, mesg->wxf, FIT_WXF_EXPRESSION_MESG_WXF_COUNT);
    ImportInteger(135, libData, data, pos, mesg->part_number);
    ImportInteger(136, libData, data, pos, mesg->partial);
    ImportInteger(137, libData, data, pos, mesg->byte_count);
    ImportFinish(138, libData, data, pos);
}
// --- END MESSAGE IMPORT FUNCTIONS ---