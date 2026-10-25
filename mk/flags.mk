# Compiler, assembler and linker flags (taken from the stock QMK build).

MCUFLAGS := -mcpu=cortex-m3 -mthumb -mno-thumb-interwork -mno-unaligned-access

OPTFLAGS := -fomit-frame-pointer -ffunction-sections -fdata-sections -fno-common -fshort-wchar \
	-fno-builtin-printf -ggdb -Os -Wall -Wstrict-prototypes -Werror -std=gnu11 -fcommon

# Feature switches (each one is tested somewhere in qmk/ or vendor/)
DEFS := \
	-DQMK_KEYBOARD=\"gmmk/gmmk2/p96/ansi\" \
	-DQMK_KEYMAP=\"$(KEYMAP)\" \
	-DPROTOCOL_CHIBIOS -DMCU_WB32 -DCORTEX_USE_FPU=FALSE \
	-DWB32_BOOTLOADER_ADDRESS=0x1FFFE000 \
	-DFIXED_CONTROL_ENDPOINT_SIZE=64 -DFIXED_NUM_CONFIGURATIONS=1 \
	-DEEPROM_ENABLE -DEEPROM_DRIVER -DEEPROM_WEAR_LEVELING \
	-DRGB_MATRIX_ENABLE -DRGB_MATRIX_AW20216S -DUSE_CIE1931_CURVE \
	-DBOOTMAGIC_ENABLE -DGRAVE_ESC_ENABLE -DMAGIC_ENABLE -DMOUSEKEY_ENABLE \
	-DSEND_STRING_ENABLE -DSPACE_CADET_ENABLE \
	-DMOUSE_ENABLE -DMOUSE_SHARED_EP -DEXTRAKEY_ENABLE \
	-DNKRO_ENABLE -DSHARED_EP_ENABLE \
	-DNO_PRINT -DNO_DEBUG \
	-DPRINTF_SUPPORT_DECIMAL_SPECIFIERS=0 \
	-DPRINTF_SUPPORT_EXPONENTIAL_SPECIFIERS=0 \
	-DPRINTF_SUPPORT_LONG_LONG=0 \
	-DPRINTF_SUPPORT_WRITEBACK_SPECIFIER=0 \
	-DPRINTF_ALIAS_STANDARD_FUNCTION_NAMES=1

INCDIRS := \
	src \
	src/keymaps/$(KEYMAP) \
	src/keyboard \
	src/board \
	qmk \
	qmk/tmk_core \
	qmk/quantum \
	qmk/quantum/keymap_extras \
	qmk/quantum/process_keycode \
	qmk/quantum/sequencer \
	qmk/drivers \
	qmk/drivers/eeprom \
	qmk/drivers/wear_leveling \
	qmk/quantum/wear_leveling \
	qmk/drivers/flash \
	qmk/quantum/rgb_matrix \
	qmk/quantum/rgb_matrix/animations \
	qmk/quantum/rgb_matrix/animations/runners \
	qmk/drivers/led \
	qmk/quantum/logging \
	qmk/lib/printf/src \
	qmk/lib/printf/src/printf \
	qmk/lib/fnv \
	qmk/quantum/bootmagic \
	qmk/quantum/send_string \
	qmk/tmk_core/protocol \
	qmk/platforms \
	qmk/platforms/chibios \
	qmk/platforms/chibios/drivers \
	qmk/tmk_core/protocol/chibios \
	qmk/tmk_core/protocol/chibios/lufa_utils \
	qmk/lib/lufa \
	$(CHIBIOS)/license \
	$(CHIBIOS)/common/startup/ARMCMx/compilers/GCC \
	$(CHIBIOS)/common/startup/ARMCMx/compilers/GCC/ld \
	$(CONTRIB)/common/startup/ARMCMx/devices/WB32F3G71xx \
	$(CHIBIOS)/common/ext/ARM/CMSIS/Core/Include \
	$(CONTRIB)/common/ext/CMSIS/WB32/WB32F3G71xx \
	$(CHIBIOS)/rt/include \
	$(CHIBIOS)/common/portability/GCC \
	$(CHIBIOS)/common/ports/ARM-common \
	$(CHIBIOS)/common/ports/ARMv7-M \
	$(CHIBIOS)/hal/osal/rt-nil \
	$(CHIBIOS)/oslib/include \
	$(CHIBIOS)/hal/include \
	$(CHIBIOS)/hal/lib/streams \
	$(CHIBIOS)/various \
	$(CHIBIOS)/hal/ports/common/ARMCMx \
	$(CONTRIB)/hal/ports/WB32/WB32F3G71xx \
	$(CONTRIB)/hal/ports/WB32/LLD/GPIOv1 \
	$(CONTRIB)/hal/ports/WB32/LLD/DMAv1 \
	$(CONTRIB)/hal/ports/WB32/LLD/TIMv1 \
	$(CONTRIB)/hal/ports/WB32/LLD/I2Cv1 \
	$(CONTRIB)/hal/ports/WB32/LLD/UARTv1 \
	$(CONTRIB)/hal/ports/WB32/LLD/SPIv1 \
	$(CONTRIB)/hal/ports/WB32/LLD/USBv1 \
	$(CONTRIB)/hal/ports/WB32/LLD/ADCv1 \
	$(CONTRIB)/hal/ports/WB32/LLD/RTCv1 \
	$(CONTRIB)/hal/ports/WB32/LLD/EXTIv1 \
	$(CONTRIB)/hal/include \
	$(CONTRIB)/various

CPPFLAGS := $(DEFS) $(addprefix -I,$(INCDIRS)) -include src/firmware_config.h
CFLAGS   := $(MCUFLAGS) $(OPTFLAGS) $(CPPFLAGS) -MMD -MP
ASFLAGS  := $(MCUFLAGS) -ggdb -x assembler-with-cpp $(CPPFLAGS) -MMD -MP

LDFLAGS := $(MCUFLAGS) -T $(LDSCRIPT) -L $(LDDIR) \
	-Wl,--gc-sections -nostartfiles -Wl,--no-warn-rwx-segments \
	-Wl,--defsym=__process_stack_size__=0x800,--defsym=__main_stack_size__=0x400 \
	-Wl,--no-wchar-size-warning --specs=nano.specs \
	-Wl,-Map=$(OUT).map,--cref
LDLIBS := -lm
