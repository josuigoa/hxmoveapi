#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#ifdef _WIN32
	#define LIB_EXPORT __declspec(dllexport)
#else
	#define LIB_EXPORT
#endif

LIB_EXPORT bool init();

LIB_EXPORT int count_connected();

LIB_EXPORT bool connect_by_id(int index);

LIB_EXPORT char* get_serial();

LIB_EXPORT void set_led(int r, int g, int b);

LIB_EXPORT void set_rumble(int rumble);

LIB_EXPORT unsigned int get_buttons();

#ifdef __cplusplus
}
#endif