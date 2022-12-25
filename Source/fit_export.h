#if !defined(FIT_EXPORT_H)
#define FIT_EXPORT_H

#include "WolframLibrary.h"
#include "stdio.h"
#include "string.h"
#include <math.h>

#include "fit_product.h"
#include "fit_crc.h"

// #define REPEAT_MESSAGE_DEFINITIONS

// 2 * PI (3.14159265)
#define TWOPI 6.2831853

// Number of semicircles per meter at the equator
#define SC_PER_M 107.173

#define FromWLTimestamp(t) ((t) - 2840036400)

#define GetInteger(col, libData, data, pos, x) \
    pos[1] = col; \
    libData->MTensor_getInteger(data, pos, x)

#define ExportInteger(col, libData, data, pos, tgt) \
    { \
        mint y = 0; \
        GetInteger(col, libData, data, pos, &y); \
        tgt = y; \
    }

#define ExportTimestamp(col, libData, data, pos, tgt) \
    { \
        mint y = 0; \
        GetInteger(col, libData, data, pos, &y); \
        tgt = FromWLTimestamp(y); \
    }

#define ExportIntegerSequence(col, libData, data, pos, tgt, length) \
    for (int i = 0; i < length; i++) { \
        ExportInteger(col+i, libData, data, pos, tgt[i]); \
    }

#define ExportString(col, libData, data, pos, tgt, length) \
    { \
        FIT_STRING string[length]; \
        for (int i = 0; i < length; i++) { \
            mint ch; \
            ExportInteger(col+i, libData, data, pos, ch); \
            string[i] = (FIT_STRING)ch; \
        } \
        strncpy(tgt, string, length); \
    }

#define ExportFloat32(col, libData, data, pos, tgt) \
    { \
        mint y = 0; \
        GetInteger(col, libData, data, pos, &y); \
        FIT_FLOAT32 z = (FIT_FLOAT32)(y); \
        tgt = z / 65535.0; \
    }

#define ExportFloat64(col, libData, data, pos, tgt) \
    { \
        mint y = 0; \
        GetInteger(col, libData, data, pos, &y); \
        FIT_FLOAT64 z = (FIT_FLOAT64)(y); \
        tgt = z / 65535.0; \
    }

#define ExportFloat32Sequence(col, libData, data, pos, tgt, length) \
    for (int i = 0; i < length; i++) { \
        ExportFloat32(col+i, libData, data, pos, tgt[i]); \
    }

#define ExportFloat64Sequence(col, libData, data, pos, tgt, length) \
    for (int i = 0; i < length; i++) { \
        ExportFloat64(col+i, libData, data, pos, tgt[i]); \
    }

///////////////////////////////////////////////////////////////////////
// Private Function Prototypes
///////////////////////////////////////////////////////////////////////

void WriteFileHeader(FILE *fp);
///////////////////////////////////////////////////////////////////////
// Creates a FIT file. Puts a place-holder for the file header on top of the file.
///////////////////////////////////////////////////////////////////////

void WriteMessageDefinition(FIT_MESG_NUM mesg_num, FIT_UINT8 local_mesg_number, const void *mesg_def_pointer, FIT_UINT16 mesg_def_size, FILE *fp);
void WriteMessageDefinition0(FIT_UINT8 local_mesg_number, const void *mesg_def_pointer, FIT_UINT16 mesg_def_size, FILE *fp);
///////////////////////////////////////////////////////////////////////
// Appends a FIT message definition (including the definition header) to the end of a file.
///////////////////////////////////////////////////////////////////////

void WriteMessageDefinitionWithDevFields
(
	FIT_UINT8 local_mesg_number,
	const void *mesg_def_pointer,
	FIT_UINT8 mesg_def_size,
	FIT_UINT8 number_dev_fields,
	FIT_DEV_FIELD_DEF *dev_field_definitions,
	FILE *fp
);
///////////////////////////////////////////////////////////////////////
// Appends a FIT message definition (including the definition header)
// and additional dev field definition data to the end of a file.
///////////////////////////////////////////////////////////////////////

void WriteMessage(FIT_UINT8 local_mesg_number, const void *mesg_pointer, FIT_UINT16 mesg_size, FILE *fp);
///////////////////////////////////////////////////////////////////////
// Appends a FIT message (including the message header) to the end of a file.
///////////////////////////////////////////////////////////////////////

void WriteDeveloperField(const void* data, FIT_UINT16 data_size, FILE *fp);
///////////////////////////////////////////////////////////////////////
// Appends Developer Fields to a Message
///////////////////////////////////////////////////////////////////////

void WriteData(const void *data, FIT_UINT16 data_size, FILE *fp);



///////////////////////////////////////////////////////////////////////
// --- START MESSAGE EXPORT DECLARATIONS ---
// This section is auto-generated. Do not edit manually.
static void export_file_id(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_file_creator(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_timestamp_correlation(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_software(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_slave_device(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_capabilities(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_file_capabilities(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_mesg_capabilities(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_field_capabilities(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_device_settings(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_user_profile(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_hrm_profile(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_sdm_profile(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_bike_profile(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_connectivity(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_watchface_settings(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_ohr_settings(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_zones_target(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_sport(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_hr_zone(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_speed_zone(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_cadence_zone(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_power_zone(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_met_zone(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_dive_settings(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_dive_alarm(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_dive_gas(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_goal(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_activity(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_session(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_lap(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_length(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_record(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_event(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_device_info(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_device_aux_battery_info(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_training_file(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_weather_conditions(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_weather_alert(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_gps_metadata(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_camera_event(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_gyroscope_data(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_accelerometer_data(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_magnetometer_data(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_barometer_data(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_three_d_sensor_calibration(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_one_d_sensor_calibration(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_video_frame(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_obdii_data(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_nmea_sentence(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_aviation_attitude(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_video(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_video_title(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_video_description(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_video_clip(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_set(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_jump(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_climb_pro(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_field_description(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_developer_data_id(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_course(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_course_point(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_segment_id(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_segment_leaderboard_entry(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_segment_point(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_segment_lap(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_segment_file(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_workout(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_workout_session(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_workout_step(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_exercise_title(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_schedule(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_totals(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_weight_scale(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_blood_pressure(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_monitoring_info(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_monitoring(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_hr(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_stress_level(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_memo_glob(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_ant_channel_id(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_ant_rx(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_ant_tx(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_exd_screen_configuration(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_exd_data_field_configuration(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_exd_data_concept_configuration(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_dive_summary(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_hrv(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_wxf_expression(WolframLibraryData libData, MTensor data, int idx, FILE *fp );
// --- END MESSAGE EXPORT DECLARATIONS ---

#endif // !defined(FIT_EXPORT_H)