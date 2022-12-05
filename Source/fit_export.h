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

#define GetInteger(libData, data, pos, x) \
    pos[1]++; \
    libData->MTensor_getInteger(data, pos, x)

#define ExportInteger(libData, data, pos, tgt) \
    {mint y = 0; \
    GetInteger(libData, data, pos, &y); \
    tgt = y;}

#define ExportTimestamp(libData, data, pos, tgt) \
    {mint y = 0; \
    GetInteger(libData, data, pos, &y); \
    tgt = FromWLTimestamp(y);}

#define ExportIntegerSequence(libData, data, pos, tgt, length) \
    for (int i = 0; i < length; i++) { \
        ExportInteger(libData, data, pos, tgt[i]); \
    }

#define ExportString(libData, data, pos, tgt, length) \
    { \
        int len = length - 1; \
        char string[length]; \
        for (int i = 0; i < len; i++) { \
            mint ch; \
            ExportInteger(libData, data, pos, ch); \
            string[i] = (char)ch; \
        } \
        string[len] = '\0'; \
        strncpy(tgt, string, length); \
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
static void export_file_id(           WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_user_profile(      WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_activity(          WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_lap(               WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_record(            WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_event(             WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_device_info(       WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_session(           WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_device_settings(   WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_zones_target(      WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_file_creator(      WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_sport(             WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_developer_data_id( WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_field_description( WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_training_file(     WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_hrv(               WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_workout_step(      WolframLibraryData libData, MTensor data, int idx, FILE *fp );
static void export_workout(           WolframLibraryData libData, MTensor data, int idx, FILE *fp );


#endif // !defined(FIT_EXPORT_H)