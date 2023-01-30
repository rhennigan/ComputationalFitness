#if !defined(FIT_IMPORT_H)
#define FIT_IMPORT_H

#include "WolframLibrary.h"
#include "stdio.h"
#include "string.h"
#include "fit_convert.h"

#define RETURN_PARTIAL_DATA

#define MESSAGE_TENSOR_ROW_WIDTH 173
#define FILE_ID_TENSOR_ROW_WIDTH  27

#define FIT_IMPORT_ERROR_CONVERSION            8
#define FIT_IMPORT_ERROR_UNEXPECTED_EOF        9
#define FIT_IMPORT_ERROR_NOT_FIT_FILE         10
#define FIT_IMPORT_ERROR_UNSUPPORTED_PROTOCOL 11
#define FIT_IMPORT_ERROR_INTERNAL             12
#define FIT_IMPORT_ERROR_OPEN_FILE            13
#define FIT_IMPORT_NO_FILE_ID                 14

#define DONE                             1685024357
#define FIT_MESG_NUM_MESSAGE_INFORMATION 1768842863

#define WLTimestamp(t) ((t) + 2840036400)

#define ImportInteger(col, libData, data, pos, x) \
    pos[1] = col; \
    libData->MTensor_setInteger(data, pos, x)

#define ImportFloat(col, libData, data, pos, x) \
    pos[1] = col; \
    libData->MTensor_setInteger(data, pos, (mint)(65535 * (x)))

#define ImportIntegerSequence(col, libData, data, pos, x, n) \
    for(int i=0; i<n; i++) { \
        pos[1] = col + i; \
        libData->MTensor_setInteger(data, pos, x[i]); \
    }

#define ImportFloatSequence(col, libData, data, pos, x, n) \
    for(int i=0; i<n; i++) { \
        pos[1] = col + i; \
        libData->MTensor_setInteger(data, pos, (mint)(65535 * (x[i]))); \
    }

#define ImportString(col, libData, data, pos, x, n) \
    { \
        FIT_STRING * string = (FIT_STRING *)(x); \
        for(int i=0; i<n; i++) { \
            pos[1] = col + i; \
            libData->MTensor_setInteger(data, pos, string[i]); \
        } \
    }

#define ImportFinish(col, libData, data, pos) \
    pos[1] = col; \
    libData->MTensor_setInteger(data, pos, DONE); \
    for(int i=col + 1; i<=MESSAGE_TENSOR_ROW_WIDTH; i++) { \
        pos[1] = i; \
        libData->MTensor_setInteger(data, pos, 0); \
    }


static int count_fit_messages(        char* input, mint* err );
static int count_usable_fit_messages( char* input, mint* err );

