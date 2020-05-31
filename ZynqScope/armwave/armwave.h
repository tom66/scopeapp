/*
 * This file is part of YAOS and is licenced under the MIT Licence.
 *
 * armwave: an ARM-optimised waveform rendering engine for the Raspberry Pi 3.  
 * This library attempts to use NEON tricks and architectural features of the Pi's
 * processor to render waveforms damn quickly.
 */

#include <Python.h>

#define AM_FLAG_RENDER_1CH_MODE     0x00000001
#define AM_FLAG_RENDER_2CH_MODE     0x00000002
#define AM_FLAG_RENDER_4CH_MODE     0x00000004
#define AM_FLAG_DONT_RENDER_CH_1    0x00000010
#define AM_FLAG_DONT_RENDER_CH_2    0x00000020
#define AM_FLAG_DONT_RENDER_CH_3    0x00000040
#define AM_FLAG_DONT_RENDER_CH_4    0x00000080
#define AM_FLAG_RENDER_PIX_AA       0x00000100

struct armwave_color_mix_t {
  int16_t r, g, b;
};

struct armwave_state_t {
  uint32_t flags;

  uint8_t *ch1_buffer;
  uint8_t *ch2_buffer;
  uint8_t *ch3_buffer;
  uint8_t *ch4_buffer;

  uint8_t *wave_buffer;

  uint32_t xstride;
  uint32_t vscale;
  uint32_t wave_stride;
  uint32_t waves;
  uint32_t bitdepth_height;
  uint32_t slice_height;
  uint32_t slice_record_height;
  uint32_t ch_buff_size;
  uint32_t size;

  uint32_t target_width;
  uint32_t target_height;

  uint32_t row_shift;
  uint32_t row_mask;

  uint32_t *out_pixbuf;

  struct armwave_color_mix_t ch1_color;
  struct armwave_color_mix_t ch2_color;
  struct armwave_color_mix_t ch3_color;
  struct armwave_color_mix_t ch4_color;

  // Look up table to map xcoord to xpixel, after scaling is applied.
  // This is probably suitable for up to ~100k points; beyond this RAM usage, and cache behaviour mean
  // that using the ALU is probably less expensive.
  uint16_t *xcoord_to_xpixel;
};

void render_nonaa_to_buffer_1ch_slice(uint32_t slice_y, uint32_t height);
void armwave_init(void);
void armwave_setup_render(uint8_t *wave_buffer, uint32_t start_point, uint32_t end_point, uint32_t waves, uint32_t wave_stride, uint32_t target_width, uint32_t target_height, uint32_t render_flags);
void armwave_set_channel_colour(int ch, int r, int g, int b);
void armwave_clear_buffer(uint32_t flags);
void armwave_fill_pixbuf_256(uint32_t *out_buffer);
void armwave_fill_pixbuf_scaled(uint32_t *out_buffer);
void armwave_dump_ppm_debug(uint32_t *buffer, char *fn);

void armwave_test_create_square(float noise_fraction);
void armwave_test_create_am_sine(float mod, float noise_fraction);

void armwave_test_init(int render_width, int render_height);
void armwave_test_generate(void);
void armwave_test_fill_gdkbuf(PyObject *buf);
void armwave_test_dump_buffer_to_ppm(char *fn);

void armwave_cleanup(void);
