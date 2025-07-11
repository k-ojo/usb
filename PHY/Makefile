# Project folders
RTL_DIR := rtl
SIM_DIR := sim
BUILD_DIR := build

# Toolchain
IVERILOG := iverilog
VVP := vvp
GTKWAVE := gtkwave

# Simulation target name (without .v extension)
TESTBENCH ?= usb_line_decoder_testbench

# Paths
SRC := $(wildcard $(RTL_DIR)/*.v)
TB  := $(SIM_DIR)/$(TESTBENCH).v
TARGET := $(BUILD_DIR)/$(TESTBENCH).vvp
WAVEFORM := $(BUILD_DIR)/wave.vcd

# Default target
all: run

# Compile specific testbench
$(TARGET): $(SRC) $(TB) | $(BUILD_DIR)
	$(IVERILOG) -g2012 -o $@ $^

# Run simulation
run: $(TARGET)
	$(VVP) $<

# View waveform
wave: $(WAVEFORM)
	$(GTKWAVE) $<

# Generate waveform during simulation
$(WAVEFORM): run

# Create build directory
$(BUILD_DIR):
	mkdir -p $@

# Clean
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all run wave clean
