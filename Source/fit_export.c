#define _CRT_SECURE_NO_WARNINGS

#include "fit_export.h"
///////////////////////////////////////////////////////////////////////
// Writes data to the file and updates the data CRC.
///////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////
// Private Variables
///////////////////////////////////////////////////////////////////////

static FIT_UINT16 data_crc;

static FIT_MESG_NUM defined_messages[FIT_MESG_NUM_COUNT];

static FIT_MESG_NUM last_message;

DLLEXPORT int FITExport(
    WolframLibraryData libData,
    mint Argc, 
    MArgument *Args, 
    MArgument Res
)
{
    mint err = 0;
    char *path;
	FILE *fp;
    MTensor data;
    mint const * dims;
    mint count;
    mint exported = 0;

	data_crc = 0;
    
    data  = MArgument_getMTensor(Args[1]);
    dims  = (libData->MTensor_getDimensions)(data);
    count = dims[0];

    path = MArgument_getUTF8String(Args[0]);
    fp = fopen(path, "w+b");
	WriteFileHeader(fp);

    for (int i=0; i<FIT_MESG_NUM_COUNT; i++)
        defined_messages[i] = 0;

    last_message = FIT_MESG_NUM_INVALID;

    for (int i=0; i<count; i++) {
        mint idx = i + 1;
        mint m_num;
        mint pos[2];
        pos[0] = idx;
        pos[1] = 1;
        libData->MTensor_getInteger(data, pos, &m_num);
        FIT_MESG_NUM mesg_num = (FIT_MESG_NUM) m_num;
        switch (mesg_num)
        {

// --- START MESSAGE EXPORT CASES ---
// This section is auto-generated. Do not edit manually.

            case FIT_MESG_NUM_FILE_ID:
            {
                exported++;
                export_file_id(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_FILE_CREATOR:
            {
                exported++;
                export_file_creator(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_TIMESTAMP_CORRELATION:
            {
                exported++;
                export_timestamp_correlation(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_SOFTWARE:
            {
                exported++;
                export_software(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_SLAVE_DEVICE:
            {
                exported++;
                export_slave_device(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_CAPABILITIES:
            {
                exported++;
                export_capabilities(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_FILE_CAPABILITIES:
            {
                exported++;
                export_file_capabilities(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_MESG_CAPABILITIES:
            {
                exported++;
                export_mesg_capabilities(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_FIELD_CAPABILITIES:
            {
                exported++;
                export_field_capabilities(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_DEVICE_SETTINGS:
            {
                exported++;
                export_device_settings(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_USER_PROFILE:
            {
                exported++;
                export_user_profile(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_HRM_PROFILE:
            {
                exported++;
                export_hrm_profile(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_SDM_PROFILE:
            {
                exported++;
                export_sdm_profile(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_BIKE_PROFILE:
            {
                exported++;
                export_bike_profile(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_CONNECTIVITY:
            {
                exported++;
                export_connectivity(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_WATCHFACE_SETTINGS:
            {
                exported++;
                export_watchface_settings(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_OHR_SETTINGS:
            {
                exported++;
                export_ohr_settings(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_ZONES_TARGET:
            {
                exported++;
                export_zones_target(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_SPORT:
            {
                exported++;
                export_sport(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_HR_ZONE:
            {
                exported++;
                export_hr_zone(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_SPEED_ZONE:
            {
                exported++;
                export_speed_zone(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_CADENCE_ZONE:
            {
                exported++;
                export_cadence_zone(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_POWER_ZONE:
            {
                exported++;
                export_power_zone(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_MET_ZONE:
            {
                exported++;
                export_met_zone(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_DIVE_SETTINGS:
            {
                exported++;
                export_dive_settings(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_DIVE_ALARM:
            {
                exported++;
                export_dive_alarm(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_DIVE_GAS:
            {
                exported++;
                export_dive_gas(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_GOAL:
            {
                exported++;
                export_goal(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_ACTIVITY:
            {
                exported++;
                export_activity(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_SESSION:
            {
                exported++;
                export_session(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_LAP:
            {
                exported++;
                export_lap(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_LENGTH:
            {
                exported++;
                export_length(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_RECORD:
            {
                exported++;
                export_record(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_EVENT:
            {
                exported++;
                export_event(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_DEVICE_INFO:
            {
                exported++;
                export_device_info(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_DEVICE_AUX_BATTERY_INFO:
            {
                exported++;
                export_device_aux_battery_info(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_TRAINING_FILE:
            {
                exported++;
                export_training_file(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_WEATHER_CONDITIONS:
            {
                exported++;
                export_weather_conditions(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_WEATHER_ALERT:
            {
                exported++;
                export_weather_alert(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_GPS_METADATA:
            {
                exported++;
                export_gps_metadata(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_CAMERA_EVENT:
            {
                exported++;
                export_camera_event(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_GYROSCOPE_DATA:
            {
                exported++;
                export_gyroscope_data(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_ACCELEROMETER_DATA:
            {
                exported++;
                export_accelerometer_data(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_MAGNETOMETER_DATA:
            {
                exported++;
                export_magnetometer_data(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_BAROMETER_DATA:
            {
                exported++;
                export_barometer_data(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_THREE_D_SENSOR_CALIBRATION:
            {
                exported++;
                export_three_d_sensor_calibration(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_ONE_D_SENSOR_CALIBRATION:
            {
                exported++;
                export_one_d_sensor_calibration(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_VIDEO_FRAME:
            {
                exported++;
                export_video_frame(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_OBDII_DATA:
            {
                exported++;
                export_obdii_data(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_NMEA_SENTENCE:
            {
                exported++;
                export_nmea_sentence(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_AVIATION_ATTITUDE:
            {
                exported++;
                export_aviation_attitude(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_VIDEO:
            {
                exported++;
                export_video(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_VIDEO_TITLE:
            {
                exported++;
                export_video_title(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_VIDEO_DESCRIPTION:
            {
                exported++;
                export_video_description(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_VIDEO_CLIP:
            {
                exported++;
                export_video_clip(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_SET:
            {
                exported++;
                export_set(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_JUMP:
            {
                exported++;
                export_jump(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_CLIMB_PRO:
            {
                exported++;
                export_climb_pro(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_FIELD_DESCRIPTION:
            {
                exported++;
                export_field_description(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_DEVELOPER_DATA_ID:
            {
                exported++;
                export_developer_data_id(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_COURSE:
            {
                exported++;
                export_course(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_COURSE_POINT:
            {
                exported++;
                export_course_point(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_SEGMENT_ID:
            {
                exported++;
                export_segment_id(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_SEGMENT_LEADERBOARD_ENTRY:
            {
                exported++;
                export_segment_leaderboard_entry(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_SEGMENT_POINT:
            {
                exported++;
                export_segment_point(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_SEGMENT_LAP:
            {
                exported++;
                export_segment_lap(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_SEGMENT_FILE:
            {
                exported++;
                export_segment_file(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_WORKOUT:
            {
                exported++;
                export_workout(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_WORKOUT_SESSION:
            {
                exported++;
                export_workout_session(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_WORKOUT_STEP:
            {
                exported++;
                export_workout_step(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_EXERCISE_TITLE:
            {
                exported++;
                export_exercise_title(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_SCHEDULE:
            {
                exported++;
                export_schedule(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_TOTALS:
            {
                exported++;
                export_totals(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_WEIGHT_SCALE:
            {
                exported++;
                export_weight_scale(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_BLOOD_PRESSURE:
            {
                exported++;
                export_blood_pressure(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_MONITORING_INFO:
            {
                exported++;
                export_monitoring_info(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_MONITORING:
            {
                exported++;
                export_monitoring(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_HR:
            {
                exported++;
                export_hr(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_STRESS_LEVEL:
            {
                exported++;
                export_stress_level(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_MEMO_GLOB:
            {
                exported++;
                export_memo_glob(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_ANT_CHANNEL_ID:
            {
                exported++;
                export_ant_channel_id(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_ANT_RX:
            {
                exported++;
                export_ant_rx(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_ANT_TX:
            {
                exported++;
                export_ant_tx(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_EXD_SCREEN_CONFIGURATION:
            {
                exported++;
                export_exd_screen_configuration(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_EXD_DATA_FIELD_CONFIGURATION:
            {
                exported++;
                export_exd_data_field_configuration(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_EXD_DATA_CONCEPT_CONFIGURATION:
            {
                exported++;
                export_exd_data_concept_configuration(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_DIVE_SUMMARY:
            {
                exported++;
                export_dive_summary(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_HRV:
            {
                exported++;
                export_hrv(libData, data, idx, fp);
                break;
            }

            case FIT_MESG_NUM_WXF_EXPRESSION:
            {
                exported++;
                export_wxf_expression(libData, data, idx, fp);
                break;
            }
// --- END MESSAGE EXPORT CASES ---

            default:
                break;
        }
    }

	// FIT_DATE_TIME timestamp = 1000000000; // 2021-09-08T01:46:40-0600Z in seconds since the FIT Epoch of 1989-12-31T:00:00:00Z
	// FIT_DATE_TIME start_time = timestamp;

	// Write file id message.
	// {
	// 	FIT_UINT8 local_mesg_number = 0;
	// 	FIT_FILE_ID_MESG file_id_mesg;
	// 	Fit_InitMesg(fit_mesg_defs[FIT_MESG_FILE_ID], &file_id_mesg);

    //     file_id_mesg.serial_number = (FIT_UINT32Z) 12345;
	// 	file_id_mesg.time_created = timestamp;
    //     strcpy(file_id_mesg.product_name, "FITExport");
	// 	file_id_mesg.manufacturer = FIT_MANUFACTURER_DEVELOPMENT;
    //     file_id_mesg.product = (FIT_UINT16) 132;
	// 	file_id_mesg.type = FIT_FILE_ACTIVITY;
	// 	WriteMessageDefinition(local_mesg_number, fit_mesg_defs[FIT_MESG_FILE_ID], FIT_FILE_ID_MESG_DEF_SIZE, fp);
	// 	WriteMessage(local_mesg_number, &file_id_mesg, FIT_FILE_ID_MESG_SIZE, fp);
	// }

	// Write Device Info message.
	// {
	// 	FIT_UINT8 local_mesg_number = 0;
	// 	FIT_DEVICE_INFO_MESG device_info_mesg;
	// 	Fit_InitMesg(fit_mesg_defs[FIT_MESG_DEVICE_INFO], &device_info_mesg);

	// 	device_info_mesg.device_index = FIT_DEVICE_INDEX_CREATOR;
	// 	device_info_mesg.manufacturer = FIT_MANUFACTURER_DEVELOPMENT;
	// 	device_info_mesg.product = 0; // USE A UNIQUE ID FOR EACH OF YOUR PRODUCTS
	// 	strcpy(device_info_mesg.product_name, "FIT Cookbook"); // Max 20 Chars
	// 	device_info_mesg.serial_number = 123456;
	// 	device_info_mesg.software_version = 100; // 1.0 * 100
	// 	device_info_mesg.timestamp = timestamp;

	// 	WriteMessageDefinition(local_mesg_number, fit_mesg_defs[FIT_MESG_DEVICE_INFO], FIT_DEVICE_INFO_MESG_DEF_SIZE, fp);
	// 	WriteMessage(local_mesg_number, &device_info_mesg, FIT_DEVICE_INFO_MESG_SIZE, fp);
	// }

	// Write Event message - START Event
	// {
	// 	FIT_UINT8 local_mesg_number = 0;
	// 	FIT_EVENT_MESG event_mesg;
	// 	Fit_InitMesg(fit_mesg_defs[FIT_MESG_EVENT], &event_mesg);

	// 	event_mesg.timestamp = timestamp;
	// 	event_mesg.event = FIT_EVENT_TIMER;
	// 	event_mesg.event_type = FIT_EVENT_TYPE_START;

	// 	WriteMessageDefinition(local_mesg_number, fit_mesg_defs[FIT_MESG_EVENT], FIT_EVENT_MESG_DEF_SIZE, fp);
	// 	WriteMessage(local_mesg_number, &event_mesg, FIT_EVENT_MESG_SIZE, fp);
	// }

	// Write Record messages.

	//The message definition only needs to be written once.  
	// {
	// 	FIT_UINT8 local_mesg_number = 0;
	// 	WriteMessageDefinition(local_mesg_number, fit_mesg_defs[FIT_MESG_RECORD], FIT_RECORD_MESG_DEF_SIZE, fp);

	// 	for (int i = 0; i < 1; i++)
	// 	{
	// 		{
	// 			FIT_RECORD_MESG record_mesg;
	// 			Fit_InitMesg(fit_mesg_defs[FIT_MESG_RECORD], &record_mesg);

	// 			record_mesg.timestamp = timestamp;

	// 			// Fake Record Data of Various Signal Patterns
	// 			record_mesg.distance = i; // Ramp
	// 			record_mesg.speed = 1; // Flatline
	// 			record_mesg.heart_rate = ((FIT_UINT8)((sin(TWOPI * (0.01 * i + 10)) + 1.0) * 127.0)); // Sine
	// 			record_mesg.cadence = ((FIT_UINT8)(i % 255)); // Sawtooth
	// 			record_mesg.power = ((FIT_UINT16)((i % 255) < 127 ? 150 : 250)); // Square
	// 			record_mesg.enhanced_altitude = (FIT_UINT32)(((float)fabs(((float)(i % 255)) - 127.0f)) + 500) * 5; // Triangle
	// 			record_mesg.position_lat = 0;
	// 			record_mesg.position_long = ((FIT_SINT32)(i * SC_PER_M));

	// 			WriteMessage(local_mesg_number, &record_mesg, FIT_RECORD_MESG_SIZE, fp);

	// 			timestamp++;
	// 		}
	// 	}
	// }

	// Write Event message - STOP Event
	// {
	// 	FIT_UINT8 local_mesg_number = 0;
	// 	FIT_EVENT_MESG event_mesg;
	// 	Fit_InitMesg(fit_mesg_defs[FIT_MESG_EVENT], &event_mesg);

	// 	event_mesg.timestamp = timestamp;
	// 	event_mesg.event = FIT_EVENT_TIMER;
	// 	event_mesg.event_type = FIT_EVENT_TYPE_STOP;

	// 	WriteMessageDefinition(local_mesg_number, fit_mesg_defs[FIT_MESG_EVENT], FIT_EVENT_MESG_DEF_SIZE, fp);
	// 	WriteMessage(local_mesg_number, &event_mesg, FIT_EVENT_MESG_SIZE, fp);
	// }

	// Write Lap message.
	// {
	// 	FIT_UINT8 local_mesg_number = 0;
	// 	FIT_LAP_MESG lap_mesg;
	// 	Fit_InitMesg(fit_mesg_defs[FIT_MESG_LAP], &lap_mesg);

	// 	lap_mesg.message_index = 0;
	// 	lap_mesg.timestamp = timestamp;
	// 	lap_mesg.start_time = start_time;
	// 	lap_mesg.total_elapsed_time = (timestamp - start_time) * 1000;
	// 	lap_mesg.total_timer_time = (timestamp - start_time) * 1000;

	// 	WriteMessageDefinition(local_mesg_number, fit_mesg_defs[FIT_MESG_LAP], FIT_LAP_MESG_DEF_SIZE, fp);
	// 	WriteMessage(local_mesg_number, &lap_mesg, FIT_LAP_MESG_SIZE, fp);
	// }

	// Write Session message.
	// {
	// 	FIT_UINT8 local_mesg_number = 0;
	// 	FIT_SESSION_MESG session_mesg;
	// 	Fit_InitMesg(fit_mesg_defs[FIT_MESG_SESSION], &session_mesg);

	// 	session_mesg.message_index = 0;
	// 	session_mesg.timestamp = timestamp;
	// 	session_mesg.start_time = start_time;
	// 	session_mesg.total_elapsed_time = (timestamp - start_time) * 1000;
	// 	session_mesg.total_timer_time = (timestamp - start_time) * 1000;
	// 	session_mesg.sport = FIT_SPORT_STAND_UP_PADDLEBOARDING;
	// 	session_mesg.sub_sport = FIT_SUB_SPORT_GENERIC;
	// 	session_mesg.first_lap_index = 0;
	// 	session_mesg.num_laps = 1;

	// 	WriteMessageDefinition(local_mesg_number, fit_mesg_defs[FIT_MESG_SESSION], FIT_SESSION_MESG_DEF_SIZE, fp);
	// 	WriteMessage(local_mesg_number, &session_mesg, FIT_SESSION_MESG_SIZE, fp);
	// }

	// Write Activity message.
	// {
	// 	FIT_UINT8 local_mesg_number = 0;
	// 	FIT_ACTIVITY_MESG activity_mesg;
	// 	Fit_InitMesg(fit_mesg_defs[FIT_MESG_ACTIVITY], &activity_mesg);

	// 	activity_mesg.timestamp = timestamp;
	// 	activity_mesg.num_sessions = 1;
	// 	activity_mesg.total_timer_time = (timestamp - start_time) * 1000;

	// 	int timezoneOffset = -7 * 3600;
	// 	activity_mesg.local_timestamp = timestamp + timezoneOffset;

	// 	WriteMessageDefinition(local_mesg_number, fit_mesg_defs[FIT_MESG_ACTIVITY], FIT_ACTIVITY_MESG_DEF_SIZE, fp);
	// 	WriteMessage(local_mesg_number, &activity_mesg, FIT_ACTIVITY_MESG_SIZE, fp);
	// }

    MArgument_setInteger(Res, exported);

	// Write CRC.
	fwrite(&data_crc, 1, sizeof(FIT_UINT16), fp);

	// Update file header with data size.
	WriteFileHeader(fp);

	fclose(fp);

    
    return LIBRARY_NO_ERROR;
}

void WriteFileHeader(FILE *fp)
{
	FIT_FILE_HDR file_header;

	file_header.header_size = FIT_FILE_HDR_SIZE;
	file_header.profile_version = FIT_PROFILE_VERSION;
	file_header.protocol_version = FIT_PROTOCOL_VERSION_20;
	memcpy((FIT_UINT8 *)&file_header.data_type, ".FIT", 4);
	fseek(fp, 0, SEEK_END);
	file_header.data_size = ftell(fp) - FIT_FILE_HDR_SIZE - sizeof(FIT_UINT16);
	file_header.crc = FitCRC_Calc16(&file_header, FIT_STRUCT_OFFSET(crc, FIT_FILE_HDR));

	fseek(fp, 0, SEEK_SET);
	fwrite((void *)&file_header, 1, FIT_FILE_HDR_SIZE, fp);
}




void WriteMessageDefinition(FIT_MESG_NUM mesg_num, FIT_UINT8 local_mesg_number, const void *mesg_def_pointer, FIT_UINT16 mesg_def_size, FILE *fp)
{
    #if defined(REPEAT_MESSAGE_DEFINITIONS)
    WriteMessageDefinition0(local_mesg_number, mesg_def_pointer, mesg_def_size, fp);
    #else
    if (last_message == mesg_num) {
        return;
    } else {
        WriteMessageDefinition0(local_mesg_number, mesg_def_pointer, mesg_def_size, fp);
        last_message = mesg_num;
    }
    #endif
}

void WriteMessageDefinition0(FIT_UINT8 local_mesg_number, const void *mesg_def_pointer, FIT_UINT16 mesg_def_size, FILE *fp)
{
	FIT_UINT8 header = local_mesg_number | FIT_HDR_TYPE_DEF_BIT;
	WriteData(&header, FIT_HDR_SIZE, fp);
	WriteData(mesg_def_pointer, mesg_def_size, fp);
}

void WriteMessageDefinitionWithDevFields
(
	FIT_UINT8 local_mesg_number,
	const void *mesg_def_pointer,
	FIT_UINT8 mesg_def_size,
	FIT_UINT8 number_dev_fields,
	FIT_DEV_FIELD_DEF *dev_field_definitions,
	FILE *fp
)
{
	FIT_UINT16 i;
	FIT_UINT8 header = local_mesg_number | FIT_HDR_TYPE_DEF_BIT | FIT_HDR_DEV_DATA_BIT;
	WriteData(&header, FIT_HDR_SIZE, fp);
	WriteData(mesg_def_pointer, mesg_def_size, fp);

	WriteData(&number_dev_fields, sizeof(FIT_UINT8), fp);
	for (i = 0; i < number_dev_fields; i++)
	{
		WriteData(&dev_field_definitions[i], sizeof(FIT_DEV_FIELD_DEF), fp);
	}
}

void WriteMessage(FIT_UINT8 local_mesg_number, const void *mesg_pointer, FIT_UINT16 mesg_size, FILE *fp)
{
	WriteData(&local_mesg_number, FIT_HDR_SIZE, fp);
	WriteData(mesg_pointer, mesg_size, fp);
}

void WriteDeveloperField(const void *data, FIT_UINT16 data_size, FILE *fp)
{
	WriteData(data, data_size, fp);
}

void WriteData(const void *data, FIT_UINT16 data_size, FILE *fp)
{
	FIT_UINT16 offset;

	fwrite(data, 1, data_size, fp);

	for (offset = 0; offset < (data_size & 0xFF); offset++)
		data_crc = FitCRC_Get16(data_crc, *((FIT_UINT8 *)data + offset));
}




// --- START MESSAGE EXPORT FUNCTIONS ---
// This section is auto-generated. Do not edit manually.

static void export_file_id(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_FILE_ID_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_FILE_ID], &mesg);

    ExportInteger(3, libData, data, pos, mesg.serial_number);
    ExportTimestamp(4, libData, data, pos, mesg.time_created);
    ExportInteger(5, libData, data, pos, mesg.manufacturer);
    ExportInteger(6, libData, data, pos, mesg.product);
    ExportInteger(7, libData, data, pos, mesg.number);
    ExportInteger(8, libData, data, pos, mesg.type);
    ExportString(9, libData, data, pos, mesg.product_name, FIT_FILE_ID_MESG_PRODUCT_NAME_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_FILE_ID, local_mesg_number, fit_mesg_defs[FIT_MESG_FILE_ID], FIT_FILE_ID_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_FILE_ID_MESG_SIZE, fp);
}


static void export_file_creator(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_FILE_CREATOR_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_FILE_CREATOR], &mesg);

    ExportInteger(3, libData, data, pos, mesg.software_version);
    ExportInteger(4, libData, data, pos, mesg.hardware_version);

    WriteMessageDefinition(FIT_MESG_NUM_FILE_CREATOR, local_mesg_number, fit_mesg_defs[FIT_MESG_FILE_CREATOR], FIT_FILE_CREATOR_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_FILE_CREATOR_MESG_SIZE, fp);
}


static void export_timestamp_correlation(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_TIMESTAMP_CORRELATION_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_TIMESTAMP_CORRELATION], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportTimestamp(4, libData, data, pos, mesg.system_timestamp);
    ExportTimestamp(5, libData, data, pos, mesg.local_timestamp);
    ExportInteger(6, libData, data, pos, mesg.fractional_timestamp);
    ExportInteger(7, libData, data, pos, mesg.fractional_system_timestamp);
    ExportInteger(8, libData, data, pos, mesg.timestamp_ms);
    ExportInteger(9, libData, data, pos, mesg.system_timestamp_ms);

    WriteMessageDefinition(FIT_MESG_NUM_TIMESTAMP_CORRELATION, local_mesg_number, fit_mesg_defs[FIT_MESG_TIMESTAMP_CORRELATION], FIT_TIMESTAMP_CORRELATION_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_TIMESTAMP_CORRELATION_MESG_SIZE, fp);
}


static void export_software(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SOFTWARE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SOFTWARE], &mesg);

    ExportString(3, libData, data, pos, mesg.part_number, FIT_SOFTWARE_MESG_PART_NUMBER_COUNT);
    ExportInteger(19, libData, data, pos, mesg.message_index);
    ExportInteger(20, libData, data, pos, mesg.version);

    WriteMessageDefinition(FIT_MESG_NUM_SOFTWARE, local_mesg_number, fit_mesg_defs[FIT_MESG_SOFTWARE], FIT_SOFTWARE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SOFTWARE_MESG_SIZE, fp);
}


static void export_slave_device(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SLAVE_DEVICE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SLAVE_DEVICE], &mesg);

    ExportInteger(3, libData, data, pos, mesg.manufacturer);
    ExportInteger(4, libData, data, pos, mesg.product);

    WriteMessageDefinition(FIT_MESG_NUM_SLAVE_DEVICE, local_mesg_number, fit_mesg_defs[FIT_MESG_SLAVE_DEVICE], FIT_SLAVE_DEVICE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SLAVE_DEVICE_MESG_SIZE, fp);
}


static void export_capabilities(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_CAPABILITIES_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_CAPABILITIES], &mesg);

    ExportIntegerSequence(3, libData, data, pos, mesg.languages, FIT_CAPABILITIES_MESG_LANGUAGES_COUNT);
    ExportInteger(7, libData, data, pos, mesg.workouts_supported);
    ExportInteger(8, libData, data, pos, mesg.connectivity_supported);
    ExportIntegerSequence(9, libData, data, pos, mesg.sports, FIT_CAPABILITIES_MESG_SPORTS_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_CAPABILITIES, local_mesg_number, fit_mesg_defs[FIT_MESG_CAPABILITIES], FIT_CAPABILITIES_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_CAPABILITIES_MESG_SIZE, fp);
}


static void export_file_capabilities(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_FILE_CAPABILITIES_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_FILE_CAPABILITIES], &mesg);

    ExportString(3, libData, data, pos, mesg.directory, FIT_FILE_CAPABILITIES_MESG_DIRECTORY_COUNT);
    ExportInteger(19, libData, data, pos, mesg.max_size);
    ExportInteger(20, libData, data, pos, mesg.message_index);
    ExportInteger(21, libData, data, pos, mesg.max_count);
    ExportInteger(22, libData, data, pos, mesg.type);
    ExportInteger(23, libData, data, pos, mesg.flags);

    WriteMessageDefinition(FIT_MESG_NUM_FILE_CAPABILITIES, local_mesg_number, fit_mesg_defs[FIT_MESG_FILE_CAPABILITIES], FIT_FILE_CAPABILITIES_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_FILE_CAPABILITIES_MESG_SIZE, fp);
}


static void export_mesg_capabilities(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_MESG_CAPABILITIES_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_MESG_CAPABILITIES], &mesg);

    ExportInteger(3, libData, data, pos, mesg.message_index);
    ExportInteger(4, libData, data, pos, mesg.mesg_num);
    ExportInteger(5, libData, data, pos, mesg.count);
    ExportInteger(6, libData, data, pos, mesg.file);
    ExportInteger(7, libData, data, pos, mesg.count_type);

    WriteMessageDefinition(FIT_MESG_NUM_MESG_CAPABILITIES, local_mesg_number, fit_mesg_defs[FIT_MESG_MESG_CAPABILITIES], FIT_MESG_CAPABILITIES_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_MESG_CAPABILITIES_MESG_SIZE, fp);
}


static void export_field_capabilities(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_FIELD_CAPABILITIES_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_FIELD_CAPABILITIES], &mesg);

    ExportInteger(3, libData, data, pos, mesg.message_index);
    ExportInteger(4, libData, data, pos, mesg.mesg_num);
    ExportInteger(5, libData, data, pos, mesg.count);
    ExportInteger(6, libData, data, pos, mesg.file);
    ExportInteger(7, libData, data, pos, mesg.field_num);

    WriteMessageDefinition(FIT_MESG_NUM_FIELD_CAPABILITIES, local_mesg_number, fit_mesg_defs[FIT_MESG_FIELD_CAPABILITIES], FIT_FIELD_CAPABILITIES_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_FIELD_CAPABILITIES_MESG_SIZE, fp);
}


static void export_device_settings(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_DEVICE_SETTINGS_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_DEVICE_SETTINGS], &mesg);

    ExportInteger(3, libData, data, pos, mesg.utc_offset);
    ExportIntegerSequence(4, libData, data, pos, mesg.time_offset, FIT_DEVICE_SETTINGS_MESG_TIME_OFFSET_COUNT);
    ExportTimestamp(5, libData, data, pos, mesg.clock_time);
    ExportInteger(6, libData, data, pos, mesg.auto_activity_detect);
    ExportIntegerSequence(7, libData, data, pos, mesg.pages_enabled, FIT_DEVICE_SETTINGS_MESG_PAGES_ENABLED_COUNT);
    ExportIntegerSequence(8, libData, data, pos, mesg.default_page, FIT_DEVICE_SETTINGS_MESG_DEFAULT_PAGE_COUNT);
    ExportInteger(9, libData, data, pos, mesg.autosync_min_steps);
    ExportInteger(10, libData, data, pos, mesg.autosync_min_time);
    ExportInteger(11, libData, data, pos, mesg.active_time_zone);
    ExportIntegerSequence(12, libData, data, pos, mesg.time_mode, FIT_DEVICE_SETTINGS_MESG_TIME_MODE_COUNT);
    ExportIntegerSequence(13, libData, data, pos, mesg.time_zone_offset, FIT_DEVICE_SETTINGS_MESG_TIME_ZONE_OFFSET_COUNT);
    ExportInteger(14, libData, data, pos, mesg.backlight_mode);
    ExportInteger(15, libData, data, pos, mesg.activity_tracker_enabled);
    ExportInteger(16, libData, data, pos, mesg.move_alert_enabled);
    ExportInteger(17, libData, data, pos, mesg.date_mode);
    ExportInteger(18, libData, data, pos, mesg.display_orientation);
    ExportInteger(19, libData, data, pos, mesg.mounting_side);
    ExportInteger(20, libData, data, pos, mesg.lactate_threshold_autodetect_enabled);
    ExportInteger(21, libData, data, pos, mesg.ble_auto_upload_enabled);
    ExportInteger(22, libData, data, pos, mesg.auto_sync_frequency);
    ExportInteger(23, libData, data, pos, mesg.number_of_screens);
    ExportInteger(24, libData, data, pos, mesg.smart_notification_display_orientation);
    ExportInteger(25, libData, data, pos, mesg.tap_interface);
    ExportInteger(26, libData, data, pos, mesg.tap_sensitivity);

    WriteMessageDefinition(FIT_MESG_NUM_DEVICE_SETTINGS, local_mesg_number, fit_mesg_defs[FIT_MESG_DEVICE_SETTINGS], FIT_DEVICE_SETTINGS_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_DEVICE_SETTINGS_MESG_SIZE, fp);
}


static void export_user_profile(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_USER_PROFILE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_USER_PROFILE], &mesg);

    ExportString(3, libData, data, pos, mesg.friendly_name, FIT_USER_PROFILE_MESG_FRIENDLY_NAME_COUNT);
    ExportInteger(19, libData, data, pos, mesg.wake_time);
    ExportInteger(20, libData, data, pos, mesg.sleep_time);
    ExportInteger(21, libData, data, pos, mesg.dive_count);
    ExportInteger(22, libData, data, pos, mesg.message_index);
    ExportInteger(23, libData, data, pos, mesg.weight);
    ExportInteger(24, libData, data, pos, mesg.local_id);
    ExportInteger(25, libData, data, pos, mesg.user_running_step_length);
    ExportInteger(26, libData, data, pos, mesg.user_walking_step_length);
    ExportInteger(27, libData, data, pos, mesg.gender);
    ExportInteger(28, libData, data, pos, mesg.age);
    ExportInteger(29, libData, data, pos, mesg.height);
    ExportInteger(30, libData, data, pos, mesg.language);
    ExportInteger(31, libData, data, pos, mesg.elev_setting);
    ExportInteger(32, libData, data, pos, mesg.weight_setting);
    ExportInteger(33, libData, data, pos, mesg.resting_heart_rate);
    ExportInteger(34, libData, data, pos, mesg.default_max_running_heart_rate);
    ExportInteger(35, libData, data, pos, mesg.default_max_biking_heart_rate);
    ExportInteger(36, libData, data, pos, mesg.default_max_heart_rate);
    ExportInteger(37, libData, data, pos, mesg.hr_setting);
    ExportInteger(38, libData, data, pos, mesg.speed_setting);
    ExportInteger(39, libData, data, pos, mesg.dist_setting);
    ExportInteger(40, libData, data, pos, mesg.power_setting);
    ExportInteger(41, libData, data, pos, mesg.activity_class);
    ExportInteger(42, libData, data, pos, mesg.position_setting);
    ExportInteger(43, libData, data, pos, mesg.temperature_setting);
    ExportIntegerSequence(44, libData, data, pos, mesg.global_id, FIT_USER_PROFILE_MESG_GLOBAL_ID_COUNT);
    ExportInteger(50, libData, data, pos, mesg.height_setting);
    ExportInteger(51, libData, data, pos, mesg.depth_setting);

    WriteMessageDefinition(FIT_MESG_NUM_USER_PROFILE, local_mesg_number, fit_mesg_defs[FIT_MESG_USER_PROFILE], FIT_USER_PROFILE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_USER_PROFILE_MESG_SIZE, fp);
}


static void export_hrm_profile(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_HRM_PROFILE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_HRM_PROFILE], &mesg);

    ExportInteger(3, libData, data, pos, mesg.message_index);
    ExportInteger(4, libData, data, pos, mesg.hrm_ant_id);
    ExportInteger(5, libData, data, pos, mesg.enabled);
    ExportInteger(6, libData, data, pos, mesg.log_hrv);
    ExportInteger(7, libData, data, pos, mesg.hrm_ant_id_trans_type);

    WriteMessageDefinition(FIT_MESG_NUM_HRM_PROFILE, local_mesg_number, fit_mesg_defs[FIT_MESG_HRM_PROFILE], FIT_HRM_PROFILE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_HRM_PROFILE_MESG_SIZE, fp);
}


static void export_sdm_profile(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SDM_PROFILE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SDM_PROFILE], &mesg);

    ExportInteger(3, libData, data, pos, mesg.odometer);
    ExportInteger(4, libData, data, pos, mesg.message_index);
    ExportInteger(5, libData, data, pos, mesg.sdm_ant_id);
    ExportInteger(6, libData, data, pos, mesg.sdm_cal_factor);
    ExportInteger(7, libData, data, pos, mesg.enabled);
    ExportInteger(8, libData, data, pos, mesg.speed_source);
    ExportInteger(9, libData, data, pos, mesg.sdm_ant_id_trans_type);
    ExportInteger(10, libData, data, pos, mesg.odometer_rollover);

    WriteMessageDefinition(FIT_MESG_NUM_SDM_PROFILE, local_mesg_number, fit_mesg_defs[FIT_MESG_SDM_PROFILE], FIT_SDM_PROFILE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SDM_PROFILE_MESG_SIZE, fp);
}


static void export_bike_profile(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_BIKE_PROFILE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_BIKE_PROFILE], &mesg);

    ExportString(3, libData, data, pos, mesg.name, FIT_BIKE_PROFILE_MESG_NAME_COUNT);
    ExportInteger(35, libData, data, pos, mesg.odometer);
    ExportInteger(36, libData, data, pos, mesg.message_index);
    ExportInteger(37, libData, data, pos, mesg.bike_spd_ant_id);
    ExportInteger(38, libData, data, pos, mesg.bike_cad_ant_id);
    ExportInteger(39, libData, data, pos, mesg.bike_spdcad_ant_id);
    ExportInteger(40, libData, data, pos, mesg.bike_power_ant_id);
    ExportInteger(41, libData, data, pos, mesg.custom_wheelsize);
    ExportInteger(42, libData, data, pos, mesg.auto_wheelsize);
    ExportInteger(43, libData, data, pos, mesg.bike_weight);
    ExportInteger(44, libData, data, pos, mesg.power_cal_factor);
    ExportInteger(45, libData, data, pos, mesg.sport);
    ExportInteger(46, libData, data, pos, mesg.sub_sport);
    ExportInteger(47, libData, data, pos, mesg.auto_wheel_cal);
    ExportInteger(48, libData, data, pos, mesg.auto_power_zero);
    ExportInteger(49, libData, data, pos, mesg.id);
    ExportInteger(50, libData, data, pos, mesg.spd_enabled);
    ExportInteger(51, libData, data, pos, mesg.cad_enabled);
    ExportInteger(52, libData, data, pos, mesg.spdcad_enabled);
    ExportInteger(53, libData, data, pos, mesg.power_enabled);
    ExportInteger(54, libData, data, pos, mesg.crank_length);
    ExportInteger(55, libData, data, pos, mesg.enabled);
    ExportInteger(56, libData, data, pos, mesg.bike_spd_ant_id_trans_type);
    ExportInteger(57, libData, data, pos, mesg.bike_cad_ant_id_trans_type);
    ExportInteger(58, libData, data, pos, mesg.bike_spdcad_ant_id_trans_type);
    ExportInteger(59, libData, data, pos, mesg.bike_power_ant_id_trans_type);
    ExportInteger(60, libData, data, pos, mesg.odometer_rollover);
    ExportInteger(61, libData, data, pos, mesg.front_gear_num);
    ExportIntegerSequence(62, libData, data, pos, mesg.front_gear, FIT_BIKE_PROFILE_MESG_FRONT_GEAR_COUNT);
    ExportInteger(65, libData, data, pos, mesg.rear_gear_num);
    ExportIntegerSequence(66, libData, data, pos, mesg.rear_gear, FIT_BIKE_PROFILE_MESG_REAR_GEAR_COUNT);
    ExportInteger(81, libData, data, pos, mesg.shimano_di2_enabled);

    WriteMessageDefinition(FIT_MESG_NUM_BIKE_PROFILE, local_mesg_number, fit_mesg_defs[FIT_MESG_BIKE_PROFILE], FIT_BIKE_PROFILE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_BIKE_PROFILE_MESG_SIZE, fp);
}


static void export_connectivity(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_CONNECTIVITY_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_CONNECTIVITY], &mesg);

    ExportString(3, libData, data, pos, mesg.name, FIT_CONNECTIVITY_MESG_NAME_COUNT);
    ExportInteger(27, libData, data, pos, mesg.bluetooth_enabled);
    ExportInteger(28, libData, data, pos, mesg.bluetooth_le_enabled);
    ExportInteger(29, libData, data, pos, mesg.ant_enabled);
    ExportInteger(30, libData, data, pos, mesg.live_tracking_enabled);
    ExportInteger(31, libData, data, pos, mesg.weather_conditions_enabled);
    ExportInteger(32, libData, data, pos, mesg.weather_alerts_enabled);
    ExportInteger(33, libData, data, pos, mesg.auto_activity_upload_enabled);
    ExportInteger(34, libData, data, pos, mesg.course_download_enabled);
    ExportInteger(35, libData, data, pos, mesg.workout_download_enabled);
    ExportInteger(36, libData, data, pos, mesg.gps_ephemeris_download_enabled);
    ExportInteger(37, libData, data, pos, mesg.incident_detection_enabled);
    ExportInteger(38, libData, data, pos, mesg.grouptrack_enabled);

    WriteMessageDefinition(FIT_MESG_NUM_CONNECTIVITY, local_mesg_number, fit_mesg_defs[FIT_MESG_CONNECTIVITY], FIT_CONNECTIVITY_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_CONNECTIVITY_MESG_SIZE, fp);
}


static void export_watchface_settings(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_WATCHFACE_SETTINGS_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_WATCHFACE_SETTINGS], &mesg);

    ExportInteger(3, libData, data, pos, mesg.message_index);
    ExportInteger(4, libData, data, pos, mesg.mode);
    ExportInteger(5, libData, data, pos, mesg.layout);

    WriteMessageDefinition(FIT_MESG_NUM_WATCHFACE_SETTINGS, local_mesg_number, fit_mesg_defs[FIT_MESG_WATCHFACE_SETTINGS], FIT_WATCHFACE_SETTINGS_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_WATCHFACE_SETTINGS_MESG_SIZE, fp);
}


static void export_ohr_settings(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_OHR_SETTINGS_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_OHR_SETTINGS], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.enabled);

    WriteMessageDefinition(FIT_MESG_NUM_OHR_SETTINGS, local_mesg_number, fit_mesg_defs[FIT_MESG_OHR_SETTINGS], FIT_OHR_SETTINGS_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_OHR_SETTINGS_MESG_SIZE, fp);
}


static void export_zones_target(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_ZONES_TARGET_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_ZONES_TARGET], &mesg);

    ExportInteger(3, libData, data, pos, mesg.functional_threshold_power);
    ExportInteger(4, libData, data, pos, mesg.max_heart_rate);
    ExportInteger(5, libData, data, pos, mesg.threshold_heart_rate);
    ExportInteger(6, libData, data, pos, mesg.hr_calc_type);
    ExportInteger(7, libData, data, pos, mesg.pwr_calc_type);

    WriteMessageDefinition(FIT_MESG_NUM_ZONES_TARGET, local_mesg_number, fit_mesg_defs[FIT_MESG_ZONES_TARGET], FIT_ZONES_TARGET_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_ZONES_TARGET_MESG_SIZE, fp);
}


static void export_sport(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SPORT_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SPORT], &mesg);

    ExportString(3, libData, data, pos, mesg.name, FIT_SPORT_MESG_NAME_COUNT);
    ExportInteger(19, libData, data, pos, mesg.sport);
    ExportInteger(20, libData, data, pos, mesg.sub_sport);

    WriteMessageDefinition(FIT_MESG_NUM_SPORT, local_mesg_number, fit_mesg_defs[FIT_MESG_SPORT], FIT_SPORT_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SPORT_MESG_SIZE, fp);
}


static void export_hr_zone(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_HR_ZONE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_HR_ZONE], &mesg);

    ExportString(3, libData, data, pos, mesg.name, FIT_HR_ZONE_MESG_NAME_COUNT);
    ExportInteger(19, libData, data, pos, mesg.message_index);
    ExportInteger(20, libData, data, pos, mesg.high_bpm);

    WriteMessageDefinition(FIT_MESG_NUM_HR_ZONE, local_mesg_number, fit_mesg_defs[FIT_MESG_HR_ZONE], FIT_HR_ZONE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_HR_ZONE_MESG_SIZE, fp);
}


static void export_speed_zone(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SPEED_ZONE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SPEED_ZONE], &mesg);

    ExportString(3, libData, data, pos, mesg.name, FIT_SPEED_ZONE_MESG_NAME_COUNT);
    ExportInteger(19, libData, data, pos, mesg.message_index);
    ExportInteger(20, libData, data, pos, mesg.high_value);

    WriteMessageDefinition(FIT_MESG_NUM_SPEED_ZONE, local_mesg_number, fit_mesg_defs[FIT_MESG_SPEED_ZONE], FIT_SPEED_ZONE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SPEED_ZONE_MESG_SIZE, fp);
}


static void export_cadence_zone(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_CADENCE_ZONE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_CADENCE_ZONE], &mesg);

    ExportString(3, libData, data, pos, mesg.name, FIT_CADENCE_ZONE_MESG_NAME_COUNT);
    ExportInteger(19, libData, data, pos, mesg.message_index);
    ExportInteger(20, libData, data, pos, mesg.high_value);

    WriteMessageDefinition(FIT_MESG_NUM_CADENCE_ZONE, local_mesg_number, fit_mesg_defs[FIT_MESG_CADENCE_ZONE], FIT_CADENCE_ZONE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_CADENCE_ZONE_MESG_SIZE, fp);
}


static void export_power_zone(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_POWER_ZONE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_POWER_ZONE], &mesg);

    ExportString(3, libData, data, pos, mesg.name, FIT_POWER_ZONE_MESG_NAME_COUNT);
    ExportInteger(19, libData, data, pos, mesg.message_index);
    ExportInteger(20, libData, data, pos, mesg.high_value);

    WriteMessageDefinition(FIT_MESG_NUM_POWER_ZONE, local_mesg_number, fit_mesg_defs[FIT_MESG_POWER_ZONE], FIT_POWER_ZONE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_POWER_ZONE_MESG_SIZE, fp);
}


static void export_met_zone(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_MET_ZONE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_MET_ZONE], &mesg);

    ExportInteger(3, libData, data, pos, mesg.message_index);
    ExportInteger(4, libData, data, pos, mesg.calories);
    ExportInteger(5, libData, data, pos, mesg.high_bpm);
    ExportInteger(6, libData, data, pos, mesg.fat_calories);

    WriteMessageDefinition(FIT_MESG_NUM_MET_ZONE, local_mesg_number, fit_mesg_defs[FIT_MESG_MET_ZONE], FIT_MET_ZONE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_MET_ZONE_MESG_SIZE, fp);
}


static void export_dive_settings(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_DIVE_SETTINGS_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_DIVE_SETTINGS], &mesg);

    ExportString(3, libData, data, pos, mesg.name, FIT_DIVE_SETTINGS_MESG_NAME_COUNT);
    ExportFloat32(19, libData, data, pos, mesg.water_density);
    ExportFloat32(20, libData, data, pos, mesg.bottom_depth);
    ExportInteger(21, libData, data, pos, mesg.bottom_time);
    ExportInteger(22, libData, data, pos, mesg.apnea_countdown_time);
    ExportInteger(23, libData, data, pos, mesg.message_index);
    ExportInteger(24, libData, data, pos, mesg.repeat_dive_interval);
    ExportInteger(25, libData, data, pos, mesg.safety_stop_time);
    ExportInteger(26, libData, data, pos, mesg.model);
    ExportInteger(27, libData, data, pos, mesg.gf_low);
    ExportInteger(28, libData, data, pos, mesg.gf_high);
    ExportInteger(29, libData, data, pos, mesg.water_type);
    ExportInteger(30, libData, data, pos, mesg.po2_warn);
    ExportInteger(31, libData, data, pos, mesg.po2_critical);
    ExportInteger(32, libData, data, pos, mesg.po2_deco);
    ExportInteger(33, libData, data, pos, mesg.safety_stop_enabled);
    ExportInteger(34, libData, data, pos, mesg.apnea_countdown_enabled);
    ExportInteger(35, libData, data, pos, mesg.backlight_mode);
    ExportInteger(36, libData, data, pos, mesg.backlight_brightness);
    ExportInteger(37, libData, data, pos, mesg.backlight_timeout);
    ExportInteger(38, libData, data, pos, mesg.heart_rate_source_type);
    ExportInteger(39, libData, data, pos, mesg.heart_rate_source);

    WriteMessageDefinition(FIT_MESG_NUM_DIVE_SETTINGS, local_mesg_number, fit_mesg_defs[FIT_MESG_DIVE_SETTINGS], FIT_DIVE_SETTINGS_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_DIVE_SETTINGS_MESG_SIZE, fp);
}


static void export_dive_alarm(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_DIVE_ALARM_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_DIVE_ALARM], &mesg);

    ExportInteger(3, libData, data, pos, mesg.depth);
    ExportInteger(4, libData, data, pos, mesg.time);
    ExportInteger(5, libData, data, pos, mesg.message_index);
    ExportInteger(6, libData, data, pos, mesg.enabled);
    ExportInteger(7, libData, data, pos, mesg.alarm_type);
    ExportInteger(8, libData, data, pos, mesg.sound);
    ExportIntegerSequence(9, libData, data, pos, mesg.dive_types, FIT_DIVE_ALARM_MESG_DIVE_TYPES_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_DIVE_ALARM, local_mesg_number, fit_mesg_defs[FIT_MESG_DIVE_ALARM], FIT_DIVE_ALARM_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_DIVE_ALARM_MESG_SIZE, fp);
}


static void export_dive_gas(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_DIVE_GAS_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_DIVE_GAS], &mesg);

    ExportInteger(3, libData, data, pos, mesg.message_index);
    ExportInteger(4, libData, data, pos, mesg.helium_content);
    ExportInteger(5, libData, data, pos, mesg.oxygen_content);
    ExportInteger(6, libData, data, pos, mesg.status);

    WriteMessageDefinition(FIT_MESG_NUM_DIVE_GAS, local_mesg_number, fit_mesg_defs[FIT_MESG_DIVE_GAS], FIT_DIVE_GAS_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_DIVE_GAS_MESG_SIZE, fp);
}


static void export_goal(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_GOAL_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_GOAL], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.start_date);
    ExportTimestamp(4, libData, data, pos, mesg.end_date);
    ExportInteger(5, libData, data, pos, mesg.value);
    ExportInteger(6, libData, data, pos, mesg.target_value);
    ExportInteger(7, libData, data, pos, mesg.message_index);
    ExportInteger(8, libData, data, pos, mesg.recurrence_value);
    ExportInteger(9, libData, data, pos, mesg.sport);
    ExportInteger(10, libData, data, pos, mesg.sub_sport);
    ExportInteger(11, libData, data, pos, mesg.type);
    ExportInteger(12, libData, data, pos, mesg.repeat);
    ExportInteger(13, libData, data, pos, mesg.recurrence);
    ExportInteger(14, libData, data, pos, mesg.enabled);
    ExportInteger(15, libData, data, pos, mesg.source);

    WriteMessageDefinition(FIT_MESG_NUM_GOAL, local_mesg_number, fit_mesg_defs[FIT_MESG_GOAL], FIT_GOAL_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_GOAL_MESG_SIZE, fp);
}


static void export_activity(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_ACTIVITY_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_ACTIVITY], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.total_timer_time);
    ExportTimestamp(5, libData, data, pos, mesg.local_timestamp);
    ExportInteger(6, libData, data, pos, mesg.num_sessions);
    ExportInteger(7, libData, data, pos, mesg.type);
    ExportInteger(8, libData, data, pos, mesg.event);
    ExportInteger(9, libData, data, pos, mesg.event_type);
    ExportInteger(10, libData, data, pos, mesg.event_group);

    WriteMessageDefinition(FIT_MESG_NUM_ACTIVITY, local_mesg_number, fit_mesg_defs[FIT_MESG_ACTIVITY], FIT_ACTIVITY_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_ACTIVITY_MESG_SIZE, fp);
}


static void export_session(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SESSION_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SESSION], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportTimestamp(4, libData, data, pos, mesg.start_time);
    ExportInteger(5, libData, data, pos, mesg.start_position_lat);
    ExportInteger(6, libData, data, pos, mesg.start_position_long);
    ExportInteger(7, libData, data, pos, mesg.total_elapsed_time);
    ExportInteger(8, libData, data, pos, mesg.total_timer_time);
    ExportInteger(9, libData, data, pos, mesg.total_distance);
    ExportInteger(10, libData, data, pos, mesg.total_cycles);
    ExportInteger(11, libData, data, pos, mesg.nec_lat);
    ExportInteger(12, libData, data, pos, mesg.nec_long);
    ExportInteger(13, libData, data, pos, mesg.swc_lat);
    ExportInteger(14, libData, data, pos, mesg.swc_long);
    ExportInteger(15, libData, data, pos, mesg.avg_stroke_count);
    ExportInteger(16, libData, data, pos, mesg.total_work);
    ExportInteger(17, libData, data, pos, mesg.total_moving_time);
    ExportIntegerSequence(18, libData, data, pos, mesg.time_in_hr_zone, FIT_SESSION_MESG_TIME_IN_HR_ZONE_COUNT);
    ExportIntegerSequence(23, libData, data, pos, mesg.time_in_speed_zone, FIT_SESSION_MESG_TIME_IN_SPEED_ZONE_COUNT);
    ExportIntegerSequence(24, libData, data, pos, mesg.time_in_cadence_zone, FIT_SESSION_MESG_TIME_IN_CADENCE_ZONE_COUNT);
    ExportIntegerSequence(25, libData, data, pos, mesg.time_in_power_zone, FIT_SESSION_MESG_TIME_IN_POWER_ZONE_COUNT);
    ExportInteger(32, libData, data, pos, mesg.avg_lap_time);
    ExportString(33, libData, data, pos, mesg.opponent_name, FIT_SESSION_MESG_OPPONENT_NAME_COUNT);
    ExportInteger(49, libData, data, pos, mesg.time_standing);
    ExportIntegerSequence(50, libData, data, pos, mesg.avg_power_position, FIT_SESSION_MESG_AVG_POWER_POSITION_COUNT);
    ExportIntegerSequence(52, libData, data, pos, mesg.max_power_position, FIT_SESSION_MESG_MAX_POWER_POSITION_COUNT);
    ExportInteger(54, libData, data, pos, mesg.enhanced_avg_speed);
    ExportInteger(55, libData, data, pos, mesg.enhanced_max_speed);
    ExportInteger(56, libData, data, pos, mesg.enhanced_avg_altitude);
    ExportInteger(57, libData, data, pos, mesg.enhanced_min_altitude);
    ExportInteger(58, libData, data, pos, mesg.enhanced_max_altitude);
    ExportInteger(59, libData, data, pos, mesg.training_load_peak);
    ExportFloat32(60, libData, data, pos, mesg.total_grit);
    ExportFloat32(61, libData, data, pos, mesg.total_flow);
    ExportFloat32(62, libData, data, pos, mesg.avg_grit);
    ExportFloat32(63, libData, data, pos, mesg.avg_flow);
    ExportInteger(64, libData, data, pos, mesg.message_index);
    ExportInteger(65, libData, data, pos, mesg.total_calories);
    ExportInteger(66, libData, data, pos, mesg.total_fat_calories);
    ExportInteger(67, libData, data, pos, mesg.avg_speed);
    ExportInteger(68, libData, data, pos, mesg.max_speed);
    ExportInteger(69, libData, data, pos, mesg.avg_power);
    ExportInteger(70, libData, data, pos, mesg.max_power);
    ExportInteger(71, libData, data, pos, mesg.total_ascent);
    ExportInteger(72, libData, data, pos, mesg.total_descent);
    ExportInteger(73, libData, data, pos, mesg.first_lap_index);
    ExportInteger(74, libData, data, pos, mesg.num_laps);
    ExportInteger(75, libData, data, pos, mesg.num_lengths);
    ExportInteger(76, libData, data, pos, mesg.normalized_power);
    ExportInteger(77, libData, data, pos, mesg.training_stress_score);
    ExportInteger(78, libData, data, pos, mesg.intensity_factor);
    ExportInteger(79, libData, data, pos, mesg.left_right_balance);
    ExportInteger(80, libData, data, pos, mesg.avg_stroke_distance);
    ExportInteger(81, libData, data, pos, mesg.pool_length);
    ExportInteger(82, libData, data, pos, mesg.threshold_power);
    ExportInteger(83, libData, data, pos, mesg.num_active_lengths);
    ExportInteger(84, libData, data, pos, mesg.avg_altitude);
    ExportInteger(85, libData, data, pos, mesg.max_altitude);
    ExportInteger(86, libData, data, pos, mesg.avg_grade);
    ExportInteger(87, libData, data, pos, mesg.avg_pos_grade);
    ExportInteger(88, libData, data, pos, mesg.avg_neg_grade);
    ExportInteger(89, libData, data, pos, mesg.max_pos_grade);
    ExportInteger(90, libData, data, pos, mesg.max_neg_grade);
    ExportInteger(91, libData, data, pos, mesg.avg_pos_vertical_speed);
    ExportInteger(92, libData, data, pos, mesg.avg_neg_vertical_speed);
    ExportInteger(93, libData, data, pos, mesg.max_pos_vertical_speed);
    ExportInteger(94, libData, data, pos, mesg.max_neg_vertical_speed);
    ExportInteger(95, libData, data, pos, mesg.best_lap_index);
    ExportInteger(96, libData, data, pos, mesg.min_altitude);
    ExportInteger(97, libData, data, pos, mesg.player_score);
    ExportInteger(98, libData, data, pos, mesg.opponent_score);
    ExportIntegerSequence(99, libData, data, pos, mesg.stroke_count, FIT_SESSION_MESG_STROKE_COUNT_COUNT);
    ExportIntegerSequence(100, libData, data, pos, mesg.zone_count, FIT_SESSION_MESG_ZONE_COUNT_COUNT);
    ExportInteger(107, libData, data, pos, mesg.max_ball_speed);
    ExportInteger(108, libData, data, pos, mesg.avg_ball_speed);
    ExportInteger(109, libData, data, pos, mesg.avg_vertical_oscillation);
    ExportInteger(110, libData, data, pos, mesg.avg_stance_time_percent);
    ExportInteger(111, libData, data, pos, mesg.avg_stance_time);
    ExportIntegerSequence(112, libData, data, pos, mesg.avg_total_hemoglobin_conc, FIT_SESSION_MESG_AVG_TOTAL_HEMOGLOBIN_CONC_COUNT);
    ExportIntegerSequence(113, libData, data, pos, mesg.min_total_hemoglobin_conc, FIT_SESSION_MESG_MIN_TOTAL_HEMOGLOBIN_CONC_COUNT);
    ExportIntegerSequence(114, libData, data, pos, mesg.max_total_hemoglobin_conc, FIT_SESSION_MESG_MAX_TOTAL_HEMOGLOBIN_CONC_COUNT);
    ExportIntegerSequence(115, libData, data, pos, mesg.avg_saturated_hemoglobin_percent, FIT_SESSION_MESG_AVG_SATURATED_HEMOGLOBIN_PERCENT_COUNT);
    ExportIntegerSequence(116, libData, data, pos, mesg.min_saturated_hemoglobin_percent, FIT_SESSION_MESG_MIN_SATURATED_HEMOGLOBIN_PERCENT_COUNT);
    ExportIntegerSequence(117, libData, data, pos, mesg.max_saturated_hemoglobin_percent, FIT_SESSION_MESG_MAX_SATURATED_HEMOGLOBIN_PERCENT_COUNT);
    ExportInteger(118, libData, data, pos, mesg.stand_count);
    ExportInteger(119, libData, data, pos, mesg.avg_lev_motor_power);
    ExportInteger(120, libData, data, pos, mesg.max_lev_motor_power);
    ExportInteger(121, libData, data, pos, mesg.avg_vertical_ratio);
    ExportInteger(122, libData, data, pos, mesg.avg_stance_time_balance);
    ExportInteger(123, libData, data, pos, mesg.avg_step_length);
    ExportInteger(124, libData, data, pos, mesg.avg_vam);
    ExportInteger(125, libData, data, pos, mesg.jump_count);
    ExportInteger(126, libData, data, pos, mesg.avg_core_temperature);
    ExportInteger(127, libData, data, pos, mesg.min_core_temperature);
    ExportInteger(128, libData, data, pos, mesg.max_core_temperature);
    ExportInteger(129, libData, data, pos, mesg.event);
    ExportInteger(130, libData, data, pos, mesg.event_type);
    ExportInteger(131, libData, data, pos, mesg.sport);
    ExportInteger(132, libData, data, pos, mesg.sub_sport);
    ExportInteger(133, libData, data, pos, mesg.avg_heart_rate);
    ExportInteger(134, libData, data, pos, mesg.max_heart_rate);
    ExportInteger(135, libData, data, pos, mesg.avg_cadence);
    ExportInteger(136, libData, data, pos, mesg.max_cadence);
    ExportInteger(137, libData, data, pos, mesg.total_training_effect);
    ExportInteger(138, libData, data, pos, mesg.event_group);
    ExportInteger(139, libData, data, pos, mesg.trigger);
    ExportInteger(140, libData, data, pos, mesg.swim_stroke);
    ExportInteger(141, libData, data, pos, mesg.pool_length_unit);
    ExportInteger(142, libData, data, pos, mesg.gps_accuracy);
    ExportInteger(143, libData, data, pos, mesg.avg_temperature);
    ExportInteger(144, libData, data, pos, mesg.max_temperature);
    ExportInteger(145, libData, data, pos, mesg.min_heart_rate);
    ExportInteger(146, libData, data, pos, mesg.avg_fractional_cadence);
    ExportInteger(147, libData, data, pos, mesg.max_fractional_cadence);
    ExportInteger(148, libData, data, pos, mesg.total_fractional_cycles);
    ExportInteger(149, libData, data, pos, mesg.avg_left_torque_effectiveness);
    ExportInteger(150, libData, data, pos, mesg.avg_right_torque_effectiveness);
    ExportInteger(151, libData, data, pos, mesg.avg_left_pedal_smoothness);
    ExportInteger(152, libData, data, pos, mesg.avg_right_pedal_smoothness);
    ExportInteger(153, libData, data, pos, mesg.avg_combined_pedal_smoothness);
    ExportInteger(154, libData, data, pos, mesg.sport_index);
    ExportInteger(155, libData, data, pos, mesg.avg_left_pco);
    ExportInteger(156, libData, data, pos, mesg.avg_right_pco);
    ExportIntegerSequence(157, libData, data, pos, mesg.avg_left_power_phase, FIT_SESSION_MESG_AVG_LEFT_POWER_PHASE_COUNT);
    ExportIntegerSequence(159, libData, data, pos, mesg.avg_left_power_phase_peak, FIT_SESSION_MESG_AVG_LEFT_POWER_PHASE_PEAK_COUNT);
    ExportIntegerSequence(161, libData, data, pos, mesg.avg_right_power_phase, FIT_SESSION_MESG_AVG_RIGHT_POWER_PHASE_COUNT);
    ExportIntegerSequence(163, libData, data, pos, mesg.avg_right_power_phase_peak, FIT_SESSION_MESG_AVG_RIGHT_POWER_PHASE_PEAK_COUNT);
    ExportIntegerSequence(165, libData, data, pos, mesg.avg_cadence_position, FIT_SESSION_MESG_AVG_CADENCE_POSITION_COUNT);
    ExportIntegerSequence(167, libData, data, pos, mesg.max_cadence_position, FIT_SESSION_MESG_MAX_CADENCE_POSITION_COUNT);
    ExportInteger(169, libData, data, pos, mesg.lev_battery_consumption);
    ExportInteger(170, libData, data, pos, mesg.total_anaerobic_training_effect);
    ExportInteger(171, libData, data, pos, mesg.total_fractional_ascent);
    ExportInteger(172, libData, data, pos, mesg.total_fractional_descent);

    WriteMessageDefinition(FIT_MESG_NUM_SESSION, local_mesg_number, fit_mesg_defs[FIT_MESG_SESSION], FIT_SESSION_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SESSION_MESG_SIZE, fp);
}


static void export_lap(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_LAP_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_LAP], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportTimestamp(4, libData, data, pos, mesg.start_time);
    ExportInteger(5, libData, data, pos, mesg.start_position_lat);
    ExportInteger(6, libData, data, pos, mesg.start_position_long);
    ExportInteger(7, libData, data, pos, mesg.end_position_lat);
    ExportInteger(8, libData, data, pos, mesg.end_position_long);
    ExportInteger(9, libData, data, pos, mesg.total_elapsed_time);
    ExportInteger(10, libData, data, pos, mesg.total_timer_time);
    ExportInteger(11, libData, data, pos, mesg.total_distance);
    ExportInteger(12, libData, data, pos, mesg.total_cycles);
    ExportInteger(13, libData, data, pos, mesg.total_work);
    ExportInteger(14, libData, data, pos, mesg.total_moving_time);
    ExportIntegerSequence(15, libData, data, pos, mesg.time_in_hr_zone, FIT_LAP_MESG_TIME_IN_HR_ZONE_COUNT);
    ExportIntegerSequence(20, libData, data, pos, mesg.time_in_speed_zone, FIT_LAP_MESG_TIME_IN_SPEED_ZONE_COUNT);
    ExportIntegerSequence(21, libData, data, pos, mesg.time_in_cadence_zone, FIT_LAP_MESG_TIME_IN_CADENCE_ZONE_COUNT);
    ExportIntegerSequence(22, libData, data, pos, mesg.time_in_power_zone, FIT_LAP_MESG_TIME_IN_POWER_ZONE_COUNT);
    ExportInteger(29, libData, data, pos, mesg.time_standing);
    ExportInteger(30, libData, data, pos, mesg.enhanced_avg_speed);
    ExportInteger(31, libData, data, pos, mesg.enhanced_max_speed);
    ExportInteger(32, libData, data, pos, mesg.enhanced_avg_altitude);
    ExportInteger(33, libData, data, pos, mesg.enhanced_min_altitude);
    ExportInteger(34, libData, data, pos, mesg.enhanced_max_altitude);
    ExportFloat32(35, libData, data, pos, mesg.total_grit);
    ExportFloat32(36, libData, data, pos, mesg.total_flow);
    ExportFloat32(37, libData, data, pos, mesg.avg_grit);
    ExportFloat32(38, libData, data, pos, mesg.avg_flow);
    ExportInteger(39, libData, data, pos, mesg.message_index);
    ExportInteger(40, libData, data, pos, mesg.total_calories);
    ExportInteger(41, libData, data, pos, mesg.total_fat_calories);
    ExportInteger(42, libData, data, pos, mesg.avg_speed);
    ExportInteger(43, libData, data, pos, mesg.max_speed);
    ExportInteger(44, libData, data, pos, mesg.avg_power);
    ExportInteger(45, libData, data, pos, mesg.max_power);
    ExportInteger(46, libData, data, pos, mesg.total_ascent);
    ExportInteger(47, libData, data, pos, mesg.total_descent);
    ExportInteger(48, libData, data, pos, mesg.num_lengths);
    ExportInteger(49, libData, data, pos, mesg.normalized_power);
    ExportInteger(50, libData, data, pos, mesg.left_right_balance);
    ExportInteger(51, libData, data, pos, mesg.first_length_index);
    ExportInteger(52, libData, data, pos, mesg.avg_stroke_distance);
    ExportInteger(53, libData, data, pos, mesg.num_active_lengths);
    ExportInteger(54, libData, data, pos, mesg.avg_altitude);
    ExportInteger(55, libData, data, pos, mesg.max_altitude);
    ExportInteger(56, libData, data, pos, mesg.avg_grade);
    ExportInteger(57, libData, data, pos, mesg.avg_pos_grade);
    ExportInteger(58, libData, data, pos, mesg.avg_neg_grade);
    ExportInteger(59, libData, data, pos, mesg.max_pos_grade);
    ExportInteger(60, libData, data, pos, mesg.max_neg_grade);
    ExportInteger(61, libData, data, pos, mesg.avg_pos_vertical_speed);
    ExportInteger(62, libData, data, pos, mesg.avg_neg_vertical_speed);
    ExportInteger(63, libData, data, pos, mesg.max_pos_vertical_speed);
    ExportInteger(64, libData, data, pos, mesg.max_neg_vertical_speed);
    ExportInteger(65, libData, data, pos, mesg.repetition_num);
    ExportInteger(66, libData, data, pos, mesg.min_altitude);
    ExportInteger(67, libData, data, pos, mesg.wkt_step_index);
    ExportInteger(68, libData, data, pos, mesg.opponent_score);
    ExportIntegerSequence(69, libData, data, pos, mesg.stroke_count, FIT_LAP_MESG_STROKE_COUNT_COUNT);
    ExportIntegerSequence(70, libData, data, pos, mesg.zone_count, FIT_LAP_MESG_ZONE_COUNT_COUNT);
    ExportInteger(77, libData, data, pos, mesg.avg_vertical_oscillation);
    ExportInteger(78, libData, data, pos, mesg.avg_stance_time_percent);
    ExportInteger(79, libData, data, pos, mesg.avg_stance_time);
    ExportInteger(80, libData, data, pos, mesg.player_score);
    ExportIntegerSequence(81, libData, data, pos, mesg.avg_total_hemoglobin_conc, FIT_LAP_MESG_AVG_TOTAL_HEMOGLOBIN_CONC_COUNT);
    ExportIntegerSequence(82, libData, data, pos, mesg.min_total_hemoglobin_conc, FIT_LAP_MESG_MIN_TOTAL_HEMOGLOBIN_CONC_COUNT);
    ExportIntegerSequence(83, libData, data, pos, mesg.max_total_hemoglobin_conc, FIT_LAP_MESG_MAX_TOTAL_HEMOGLOBIN_CONC_COUNT);
    ExportIntegerSequence(84, libData, data, pos, mesg.avg_saturated_hemoglobin_percent, FIT_LAP_MESG_AVG_SATURATED_HEMOGLOBIN_PERCENT_COUNT);
    ExportIntegerSequence(85, libData, data, pos, mesg.min_saturated_hemoglobin_percent, FIT_LAP_MESG_MIN_SATURATED_HEMOGLOBIN_PERCENT_COUNT);
    ExportIntegerSequence(86, libData, data, pos, mesg.max_saturated_hemoglobin_percent, FIT_LAP_MESG_MAX_SATURATED_HEMOGLOBIN_PERCENT_COUNT);
    ExportInteger(87, libData, data, pos, mesg.stand_count);
    ExportIntegerSequence(88, libData, data, pos, mesg.avg_power_position, FIT_LAP_MESG_AVG_POWER_POSITION_COUNT);
    ExportIntegerSequence(89, libData, data, pos, mesg.max_power_position, FIT_LAP_MESG_MAX_POWER_POSITION_COUNT);
    ExportInteger(90, libData, data, pos, mesg.avg_lev_motor_power);
    ExportInteger(91, libData, data, pos, mesg.max_lev_motor_power);
    ExportInteger(92, libData, data, pos, mesg.avg_vertical_ratio);
    ExportInteger(93, libData, data, pos, mesg.avg_stance_time_balance);
    ExportInteger(94, libData, data, pos, mesg.avg_step_length);
    ExportInteger(95, libData, data, pos, mesg.avg_vam);
    ExportInteger(96, libData, data, pos, mesg.jump_count);
    ExportInteger(97, libData, data, pos, mesg.avg_core_temperature);
    ExportInteger(98, libData, data, pos, mesg.min_core_temperature);
    ExportInteger(99, libData, data, pos, mesg.max_core_temperature);
    ExportInteger(100, libData, data, pos, mesg.event);
    ExportInteger(101, libData, data, pos, mesg.event_type);
    ExportInteger(102, libData, data, pos, mesg.avg_heart_rate);
    ExportInteger(103, libData, data, pos, mesg.max_heart_rate);
    ExportInteger(104, libData, data, pos, mesg.avg_cadence);
    ExportInteger(105, libData, data, pos, mesg.max_cadence);
    ExportInteger(106, libData, data, pos, mesg.intensity);
    ExportInteger(107, libData, data, pos, mesg.lap_trigger);
    ExportInteger(108, libData, data, pos, mesg.sport);
    ExportInteger(109, libData, data, pos, mesg.event_group);
    ExportInteger(110, libData, data, pos, mesg.swim_stroke);
    ExportInteger(111, libData, data, pos, mesg.sub_sport);
    ExportInteger(112, libData, data, pos, mesg.gps_accuracy);
    ExportInteger(113, libData, data, pos, mesg.avg_temperature);
    ExportInteger(114, libData, data, pos, mesg.max_temperature);
    ExportInteger(115, libData, data, pos, mesg.min_heart_rate);
    ExportInteger(116, libData, data, pos, mesg.avg_fractional_cadence);
    ExportInteger(117, libData, data, pos, mesg.max_fractional_cadence);
    ExportInteger(118, libData, data, pos, mesg.total_fractional_cycles);
    ExportInteger(119, libData, data, pos, mesg.avg_left_torque_effectiveness);
    ExportInteger(120, libData, data, pos, mesg.avg_right_torque_effectiveness);
    ExportInteger(121, libData, data, pos, mesg.avg_left_pedal_smoothness);
    ExportInteger(122, libData, data, pos, mesg.avg_right_pedal_smoothness);
    ExportInteger(123, libData, data, pos, mesg.avg_combined_pedal_smoothness);
    ExportInteger(124, libData, data, pos, mesg.avg_left_pco);
    ExportInteger(125, libData, data, pos, mesg.avg_right_pco);
    ExportIntegerSequence(126, libData, data, pos, mesg.avg_left_power_phase, FIT_LAP_MESG_AVG_LEFT_POWER_PHASE_COUNT);
    ExportIntegerSequence(127, libData, data, pos, mesg.avg_left_power_phase_peak, FIT_LAP_MESG_AVG_LEFT_POWER_PHASE_PEAK_COUNT);
    ExportIntegerSequence(128, libData, data, pos, mesg.avg_right_power_phase, FIT_LAP_MESG_AVG_RIGHT_POWER_PHASE_COUNT);
    ExportIntegerSequence(129, libData, data, pos, mesg.avg_right_power_phase_peak, FIT_LAP_MESG_AVG_RIGHT_POWER_PHASE_PEAK_COUNT);
    ExportIntegerSequence(130, libData, data, pos, mesg.avg_cadence_position, FIT_LAP_MESG_AVG_CADENCE_POSITION_COUNT);
    ExportIntegerSequence(131, libData, data, pos, mesg.max_cadence_position, FIT_LAP_MESG_MAX_CADENCE_POSITION_COUNT);
    ExportInteger(132, libData, data, pos, mesg.lev_battery_consumption);
    ExportInteger(133, libData, data, pos, mesg.total_fractional_ascent);
    ExportInteger(134, libData, data, pos, mesg.total_fractional_descent);

    WriteMessageDefinition(FIT_MESG_NUM_LAP, local_mesg_number, fit_mesg_defs[FIT_MESG_LAP], FIT_LAP_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_LAP_MESG_SIZE, fp);
}


static void export_length(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_LENGTH_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_LENGTH], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportTimestamp(4, libData, data, pos, mesg.start_time);
    ExportInteger(5, libData, data, pos, mesg.total_elapsed_time);
    ExportInteger(6, libData, data, pos, mesg.total_timer_time);
    ExportInteger(7, libData, data, pos, mesg.message_index);
    ExportInteger(8, libData, data, pos, mesg.total_strokes);
    ExportInteger(9, libData, data, pos, mesg.avg_speed);
    ExportInteger(10, libData, data, pos, mesg.total_calories);
    ExportInteger(11, libData, data, pos, mesg.player_score);
    ExportInteger(12, libData, data, pos, mesg.opponent_score);
    ExportIntegerSequence(13, libData, data, pos, mesg.stroke_count, FIT_LENGTH_MESG_STROKE_COUNT_COUNT);
    ExportIntegerSequence(14, libData, data, pos, mesg.zone_count, FIT_LENGTH_MESG_ZONE_COUNT_COUNT);
    ExportInteger(21, libData, data, pos, mesg.event);
    ExportInteger(22, libData, data, pos, mesg.event_type);
    ExportInteger(23, libData, data, pos, mesg.swim_stroke);
    ExportInteger(24, libData, data, pos, mesg.avg_swimming_cadence);
    ExportInteger(25, libData, data, pos, mesg.event_group);
    ExportInteger(26, libData, data, pos, mesg.length_type);

    WriteMessageDefinition(FIT_MESG_NUM_LENGTH, local_mesg_number, fit_mesg_defs[FIT_MESG_LENGTH], FIT_LENGTH_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_LENGTH_MESG_SIZE, fp);
}


static void export_record(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_RECORD_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_RECORD], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.position_lat);
    ExportInteger(5, libData, data, pos, mesg.position_long);
    ExportInteger(6, libData, data, pos, mesg.distance);
    ExportInteger(7, libData, data, pos, mesg.time_from_course);
    ExportInteger(8, libData, data, pos, mesg.total_cycles);
    ExportInteger(9, libData, data, pos, mesg.accumulated_power);
    ExportInteger(10, libData, data, pos, mesg.enhanced_speed);
    ExportInteger(11, libData, data, pos, mesg.enhanced_altitude);
    ExportInteger(12, libData, data, pos, mesg.absolute_pressure);
    ExportInteger(13, libData, data, pos, mesg.depth);
    ExportInteger(14, libData, data, pos, mesg.next_stop_depth);
    ExportInteger(15, libData, data, pos, mesg.next_stop_time);
    ExportInteger(16, libData, data, pos, mesg.time_to_surface);
    ExportInteger(17, libData, data, pos, mesg.ndl_time);
    ExportFloat32(18, libData, data, pos, mesg.grit);
    ExportFloat32(19, libData, data, pos, mesg.flow);
    ExportInteger(20, libData, data, pos, mesg.altitude);
    ExportInteger(21, libData, data, pos, mesg.speed);
    ExportInteger(22, libData, data, pos, mesg.power);
    ExportInteger(23, libData, data, pos, mesg.grade);
    ExportInteger(24, libData, data, pos, mesg.compressed_accumulated_power);
    ExportInteger(25, libData, data, pos, mesg.vertical_speed);
    ExportInteger(26, libData, data, pos, mesg.calories);
    ExportInteger(27, libData, data, pos, mesg.vertical_oscillation);
    ExportInteger(28, libData, data, pos, mesg.stance_time_percent);
    ExportInteger(29, libData, data, pos, mesg.stance_time);
    ExportInteger(30, libData, data, pos, mesg.ball_speed);
    ExportInteger(31, libData, data, pos, mesg.cadence256);
    ExportInteger(32, libData, data, pos, mesg.total_hemoglobin_conc);
    ExportInteger(33, libData, data, pos, mesg.total_hemoglobin_conc_min);
    ExportInteger(34, libData, data, pos, mesg.total_hemoglobin_conc_max);
    ExportInteger(35, libData, data, pos, mesg.saturated_hemoglobin_percent);
    ExportInteger(36, libData, data, pos, mesg.saturated_hemoglobin_percent_min);
    ExportInteger(37, libData, data, pos, mesg.saturated_hemoglobin_percent_max);
    ExportInteger(38, libData, data, pos, mesg.motor_power);
    ExportInteger(39, libData, data, pos, mesg.vertical_ratio);
    ExportInteger(40, libData, data, pos, mesg.stance_time_balance);
    ExportInteger(41, libData, data, pos, mesg.step_length);
    ExportInteger(42, libData, data, pos, mesg.n2_load);
    ExportInteger(43, libData, data, pos, mesg.ebike_travel_range);
    ExportInteger(44, libData, data, pos, mesg.core_temperature);
    ExportInteger(45, libData, data, pos, mesg.heart_rate);
    ExportInteger(46, libData, data, pos, mesg.cadence);
    ExportIntegerSequence(47, libData, data, pos, mesg.compressed_speed_distance, FIT_RECORD_MESG_COMPRESSED_SPEED_DISTANCE_COUNT);
    ExportInteger(50, libData, data, pos, mesg.resistance);
    ExportInteger(51, libData, data, pos, mesg.cycle_length);
    ExportInteger(52, libData, data, pos, mesg.temperature);
    ExportIntegerSequence(53, libData, data, pos, mesg.speed_1s, FIT_RECORD_MESG_SPEED_1S_COUNT);
    ExportInteger(58, libData, data, pos, mesg.cycles);
    ExportInteger(59, libData, data, pos, mesg.left_right_balance);
    ExportInteger(60, libData, data, pos, mesg.gps_accuracy);
    ExportInteger(61, libData, data, pos, mesg.activity_type);
    ExportInteger(62, libData, data, pos, mesg.left_torque_effectiveness);
    ExportInteger(63, libData, data, pos, mesg.right_torque_effectiveness);
    ExportInteger(64, libData, data, pos, mesg.left_pedal_smoothness);
    ExportInteger(65, libData, data, pos, mesg.right_pedal_smoothness);
    ExportInteger(66, libData, data, pos, mesg.combined_pedal_smoothness);
    ExportInteger(67, libData, data, pos, mesg.time128);
    ExportInteger(68, libData, data, pos, mesg.stroke_type);
    ExportInteger(69, libData, data, pos, mesg.zone);
    ExportInteger(70, libData, data, pos, mesg.fractional_cadence);
    ExportInteger(71, libData, data, pos, mesg.device_index);
    ExportInteger(72, libData, data, pos, mesg.left_pco);
    ExportInteger(73, libData, data, pos, mesg.right_pco);
    ExportIntegerSequence(74, libData, data, pos, mesg.left_power_phase, FIT_RECORD_MESG_LEFT_POWER_PHASE_COUNT);
    ExportIntegerSequence(76, libData, data, pos, mesg.left_power_phase_peak, FIT_RECORD_MESG_LEFT_POWER_PHASE_PEAK_COUNT);
    ExportIntegerSequence(78, libData, data, pos, mesg.right_power_phase, FIT_RECORD_MESG_RIGHT_POWER_PHASE_COUNT);
    ExportIntegerSequence(80, libData, data, pos, mesg.right_power_phase_peak, FIT_RECORD_MESG_RIGHT_POWER_PHASE_PEAK_COUNT);
    ExportInteger(82, libData, data, pos, mesg.battery_soc);
    ExportInteger(83, libData, data, pos, mesg.cns_load);
    ExportInteger(84, libData, data, pos, mesg.ebike_battery_level);
    ExportInteger(85, libData, data, pos, mesg.ebike_assist_mode);
    ExportInteger(86, libData, data, pos, mesg.ebike_assist_level_percent);

    WriteMessageDefinition(FIT_MESG_NUM_RECORD, local_mesg_number, fit_mesg_defs[FIT_MESG_RECORD], FIT_RECORD_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_RECORD_MESG_SIZE, fp);
}


static void export_event(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_EVENT_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_EVENT], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.data);
    ExportInteger(5, libData, data, pos, mesg.data16);
    ExportInteger(6, libData, data, pos, mesg.score);
    ExportInteger(7, libData, data, pos, mesg.opponent_score);
    ExportInteger(8, libData, data, pos, mesg.event);
    ExportInteger(9, libData, data, pos, mesg.event_type);
    ExportInteger(10, libData, data, pos, mesg.event_group);
    ExportInteger(11, libData, data, pos, mesg.front_gear_num);
    ExportInteger(12, libData, data, pos, mesg.front_gear);
    ExportInteger(13, libData, data, pos, mesg.rear_gear_num);
    ExportInteger(14, libData, data, pos, mesg.rear_gear);
    ExportInteger(15, libData, data, pos, mesg.device_index);
    ExportInteger(16, libData, data, pos, mesg.radar_threat_level_max);
    ExportInteger(17, libData, data, pos, mesg.radar_threat_count);
    ExportInteger(18, libData, data, pos, mesg.radar_threat_avg_approach_speed);
    ExportInteger(19, libData, data, pos, mesg.radar_threat_max_approach_speed);

    WriteMessageDefinition(FIT_MESG_NUM_EVENT, local_mesg_number, fit_mesg_defs[FIT_MESG_EVENT], FIT_EVENT_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_EVENT_MESG_SIZE, fp);
}


static void export_device_info(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_DEVICE_INFO_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_DEVICE_INFO], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.serial_number);
    ExportInteger(5, libData, data, pos, mesg.cum_operating_time);
    ExportString(6, libData, data, pos, mesg.descriptor, FIT_DEVICE_INFO_MESG_DESCRIPTOR_COUNT);
    ExportString(26, libData, data, pos, mesg.product_name, FIT_DEVICE_INFO_MESG_PRODUCT_NAME_COUNT);
    ExportInteger(46, libData, data, pos, mesg.manufacturer);
    ExportInteger(47, libData, data, pos, mesg.product);
    ExportInteger(48, libData, data, pos, mesg.software_version);
    ExportInteger(49, libData, data, pos, mesg.battery_voltage);
    ExportInteger(50, libData, data, pos, mesg.ant_device_number);
    ExportInteger(51, libData, data, pos, mesg.device_index);
    ExportInteger(52, libData, data, pos, mesg.device_type);
    ExportInteger(53, libData, data, pos, mesg.hardware_version);
    ExportInteger(54, libData, data, pos, mesg.battery_status);
    ExportInteger(55, libData, data, pos, mesg.sensor_position);
    ExportInteger(56, libData, data, pos, mesg.ant_transmission_type);
    ExportInteger(57, libData, data, pos, mesg.ant_network);
    ExportInteger(58, libData, data, pos, mesg.source_type);
    ExportInteger(59, libData, data, pos, mesg.battery_level);

    WriteMessageDefinition(FIT_MESG_NUM_DEVICE_INFO, local_mesg_number, fit_mesg_defs[FIT_MESG_DEVICE_INFO], FIT_DEVICE_INFO_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_DEVICE_INFO_MESG_SIZE, fp);
}


static void export_device_aux_battery_info(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_DEVICE_AUX_BATTERY_INFO_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_DEVICE_AUX_BATTERY_INFO], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.battery_voltage);
    ExportInteger(5, libData, data, pos, mesg.device_index);
    ExportInteger(6, libData, data, pos, mesg.battery_status);
    ExportInteger(7, libData, data, pos, mesg.battery_identifier);

    WriteMessageDefinition(FIT_MESG_NUM_DEVICE_AUX_BATTERY_INFO, local_mesg_number, fit_mesg_defs[FIT_MESG_DEVICE_AUX_BATTERY_INFO], FIT_DEVICE_AUX_BATTERY_INFO_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_DEVICE_AUX_BATTERY_INFO_MESG_SIZE, fp);
}


static void export_training_file(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_TRAINING_FILE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_TRAINING_FILE], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.serial_number);
    ExportTimestamp(5, libData, data, pos, mesg.time_created);
    ExportInteger(6, libData, data, pos, mesg.manufacturer);
    ExportInteger(7, libData, data, pos, mesg.product);
    ExportInteger(8, libData, data, pos, mesg.type);

    WriteMessageDefinition(FIT_MESG_NUM_TRAINING_FILE, local_mesg_number, fit_mesg_defs[FIT_MESG_TRAINING_FILE], FIT_TRAINING_FILE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_TRAINING_FILE_MESG_SIZE, fp);
}


static void export_weather_conditions(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_WEATHER_CONDITIONS_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_WEATHER_CONDITIONS], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportString(4, libData, data, pos, mesg.location, FIT_WEATHER_CONDITIONS_MESG_LOCATION_COUNT);
    ExportTimestamp(68, libData, data, pos, mesg.observed_at_time);
    ExportInteger(69, libData, data, pos, mesg.observed_location_lat);
    ExportInteger(70, libData, data, pos, mesg.observed_location_long);
    ExportInteger(71, libData, data, pos, mesg.wind_direction);
    ExportInteger(72, libData, data, pos, mesg.wind_speed);
    ExportInteger(73, libData, data, pos, mesg.weather_report);
    ExportInteger(74, libData, data, pos, mesg.temperature);
    ExportInteger(75, libData, data, pos, mesg.condition);
    ExportInteger(76, libData, data, pos, mesg.precipitation_probability);
    ExportInteger(77, libData, data, pos, mesg.temperature_feels_like);
    ExportInteger(78, libData, data, pos, mesg.relative_humidity);
    ExportInteger(79, libData, data, pos, mesg.day_of_week);
    ExportInteger(80, libData, data, pos, mesg.high_temperature);
    ExportInteger(81, libData, data, pos, mesg.low_temperature);

    WriteMessageDefinition(FIT_MESG_NUM_WEATHER_CONDITIONS, local_mesg_number, fit_mesg_defs[FIT_MESG_WEATHER_CONDITIONS], FIT_WEATHER_CONDITIONS_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_WEATHER_CONDITIONS_MESG_SIZE, fp);
}


static void export_weather_alert(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_WEATHER_ALERT_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_WEATHER_ALERT], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportString(4, libData, data, pos, mesg.report_id, FIT_WEATHER_ALERT_MESG_REPORT_ID_COUNT);
    ExportTimestamp(16, libData, data, pos, mesg.issue_time);
    ExportTimestamp(17, libData, data, pos, mesg.expire_time);
    ExportInteger(18, libData, data, pos, mesg.severity);
    ExportInteger(19, libData, data, pos, mesg.type);

    WriteMessageDefinition(FIT_MESG_NUM_WEATHER_ALERT, local_mesg_number, fit_mesg_defs[FIT_MESG_WEATHER_ALERT], FIT_WEATHER_ALERT_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_WEATHER_ALERT_MESG_SIZE, fp);
}


static void export_gps_metadata(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_GPS_METADATA_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_GPS_METADATA], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.position_lat);
    ExportInteger(5, libData, data, pos, mesg.position_long);
    ExportInteger(6, libData, data, pos, mesg.enhanced_altitude);
    ExportInteger(7, libData, data, pos, mesg.enhanced_speed);
    ExportTimestamp(8, libData, data, pos, mesg.utc_timestamp);
    ExportInteger(9, libData, data, pos, mesg.timestamp_ms);
    ExportInteger(10, libData, data, pos, mesg.heading);
    ExportIntegerSequence(11, libData, data, pos, mesg.velocity, FIT_GPS_METADATA_MESG_VELOCITY_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_GPS_METADATA, local_mesg_number, fit_mesg_defs[FIT_MESG_GPS_METADATA], FIT_GPS_METADATA_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_GPS_METADATA_MESG_SIZE, fp);
}


static void export_camera_event(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_CAMERA_EVENT_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_CAMERA_EVENT], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.timestamp_ms);
    ExportInteger(5, libData, data, pos, mesg.camera_event_type);
    ExportString(6, libData, data, pos, mesg.camera_file_uuid, FIT_CAMERA_EVENT_MESG_CAMERA_FILE_UUID_COUNT);
    ExportInteger(7, libData, data, pos, mesg.camera_orientation);

    WriteMessageDefinition(FIT_MESG_NUM_CAMERA_EVENT, local_mesg_number, fit_mesg_defs[FIT_MESG_CAMERA_EVENT], FIT_CAMERA_EVENT_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_CAMERA_EVENT_MESG_SIZE, fp);
}


static void export_gyroscope_data(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_GYROSCOPE_DATA_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_GYROSCOPE_DATA], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportFloat32Sequence(4, libData, data, pos, mesg.calibrated_gyro_x, FIT_GYROSCOPE_DATA_MESG_CALIBRATED_GYRO_X_COUNT);
    ExportFloat32Sequence(5, libData, data, pos, mesg.calibrated_gyro_y, FIT_GYROSCOPE_DATA_MESG_CALIBRATED_GYRO_Y_COUNT);
    ExportFloat32Sequence(6, libData, data, pos, mesg.calibrated_gyro_z, FIT_GYROSCOPE_DATA_MESG_CALIBRATED_GYRO_Z_COUNT);
    ExportInteger(7, libData, data, pos, mesg.timestamp_ms);
    ExportIntegerSequence(8, libData, data, pos, mesg.sample_time_offset, FIT_GYROSCOPE_DATA_MESG_SAMPLE_TIME_OFFSET_COUNT);
    ExportIntegerSequence(9, libData, data, pos, mesg.gyro_x, FIT_GYROSCOPE_DATA_MESG_GYRO_X_COUNT);
    ExportIntegerSequence(10, libData, data, pos, mesg.gyro_y, FIT_GYROSCOPE_DATA_MESG_GYRO_Y_COUNT);
    ExportIntegerSequence(11, libData, data, pos, mesg.gyro_z, FIT_GYROSCOPE_DATA_MESG_GYRO_Z_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_GYROSCOPE_DATA, local_mesg_number, fit_mesg_defs[FIT_MESG_GYROSCOPE_DATA], FIT_GYROSCOPE_DATA_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_GYROSCOPE_DATA_MESG_SIZE, fp);
}


static void export_accelerometer_data(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_ACCELEROMETER_DATA_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_ACCELEROMETER_DATA], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportFloat32Sequence(4, libData, data, pos, mesg.calibrated_accel_x, FIT_ACCELEROMETER_DATA_MESG_CALIBRATED_ACCEL_X_COUNT);
    ExportFloat32Sequence(5, libData, data, pos, mesg.calibrated_accel_y, FIT_ACCELEROMETER_DATA_MESG_CALIBRATED_ACCEL_Y_COUNT);
    ExportFloat32Sequence(6, libData, data, pos, mesg.calibrated_accel_z, FIT_ACCELEROMETER_DATA_MESG_CALIBRATED_ACCEL_Z_COUNT);
    ExportInteger(7, libData, data, pos, mesg.timestamp_ms);
    ExportIntegerSequence(8, libData, data, pos, mesg.sample_time_offset, FIT_ACCELEROMETER_DATA_MESG_SAMPLE_TIME_OFFSET_COUNT);
    ExportIntegerSequence(9, libData, data, pos, mesg.accel_x, FIT_ACCELEROMETER_DATA_MESG_ACCEL_X_COUNT);
    ExportIntegerSequence(10, libData, data, pos, mesg.accel_y, FIT_ACCELEROMETER_DATA_MESG_ACCEL_Y_COUNT);
    ExportIntegerSequence(11, libData, data, pos, mesg.accel_z, FIT_ACCELEROMETER_DATA_MESG_ACCEL_Z_COUNT);
    ExportIntegerSequence(12, libData, data, pos, mesg.compressed_calibrated_accel_x, FIT_ACCELEROMETER_DATA_MESG_COMPRESSED_CALIBRATED_ACCEL_X_COUNT);
    ExportIntegerSequence(13, libData, data, pos, mesg.compressed_calibrated_accel_y, FIT_ACCELEROMETER_DATA_MESG_COMPRESSED_CALIBRATED_ACCEL_Y_COUNT);
    ExportIntegerSequence(14, libData, data, pos, mesg.compressed_calibrated_accel_z, FIT_ACCELEROMETER_DATA_MESG_COMPRESSED_CALIBRATED_ACCEL_Z_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_ACCELEROMETER_DATA, local_mesg_number, fit_mesg_defs[FIT_MESG_ACCELEROMETER_DATA], FIT_ACCELEROMETER_DATA_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_ACCELEROMETER_DATA_MESG_SIZE, fp);
}


static void export_magnetometer_data(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_MAGNETOMETER_DATA_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_MAGNETOMETER_DATA], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportFloat32Sequence(4, libData, data, pos, mesg.calibrated_mag_x, FIT_MAGNETOMETER_DATA_MESG_CALIBRATED_MAG_X_COUNT);
    ExportFloat32Sequence(5, libData, data, pos, mesg.calibrated_mag_y, FIT_MAGNETOMETER_DATA_MESG_CALIBRATED_MAG_Y_COUNT);
    ExportFloat32Sequence(6, libData, data, pos, mesg.calibrated_mag_z, FIT_MAGNETOMETER_DATA_MESG_CALIBRATED_MAG_Z_COUNT);
    ExportInteger(7, libData, data, pos, mesg.timestamp_ms);
    ExportIntegerSequence(8, libData, data, pos, mesg.sample_time_offset, FIT_MAGNETOMETER_DATA_MESG_SAMPLE_TIME_OFFSET_COUNT);
    ExportIntegerSequence(9, libData, data, pos, mesg.mag_x, FIT_MAGNETOMETER_DATA_MESG_MAG_X_COUNT);
    ExportIntegerSequence(10, libData, data, pos, mesg.mag_y, FIT_MAGNETOMETER_DATA_MESG_MAG_Y_COUNT);
    ExportIntegerSequence(11, libData, data, pos, mesg.mag_z, FIT_MAGNETOMETER_DATA_MESG_MAG_Z_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_MAGNETOMETER_DATA, local_mesg_number, fit_mesg_defs[FIT_MESG_MAGNETOMETER_DATA], FIT_MAGNETOMETER_DATA_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_MAGNETOMETER_DATA_MESG_SIZE, fp);
}


static void export_barometer_data(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_BAROMETER_DATA_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_BAROMETER_DATA], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportIntegerSequence(4, libData, data, pos, mesg.baro_pres, FIT_BAROMETER_DATA_MESG_BARO_PRES_COUNT);
    ExportInteger(5, libData, data, pos, mesg.timestamp_ms);
    ExportIntegerSequence(6, libData, data, pos, mesg.sample_time_offset, FIT_BAROMETER_DATA_MESG_SAMPLE_TIME_OFFSET_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_BAROMETER_DATA, local_mesg_number, fit_mesg_defs[FIT_MESG_BAROMETER_DATA], FIT_BAROMETER_DATA_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_BAROMETER_DATA_MESG_SIZE, fp);
}


static void export_three_d_sensor_calibration(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_THREE_D_SENSOR_CALIBRATION_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_THREE_D_SENSOR_CALIBRATION], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.calibration_factor);
    ExportInteger(5, libData, data, pos, mesg.calibration_divisor);
    ExportInteger(6, libData, data, pos, mesg.level_shift);
    ExportIntegerSequence(7, libData, data, pos, mesg.offset_cal, FIT_THREE_D_SENSOR_CALIBRATION_MESG_OFFSET_CAL_COUNT);
    ExportIntegerSequence(10, libData, data, pos, mesg.orientation_matrix, FIT_THREE_D_SENSOR_CALIBRATION_MESG_ORIENTATION_MATRIX_COUNT);
    ExportInteger(19, libData, data, pos, mesg.sensor_type);

    WriteMessageDefinition(FIT_MESG_NUM_THREE_D_SENSOR_CALIBRATION, local_mesg_number, fit_mesg_defs[FIT_MESG_THREE_D_SENSOR_CALIBRATION], FIT_THREE_D_SENSOR_CALIBRATION_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_THREE_D_SENSOR_CALIBRATION_MESG_SIZE, fp);
}


static void export_one_d_sensor_calibration(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_ONE_D_SENSOR_CALIBRATION_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_ONE_D_SENSOR_CALIBRATION], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.calibration_factor);
    ExportInteger(5, libData, data, pos, mesg.calibration_divisor);
    ExportInteger(6, libData, data, pos, mesg.level_shift);
    ExportInteger(7, libData, data, pos, mesg.offset_cal);
    ExportInteger(8, libData, data, pos, mesg.sensor_type);

    WriteMessageDefinition(FIT_MESG_NUM_ONE_D_SENSOR_CALIBRATION, local_mesg_number, fit_mesg_defs[FIT_MESG_ONE_D_SENSOR_CALIBRATION], FIT_ONE_D_SENSOR_CALIBRATION_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_ONE_D_SENSOR_CALIBRATION_MESG_SIZE, fp);
}


static void export_video_frame(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_VIDEO_FRAME_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_VIDEO_FRAME], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.frame_number);
    ExportInteger(5, libData, data, pos, mesg.timestamp_ms);

    WriteMessageDefinition(FIT_MESG_NUM_VIDEO_FRAME, local_mesg_number, fit_mesg_defs[FIT_MESG_VIDEO_FRAME], FIT_VIDEO_FRAME_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_VIDEO_FRAME_MESG_SIZE, fp);
}


static void export_obdii_data(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_OBDII_DATA_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_OBDII_DATA], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportIntegerSequence(4, libData, data, pos, mesg.system_time, FIT_OBDII_DATA_MESG_SYSTEM_TIME_COUNT);
    ExportTimestamp(5, libData, data, pos, mesg.start_timestamp);
    ExportInteger(6, libData, data, pos, mesg.timestamp_ms);
    ExportIntegerSequence(7, libData, data, pos, mesg.time_offset, FIT_OBDII_DATA_MESG_TIME_OFFSET_COUNT);
    ExportInteger(8, libData, data, pos, mesg.start_timestamp_ms);
    ExportInteger(9, libData, data, pos, mesg.pid);
    ExportIntegerSequence(10, libData, data, pos, mesg.raw_data, FIT_OBDII_DATA_MESG_RAW_DATA_COUNT);
    ExportIntegerSequence(11, libData, data, pos, mesg.pid_data_size, FIT_OBDII_DATA_MESG_PID_DATA_SIZE_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_OBDII_DATA, local_mesg_number, fit_mesg_defs[FIT_MESG_OBDII_DATA], FIT_OBDII_DATA_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_OBDII_DATA_MESG_SIZE, fp);
}


static void export_nmea_sentence(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_NMEA_SENTENCE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_NMEA_SENTENCE], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.timestamp_ms);
    ExportString(5, libData, data, pos, mesg.sentence, FIT_NMEA_SENTENCE_MESG_SENTENCE_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_NMEA_SENTENCE, local_mesg_number, fit_mesg_defs[FIT_MESG_NMEA_SENTENCE], FIT_NMEA_SENTENCE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_NMEA_SENTENCE_MESG_SIZE, fp);
}


static void export_aviation_attitude(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_AVIATION_ATTITUDE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_AVIATION_ATTITUDE], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportIntegerSequence(4, libData, data, pos, mesg.system_time, FIT_AVIATION_ATTITUDE_MESG_SYSTEM_TIME_COUNT);
    ExportInteger(5, libData, data, pos, mesg.timestamp_ms);
    ExportIntegerSequence(6, libData, data, pos, mesg.pitch, FIT_AVIATION_ATTITUDE_MESG_PITCH_COUNT);
    ExportIntegerSequence(7, libData, data, pos, mesg.roll, FIT_AVIATION_ATTITUDE_MESG_ROLL_COUNT);
    ExportIntegerSequence(8, libData, data, pos, mesg.accel_lateral, FIT_AVIATION_ATTITUDE_MESG_ACCEL_LATERAL_COUNT);
    ExportIntegerSequence(9, libData, data, pos, mesg.accel_normal, FIT_AVIATION_ATTITUDE_MESG_ACCEL_NORMAL_COUNT);
    ExportIntegerSequence(10, libData, data, pos, mesg.turn_rate, FIT_AVIATION_ATTITUDE_MESG_TURN_RATE_COUNT);
    ExportIntegerSequence(11, libData, data, pos, mesg.track, FIT_AVIATION_ATTITUDE_MESG_TRACK_COUNT);
    ExportIntegerSequence(12, libData, data, pos, mesg.validity, FIT_AVIATION_ATTITUDE_MESG_VALIDITY_COUNT);
    ExportIntegerSequence(13, libData, data, pos, mesg.stage, FIT_AVIATION_ATTITUDE_MESG_STAGE_COUNT);
    ExportIntegerSequence(14, libData, data, pos, mesg.attitude_stage_complete, FIT_AVIATION_ATTITUDE_MESG_ATTITUDE_STAGE_COMPLETE_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_AVIATION_ATTITUDE, local_mesg_number, fit_mesg_defs[FIT_MESG_AVIATION_ATTITUDE], FIT_AVIATION_ATTITUDE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_AVIATION_ATTITUDE_MESG_SIZE, fp);
}


static void export_video(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_VIDEO_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_VIDEO], &mesg);

    ExportInteger(3, libData, data, pos, mesg.duration);
    ExportString(4, libData, data, pos, mesg.url, FIT_VIDEO_MESG_URL_COUNT);
    ExportString(5, libData, data, pos, mesg.hosting_provider, FIT_VIDEO_MESG_HOSTING_PROVIDER_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_VIDEO, local_mesg_number, fit_mesg_defs[FIT_MESG_VIDEO], FIT_VIDEO_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_VIDEO_MESG_SIZE, fp);
}


static void export_video_title(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_VIDEO_TITLE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_VIDEO_TITLE], &mesg);

    ExportString(3, libData, data, pos, mesg.text, FIT_VIDEO_TITLE_MESG_TEXT_COUNT);
    ExportInteger(83, libData, data, pos, mesg.message_index);
    ExportInteger(84, libData, data, pos, mesg.message_count);

    WriteMessageDefinition(FIT_MESG_NUM_VIDEO_TITLE, local_mesg_number, fit_mesg_defs[FIT_MESG_VIDEO_TITLE], FIT_VIDEO_TITLE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_VIDEO_TITLE_MESG_SIZE, fp);
}


static void export_video_description(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_VIDEO_DESCRIPTION_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_VIDEO_DESCRIPTION], &mesg);

    ExportString(3, libData, data, pos, mesg.text, FIT_VIDEO_DESCRIPTION_MESG_TEXT_COUNT);
    ExportInteger(131, libData, data, pos, mesg.message_index);
    ExportInteger(132, libData, data, pos, mesg.message_count);

    WriteMessageDefinition(FIT_MESG_NUM_VIDEO_DESCRIPTION, local_mesg_number, fit_mesg_defs[FIT_MESG_VIDEO_DESCRIPTION], FIT_VIDEO_DESCRIPTION_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_VIDEO_DESCRIPTION_MESG_SIZE, fp);
}


static void export_video_clip(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_VIDEO_CLIP_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_VIDEO_CLIP], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.start_timestamp);
    ExportTimestamp(4, libData, data, pos, mesg.end_timestamp);
    ExportInteger(5, libData, data, pos, mesg.clip_start);
    ExportInteger(6, libData, data, pos, mesg.clip_end);
    ExportInteger(7, libData, data, pos, mesg.clip_number);
    ExportInteger(8, libData, data, pos, mesg.start_timestamp_ms);
    ExportInteger(9, libData, data, pos, mesg.end_timestamp_ms);

    WriteMessageDefinition(FIT_MESG_NUM_VIDEO_CLIP, local_mesg_number, fit_mesg_defs[FIT_MESG_VIDEO_CLIP], FIT_VIDEO_CLIP_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_VIDEO_CLIP_MESG_SIZE, fp);
}


static void export_set(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SET_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SET], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.duration);
    ExportTimestamp(5, libData, data, pos, mesg.start_time);
    ExportInteger(6, libData, data, pos, mesg.repetitions);
    ExportInteger(7, libData, data, pos, mesg.weight);
    ExportIntegerSequence(8, libData, data, pos, mesg.category, FIT_SET_MESG_CATEGORY_COUNT);
    ExportIntegerSequence(9, libData, data, pos, mesg.category_subtype, FIT_SET_MESG_CATEGORY_SUBTYPE_COUNT);
    ExportInteger(10, libData, data, pos, mesg.weight_display_unit);
    ExportInteger(11, libData, data, pos, mesg.message_index);
    ExportInteger(12, libData, data, pos, mesg.wkt_step_index);
    ExportInteger(13, libData, data, pos, mesg.set_type);

    WriteMessageDefinition(FIT_MESG_NUM_SET, local_mesg_number, fit_mesg_defs[FIT_MESG_SET], FIT_SET_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SET_MESG_SIZE, fp);
}


static void export_jump(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_JUMP_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_JUMP], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportFloat32(4, libData, data, pos, mesg.distance);
    ExportFloat32(5, libData, data, pos, mesg.height);
    ExportFloat32(6, libData, data, pos, mesg.hang_time);
    ExportFloat32(7, libData, data, pos, mesg.score);
    ExportInteger(8, libData, data, pos, mesg.position_lat);
    ExportInteger(9, libData, data, pos, mesg.position_long);
    ExportInteger(10, libData, data, pos, mesg.enhanced_speed);
    ExportInteger(11, libData, data, pos, mesg.speed);
    ExportInteger(12, libData, data, pos, mesg.rotations);

    WriteMessageDefinition(FIT_MESG_NUM_JUMP, local_mesg_number, fit_mesg_defs[FIT_MESG_JUMP], FIT_JUMP_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_JUMP_MESG_SIZE, fp);
}


static void export_climb_pro(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_CLIMB_PRO_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_CLIMB_PRO], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.position_lat);
    ExportInteger(5, libData, data, pos, mesg.position_long);
    ExportFloat32(6, libData, data, pos, mesg.current_dist);
    ExportInteger(7, libData, data, pos, mesg.climb_number);
    ExportInteger(8, libData, data, pos, mesg.climb_pro_event);
    ExportInteger(9, libData, data, pos, mesg.climb_category);

    WriteMessageDefinition(FIT_MESG_NUM_CLIMB_PRO, local_mesg_number, fit_mesg_defs[FIT_MESG_CLIMB_PRO], FIT_CLIMB_PRO_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_CLIMB_PRO_MESG_SIZE, fp);
}


static void export_field_description(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_FIELD_DESCRIPTION_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_FIELD_DESCRIPTION], &mesg);

    ExportString(3, libData, data, pos, mesg.field_name, FIT_FIELD_DESCRIPTION_MESG_FIELD_NAME_COUNT);
    ExportString(67, libData, data, pos, mesg.units, FIT_FIELD_DESCRIPTION_MESG_UNITS_COUNT);
    ExportInteger(83, libData, data, pos, mesg.fit_base_unit_id);
    ExportInteger(84, libData, data, pos, mesg.native_mesg_num);
    ExportInteger(85, libData, data, pos, mesg.developer_data_index);
    ExportInteger(86, libData, data, pos, mesg.field_definition_number);
    ExportInteger(87, libData, data, pos, mesg.fit_base_type_id);
    ExportInteger(88, libData, data, pos, mesg.array);
    ExportString(89, libData, data, pos, mesg.components, FIT_FIELD_DESCRIPTION_MESG_COMPONENTS_COUNT);
    ExportInteger(90, libData, data, pos, mesg.scale);
    ExportInteger(91, libData, data, pos, mesg.offset);
    ExportString(92, libData, data, pos, mesg.bits, FIT_FIELD_DESCRIPTION_MESG_BITS_COUNT);
    ExportString(93, libData, data, pos, mesg.accumulate, FIT_FIELD_DESCRIPTION_MESG_ACCUMULATE_COUNT);
    ExportInteger(94, libData, data, pos, mesg.native_field_num);

    WriteMessageDefinition(FIT_MESG_NUM_FIELD_DESCRIPTION, local_mesg_number, fit_mesg_defs[FIT_MESG_FIELD_DESCRIPTION], FIT_FIELD_DESCRIPTION_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_FIELD_DESCRIPTION_MESG_SIZE, fp);
}


static void export_developer_data_id(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_DEVELOPER_DATA_ID_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_DEVELOPER_DATA_ID], &mesg);

    ExportIntegerSequence(3, libData, data, pos, mesg.developer_id, FIT_DEVELOPER_DATA_ID_MESG_DEVELOPER_ID_COUNT);
    ExportIntegerSequence(19, libData, data, pos, mesg.application_id, FIT_DEVELOPER_DATA_ID_MESG_APPLICATION_ID_COUNT);
    ExportInteger(35, libData, data, pos, mesg.application_version);
    ExportInteger(36, libData, data, pos, mesg.manufacturer_id);
    ExportInteger(37, libData, data, pos, mesg.developer_data_index);

    WriteMessageDefinition(FIT_MESG_NUM_DEVELOPER_DATA_ID, local_mesg_number, fit_mesg_defs[FIT_MESG_DEVELOPER_DATA_ID], FIT_DEVELOPER_DATA_ID_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_DEVELOPER_DATA_ID_MESG_SIZE, fp);
}


static void export_course(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_COURSE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_COURSE], &mesg);

    ExportString(3, libData, data, pos, mesg.name, FIT_COURSE_MESG_NAME_COUNT);
    ExportInteger(19, libData, data, pos, mesg.capabilities);
    ExportInteger(20, libData, data, pos, mesg.sport);
    ExportInteger(21, libData, data, pos, mesg.sub_sport);

    WriteMessageDefinition(FIT_MESG_NUM_COURSE, local_mesg_number, fit_mesg_defs[FIT_MESG_COURSE], FIT_COURSE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_COURSE_MESG_SIZE, fp);
}


static void export_course_point(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_COURSE_POINT_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_COURSE_POINT], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.position_lat);
    ExportInteger(5, libData, data, pos, mesg.position_long);
    ExportInteger(6, libData, data, pos, mesg.distance);
    ExportString(7, libData, data, pos, mesg.name, FIT_COURSE_POINT_MESG_NAME_COUNT);
    ExportInteger(23, libData, data, pos, mesg.message_index);
    ExportInteger(24, libData, data, pos, mesg.type);
    ExportInteger(25, libData, data, pos, mesg.favorite);

    WriteMessageDefinition(FIT_MESG_NUM_COURSE_POINT, local_mesg_number, fit_mesg_defs[FIT_MESG_COURSE_POINT], FIT_COURSE_POINT_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_COURSE_POINT_MESG_SIZE, fp);
}


static void export_segment_id(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SEGMENT_ID_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SEGMENT_ID], &mesg);

    ExportString(3, libData, data, pos, mesg.uuid, FIT_SEGMENT_ID_MESG_UUID_COUNT);
    ExportInteger(39, libData, data, pos, mesg.user_profile_primary_key);
    ExportInteger(40, libData, data, pos, mesg.device_id);
    ExportString(41, libData, data, pos, mesg.name, FIT_SEGMENT_ID_MESG_NAME_COUNT);
    ExportInteger(91, libData, data, pos, mesg.sport);
    ExportInteger(92, libData, data, pos, mesg.enabled);
    ExportInteger(93, libData, data, pos, mesg.default_race_leader);
    ExportInteger(94, libData, data, pos, mesg.delete_status);
    ExportInteger(95, libData, data, pos, mesg.selection_type);

    WriteMessageDefinition(FIT_MESG_NUM_SEGMENT_ID, local_mesg_number, fit_mesg_defs[FIT_MESG_SEGMENT_ID], FIT_SEGMENT_ID_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SEGMENT_ID_MESG_SIZE, fp);
}


static void export_segment_leaderboard_entry(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SEGMENT_LEADERBOARD_ENTRY_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SEGMENT_LEADERBOARD_ENTRY], &mesg);

    ExportInteger(3, libData, data, pos, mesg.group_primary_key);
    ExportInteger(4, libData, data, pos, mesg.activity_id);
    ExportInteger(5, libData, data, pos, mesg.segment_time);
    ExportInteger(6, libData, data, pos, mesg.message_index);
    ExportString(7, libData, data, pos, mesg.name, FIT_SEGMENT_LEADERBOARD_ENTRY_MESG_NAME_COUNT);
    ExportInteger(8, libData, data, pos, mesg.type);
    ExportString(9, libData, data, pos, mesg.activity_id_string, FIT_SEGMENT_LEADERBOARD_ENTRY_MESG_ACTIVITY_ID_STRING_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_SEGMENT_LEADERBOARD_ENTRY, local_mesg_number, fit_mesg_defs[FIT_MESG_SEGMENT_LEADERBOARD_ENTRY], FIT_SEGMENT_LEADERBOARD_ENTRY_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SEGMENT_LEADERBOARD_ENTRY_MESG_SIZE, fp);
}


static void export_segment_point(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SEGMENT_POINT_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SEGMENT_POINT], &mesg);

    ExportInteger(3, libData, data, pos, mesg.position_lat);
    ExportInteger(4, libData, data, pos, mesg.position_long);
    ExportInteger(5, libData, data, pos, mesg.distance);
    ExportIntegerSequence(6, libData, data, pos, mesg.leader_time, FIT_SEGMENT_POINT_MESG_LEADER_TIME_COUNT);
    ExportInteger(7, libData, data, pos, mesg.message_index);
    ExportInteger(8, libData, data, pos, mesg.altitude);

    WriteMessageDefinition(FIT_MESG_NUM_SEGMENT_POINT, local_mesg_number, fit_mesg_defs[FIT_MESG_SEGMENT_POINT], FIT_SEGMENT_POINT_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SEGMENT_POINT_MESG_SIZE, fp);
}


static void export_segment_lap(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SEGMENT_LAP_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SEGMENT_LAP], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportTimestamp(4, libData, data, pos, mesg.start_time);
    ExportInteger(5, libData, data, pos, mesg.start_position_lat);
    ExportInteger(6, libData, data, pos, mesg.start_position_long);
    ExportInteger(7, libData, data, pos, mesg.end_position_lat);
    ExportInteger(8, libData, data, pos, mesg.end_position_long);
    ExportInteger(9, libData, data, pos, mesg.total_elapsed_time);
    ExportInteger(10, libData, data, pos, mesg.total_timer_time);
    ExportInteger(11, libData, data, pos, mesg.total_distance);
    ExportInteger(12, libData, data, pos, mesg.total_cycles);
    ExportInteger(13, libData, data, pos, mesg.nec_lat);
    ExportInteger(14, libData, data, pos, mesg.nec_long);
    ExportInteger(15, libData, data, pos, mesg.swc_lat);
    ExportInteger(16, libData, data, pos, mesg.swc_long);
    ExportString(17, libData, data, pos, mesg.name, FIT_SEGMENT_LAP_MESG_NAME_COUNT);
    ExportInteger(41, libData, data, pos, mesg.total_work);
    ExportInteger(42, libData, data, pos, mesg.total_moving_time);
    ExportIntegerSequence(43, libData, data, pos, mesg.time_in_hr_zone, FIT_SEGMENT_LAP_MESG_TIME_IN_HR_ZONE_COUNT);
    ExportIntegerSequence(48, libData, data, pos, mesg.time_in_speed_zone, FIT_SEGMENT_LAP_MESG_TIME_IN_SPEED_ZONE_COUNT);
    ExportIntegerSequence(49, libData, data, pos, mesg.time_in_cadence_zone, FIT_SEGMENT_LAP_MESG_TIME_IN_CADENCE_ZONE_COUNT);
    ExportIntegerSequence(50, libData, data, pos, mesg.time_in_power_zone, FIT_SEGMENT_LAP_MESG_TIME_IN_POWER_ZONE_COUNT);
    ExportInteger(57, libData, data, pos, mesg.active_time);
    ExportInteger(58, libData, data, pos, mesg.time_standing);
    ExportIntegerSequence(59, libData, data, pos, mesg.avg_power_position, FIT_SEGMENT_LAP_MESG_AVG_POWER_POSITION_COUNT);
    ExportIntegerSequence(61, libData, data, pos, mesg.max_power_position, FIT_SEGMENT_LAP_MESG_MAX_POWER_POSITION_COUNT);
    ExportFloat32(63, libData, data, pos, mesg.total_grit);
    ExportFloat32(64, libData, data, pos, mesg.total_flow);
    ExportFloat32(65, libData, data, pos, mesg.avg_grit);
    ExportFloat32(66, libData, data, pos, mesg.avg_flow);
    ExportInteger(67, libData, data, pos, mesg.message_index);
    ExportInteger(68, libData, data, pos, mesg.total_calories);
    ExportInteger(69, libData, data, pos, mesg.total_fat_calories);
    ExportInteger(70, libData, data, pos, mesg.avg_speed);
    ExportInteger(71, libData, data, pos, mesg.max_speed);
    ExportInteger(72, libData, data, pos, mesg.avg_power);
    ExportInteger(73, libData, data, pos, mesg.max_power);
    ExportInteger(74, libData, data, pos, mesg.total_ascent);
    ExportInteger(75, libData, data, pos, mesg.total_descent);
    ExportInteger(76, libData, data, pos, mesg.normalized_power);
    ExportInteger(77, libData, data, pos, mesg.left_right_balance);
    ExportInteger(78, libData, data, pos, mesg.avg_altitude);
    ExportInteger(79, libData, data, pos, mesg.max_altitude);
    ExportInteger(80, libData, data, pos, mesg.avg_grade);
    ExportInteger(81, libData, data, pos, mesg.avg_pos_grade);
    ExportInteger(82, libData, data, pos, mesg.avg_neg_grade);
    ExportInteger(83, libData, data, pos, mesg.max_pos_grade);
    ExportInteger(84, libData, data, pos, mesg.max_neg_grade);
    ExportInteger(85, libData, data, pos, mesg.avg_pos_vertical_speed);
    ExportInteger(86, libData, data, pos, mesg.avg_neg_vertical_speed);
    ExportInteger(87, libData, data, pos, mesg.max_pos_vertical_speed);
    ExportInteger(88, libData, data, pos, mesg.max_neg_vertical_speed);
    ExportInteger(89, libData, data, pos, mesg.repetition_num);
    ExportInteger(90, libData, data, pos, mesg.min_altitude);
    ExportInteger(91, libData, data, pos, mesg.wkt_step_index);
    ExportInteger(92, libData, data, pos, mesg.front_gear_shift_count);
    ExportInteger(93, libData, data, pos, mesg.rear_gear_shift_count);
    ExportInteger(94, libData, data, pos, mesg.stand_count);
    ExportInteger(95, libData, data, pos, mesg.manufacturer);
    ExportInteger(96, libData, data, pos, mesg.event);
    ExportInteger(97, libData, data, pos, mesg.event_type);
    ExportInteger(98, libData, data, pos, mesg.avg_heart_rate);
    ExportInteger(99, libData, data, pos, mesg.max_heart_rate);
    ExportInteger(100, libData, data, pos, mesg.avg_cadence);
    ExportInteger(101, libData, data, pos, mesg.max_cadence);
    ExportInteger(102, libData, data, pos, mesg.sport);
    ExportInteger(103, libData, data, pos, mesg.event_group);
    ExportInteger(104, libData, data, pos, mesg.sub_sport);
    ExportInteger(105, libData, data, pos, mesg.gps_accuracy);
    ExportInteger(106, libData, data, pos, mesg.avg_temperature);
    ExportInteger(107, libData, data, pos, mesg.max_temperature);
    ExportInteger(108, libData, data, pos, mesg.min_heart_rate);
    ExportInteger(109, libData, data, pos, mesg.sport_event);
    ExportInteger(110, libData, data, pos, mesg.avg_left_torque_effectiveness);
    ExportInteger(111, libData, data, pos, mesg.avg_right_torque_effectiveness);
    ExportInteger(112, libData, data, pos, mesg.avg_left_pedal_smoothness);
    ExportInteger(113, libData, data, pos, mesg.avg_right_pedal_smoothness);
    ExportInteger(114, libData, data, pos, mesg.avg_combined_pedal_smoothness);
    ExportInteger(115, libData, data, pos, mesg.status);
    ExportString(116, libData, data, pos, mesg.uuid, FIT_SEGMENT_LAP_MESG_UUID_COUNT);
    ExportInteger(149, libData, data, pos, mesg.avg_fractional_cadence);
    ExportInteger(150, libData, data, pos, mesg.max_fractional_cadence);
    ExportInteger(151, libData, data, pos, mesg.total_fractional_cycles);
    ExportInteger(152, libData, data, pos, mesg.avg_left_pco);
    ExportInteger(153, libData, data, pos, mesg.avg_right_pco);
    ExportIntegerSequence(154, libData, data, pos, mesg.avg_left_power_phase, FIT_SEGMENT_LAP_MESG_AVG_LEFT_POWER_PHASE_COUNT);
    ExportIntegerSequence(156, libData, data, pos, mesg.avg_left_power_phase_peak, FIT_SEGMENT_LAP_MESG_AVG_LEFT_POWER_PHASE_PEAK_COUNT);
    ExportIntegerSequence(158, libData, data, pos, mesg.avg_right_power_phase, FIT_SEGMENT_LAP_MESG_AVG_RIGHT_POWER_PHASE_COUNT);
    ExportIntegerSequence(160, libData, data, pos, mesg.avg_right_power_phase_peak, FIT_SEGMENT_LAP_MESG_AVG_RIGHT_POWER_PHASE_PEAK_COUNT);
    ExportIntegerSequence(162, libData, data, pos, mesg.avg_cadence_position, FIT_SEGMENT_LAP_MESG_AVG_CADENCE_POSITION_COUNT);
    ExportIntegerSequence(164, libData, data, pos, mesg.max_cadence_position, FIT_SEGMENT_LAP_MESG_MAX_CADENCE_POSITION_COUNT);
    ExportInteger(166, libData, data, pos, mesg.total_fractional_ascent);
    ExportInteger(167, libData, data, pos, mesg.total_fractional_descent);

    WriteMessageDefinition(FIT_MESG_NUM_SEGMENT_LAP, local_mesg_number, fit_mesg_defs[FIT_MESG_SEGMENT_LAP], FIT_SEGMENT_LAP_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SEGMENT_LAP_MESG_SIZE, fp);
}


static void export_segment_file(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SEGMENT_FILE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SEGMENT_FILE], &mesg);

    ExportInteger(3, libData, data, pos, mesg.user_profile_primary_key);
    ExportIntegerSequence(4, libData, data, pos, mesg.leader_group_primary_key, FIT_SEGMENT_FILE_MESG_LEADER_GROUP_PRIMARY_KEY_COUNT);
    ExportIntegerSequence(5, libData, data, pos, mesg.leader_activity_id, FIT_SEGMENT_FILE_MESG_LEADER_ACTIVITY_ID_COUNT);
    ExportInteger(6, libData, data, pos, mesg.message_index);
    ExportString(7, libData, data, pos, mesg.file_uuid, FIT_SEGMENT_FILE_MESG_FILE_UUID_COUNT);
    ExportInteger(8, libData, data, pos, mesg.enabled);
    ExportIntegerSequence(9, libData, data, pos, mesg.leader_type, FIT_SEGMENT_FILE_MESG_LEADER_TYPE_COUNT);
    ExportString(10, libData, data, pos, mesg.leader_activity_id_string, FIT_SEGMENT_FILE_MESG_LEADER_ACTIVITY_ID_STRING_COUNT);
    ExportInteger(11, libData, data, pos, mesg.default_race_leader);

    WriteMessageDefinition(FIT_MESG_NUM_SEGMENT_FILE, local_mesg_number, fit_mesg_defs[FIT_MESG_SEGMENT_FILE], FIT_SEGMENT_FILE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SEGMENT_FILE_MESG_SIZE, fp);
}


static void export_workout(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_WORKOUT_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_WORKOUT], &mesg);

    ExportInteger(3, libData, data, pos, mesg.capabilities);
    ExportString(4, libData, data, pos, mesg.wkt_name, FIT_WORKOUT_MESG_WKT_NAME_COUNT);
    ExportInteger(104, libData, data, pos, mesg.num_valid_steps);
    ExportInteger(105, libData, data, pos, mesg.pool_length);
    ExportInteger(106, libData, data, pos, mesg.sport);
    ExportInteger(107, libData, data, pos, mesg.sub_sport);
    ExportInteger(108, libData, data, pos, mesg.pool_length_unit);

    WriteMessageDefinition(FIT_MESG_NUM_WORKOUT, local_mesg_number, fit_mesg_defs[FIT_MESG_WORKOUT], FIT_WORKOUT_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_WORKOUT_MESG_SIZE, fp);
}


static void export_workout_session(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_WORKOUT_SESSION_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_WORKOUT_SESSION], &mesg);

    ExportInteger(3, libData, data, pos, mesg.message_index);
    ExportInteger(4, libData, data, pos, mesg.num_valid_steps);
    ExportInteger(5, libData, data, pos, mesg.first_step_index);
    ExportInteger(6, libData, data, pos, mesg.pool_length);
    ExportInteger(7, libData, data, pos, mesg.sport);
    ExportInteger(8, libData, data, pos, mesg.sub_sport);
    ExportInteger(9, libData, data, pos, mesg.pool_length_unit);

    WriteMessageDefinition(FIT_MESG_NUM_WORKOUT_SESSION, local_mesg_number, fit_mesg_defs[FIT_MESG_WORKOUT_SESSION], FIT_WORKOUT_SESSION_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_WORKOUT_SESSION_MESG_SIZE, fp);
}


static void export_workout_step(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_WORKOUT_STEP_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_WORKOUT_STEP], &mesg);

    ExportString(3, libData, data, pos, mesg.wkt_step_name, FIT_WORKOUT_STEP_MESG_WKT_STEP_NAME_COUNT);
    ExportInteger(51, libData, data, pos, mesg.duration_value);
    ExportInteger(52, libData, data, pos, mesg.target_value);
    ExportInteger(53, libData, data, pos, mesg.custom_target_value_low);
    ExportInteger(54, libData, data, pos, mesg.custom_target_value_high);
    ExportInteger(55, libData, data, pos, mesg.secondary_target_value);
    ExportInteger(56, libData, data, pos, mesg.secondary_custom_target_value_low);
    ExportInteger(57, libData, data, pos, mesg.secondary_custom_target_value_high);
    ExportInteger(58, libData, data, pos, mesg.message_index);
    ExportInteger(59, libData, data, pos, mesg.exercise_category);
    ExportInteger(60, libData, data, pos, mesg.exercise_name);
    ExportInteger(61, libData, data, pos, mesg.exercise_weight);
    ExportInteger(62, libData, data, pos, mesg.weight_display_unit);
    ExportInteger(63, libData, data, pos, mesg.duration_type);
    ExportInteger(64, libData, data, pos, mesg.target_type);
    ExportInteger(65, libData, data, pos, mesg.intensity);
    ExportString(66, libData, data, pos, mesg.notes, FIT_WORKOUT_STEP_MESG_NOTES_COUNT);
    ExportInteger(116, libData, data, pos, mesg.equipment);
    ExportInteger(117, libData, data, pos, mesg.secondary_target_type);

    WriteMessageDefinition(FIT_MESG_NUM_WORKOUT_STEP, local_mesg_number, fit_mesg_defs[FIT_MESG_WORKOUT_STEP], FIT_WORKOUT_STEP_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_WORKOUT_STEP_MESG_SIZE, fp);
}


static void export_exercise_title(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_EXERCISE_TITLE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_EXERCISE_TITLE], &mesg);

    ExportString(3, libData, data, pos, mesg.wkt_step_name, FIT_EXERCISE_TITLE_MESG_WKT_STEP_NAME_COUNT);
    ExportInteger(51, libData, data, pos, mesg.message_index);
    ExportInteger(52, libData, data, pos, mesg.exercise_category);
    ExportInteger(53, libData, data, pos, mesg.exercise_name);

    WriteMessageDefinition(FIT_MESG_NUM_EXERCISE_TITLE, local_mesg_number, fit_mesg_defs[FIT_MESG_EXERCISE_TITLE], FIT_EXERCISE_TITLE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_EXERCISE_TITLE_MESG_SIZE, fp);
}


static void export_schedule(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SCHEDULE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SCHEDULE], &mesg);

    ExportInteger(3, libData, data, pos, mesg.serial_number);
    ExportTimestamp(4, libData, data, pos, mesg.time_created);
    ExportTimestamp(5, libData, data, pos, mesg.scheduled_time);
    ExportInteger(6, libData, data, pos, mesg.manufacturer);
    ExportInteger(7, libData, data, pos, mesg.product);
    ExportInteger(8, libData, data, pos, mesg.completed);
    ExportInteger(9, libData, data, pos, mesg.type);

    WriteMessageDefinition(FIT_MESG_NUM_SCHEDULE, local_mesg_number, fit_mesg_defs[FIT_MESG_SCHEDULE], FIT_SCHEDULE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SCHEDULE_MESG_SIZE, fp);
}


static void export_totals(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_TOTALS_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_TOTALS], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.timer_time);
    ExportInteger(5, libData, data, pos, mesg.distance);
    ExportInteger(6, libData, data, pos, mesg.calories);
    ExportInteger(7, libData, data, pos, mesg.elapsed_time);
    ExportInteger(8, libData, data, pos, mesg.active_time);
    ExportInteger(9, libData, data, pos, mesg.message_index);
    ExportInteger(10, libData, data, pos, mesg.sessions);
    ExportInteger(11, libData, data, pos, mesg.sport);
    ExportInteger(12, libData, data, pos, mesg.sport_index);

    WriteMessageDefinition(FIT_MESG_NUM_TOTALS, local_mesg_number, fit_mesg_defs[FIT_MESG_TOTALS], FIT_TOTALS_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_TOTALS_MESG_SIZE, fp);
}


static void export_weight_scale(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_WEIGHT_SCALE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_WEIGHT_SCALE], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.weight);
    ExportInteger(5, libData, data, pos, mesg.percent_fat);
    ExportInteger(6, libData, data, pos, mesg.percent_hydration);
    ExportInteger(7, libData, data, pos, mesg.visceral_fat_mass);
    ExportInteger(8, libData, data, pos, mesg.bone_mass);
    ExportInteger(9, libData, data, pos, mesg.muscle_mass);
    ExportInteger(10, libData, data, pos, mesg.basal_met);
    ExportInteger(11, libData, data, pos, mesg.active_met);
    ExportInteger(12, libData, data, pos, mesg.user_profile_index);
    ExportInteger(13, libData, data, pos, mesg.physique_rating);
    ExportInteger(14, libData, data, pos, mesg.metabolic_age);
    ExportInteger(15, libData, data, pos, mesg.visceral_fat_rating);

    WriteMessageDefinition(FIT_MESG_NUM_WEIGHT_SCALE, local_mesg_number, fit_mesg_defs[FIT_MESG_WEIGHT_SCALE], FIT_WEIGHT_SCALE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_WEIGHT_SCALE_MESG_SIZE, fp);
}


static void export_blood_pressure(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_BLOOD_PRESSURE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_BLOOD_PRESSURE], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.systolic_pressure);
    ExportInteger(5, libData, data, pos, mesg.diastolic_pressure);
    ExportInteger(6, libData, data, pos, mesg.mean_arterial_pressure);
    ExportInteger(7, libData, data, pos, mesg.map_3_sample_mean);
    ExportInteger(8, libData, data, pos, mesg.map_morning_values);
    ExportInteger(9, libData, data, pos, mesg.map_evening_values);
    ExportInteger(10, libData, data, pos, mesg.user_profile_index);
    ExportInteger(11, libData, data, pos, mesg.heart_rate);
    ExportInteger(12, libData, data, pos, mesg.heart_rate_type);
    ExportInteger(13, libData, data, pos, mesg.status);

    WriteMessageDefinition(FIT_MESG_NUM_BLOOD_PRESSURE, local_mesg_number, fit_mesg_defs[FIT_MESG_BLOOD_PRESSURE], FIT_BLOOD_PRESSURE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_BLOOD_PRESSURE_MESG_SIZE, fp);
}


static void export_monitoring_info(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_MONITORING_INFO_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_MONITORING_INFO], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportTimestamp(4, libData, data, pos, mesg.local_timestamp);
    ExportIntegerSequence(5, libData, data, pos, mesg.cycles_to_distance, FIT_MONITORING_INFO_MESG_CYCLES_TO_DISTANCE_COUNT);
    ExportIntegerSequence(6, libData, data, pos, mesg.cycles_to_calories, FIT_MONITORING_INFO_MESG_CYCLES_TO_CALORIES_COUNT);
    ExportInteger(7, libData, data, pos, mesg.resting_metabolic_rate);
    ExportIntegerSequence(8, libData, data, pos, mesg.activity_type, FIT_MONITORING_INFO_MESG_ACTIVITY_TYPE_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_MONITORING_INFO, local_mesg_number, fit_mesg_defs[FIT_MESG_MONITORING_INFO], FIT_MONITORING_INFO_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_MONITORING_INFO_MESG_SIZE, fp);
}


static void export_monitoring(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_MONITORING_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_MONITORING], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.distance);
    ExportInteger(5, libData, data, pos, mesg.cycles);
    ExportInteger(6, libData, data, pos, mesg.active_time);
    ExportTimestamp(7, libData, data, pos, mesg.local_timestamp);
    ExportIntegerSequence(8, libData, data, pos, mesg.activity_time, FIT_MONITORING_MESG_ACTIVITY_TIME_COUNT);
    ExportInteger(16, libData, data, pos, mesg.duration);
    ExportInteger(17, libData, data, pos, mesg.ascent);
    ExportInteger(18, libData, data, pos, mesg.descent);
    ExportInteger(19, libData, data, pos, mesg.calories);
    ExportInteger(20, libData, data, pos, mesg.distance_16);
    ExportInteger(21, libData, data, pos, mesg.cycles_16);
    ExportInteger(22, libData, data, pos, mesg.active_time_16);
    ExportInteger(23, libData, data, pos, mesg.temperature);
    ExportInteger(24, libData, data, pos, mesg.temperature_min);
    ExportInteger(25, libData, data, pos, mesg.temperature_max);
    ExportInteger(26, libData, data, pos, mesg.active_calories);
    ExportInteger(27, libData, data, pos, mesg.timestamp_16);
    ExportInteger(28, libData, data, pos, mesg.duration_min);
    ExportInteger(29, libData, data, pos, mesg.moderate_activity_minutes);
    ExportInteger(30, libData, data, pos, mesg.vigorous_activity_minutes);
    ExportInteger(31, libData, data, pos, mesg.device_index);
    ExportInteger(32, libData, data, pos, mesg.activity_type);
    ExportInteger(33, libData, data, pos, mesg.activity_subtype);
    ExportInteger(34, libData, data, pos, mesg.activity_level);
    ExportInteger(35, libData, data, pos, mesg.current_activity_type_intensity);
    ExportInteger(36, libData, data, pos, mesg.timestamp_min_8);
    ExportInteger(37, libData, data, pos, mesg.heart_rate);
    ExportInteger(38, libData, data, pos, mesg.intensity);

    WriteMessageDefinition(FIT_MESG_NUM_MONITORING, local_mesg_number, fit_mesg_defs[FIT_MESG_MONITORING], FIT_MONITORING_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_MONITORING_MESG_SIZE, fp);
}


static void export_hr(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_HR_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_HR], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportIntegerSequence(4, libData, data, pos, mesg.event_timestamp, FIT_HR_MESG_EVENT_TIMESTAMP_COUNT);
    ExportInteger(5, libData, data, pos, mesg.fractional_timestamp);
    ExportInteger(6, libData, data, pos, mesg.time256);
    ExportIntegerSequence(7, libData, data, pos, mesg.filtered_bpm, FIT_HR_MESG_FILTERED_BPM_COUNT);
    ExportIntegerSequence(8, libData, data, pos, mesg.event_timestamp_12, FIT_HR_MESG_EVENT_TIMESTAMP_12_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_HR, local_mesg_number, fit_mesg_defs[FIT_MESG_HR], FIT_HR_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_HR_MESG_SIZE, fp);
}


static void export_stress_level(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_STRESS_LEVEL_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_STRESS_LEVEL], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.stress_level_time);
    ExportInteger(4, libData, data, pos, mesg.stress_level_value);

    WriteMessageDefinition(FIT_MESG_NUM_STRESS_LEVEL, local_mesg_number, fit_mesg_defs[FIT_MESG_STRESS_LEVEL], FIT_STRESS_LEVEL_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_STRESS_LEVEL_MESG_SIZE, fp);
}


static void export_memo_glob(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_MEMO_GLOB_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_MEMO_GLOB], &mesg);

    ExportInteger(3, libData, data, pos, mesg.part_index);
    ExportInteger(4, libData, data, pos, mesg.mesg_num);
    ExportInteger(5, libData, data, pos, mesg.parent_index);
    ExportIntegerSequence(6, libData, data, pos, mesg.memo, FIT_MEMO_GLOB_MESG_MEMO_COUNT);
    ExportInteger(56, libData, data, pos, mesg.field_num);
    ExportIntegerSequence(57, libData, data, pos, mesg.data, FIT_MEMO_GLOB_MESG_DATA_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_MEMO_GLOB, local_mesg_number, fit_mesg_defs[FIT_MESG_MEMO_GLOB], FIT_MEMO_GLOB_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_MEMO_GLOB_MESG_SIZE, fp);
}


static void export_ant_channel_id(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_ANT_CHANNEL_ID_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_ANT_CHANNEL_ID], &mesg);

    ExportInteger(3, libData, data, pos, mesg.device_number);
    ExportInteger(4, libData, data, pos, mesg.channel_number);
    ExportInteger(5, libData, data, pos, mesg.device_type);
    ExportInteger(6, libData, data, pos, mesg.transmission_type);
    ExportInteger(7, libData, data, pos, mesg.device_index);

    WriteMessageDefinition(FIT_MESG_NUM_ANT_CHANNEL_ID, local_mesg_number, fit_mesg_defs[FIT_MESG_ANT_CHANNEL_ID], FIT_ANT_CHANNEL_ID_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_ANT_CHANNEL_ID_MESG_SIZE, fp);
}


static void export_ant_rx(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_ANT_RX_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_ANT_RX], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportIntegerSequence(4, libData, data, pos, mesg.data, FIT_ANT_RX_MESG_DATA_COUNT);
    ExportInteger(12, libData, data, pos, mesg.fractional_timestamp);
    ExportInteger(13, libData, data, pos, mesg.mesg_id);
    ExportIntegerSequence(14, libData, data, pos, mesg.mesg_data, FIT_ANT_RX_MESG_MESG_DATA_COUNT);
    ExportInteger(23, libData, data, pos, mesg.channel_number);

    WriteMessageDefinition(FIT_MESG_NUM_ANT_RX, local_mesg_number, fit_mesg_defs[FIT_MESG_ANT_RX], FIT_ANT_RX_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_ANT_RX_MESG_SIZE, fp);
}


static void export_ant_tx(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_ANT_TX_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_ANT_TX], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportIntegerSequence(4, libData, data, pos, mesg.data, FIT_ANT_TX_MESG_DATA_COUNT);
    ExportInteger(12, libData, data, pos, mesg.fractional_timestamp);
    ExportInteger(13, libData, data, pos, mesg.mesg_id);
    ExportIntegerSequence(14, libData, data, pos, mesg.mesg_data, FIT_ANT_TX_MESG_MESG_DATA_COUNT);
    ExportInteger(23, libData, data, pos, mesg.channel_number);

    WriteMessageDefinition(FIT_MESG_NUM_ANT_TX, local_mesg_number, fit_mesg_defs[FIT_MESG_ANT_TX], FIT_ANT_TX_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_ANT_TX_MESG_SIZE, fp);
}


static void export_exd_screen_configuration(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_EXD_SCREEN_CONFIGURATION_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_EXD_SCREEN_CONFIGURATION], &mesg);

    ExportInteger(3, libData, data, pos, mesg.screen_index);
    ExportInteger(4, libData, data, pos, mesg.field_count);
    ExportInteger(5, libData, data, pos, mesg.layout);
    ExportInteger(6, libData, data, pos, mesg.screen_enabled);

    WriteMessageDefinition(FIT_MESG_NUM_EXD_SCREEN_CONFIGURATION, local_mesg_number, fit_mesg_defs[FIT_MESG_EXD_SCREEN_CONFIGURATION], FIT_EXD_SCREEN_CONFIGURATION_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_EXD_SCREEN_CONFIGURATION_MESG_SIZE, fp);
}


static void export_exd_data_field_configuration(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_EXD_DATA_FIELD_CONFIGURATION_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_EXD_DATA_FIELD_CONFIGURATION], &mesg);

    ExportInteger(3, libData, data, pos, mesg.screen_index);
    ExportInteger(4, libData, data, pos, mesg.concept_field);
    ExportInteger(5, libData, data, pos, mesg.field_id);
    ExportInteger(6, libData, data, pos, mesg.concept_count);
    ExportInteger(7, libData, data, pos, mesg.display_type);
    ExportString(8, libData, data, pos, mesg.title, FIT_EXD_DATA_FIELD_CONFIGURATION_MESG_TITLE_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_EXD_DATA_FIELD_CONFIGURATION, local_mesg_number, fit_mesg_defs[FIT_MESG_EXD_DATA_FIELD_CONFIGURATION], FIT_EXD_DATA_FIELD_CONFIGURATION_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_EXD_DATA_FIELD_CONFIGURATION_MESG_SIZE, fp);
}


static void export_exd_data_concept_configuration(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_EXD_DATA_CONCEPT_CONFIGURATION_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_EXD_DATA_CONCEPT_CONFIGURATION], &mesg);

    ExportInteger(3, libData, data, pos, mesg.screen_index);
    ExportInteger(4, libData, data, pos, mesg.concept_field);
    ExportInteger(5, libData, data, pos, mesg.field_id);
    ExportInteger(6, libData, data, pos, mesg.concept_index);
    ExportInteger(7, libData, data, pos, mesg.data_page);
    ExportInteger(8, libData, data, pos, mesg.concept_key);
    ExportInteger(9, libData, data, pos, mesg.scaling);
    ExportInteger(10, libData, data, pos, mesg.data_units);
    ExportInteger(11, libData, data, pos, mesg.qualifier);
    ExportInteger(12, libData, data, pos, mesg.descriptor);
    ExportInteger(13, libData, data, pos, mesg.is_signed);

    WriteMessageDefinition(FIT_MESG_NUM_EXD_DATA_CONCEPT_CONFIGURATION, local_mesg_number, fit_mesg_defs[FIT_MESG_EXD_DATA_CONCEPT_CONFIGURATION], FIT_EXD_DATA_CONCEPT_CONFIGURATION_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_EXD_DATA_CONCEPT_CONFIGURATION_MESG_SIZE, fp);
}


static void export_dive_summary(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_DIVE_SUMMARY_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_DIVE_SUMMARY], &mesg);

    ExportTimestamp(3, libData, data, pos, mesg.timestamp);
    ExportInteger(4, libData, data, pos, mesg.avg_depth);
    ExportInteger(5, libData, data, pos, mesg.max_depth);
    ExportInteger(6, libData, data, pos, mesg.surface_interval);
    ExportInteger(7, libData, data, pos, mesg.dive_number);
    ExportInteger(8, libData, data, pos, mesg.bottom_time);
    ExportInteger(9, libData, data, pos, mesg.avg_ascent_rate);
    ExportInteger(10, libData, data, pos, mesg.avg_descent_rate);
    ExportInteger(11, libData, data, pos, mesg.max_ascent_rate);
    ExportInteger(12, libData, data, pos, mesg.max_descent_rate);
    ExportInteger(13, libData, data, pos, mesg.hang_time);
    ExportInteger(14, libData, data, pos, mesg.reference_mesg);
    ExportInteger(15, libData, data, pos, mesg.reference_index);
    ExportInteger(16, libData, data, pos, mesg.start_n2);
    ExportInteger(17, libData, data, pos, mesg.end_n2);
    ExportInteger(18, libData, data, pos, mesg.o2_toxicity);
    ExportInteger(19, libData, data, pos, mesg.start_cns);
    ExportInteger(20, libData, data, pos, mesg.end_cns);

    WriteMessageDefinition(FIT_MESG_NUM_DIVE_SUMMARY, local_mesg_number, fit_mesg_defs[FIT_MESG_DIVE_SUMMARY], FIT_DIVE_SUMMARY_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_DIVE_SUMMARY_MESG_SIZE, fp);
}


static void export_hrv(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_HRV_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_HRV], &mesg);

    ExportIntegerSequence(3, libData, data, pos, mesg.time, FIT_HRV_MESG_TIME_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_HRV, local_mesg_number, fit_mesg_defs[FIT_MESG_HRV], FIT_HRV_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_HRV_MESG_SIZE, fp);
}


static void export_wxf_expression(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_WXF_EXPRESSION_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_WXF_EXPRESSION], &mesg);

    ExportIntegerSequence(3, libData, data, pos, mesg.uuid, FIT_WXF_EXPRESSION_MESG_UUID_COUNT);
    ExportIntegerSequence(7, libData, data, pos, mesg.wxf, FIT_WXF_EXPRESSION_MESG_WXF_COUNT);
    ExportInteger(135, libData, data, pos, mesg.part_number);
    ExportInteger(136, libData, data, pos, mesg.partial);
    ExportInteger(137, libData, data, pos, mesg.byte_count);

    WriteMessageDefinition(FIT_MESG_NUM_WXF_EXPRESSION, local_mesg_number, fit_mesg_defs[FIT_MESG_WXF_EXPRESSION], FIT_WXF_EXPRESSION_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_WXF_EXPRESSION_MESG_SIZE, fp);
}
// --- END MESSAGE EXPORT FUNCTIONS ---