// Global configuration. Force-included (-include) ahead of every translation unit.
// Later headers rely on #ifndef defaults, so the order matters.
#pragma once

#include "keyboard_config.h" // src/keyboard: pins, SPI, LED driver
#include "info_config.h"     // src/keyboard: matrix size, USB IDs, RGB defaults (from QMK keyboard.json)
#include "keymap_config.h"   // src/keymaps/$(KEYMAP)
#include "board_config.h"    // src/board

#include "platforms/chibios/config.h"
#include "drivers/wear_leveling/wear_leveling_flash_spi_config.h"
#include "quantum/rgb_matrix/post_config.h"