// --- START MESSAGE IMPORT DECLARATIONS ---
// This section is auto-generated. Do not edit manually.
static void import_file_id(WolframLibraryData libData, MTensor data, int idx, const FIT_FILE_ID_MESG *mesg);
static void import_file_creator(WolframLibraryData libData, MTensor data, int idx, const FIT_FILE_CREATOR_MESG *mesg);
static void import_timestamp_correlation(WolframLibraryData libData, MTensor data, int idx, const FIT_TIMESTAMP_CORRELATION_MESG *mesg);
static void import_software(WolframLibraryData libData, MTensor data, int idx, const FIT_SOFTWARE_MESG *mesg);
static void import_slave_device(WolframLibraryData libData, MTensor data, int idx, const FIT_SLAVE_DEVICE_MESG *mesg);
static void import_capabilities(WolframLibraryData libData, MTensor data, int idx, const FIT_CAPABILITIES_MESG *mesg);
static void import_file_capabilities(WolframLibraryData libData, MTensor data, int idx, const FIT_FILE_CAPABILITIES_MESG *mesg);
static void import_mesg_capabilities(WolframLibraryData libData, MTensor data, int idx, const FIT_MESG_CAPABILITIES_MESG *mesg);
static void import_field_capabilities(WolframLibraryData libData, MTensor data, int idx, const FIT_FIELD_CAPABILITIES_MESG *mesg);
static void import_device_settings(WolframLibraryData libData, MTensor data, int idx, const FIT_DEVICE_SETTINGS_MESG *mesg);
static void import_user_profile(WolframLibraryData libData, MTensor data, int idx, const FIT_USER_PROFILE_MESG *mesg);
static void import_hrm_profile(WolframLibraryData libData, MTensor data, int idx, const FIT_HRM_PROFILE_MESG *mesg);
static void import_sdm_profile(WolframLibraryData libData, MTensor data, int idx, const FIT_SDM_PROFILE_MESG *mesg);
static void import_bike_profile(WolframLibraryData libData, MTensor data, int idx, const FIT_BIKE_PROFILE_MESG *mesg);
static void import_connectivity(WolframLibraryData libData, MTensor data, int idx, const FIT_CONNECTIVITY_MESG *mesg);
static void import_watchface_settings(WolframLibraryData libData, MTensor data, int idx, const FIT_WATCHFACE_SETTINGS_MESG *mesg);
static void import_ohr_settings(WolframLibraryData libData, MTensor data, int idx, const FIT_OHR_SETTINGS_MESG *mesg);
static void import_zones_target(WolframLibraryData libData, MTensor data, int idx, const FIT_ZONES_TARGET_MESG *mesg);
static void import_sport(WolframLibraryData libData, MTensor data, int idx, const FIT_SPORT_MESG *mesg);
static void import_hr_zone(WolframLibraryData libData, MTensor data, int idx, const FIT_HR_ZONE_MESG *mesg);
static void import_speed_zone(WolframLibraryData libData, MTensor data, int idx, const FIT_SPEED_ZONE_MESG *mesg);
static void import_cadence_zone(WolframLibraryData libData, MTensor data, int idx, const FIT_CADENCE_ZONE_MESG *mesg);
static void import_power_zone(WolframLibraryData libData, MTensor data, int idx, const FIT_POWER_ZONE_MESG *mesg);
static void import_met_zone(WolframLibraryData libData, MTensor data, int idx, const FIT_MET_ZONE_MESG *mesg);
static void import_dive_settings(WolframLibraryData libData, MTensor data, int idx, const FIT_DIVE_SETTINGS_MESG *mesg);
static void import_dive_alarm(WolframLibraryData libData, MTensor data, int idx, const FIT_DIVE_ALARM_MESG *mesg);
static void import_dive_gas(WolframLibraryData libData, MTensor data, int idx, const FIT_DIVE_GAS_MESG *mesg);
static void import_goal(WolframLibraryData libData, MTensor data, int idx, const FIT_GOAL_MESG *mesg);
static void import_activity(WolframLibraryData libData, MTensor data, int idx, const FIT_ACTIVITY_MESG *mesg);
static void import_session(WolframLibraryData libData, MTensor data, int idx, const FIT_SESSION_MESG *mesg);
static void import_lap(WolframLibraryData libData, MTensor data, int idx, const FIT_LAP_MESG *mesg);
static void import_length(WolframLibraryData libData, MTensor data, int idx, const FIT_LENGTH_MESG *mesg);
static void import_record(WolframLibraryData libData, MTensor data, int idx, const FIT_RECORD_MESG *mesg);
static void import_event(WolframLibraryData libData, MTensor data, int idx, const FIT_EVENT_MESG *mesg);
static void import_device_info(WolframLibraryData libData, MTensor data, int idx, const FIT_DEVICE_INFO_MESG *mesg);
static void import_device_aux_battery_info(WolframLibraryData libData, MTensor data, int idx, const FIT_DEVICE_AUX_BATTERY_INFO_MESG *mesg);
static void import_training_file(WolframLibraryData libData, MTensor data, int idx, const FIT_TRAINING_FILE_MESG *mesg);
static void import_weather_conditions(WolframLibraryData libData, MTensor data, int idx, const FIT_WEATHER_CONDITIONS_MESG *mesg);
static void import_weather_alert(WolframLibraryData libData, MTensor data, int idx, const FIT_WEATHER_ALERT_MESG *mesg);
static void import_gps_metadata(WolframLibraryData libData, MTensor data, int idx, const FIT_GPS_METADATA_MESG *mesg);
static void import_camera_event(WolframLibraryData libData, MTensor data, int idx, const FIT_CAMERA_EVENT_MESG *mesg);
static void import_gyroscope_data(WolframLibraryData libData, MTensor data, int idx, const FIT_GYROSCOPE_DATA_MESG *mesg);
static void import_accelerometer_data(WolframLibraryData libData, MTensor data, int idx, const FIT_ACCELEROMETER_DATA_MESG *mesg);
static void import_magnetometer_data(WolframLibraryData libData, MTensor data, int idx, const FIT_MAGNETOMETER_DATA_MESG *mesg);
static void import_barometer_data(WolframLibraryData libData, MTensor data, int idx, const FIT_BAROMETER_DATA_MESG *mesg);
static void import_three_d_sensor_calibration(WolframLibraryData libData, MTensor data, int idx, const FIT_THREE_D_SENSOR_CALIBRATION_MESG *mesg);
static void import_one_d_sensor_calibration(WolframLibraryData libData, MTensor data, int idx, const FIT_ONE_D_SENSOR_CALIBRATION_MESG *mesg);
static void import_video_frame(WolframLibraryData libData, MTensor data, int idx, const FIT_VIDEO_FRAME_MESG *mesg);
static void import_obdii_data(WolframLibraryData libData, MTensor data, int idx, const FIT_OBDII_DATA_MESG *mesg);
static void import_nmea_sentence(WolframLibraryData libData, MTensor data, int idx, const FIT_NMEA_SENTENCE_MESG *mesg);
static void import_aviation_attitude(WolframLibraryData libData, MTensor data, int idx, const FIT_AVIATION_ATTITUDE_MESG *mesg);
static void import_video(WolframLibraryData libData, MTensor data, int idx, const FIT_VIDEO_MESG *mesg);
static void import_video_title(WolframLibraryData libData, MTensor data, int idx, const FIT_VIDEO_TITLE_MESG *mesg);
static void import_video_description(WolframLibraryData libData, MTensor data, int idx, const FIT_VIDEO_DESCRIPTION_MESG *mesg);
static void import_video_clip(WolframLibraryData libData, MTensor data, int idx, const FIT_VIDEO_CLIP_MESG *mesg);
static void import_set(WolframLibraryData libData, MTensor data, int idx, const FIT_SET_MESG *mesg);
static void import_jump(WolframLibraryData libData, MTensor data, int idx, const FIT_JUMP_MESG *mesg);
static void import_climb_pro(WolframLibraryData libData, MTensor data, int idx, const FIT_CLIMB_PRO_MESG *mesg);
static void import_field_description(WolframLibraryData libData, MTensor data, int idx, const FIT_FIELD_DESCRIPTION_MESG *mesg);
static void import_developer_data_id(WolframLibraryData libData, MTensor data, int idx, const FIT_DEVELOPER_DATA_ID_MESG *mesg);
static void import_course(WolframLibraryData libData, MTensor data, int idx, const FIT_COURSE_MESG *mesg);
static void import_course_point(WolframLibraryData libData, MTensor data, int idx, const FIT_COURSE_POINT_MESG *mesg);
static void import_segment_id(WolframLibraryData libData, MTensor data, int idx, const FIT_SEGMENT_ID_MESG *mesg);
static void import_segment_leaderboard_entry(WolframLibraryData libData, MTensor data, int idx, const FIT_SEGMENT_LEADERBOARD_ENTRY_MESG *mesg);
static void import_segment_point(WolframLibraryData libData, MTensor data, int idx, const FIT_SEGMENT_POINT_MESG *mesg);
static void import_segment_lap(WolframLibraryData libData, MTensor data, int idx, const FIT_SEGMENT_LAP_MESG *mesg);
static void import_segment_file(WolframLibraryData libData, MTensor data, int idx, const FIT_SEGMENT_FILE_MESG *mesg);
static void import_workout(WolframLibraryData libData, MTensor data, int idx, const FIT_WORKOUT_MESG *mesg);
static void import_workout_session(WolframLibraryData libData, MTensor data, int idx, const FIT_WORKOUT_SESSION_MESG *mesg);
static void import_workout_step(WolframLibraryData libData, MTensor data, int idx, const FIT_WORKOUT_STEP_MESG *mesg);
static void import_exercise_title(WolframLibraryData libData, MTensor data, int idx, const FIT_EXERCISE_TITLE_MESG *mesg);
static void import_schedule(WolframLibraryData libData, MTensor data, int idx, const FIT_SCHEDULE_MESG *mesg);
static void import_totals(WolframLibraryData libData, MTensor data, int idx, const FIT_TOTALS_MESG *mesg);
static void import_weight_scale(WolframLibraryData libData, MTensor data, int idx, const FIT_WEIGHT_SCALE_MESG *mesg);
static void import_blood_pressure(WolframLibraryData libData, MTensor data, int idx, const FIT_BLOOD_PRESSURE_MESG *mesg);
static void import_monitoring_info(WolframLibraryData libData, MTensor data, int idx, const FIT_MONITORING_INFO_MESG *mesg);
static void import_monitoring(WolframLibraryData libData, MTensor data, int idx, const FIT_MONITORING_MESG *mesg);
static void import_hr(WolframLibraryData libData, MTensor data, int idx, const FIT_HR_MESG *mesg);
static void import_stress_level(WolframLibraryData libData, MTensor data, int idx, const FIT_STRESS_LEVEL_MESG *mesg);
static void import_memo_glob(WolframLibraryData libData, MTensor data, int idx, const FIT_MEMO_GLOB_MESG *mesg);
static void import_ant_channel_id(WolframLibraryData libData, MTensor data, int idx, const FIT_ANT_CHANNEL_ID_MESG *mesg);
static void import_ant_rx(WolframLibraryData libData, MTensor data, int idx, const FIT_ANT_RX_MESG *mesg);
static void import_ant_tx(WolframLibraryData libData, MTensor data, int idx, const FIT_ANT_TX_MESG *mesg);
static void import_exd_screen_configuration(WolframLibraryData libData, MTensor data, int idx, const FIT_EXD_SCREEN_CONFIGURATION_MESG *mesg);
static void import_exd_data_field_configuration(WolframLibraryData libData, MTensor data, int idx, const FIT_EXD_DATA_FIELD_CONFIGURATION_MESG *mesg);
static void import_exd_data_concept_configuration(WolframLibraryData libData, MTensor data, int idx, const FIT_EXD_DATA_CONCEPT_CONFIGURATION_MESG *mesg);
static void import_dive_summary(WolframLibraryData libData, MTensor data, int idx, const FIT_DIVE_SUMMARY_MESG *mesg);
static void import_hrv(WolframLibraryData libData, MTensor data, int idx, const FIT_HRV_MESG *mesg);
static void import_wxf_expression(WolframLibraryData libData, MTensor data, int idx, const FIT_WXF_EXPRESSION_MESG *mesg);
// --- END MESSAGE IMPORT DECLARATIONS ---

static void import_unknown( WolframLibraryData libData, MTensor data, int idx, int mesgNum, const FIT_UINT8 *mesg );

#endif // !defined(FIT_IMPORT_H)