#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "include/hxmoveapi.h"

#ifdef __cplusplus
extern "C" {
#endif

LIB_EXPORT axis_data_ptr create_axis(int x, int y, int z) {
    axis_data_ptr ret = (axis_data_ptr)malloc(sizeof(axis_data));
	ret->x = x;
	ret->y = y;
	ret->z = z;
    
	return ret;
}

LIB_EXPORT void free_psmove(PSMove *move) {
    free(move);
}

LIB_EXPORT axis_data_ptr get_accelerometer(PSMove *move) {
    int x, y, z;
    if (psmove_poll(move)) {
        psmove_get_accelerometer(move, &x, &y, &z);
    }
    
    return create_axis(x, y, z);
}

LIB_EXPORT axis_data_ptr get_gyroscope(PSMove *move) {
    int x, y, z;
    if (psmove_poll(move)) {
        psmove_get_gyroscope(move, &x, &y, &z);
    }
    
    return create_axis(x, y, z);
}

LIB_EXPORT axis_data_ptr get_magnetometer(PSMove *move) {
    int x, y, z;
    if (psmove_poll(move)) {
        psmove_get_magnetometer(move, &x, &y, &z);
    }
    
    return create_axis(x, y, z);
}

LIB_EXPORT int axis_get_x(axis_data_ptr a) {
    return a->x;
}

LIB_EXPORT int axis_get_y(axis_data_ptr a) {
    return a->y;
}

LIB_EXPORT int axis_get_z(axis_data_ptr a) {
    return a->z;
}

/*
void __init()
{
    PSMove *move;
    enum PSMove_Connection_Type ctype;
    int i;

    if (!psmove_init(PSMOVE_CURRENT_VERSION)) {
        fprintf(stderr, "PS Move API init failed (wrong version?)\n");
        exit(1);
    }

    i = psmove_count_connected();
    printf("Connected controllers: %d\n", i);

    move = psmove_connect();

    if (move == NULL) {
        printf("Could not connect to default Move controller.\n"
               "Please connect one via USB or Bluetooth.\n");
        exit(1);
    }

    char *serial = psmove_get_serial(move);
    printf("Serial: %s\n", serial);
    free(serial);

    ctype = psmove_connection_type(move);
    switch (ctype) {
        case Conn_USB:
            printf("Connected via USB.\n");
            break;
        case Conn_Bluetooth:
            printf("Connected via Bluetooth.\n");
            break;
        case Conn_Unknown:
            printf("Unknown connection type.\n");
            break;
    }

    for (i=0; i<10; i++) {
        psmove_set_leds(move, 0, 255*(i%3==0), 0);
        psmove_set_rumble(move, 255*(i%2));
        psmove_update_leds(move);
        psmove_util_sleep_ms(10*(i%10));
    }

    for (i=250; i>=0; i-=5) {
		psmove_set_leds(move, (unsigned char)i, (unsigned char)i, 0);
        psmove_set_rumble(move, 0);
        psmove_update_leds(move);
    }

    // Enable rate limiting for LED updates
    psmove_set_rate_limiting(move, 1);

    psmove_set_leds(move, 0, 0, 0);
    psmove_set_rumble(move, 0);
    psmove_update_leds(move);

    while (ctype != Conn_USB && !(psmove_get_buttons(move) & Btn_PS)) {
        int res = psmove_poll(move);
        if (res) {
            if (psmove_get_buttons(move) & Btn_TRIANGLE) {
                printf("Triangle pressed, with trigger value: %d\n",
                        psmove_get_trigger(move));
                psmove_set_rumble(move, psmove_get_trigger(move));
            } else {
                psmove_set_rumble(move, 0x00);
            }

            psmove_set_leds(move, 0, 0, psmove_get_trigger(move));

            int x, y, z;
            psmove_get_accelerometer(move, &x, &y, &z);
            printf("accel: %5d %5d %5d\n", x, y, z);
            psmove_get_gyroscope(move, &x, &y, &z);
            printf("gyro: %5d %5d %5d\n", x, y, z);
            psmove_get_magnetometer(move, &x, &y, &z);
            printf("magnetometer: %5d %5d %5d\n", x, y, z);
            printf("buttons: %x\n", psmove_get_buttons(move));

            int battery = psmove_get_battery(move);

            if (battery == Batt_CHARGING) {
                printf("battery charging\n");
            } else if (battery == Batt_CHARGING_DONE) {
                printf("battery fully charged (on charger)\n");
            } else if (battery >= Batt_MIN && battery <= Batt_MAX) {
                printf("battery level: %d / %d\n", battery, Batt_MAX);
            } else {
                printf("battery level: unknown (%x)\n", battery);
            }

            printf("raw temperature: %d\n", psmove_get_temperature(move));
            printf("celsius temperature: %f\n", psmove_get_temperature_in_celsius(move));

            psmove_update_leds(move);
        }
    }

    psmove_disconnect(move);
}
*/

#ifdef __cplusplus
}
#endif
