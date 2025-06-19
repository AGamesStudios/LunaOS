#include <stddef.h>
#include <stdint.h>

static const char message[] = "Hello from LunaOS baremetal!";

void kernel_main(void) {
    volatile char *video = (volatile char*)0xb8000;
    for (size_t i = 0; message[i]; i++) {
        video[i * 2] = message[i];
        video[i * 2 + 1] = 0x07;
    }
    for (;;) { __asm__("hlt"); }
}
