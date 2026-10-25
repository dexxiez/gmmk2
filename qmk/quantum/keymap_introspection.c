// Copyright 2022 Nick Brassel (@tzarc)
// SPDX-License-Identifier: GPL-2.0-or-later

#include "quantum.h"
#include "keymap_introspection.h"

uint16_t keycode_at_keymap_location(uint8_t layer_num, uint8_t row, uint8_t column) {
    if (layer_num < keymap_layer_count && row < MATRIX_ROWS && column < MATRIX_COLS) {
        return pgm_read_word(&keymaps[layer_num][row][column]);
    }
    return KC_TRNS;
}
