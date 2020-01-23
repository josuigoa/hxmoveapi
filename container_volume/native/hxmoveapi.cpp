#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "include/hxmoveapi.h"
#include "include/psmoveapi/psmove.h"

#ifdef __cplusplus
extern "C" {
#endif

PSMove *move;

LIB_EXPORT bool init() {

    if (!psmove_init(PSMOVE_CURRENT_VERSION)) {
        fprintf(stderr, "PS Move API init failed (wrong version?)\n");
        exit(1);
    }
    
    move = psmove_connect();

    if (move == NULL) {
        printf("Could not connect to default Move controller.\n"
               "Please connect one via USB or Bluetooth.\n");
    }
    
    return move != NULL;
}

LIB_EXPORT char* get_serial() {

    char *serial = psmove_get_serial(move);
    return serial;
}

LIB_EXPORT void set_led(int r, int g, int b) {
    psmove_set_leds(move, r, g, b);
    psmove_update_leds(move);
}

LIB_EXPORT void set_rumble(int rumble) {
    psmove_set_rumble(move, rumble);
    psmove_update_leds(move);
}

LIB_EXPORT unsigned int get_buttons() {
    if (psmove_poll(move)) {
        return psmove_get_buttons(move);
    }
    return 0;
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
