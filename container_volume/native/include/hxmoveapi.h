#pragma once

#include "psmoveapi/psmove.h"

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

LIB_EXPORT axis_data_ptr get_accelerometer(PSMove *move);

LIB_EXPORT axis_data_ptr get_gyroscope(PSMove *move);

LIB_EXPORT axis_data_ptr get_magnetometer(PSMove *move);

LIB_EXPORT void free_psmove(PSMove *move);

LIB_EXPORT axis_data_ptr create_axis(int x, int y, int z);

LIB_EXPORT int axis_get_x(axis_data_ptr a);

LIB_EXPORT int axis_get_y(axis_data_ptr a);

LIB_EXPORT int axis_get_z(axis_data_ptr a);

#ifdef __cplusplus
}
#endif