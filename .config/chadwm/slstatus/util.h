/* See LICENSE file for copyright and license details. */
#include <stdint.h>

extern char buf[1024];

#define LEN(x) (sizeof(x) / sizeof((x)[0]))
// #define BASE 1000
int BASE = 1000;

extern char *argv0;

void warn(const char *, ...);
void die(const char *, ...);

int esnprintf(char *str, size_t size, const char *fmt, ...);
const char *bprintf(const char *fmt, ...);
const char *fmt_human(uintmax_t num, int BASE);
int pscanf(const char *path, const char *fmt, ...);
