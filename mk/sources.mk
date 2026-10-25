# Translation units, grouped by origin.
# Sources that compiled to empty objects under this config were dropped.

KEYBOARD_SRC := \
	src/board/board.c \
	src/keyboard/ansi.c \
	src/keyboard/layout.c

KEYMAP_SRC := $(wildcard src/keymaps/$(KEYMAP)/*.c)

QMK_SRC := \
	qmk/quantum/action.c \
	qmk/quantum/action_layer.c \
	qmk/quantum/action_tapping.c \
	qmk/quantum/action_util.c \
	qmk/quantum/bitwise.c \
	qmk/quantum/bootmagic/bootmagic.c \
	qmk/quantum/color.c \
	qmk/quantum/debounce/sym_defer_g.c \
	qmk/quantum/eeconfig.c \
	qmk/quantum/keyboard.c \
	qmk/quantum/keycode_config.c \
	qmk/quantum/keymap_common.c \
	qmk/quantum/keymap_introspection.c \
	qmk/quantum/led.c \
	qmk/quantum/led_tables.c \
	qmk/quantum/logging/debug.c \
	qmk/quantum/logging/print.c \
	qmk/quantum/logging/sendchar.c \
	qmk/quantum/main.c \
	qmk/quantum/matrix.c \
	qmk/quantum/matrix_common.c \
	qmk/quantum/mousekey.c \
	qmk/quantum/process_keycode/process_grave_esc.c \
	qmk/quantum/process_keycode/process_magic.c \
	qmk/quantum/process_keycode/process_rgb.c \
	qmk/quantum/process_keycode/process_space_cadet.c \
	qmk/quantum/quantum.c \
	qmk/quantum/rgb_matrix/rgb_matrix.c \
	qmk/quantum/rgb_matrix/rgb_matrix_drivers.c \
	qmk/quantum/send_string/send_string.c \
	qmk/quantum/wear_leveling/wear_leveling.c \
	qmk/tmk_core/protocol/chibios/chibios.c \
	qmk/tmk_core/protocol/chibios/usb_driver.c \
	qmk/tmk_core/protocol/chibios/usb_endpoints.c \
	qmk/tmk_core/protocol/chibios/usb_main.c \
	qmk/tmk_core/protocol/chibios/usb_report_handling.c \
	qmk/tmk_core/protocol/chibios/usb_util.c \
	qmk/tmk_core/protocol/host.c \
	qmk/tmk_core/protocol/report.c \
	qmk/tmk_core/protocol/usb_descriptor.c \
	qmk/tmk_core/protocol/usb_device_state.c \
	qmk/tmk_core/protocol/usb_util.c \
	qmk/platforms/chibios/bootloaders/wb32_dfu.c \
	qmk/platforms/chibios/drivers/spi_master.c \
	qmk/platforms/chibios/hardware_id.c \
	qmk/platforms/chibios/platform.c \
	qmk/platforms/chibios/suspend.c \
	qmk/platforms/chibios/syscall-fallbacks.c \
	qmk/platforms/chibios/timer.c \
	qmk/platforms/suspend.c \
	qmk/platforms/timer.c \
	qmk/drivers/eeprom/eeprom_driver.c \
	qmk/drivers/eeprom/eeprom_wear_leveling.c \
	qmk/drivers/flash/flash_spi.c \
	qmk/drivers/led/aw20216s.c \
	qmk/drivers/wear_leveling/wear_leveling_flash_spi.c \
	qmk/lib/fnv/hash_32a.c \
	qmk/lib/fnv/hash_64a.c \
	qmk/lib/lib8tion/lib8tion.c \
	qmk/lib/printf/src/printf/printf.c

CHIBIOS := vendor/chibios/os
CONTRIB := vendor/chibios-contrib/os

CHIBIOS_SRC := \
	$(CHIBIOS)/common/ports/ARMv7-M/chcore.c \
	$(CHIBIOS)/common/startup/ARMCMx/compilers/GCC/crt1.c \
	$(CHIBIOS)/hal/lib/streams/bufstreams.c \
	$(CHIBIOS)/hal/lib/streams/chprintf.c \
	$(CHIBIOS)/hal/lib/streams/chscanf.c \
	$(CHIBIOS)/hal/lib/streams/memstreams.c \
	$(CHIBIOS)/hal/lib/streams/nullstreams.c \
	$(CHIBIOS)/hal/ports/common/ARMCMx/nvic.c \
	$(CHIBIOS)/hal/src/hal.c \
	$(CHIBIOS)/hal/src/hal_buffers.c \
	$(CHIBIOS)/hal/src/hal_flash.c \
	$(CHIBIOS)/hal/src/hal_pal.c \
	$(CHIBIOS)/hal/src/hal_queues.c \
	$(CHIBIOS)/hal/src/hal_spi.c \
	$(CHIBIOS)/hal/src/hal_st.c \
	$(CHIBIOS)/hal/src/hal_usb.c \
	$(CHIBIOS)/oslib/src/chmemcore.c \
	$(CHIBIOS)/rt/src/chevents.c \
	$(CHIBIOS)/rt/src/chinstances.c \
	$(CHIBIOS)/rt/src/chmtx.c \
	$(CHIBIOS)/rt/src/chrfcu.c \
	$(CHIBIOS)/rt/src/chschd.c \
	$(CHIBIOS)/rt/src/chsem.c \
	$(CHIBIOS)/rt/src/chsys.c \
	$(CHIBIOS)/rt/src/chthreads.c \
	$(CHIBIOS)/rt/src/chvt.c \
	$(CHIBIOS)/various/syscalls.c \
	$(CONTRIB)/hal/ports/WB32/LLD/GPIOv1/hal_pal_lld.c \
	$(CONTRIB)/hal/ports/WB32/LLD/SPIv1/hal_spi_lld.c \
	$(CONTRIB)/hal/ports/WB32/LLD/TIMv1/hal_st_lld.c \
	$(CONTRIB)/hal/ports/WB32/LLD/USBv1/hal_usb_lld.c \
	$(CONTRIB)/hal/ports/WB32/WB32F3G71xx/hal_lld.c \
	$(CONTRIB)/hal/ports/WB32/WB32F3G71xx/wb32_isr.c

CHIBIOS_ASM := \
	$(CHIBIOS)/common/startup/ARMCMx/compilers/GCC/crt0_v7m.S \
	$(CHIBIOS)/common/startup/ARMCMx/compilers/GCC/vectors.S \
	$(CHIBIOS)/common/ports/ARMv7-M/compilers/GCC/chcoreasm.S

LDSCRIPT := $(CONTRIB)/common/startup/ARMCMx/compilers/GCC/ld/WB32F3G71x9.ld
LDDIR    := $(CHIBIOS)/common/startup/ARMCMx/compilers/GCC/ld
