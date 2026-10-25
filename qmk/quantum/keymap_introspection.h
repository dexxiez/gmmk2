// Copyright 2022 Nick Brassel (@tzarc)
// SPDX-License-Identifier: GPL-2.0-or-later
#pragma once

#include <stdint.h>

// Both defined by the active src/keymaps/<name>/keymap.c
extern const uint16_t keymaps[][MATRIX_ROWS][MATRIX_COLS];
extern const uint8_t  keymap_layer_count;

uint16_t keycode_at_keymap_location(uint8_t layer_num, uint8_t row, uint8_t column);
