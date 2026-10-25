# GMMK 2 96% ANSI firmware

Standalone build of the QMK firmware for the GMMK 2 P96 ANSI (WB32F3G71, ChibiOS 21.11).

```
git submodule update --init
make                       # keymap: dexxiez
make KEYMAP=dexxiez-work
make flash                 # needs wb32-dfu-updater_cli, keyboard in bootloader
make compiledb             # compile_commands.json for clangd (needs bear)
```

Output lands in `build/gmmk2_<keymap>.{bin,hex,elf,map}`.

## Layout

| Path | What |
|---|---|
| `src/keymaps/<name>/` | keymaps; each `keymap.c` defines `keymaps[]` and `keymap_layer_count` |
| `src/keyboard/` | matrix, LED layout (`layout.c/h`), keyboard config |
| `src/board/` | WB32 board init plus ChibiOS `chconf.h`/`halconf.h`/`mcuconf.h` |
| `src/firmware_config.h` | force-included into every file; sets the order configs load in |
| `qmk/` | the parts of QMK core this build uses, copied verbatim apart from noted edits |
| `vendor/` | ChibiOS 21.11.x and ChibiOS-Contrib, pinned to the commits QMK uses |
| `mk/` | source lists and compiler flags |
| `docs/qmk-build-manifest.md` | every file the original QMK build touched |

## Changes from QMK

- `qmk/quantum/keymap_introspection.c` no longer `#include`s the keymap; the keymap is its own translation unit.
- `src/board/board.c` exports `board_early_init()` directly instead of QMK's `init_hooks.h` rename macro.
- ChibiOS config `#include_next` chains are flattened into single files in `src/board/`.
- `QMK_KEYBOARD_H` replaced with `#include "layout.h"`.
- Sources that compiled to empty objects and unused `-D` flags were removed.
