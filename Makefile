# GMMK 2 96% ANSI firmware (WB32F3G71, ChibiOS)
#   make                     build default keymap
#   make KEYMAP=dexxiez-work build another keymap from src/keymaps/
#   make flash               flash over wb32-dfu
#   make compiledb           compile_commands.json for clangd, all keymaps (needs bear)
#   make clean

# Automatically enable parallel builds matching available CPU cores
MAKEFLAGS += -j$(shell nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 4)

KEYMAP ?= dexxiez

TOOLCHAIN ?= arm-none-eabi-
CC      := $(TOOLCHAIN)gcc
OBJCOPY := $(TOOLCHAIN)objcopy
SIZE    := $(TOOLCHAIN)size

BUILD := build/$(KEYMAP)
OUT   := build/gmmk2_$(KEYMAP)

ifeq ($(wildcard src/keymaps/$(KEYMAP)/keymap.c),)
$(error unknown keymap '$(KEYMAP)', see src/keymaps/)
endif

include mk/sources.mk
include mk/flags.mk

C_SRC := $(KEYBOARD_SRC) $(KEYMAP_SRC) $(QMK_SRC) $(CHIBIOS_SRC)
OBJS  := $(addprefix $(BUILD)/,$(C_SRC:.c=.o) $(CHIBIOS_ASM:.S=.o))

.PHONY: all clean flash compiledb
all: $(OUT).bin $(OUT).hex
	@$(SIZE) $(OUT).elf

$(BUILD)/%.o: %.c
	@mkdir -p $(dir $@)
	@echo "CC  $<"
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILD)/%.o: %.S
	@mkdir -p $(dir $@)
	@echo "AS  $<"
	@$(CC) $(ASFLAGS) -c $< -o $@

$(OUT).elf: $(OBJS)
	@echo "LD  $@"
	@$(CC) $(OBJS) $(LDFLAGS) $(LDLIBS) -o $@

$(OUT).bin: $(OUT).elf
	@$(OBJCOPY) -O binary $< $@

$(OUT).hex: $(OUT).elf
	@$(OBJCOPY) -O ihex $< $@

flash: $(OUT).bin
	wb32-dfu-updater_cli -D $< && wb32-dfu-updater_cli -R

KEYMAPS := $(notdir $(wildcard src/keymaps/*))

compiledb:
	rm -rf build compile_commands.json
	$(foreach k,$(KEYMAPS),bear --append -- $(MAKE) --no-print-directory KEYMAP=$k &&) true

clean:
	rm -rf build

-include $(OBJS:.o=.d)
