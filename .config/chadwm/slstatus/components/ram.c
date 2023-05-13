/* See LICENSE file for copyright and license details. */
#include <stdio.h>

#include "../slstatus.h"
#include "../util.h"

#include <stdint.h>

const char *
ram_used(const char *unused)
{
  uintmax_t total, free, buffers, cached, used;

  pscanf("/proc/meminfo",
             "MemTotal: %ju kB\n"
             "MemFree: %ju kB\n"
             "MemAvailable: %ju kB\n"
             "Buffers: %ju kB\n"
             "Cached: %ju kB\n",
             &total, &free, &buffers, &buffers, &cached); 

  return fmt_human((total - free - buffers - cached) * BASE);
}
