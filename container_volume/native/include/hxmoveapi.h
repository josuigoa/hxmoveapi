#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#ifdef _WIN32
	#define LIB_EXPORT __declspec(dllexport)
#else
	#define LIB_EXPORT
#endif

typedef struct {
	int x;
	int y;
	int z;
} axis_data;
typedef axis_data *axis_data_ptr;

LIB_EXPORT bool init();

LIB_EXPORT int count_connected();

LIB_EXPORT bool connect_by_id(int index);

LIB_EXPORT char* get_serial();

LIB_EXPORT void set_led(int r, int g, int b);

LIB_EXPORT void set_rumble(int rumble);

LIB_EXPORT unsigned int get_buttons();

LIB_EXPORT axis_data_ptr get_accelerometer();

LIB_EXPORT axis_data_ptr get_gyroscope();
	
LIB_EXPORT axis_data_ptr get_magnetometer();

LIB_EXPORT int axis_get_x(axis_data_ptr a);

LIB_EXPORT int axis_get_y(axis_data_ptr a);

LIB_EXPORT int axis_get_z(axis_data_ptr a);

#ifdef __cplusplus
}
#endif