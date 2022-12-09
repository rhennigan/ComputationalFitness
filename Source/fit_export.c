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
        MArgument_setInteger(Res, m_num);
        FIT_MESG_NUM mesg_num = (FIT_MESG_NUM) m_num;
        switch (mesg_num)
        {
            case FIT_MESG_NUM_FILE_ID:
            {
                export_file_id(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_USER_PROFILE:
            {
                export_user_profile(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_ACTIVITY:
            {
                export_activity(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_LAP:
            {
                export_lap(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_RECORD:
            {
                export_record(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_EVENT:
            {
                export_event(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_DEVICE_INFO:
            {
                export_device_info(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_SESSION:
            {
                export_session(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_DEVICE_SETTINGS:
            {
                export_device_settings(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_ZONES_TARGET:
            {
                export_zones_target(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_FILE_CREATOR:
            {
                export_file_creator(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_SPORT:
            {
                export_sport(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_DEVELOPER_DATA_ID:
            {
                export_developer_data_id(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_FIELD_DESCRIPTION:
            {
                export_field_description(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_TRAINING_FILE:
            {
                export_training_file(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_HRV:
            {
                export_hrv(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_WORKOUT_STEP:
            {
                export_workout_step(libData, data, idx, fp);
                break;
            }
            case FIT_MESG_NUM_WORKOUT:
            {
                export_workout(libData, data, idx, fp);
                break;
            }
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


static void export_file_id(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_FILE_ID_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_FILE_ID], &mesg);

    ExportInteger(libData, data, pos, mesg.serial_number);
    ExportTimestamp(libData, data, pos, mesg.time_created);
    ExportInteger(libData, data, pos, mesg.manufacturer);
    ExportInteger(libData, data, pos, mesg.product);
    ExportInteger(libData, data, pos, mesg.number);
    ExportInteger(libData, data, pos, mesg.type);
    ExportString(libData, data, pos, mesg.product_name, FIT_FILE_ID_MESG_PRODUCT_NAME_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_FILE_ID, local_mesg_number, fit_mesg_defs[FIT_MESG_FILE_ID], FIT_FILE_ID_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_FILE_ID_MESG_SIZE, fp);
}


static void export_user_profile(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_USER_PROFILE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_USER_PROFILE], &mesg);

    ExportInteger(libData, data, pos, mesg.message_index);
    ExportInteger(libData, data, pos, mesg.weight);
    ExportInteger(libData, data, pos, mesg.local_id);
    ExportInteger(libData, data, pos, mesg.user_running_step_length);
    ExportInteger(libData, data, pos, mesg.user_walking_step_length);
    ExportInteger(libData, data, pos, mesg.gender);
    ExportInteger(libData, data, pos, mesg.age);
    ExportInteger(libData, data, pos, mesg.height);
    ExportInteger(libData, data, pos, mesg.language);
    ExportInteger(libData, data, pos, mesg.elev_setting);
    ExportInteger(libData, data, pos, mesg.weight_setting);
    ExportInteger(libData, data, pos, mesg.resting_heart_rate);
    ExportInteger(libData, data, pos, mesg.default_max_running_heart_rate);
    ExportInteger(libData, data, pos, mesg.default_max_biking_heart_rate);
    ExportInteger(libData, data, pos, mesg.default_max_heart_rate);
    ExportInteger(libData, data, pos, mesg.hr_setting);
    ExportInteger(libData, data, pos, mesg.speed_setting);
    ExportInteger(libData, data, pos, mesg.dist_setting);
    ExportInteger(libData, data, pos, mesg.power_setting);
    ExportInteger(libData, data, pos, mesg.activity_class);
    ExportInteger(libData, data, pos, mesg.position_setting);
    ExportInteger(libData, data, pos, mesg.temperature_setting);
    ExportInteger(libData, data, pos, mesg.height_setting);
    ExportString(libData, data, pos, mesg.friendly_name, FIT_USER_PROFILE_MESG_FRIENDLY_NAME_COUNT);
    ExportIntegerSequence(libData, data, pos, mesg.global_id, FIT_USER_PROFILE_MESG_GLOBAL_ID_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_USER_PROFILE, local_mesg_number, fit_mesg_defs[FIT_MESG_USER_PROFILE], FIT_USER_PROFILE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_USER_PROFILE_MESG_SIZE, fp);
}


static void export_activity(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_ACTIVITY_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_ACTIVITY], &mesg);

    ExportTimestamp(libData, data, pos, mesg.timestamp);
    ExportInteger(libData, data, pos, mesg.total_timer_time);
    ExportTimestamp(libData, data, pos, mesg.local_timestamp);
    ExportInteger(libData, data, pos, mesg.num_sessions);
    ExportInteger(libData, data, pos, mesg.type);
    ExportInteger(libData, data, pos, mesg.event);
    ExportInteger(libData, data, pos, mesg.event_type);
    ExportInteger(libData, data, pos, mesg.event_group);

    WriteMessageDefinition(FIT_MESG_NUM_ACTIVITY, local_mesg_number, fit_mesg_defs[FIT_MESG_ACTIVITY], FIT_ACTIVITY_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_ACTIVITY_MESG_SIZE, fp);
}


static void export_lap(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_LAP_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_LAP], &mesg);

    ExportTimestamp(libData, data, pos, mesg.timestamp);
    ExportTimestamp(libData, data, pos, mesg.start_time);
    ExportInteger(libData, data, pos, mesg.start_position_lat);
    ExportInteger(libData, data, pos, mesg.start_position_long);
    ExportInteger(libData, data, pos, mesg.end_position_lat);
    ExportInteger(libData, data, pos, mesg.end_position_long);
    ExportInteger(libData, data, pos, mesg.total_elapsed_time);
    ExportInteger(libData, data, pos, mesg.total_timer_time);
    ExportInteger(libData, data, pos, mesg.total_distance);
    ExportInteger(libData, data, pos, mesg.total_cycles);
    ExportInteger(libData, data, pos, mesg.total_work);
    ExportInteger(libData, data, pos, mesg.total_moving_time);
    ExportInteger(libData, data, pos, mesg.time_in_hr_zone[0]);
    ExportInteger(libData, data, pos, mesg.time_in_speed_zone[0]);
    ExportInteger(libData, data, pos, mesg.time_in_cadence_zone[0]);
    ExportInteger(libData, data, pos, mesg.time_in_power_zone[0]);
    ExportInteger(libData, data, pos, mesg.enhanced_avg_speed);
    ExportInteger(libData, data, pos, mesg.enhanced_max_speed);
    ExportInteger(libData, data, pos, mesg.enhanced_avg_altitude);
    ExportInteger(libData, data, pos, mesg.enhanced_min_altitude);
    ExportInteger(libData, data, pos, mesg.enhanced_max_altitude);
    ExportInteger(libData, data, pos, mesg.message_index);
    ExportInteger(libData, data, pos, mesg.total_calories);
    ExportInteger(libData, data, pos, mesg.total_fat_calories);
    ExportInteger(libData, data, pos, mesg.avg_speed);
    ExportInteger(libData, data, pos, mesg.max_speed);
    ExportInteger(libData, data, pos, mesg.avg_power);
    ExportInteger(libData, data, pos, mesg.max_power);
    ExportInteger(libData, data, pos, mesg.total_ascent);
    ExportInteger(libData, data, pos, mesg.total_descent);
    ExportInteger(libData, data, pos, mesg.num_lengths);
    ExportInteger(libData, data, pos, mesg.normalized_power);
    ExportInteger(libData, data, pos, mesg.left_right_balance);
    ExportInteger(libData, data, pos, mesg.first_length_index);
    ExportInteger(libData, data, pos, mesg.avg_stroke_distance);
    ExportInteger(libData, data, pos, mesg.num_active_lengths);
    ExportInteger(libData, data, pos, mesg.avg_altitude);
    ExportInteger(libData, data, pos, mesg.max_altitude);
    ExportInteger(libData, data, pos, mesg.avg_grade);
    ExportInteger(libData, data, pos, mesg.avg_pos_grade);
    ExportInteger(libData, data, pos, mesg.avg_neg_grade);
    ExportInteger(libData, data, pos, mesg.max_pos_grade);
    ExportInteger(libData, data, pos, mesg.max_neg_grade);
    ExportInteger(libData, data, pos, mesg.avg_pos_vertical_speed);
    ExportInteger(libData, data, pos, mesg.avg_neg_vertical_speed);
    ExportInteger(libData, data, pos, mesg.max_pos_vertical_speed);
    ExportInteger(libData, data, pos, mesg.max_neg_vertical_speed);
    ExportInteger(libData, data, pos, mesg.repetition_num);
    ExportInteger(libData, data, pos, mesg.min_altitude);
    ExportInteger(libData, data, pos, mesg.wkt_step_index);
    ExportInteger(libData, data, pos, mesg.opponent_score);
    ExportInteger(libData, data, pos, mesg.stroke_count[0]);
    ExportInteger(libData, data, pos, mesg.zone_count[0]);
    ExportInteger(libData, data, pos, mesg.avg_vertical_oscillation);
    ExportInteger(libData, data, pos, mesg.avg_stance_time_percent);
    ExportInteger(libData, data, pos, mesg.avg_stance_time);
    ExportInteger(libData, data, pos, mesg.player_score);
    ExportInteger(libData, data, pos, mesg.avg_total_hemoglobin_conc[0]);
    ExportInteger(libData, data, pos, mesg.min_total_hemoglobin_conc[0]);
    ExportInteger(libData, data, pos, mesg.max_total_hemoglobin_conc[0]);
    ExportInteger(libData, data, pos, mesg.avg_saturated_hemoglobin_percent[0]);
    ExportInteger(libData, data, pos, mesg.min_saturated_hemoglobin_percent[0]);
    ExportInteger(libData, data, pos, mesg.max_saturated_hemoglobin_percent[0]);
    ExportInteger(libData, data, pos, mesg.avg_vam);
    ExportInteger(libData, data, pos, mesg.event);
    ExportInteger(libData, data, pos, mesg.event_type);
    ExportInteger(libData, data, pos, mesg.avg_heart_rate);
    ExportInteger(libData, data, pos, mesg.max_heart_rate);
    ExportInteger(libData, data, pos, mesg.avg_cadence);
    ExportInteger(libData, data, pos, mesg.max_cadence);
    ExportInteger(libData, data, pos, mesg.intensity);
    ExportInteger(libData, data, pos, mesg.lap_trigger);
    ExportInteger(libData, data, pos, mesg.sport);
    ExportInteger(libData, data, pos, mesg.event_group);
    ExportInteger(libData, data, pos, mesg.swim_stroke);
    ExportInteger(libData, data, pos, mesg.sub_sport);
    ExportInteger(libData, data, pos, mesg.gps_accuracy);
    ExportInteger(libData, data, pos, mesg.avg_temperature);
    ExportInteger(libData, data, pos, mesg.max_temperature);
    ExportInteger(libData, data, pos, mesg.min_heart_rate);
    ExportInteger(libData, data, pos, mesg.avg_fractional_cadence);
    ExportInteger(libData, data, pos, mesg.max_fractional_cadence);
    ExportInteger(libData, data, pos, mesg.total_fractional_cycles);

    WriteMessageDefinition(FIT_MESG_NUM_LAP, local_mesg_number, fit_mesg_defs[FIT_MESG_LAP], FIT_LAP_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_LAP_MESG_SIZE, fp);
}


static void export_record(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_RECORD_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_RECORD], &mesg);

    ExportTimestamp(libData, data, pos, mesg.timestamp);
    ExportInteger(libData, data, pos, mesg.position_lat);
    ExportInteger(libData, data, pos, mesg.position_long);
    ExportInteger(libData, data, pos, mesg.distance);
    ExportInteger(libData, data, pos, mesg.time_from_course);
    ExportInteger(libData, data, pos, mesg.total_cycles);
    ExportInteger(libData, data, pos, mesg.accumulated_power);
    ExportInteger(libData, data, pos, mesg.enhanced_speed);
    ExportInteger(libData, data, pos, mesg.enhanced_altitude);
    ExportInteger(libData, data, pos, mesg.altitude);
    ExportInteger(libData, data, pos, mesg.speed);
    ExportInteger(libData, data, pos, mesg.power);
    ExportInteger(libData, data, pos, mesg.grade);
    ExportInteger(libData, data, pos, mesg.compressed_accumulated_power);
    ExportInteger(libData, data, pos, mesg.vertical_speed);
    ExportInteger(libData, data, pos, mesg.calories);
    ExportInteger(libData, data, pos, mesg.vertical_oscillation);
    ExportInteger(libData, data, pos, mesg.stance_time_percent);
    ExportInteger(libData, data, pos, mesg.stance_time);
    ExportInteger(libData, data, pos, mesg.ball_speed);
    ExportInteger(libData, data, pos, mesg.cadence256);
    ExportInteger(libData, data, pos, mesg.total_hemoglobin_conc);
    ExportInteger(libData, data, pos, mesg.total_hemoglobin_conc_min);
    ExportInteger(libData, data, pos, mesg.total_hemoglobin_conc_max);
    ExportInteger(libData, data, pos, mesg.saturated_hemoglobin_percent);
    ExportInteger(libData, data, pos, mesg.saturated_hemoglobin_percent_min);
    ExportInteger(libData, data, pos, mesg.saturated_hemoglobin_percent_max);
    ExportInteger(libData, data, pos, mesg.heart_rate);
    ExportInteger(libData, data, pos, mesg.cadence);
    ExportInteger(libData, data, pos, mesg.resistance);
    ExportInteger(libData, data, pos, mesg.cycle_length);
    ExportInteger(libData, data, pos, mesg.temperature);
    ExportInteger(libData, data, pos, mesg.cycles);
    ExportInteger(libData, data, pos, mesg.left_right_balance);
    ExportInteger(libData, data, pos, mesg.gps_accuracy);
    ExportInteger(libData, data, pos, mesg.activity_type);
    ExportInteger(libData, data, pos, mesg.left_torque_effectiveness);
    ExportInteger(libData, data, pos, mesg.right_torque_effectiveness);
    ExportInteger(libData, data, pos, mesg.left_pedal_smoothness);
    ExportInteger(libData, data, pos, mesg.right_pedal_smoothness);
    ExportInteger(libData, data, pos, mesg.combined_pedal_smoothness);
    ExportInteger(libData, data, pos, mesg.time128);
    ExportInteger(libData, data, pos, mesg.stroke_type);
    ExportInteger(libData, data, pos, mesg.zone);
    ExportInteger(libData, data, pos, mesg.fractional_cadence);
    ExportInteger(libData, data, pos, mesg.device_index);
    ExportInteger(libData, data, pos, mesg.left_pco);
    ExportInteger(libData, data, pos, mesg.right_pco);
    ExportInteger(libData, data, pos, mesg.left_power_phase[0]);
    ExportInteger(libData, data, pos, mesg.left_power_phase[1]);
    ExportInteger(libData, data, pos, mesg.left_power_phase_peak[0]);
    ExportInteger(libData, data, pos, mesg.left_power_phase_peak[1]);
    ExportInteger(libData, data, pos, mesg.right_power_phase[0]);
    ExportInteger(libData, data, pos, mesg.right_power_phase[1]);
    ExportInteger(libData, data, pos, mesg.right_power_phase_peak[0]);
    ExportInteger(libData, data, pos, mesg.right_power_phase_peak[1]);
    ExportInteger(libData, data, pos, mesg.battery_soc);
    ExportInteger(libData, data, pos, mesg.motor_power);
    ExportInteger(libData, data, pos, mesg.vertical_ratio);
    ExportInteger(libData, data, pos, mesg.stance_time_balance);
    ExportInteger(libData, data, pos, mesg.step_length);
    ExportInteger(libData, data, pos, mesg.absolute_pressure);

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

    ExportTimestamp(libData, data, pos, mesg.timestamp);
    ExportInteger(libData, data, pos, mesg.data);
    ExportInteger(libData, data, pos, mesg.data16);
    ExportInteger(libData, data, pos, mesg.score);
    ExportInteger(libData, data, pos, mesg.opponent_score);
    ExportInteger(libData, data, pos, mesg.event);
    ExportInteger(libData, data, pos, mesg.event_type);
    ExportInteger(libData, data, pos, mesg.event_group);
    ExportInteger(libData, data, pos, mesg.front_gear_num);
    ExportInteger(libData, data, pos, mesg.front_gear);
    ExportInteger(libData, data, pos, mesg.rear_gear_num);
    ExportInteger(libData, data, pos, mesg.rear_gear);
    ExportInteger(libData, data, pos, mesg.radar_threat_level_max);
    ExportInteger(libData, data, pos, mesg.radar_threat_count);

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

    ExportTimestamp(libData, data, pos, mesg.timestamp);
    ExportInteger(libData, data, pos, mesg.serial_number);
    ExportInteger(libData, data, pos, mesg.cum_operating_time);
    ExportInteger(libData, data, pos, mesg.manufacturer);
    ExportInteger(libData, data, pos, mesg.product);
    ExportInteger(libData, data, pos, mesg.software_version);
    ExportInteger(libData, data, pos, mesg.battery_voltage);
    ExportInteger(libData, data, pos, mesg.ant_device_number);
    ExportInteger(libData, data, pos, mesg.device_index);
    ExportInteger(libData, data, pos, mesg.device_type);
    ExportInteger(libData, data, pos, mesg.hardware_version);
    ExportInteger(libData, data, pos, mesg.battery_status);
    ExportInteger(libData, data, pos, mesg.sensor_position);
    ExportInteger(libData, data, pos, mesg.ant_transmission_type);
    ExportInteger(libData, data, pos, mesg.ant_network);
    ExportInteger(libData, data, pos, mesg.source_type);
    ExportString(libData, data, pos, mesg.product_name, FIT_DEVICE_INFO_MESG_PRODUCT_NAME_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_DEVICE_INFO, local_mesg_number, fit_mesg_defs[FIT_MESG_DEVICE_INFO], FIT_DEVICE_INFO_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_DEVICE_INFO_MESG_SIZE, fp);
}


static void export_session(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SESSION_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SESSION], &mesg);

    ExportInteger(libData, data, pos, mesg.start_position_lat);
    ExportInteger(libData, data, pos, mesg.start_position_long);
    ExportInteger(libData, data, pos, mesg.total_elapsed_time);
    ExportInteger(libData, data, pos, mesg.total_timer_time);
    ExportInteger(libData, data, pos, mesg.total_distance);
    ExportInteger(libData, data, pos, mesg.total_cycles);
    ExportInteger(libData, data, pos, mesg.nec_lat);
    ExportInteger(libData, data, pos, mesg.nec_long);
    ExportInteger(libData, data, pos, mesg.swc_lat);
    ExportInteger(libData, data, pos, mesg.swc_long);
    ExportInteger(libData, data, pos, mesg.avg_stroke_count);
    ExportInteger(libData, data, pos, mesg.total_work);
    ExportInteger(libData, data, pos, mesg.total_moving_time);
    ExportInteger(libData, data, pos, mesg.avg_lap_time);
    ExportInteger(libData, data, pos, mesg.enhanced_avg_speed);
    ExportInteger(libData, data, pos, mesg.enhanced_max_speed);
    ExportInteger(libData, data, pos, mesg.enhanced_avg_altitude);
    ExportInteger(libData, data, pos, mesg.enhanced_min_altitude);
    ExportInteger(libData, data, pos, mesg.enhanced_max_altitude);
    ExportInteger(libData, data, pos, mesg.message_index);
    ExportInteger(libData, data, pos, mesg.total_calories);
    ExportInteger(libData, data, pos, mesg.total_fat_calories);
    ExportInteger(libData, data, pos, mesg.avg_speed);
    ExportInteger(libData, data, pos, mesg.max_speed);
    ExportInteger(libData, data, pos, mesg.avg_power);
    ExportInteger(libData, data, pos, mesg.max_power);
    ExportInteger(libData, data, pos, mesg.total_ascent);
    ExportInteger(libData, data, pos, mesg.total_descent);
    ExportInteger(libData, data, pos, mesg.first_lap_index);
    ExportInteger(libData, data, pos, mesg.num_laps);
    ExportInteger(libData, data, pos, mesg.num_lengths);
    ExportInteger(libData, data, pos, mesg.normalized_power);
    ExportInteger(libData, data, pos, mesg.training_stress_score);
    ExportInteger(libData, data, pos, mesg.intensity_factor);
    ExportInteger(libData, data, pos, mesg.left_right_balance);
    ExportInteger(libData, data, pos, mesg.avg_stroke_distance);
    ExportInteger(libData, data, pos, mesg.pool_length);
    ExportInteger(libData, data, pos, mesg.threshold_power);
    ExportInteger(libData, data, pos, mesg.num_active_lengths);
    ExportInteger(libData, data, pos, mesg.avg_altitude);
    ExportInteger(libData, data, pos, mesg.max_altitude);
    ExportInteger(libData, data, pos, mesg.avg_grade);
    ExportInteger(libData, data, pos, mesg.avg_pos_grade);
    ExportInteger(libData, data, pos, mesg.avg_neg_grade);
    ExportInteger(libData, data, pos, mesg.max_pos_grade);
    ExportInteger(libData, data, pos, mesg.max_neg_grade);
    ExportInteger(libData, data, pos, mesg.avg_pos_vertical_speed);
    ExportInteger(libData, data, pos, mesg.avg_neg_vertical_speed);
    ExportInteger(libData, data, pos, mesg.max_pos_vertical_speed);
    ExportInteger(libData, data, pos, mesg.max_neg_vertical_speed);
    ExportInteger(libData, data, pos, mesg.best_lap_index);
    ExportInteger(libData, data, pos, mesg.min_altitude);
    ExportInteger(libData, data, pos, mesg.player_score);
    ExportInteger(libData, data, pos, mesg.opponent_score);
    ExportInteger(libData, data, pos, mesg.max_ball_speed);
    ExportInteger(libData, data, pos, mesg.avg_ball_speed);
    ExportInteger(libData, data, pos, mesg.avg_vertical_oscillation);
    ExportInteger(libData, data, pos, mesg.avg_stance_time_percent);
    ExportInteger(libData, data, pos, mesg.avg_stance_time);
    ExportInteger(libData, data, pos, mesg.avg_vam);
    ExportInteger(libData, data, pos, mesg.event);
    ExportInteger(libData, data, pos, mesg.event_type);
    ExportInteger(libData, data, pos, mesg.sport);
    ExportInteger(libData, data, pos, mesg.sub_sport);
    ExportInteger(libData, data, pos, mesg.avg_heart_rate);
    ExportInteger(libData, data, pos, mesg.max_heart_rate);
    ExportInteger(libData, data, pos, mesg.avg_cadence);
    ExportInteger(libData, data, pos, mesg.max_cadence);
    ExportInteger(libData, data, pos, mesg.total_training_effect);
    ExportInteger(libData, data, pos, mesg.event_group);
    ExportInteger(libData, data, pos, mesg.trigger);
    ExportInteger(libData, data, pos, mesg.swim_stroke);
    ExportInteger(libData, data, pos, mesg.pool_length_unit);
    ExportInteger(libData, data, pos, mesg.gps_accuracy);
    ExportInteger(libData, data, pos, mesg.avg_temperature);
    ExportInteger(libData, data, pos, mesg.max_temperature);
    ExportInteger(libData, data, pos, mesg.min_heart_rate);
    ExportInteger(libData, data, pos, mesg.avg_fractional_cadence);
    ExportInteger(libData, data, pos, mesg.max_fractional_cadence);
    ExportInteger(libData, data, pos, mesg.total_fractional_cycles);
    ExportInteger(libData, data, pos, mesg.sport_index);
    ExportInteger(libData, data, pos, mesg.total_anaerobic_training_effect);
    ExportInteger(libData, data, pos, mesg.avg_left_pco);
    ExportInteger(libData, data, pos, mesg.avg_right_pco);
    ExportInteger(libData, data, pos, mesg.avg_left_power_phase[0]);
    ExportInteger(libData, data, pos, mesg.avg_left_power_phase[1]);
    ExportInteger(libData, data, pos, mesg.avg_left_power_phase_peak[0]);
    ExportInteger(libData, data, pos, mesg.avg_left_power_phase_peak[1]);
    ExportInteger(libData, data, pos, mesg.avg_right_power_phase[0]);
    ExportInteger(libData, data, pos, mesg.avg_right_power_phase[1]);
    ExportInteger(libData, data, pos, mesg.avg_right_power_phase_peak[0]);
    ExportInteger(libData, data, pos, mesg.avg_right_power_phase_peak[1]);

    WriteMessageDefinition(FIT_MESG_NUM_SESSION, local_mesg_number, fit_mesg_defs[FIT_MESG_SESSION], FIT_SESSION_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SESSION_MESG_SIZE, fp);
}


static void export_device_settings(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_DEVICE_SETTINGS_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_DEVICE_SETTINGS], &mesg);

    ExportInteger(libData, data, pos, mesg.utc_offset);
    ExportInteger(libData, data, pos, mesg.time_offset[0]);
    ExportInteger(libData, data, pos, mesg.time_offset[1]);
    ExportTimestamp(libData, data, pos, mesg.clock_time);
    ExportInteger(libData, data, pos, mesg.pages_enabled[0]);
    ExportInteger(libData, data, pos, mesg.default_page[0]);
    ExportInteger(libData, data, pos, mesg.autosync_min_steps);
    ExportInteger(libData, data, pos, mesg.autosync_min_time);
    ExportInteger(libData, data, pos, mesg.active_time_zone);
    ExportInteger(libData, data, pos, mesg.time_mode[0]);
    ExportInteger(libData, data, pos, mesg.time_mode[1]);
    ExportInteger(libData, data, pos, mesg.time_zone_offset[0]);
    ExportInteger(libData, data, pos, mesg.time_zone_offset[1]);
    ExportInteger(libData, data, pos, mesg.backlight_mode);
    ExportInteger(libData, data, pos, mesg.activity_tracker_enabled);
    ExportInteger(libData, data, pos, mesg.move_alert_enabled);
    ExportInteger(libData, data, pos, mesg.date_mode);
    ExportInteger(libData, data, pos, mesg.display_orientation);
    ExportInteger(libData, data, pos, mesg.mounting_side);
    ExportInteger(libData, data, pos, mesg.tap_sensitivity);

    WriteMessageDefinition(FIT_MESG_NUM_DEVICE_SETTINGS, local_mesg_number, fit_mesg_defs[FIT_MESG_DEVICE_SETTINGS], FIT_DEVICE_SETTINGS_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_DEVICE_SETTINGS_MESG_SIZE, fp);
}


static void export_zones_target(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_ZONES_TARGET_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_ZONES_TARGET], &mesg);

    ExportInteger(libData, data, pos, mesg.functional_threshold_power);
    ExportInteger(libData, data, pos, mesg.max_heart_rate);
    ExportInteger(libData, data, pos, mesg.threshold_heart_rate);
    ExportInteger(libData, data, pos, mesg.hr_calc_type);
    ExportInteger(libData, data, pos, mesg.pwr_calc_type);

    WriteMessageDefinition(FIT_MESG_NUM_ZONES_TARGET, local_mesg_number, fit_mesg_defs[FIT_MESG_ZONES_TARGET], FIT_ZONES_TARGET_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_ZONES_TARGET_MESG_SIZE, fp);
}


static void export_file_creator(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_FILE_CREATOR_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_FILE_CREATOR], &mesg);

    ExportInteger(libData, data, pos, mesg.software_version );
    ExportInteger(libData, data, pos, mesg.hardware_version );

    WriteMessageDefinition(FIT_MESG_NUM_FILE_CREATOR, local_mesg_number, fit_mesg_defs[FIT_MESG_FILE_CREATOR], FIT_FILE_CREATOR_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_FILE_CREATOR_MESG_SIZE, fp);
}


static void export_sport(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_SPORT_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_SPORT], &mesg);

    ExportString(libData, data, pos, mesg.name, FIT_SPORT_MESG_NAME_COUNT);
    ExportInteger(libData, data, pos, mesg.sport);
    ExportInteger(libData, data, pos, mesg.sub_sport);

    WriteMessageDefinition(FIT_MESG_NUM_SPORT, local_mesg_number, fit_mesg_defs[FIT_MESG_SPORT], FIT_SPORT_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_SPORT_MESG_SIZE, fp);
}


static void export_developer_data_id(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_DEVELOPER_DATA_ID_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_DEVELOPER_DATA_ID], &mesg);

    ExportIntegerSequence(libData, data, pos, mesg.developer_id, FIT_DEVELOPER_DATA_ID_MESG_DEVELOPER_ID_COUNT);
    ExportIntegerSequence(libData, data, pos, mesg.application_id, FIT_DEVELOPER_DATA_ID_MESG_APPLICATION_ID_COUNT);
    ExportInteger(libData, data, pos, mesg.application_version);
    ExportInteger(libData, data, pos, mesg.manufacturer_id);
    ExportInteger(libData, data, pos, mesg.developer_data_index);

    WriteMessageDefinition(FIT_MESG_NUM_DEVELOPER_DATA_ID, local_mesg_number, fit_mesg_defs[FIT_MESG_DEVELOPER_DATA_ID], FIT_DEVELOPER_DATA_ID_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_DEVELOPER_DATA_ID_MESG_SIZE, fp);
}


static void export_field_description(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_FIELD_DESCRIPTION_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_FIELD_DESCRIPTION], &mesg);

    ExportString(libData, data, pos, mesg.field_name, FIT_FIELD_DESCRIPTION_MESG_FIELD_NAME_COUNT);
    ExportString(libData, data, pos, mesg.units, FIT_FIELD_DESCRIPTION_MESG_UNITS_COUNT);
    ExportInteger(libData, data, pos, mesg.fit_base_unit_id);
    ExportInteger(libData, data, pos, mesg.native_mesg_num);
    ExportInteger(libData, data, pos, mesg.developer_data_index);
    ExportInteger(libData, data, pos, mesg.field_definition_number);
    ExportInteger(libData, data, pos, mesg.fit_base_type_id);
    ExportInteger(libData, data, pos, mesg.scale);
    ExportInteger(libData, data, pos, mesg.offset);
    ExportInteger(libData, data, pos, mesg.native_field_num);

    WriteMessageDefinition(FIT_MESG_NUM_FIELD_DESCRIPTION, local_mesg_number, fit_mesg_defs[FIT_MESG_FIELD_DESCRIPTION], FIT_FIELD_DESCRIPTION_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_FIELD_DESCRIPTION_MESG_SIZE, fp);
}


static void export_training_file(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_TRAINING_FILE_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_TRAINING_FILE], &mesg);

    ExportInteger(libData, data, pos, mesg.timestamp);
    ExportInteger(libData, data, pos, mesg.serial_number);
    ExportInteger(libData, data, pos, mesg.time_created);
    ExportInteger(libData, data, pos, mesg.manufacturer);
    ExportInteger(libData, data, pos, mesg.product);
    ExportInteger(libData, data, pos, mesg.type);

    WriteMessageDefinition(FIT_MESG_NUM_TRAINING_FILE, local_mesg_number, fit_mesg_defs[FIT_MESG_TRAINING_FILE], FIT_TRAINING_FILE_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_TRAINING_FILE_MESG_SIZE, fp);
}


static void export_hrv(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_HRV_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_HRV], &mesg);

    ExportIntegerSequence(libData, data, pos, mesg.time, FIT_HRV_MESG_TIME_COUNT);

    WriteMessageDefinition(FIT_MESG_NUM_HRV, local_mesg_number, fit_mesg_defs[FIT_MESG_HRV], FIT_HRV_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_HRV_MESG_SIZE, fp);
}


static void export_workout_step(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_WORKOUT_STEP_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_WORKOUT_STEP], &mesg);

    ExportString(libData, data, pos, mesg.wkt_step_name, FIT_WORKOUT_STEP_MESG_WKT_STEP_NAME_COUNT);
    ExportInteger(libData, data, pos, mesg.duration_value);
    ExportInteger(libData, data, pos, mesg.target_value);
    ExportInteger(libData, data, pos, mesg.custom_target_value_low);
    ExportInteger(libData, data, pos, mesg.custom_target_value_high);
    ExportInteger(libData, data, pos, mesg.secondary_target_value);
    ExportInteger(libData, data, pos, mesg.secondary_custom_target_value_low);
    ExportInteger(libData, data, pos, mesg.secondary_custom_target_value_high);
    ExportInteger(libData, data, pos, mesg.message_index);
    ExportInteger(libData, data, pos, mesg.exercise_category);
    ExportInteger(libData, data, pos, mesg.duration_type);
    ExportInteger(libData, data, pos, mesg.target_type);
    ExportInteger(libData, data, pos, mesg.intensity);
    ExportString(libData, data, pos, mesg.notes, FIT_WORKOUT_STEP_MESG_NOTES_COUNT);
    ExportInteger(libData, data, pos, mesg.equipment);
    ExportInteger(libData, data, pos, mesg.secondary_target_type);

    WriteMessageDefinition(FIT_MESG_NUM_WORKOUT_STEP, local_mesg_number, fit_mesg_defs[FIT_MESG_WORKOUT_STEP], FIT_WORKOUT_STEP_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_WORKOUT_STEP_MESG_SIZE, fp);
}


static void export_workout(WolframLibraryData libData, MTensor data, int idx, FILE *fp) {
    mint pos[2];
    pos[0] = idx;
    pos[1] = 1;
    mint x = 0;

    FIT_UINT8 local_mesg_number = 0;
    FIT_WORKOUT_MESG mesg;
    Fit_InitMesg(fit_mesg_defs[FIT_MESG_WORKOUT], &mesg);

    ExportInteger(libData, data, pos, mesg.capabilities);
    ExportString(libData, data, pos, mesg.wkt_name, FIT_WORKOUT_MESG_WKT_NAME_COUNT);
    ExportInteger(libData, data, pos, mesg.num_valid_steps);
    ExportInteger(libData, data, pos, mesg.pool_length);
    ExportInteger(libData, data, pos, mesg.sport);
    ExportInteger(libData, data, pos, mesg.sub_sport);
    ExportInteger(libData, data, pos, mesg.pool_length_unit);

    WriteMessageDefinition(FIT_MESG_NUM_WORKOUT, local_mesg_number, fit_mesg_defs[FIT_MESG_WORKOUT], FIT_WORKOUT_MESG_DEF_SIZE, fp);
    WriteMessage(local_mesg_number, &mesg, FIT_WORKOUT_MESG_SIZE, fp);
}