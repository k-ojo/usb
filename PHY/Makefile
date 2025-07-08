# === File: Makefile ===

# Compiler and viewer
IVERILOG = iverilog
VVP      = vvp
GTKWAVE  = gtkwave

# Directories
RTL_DIR = rtl
SIM_DIR = sim

# Files
SRC = $(RTL_DIR)/usb_line_decoder.v \
      $(RTL_DIR)/nrzi_decoder.v \
      $(RTL_DIR)/bit_unstuffer.v \
      $(RTL_DIR)/nrzi_encoder.v \
      $(RTL_DIR)/bit_stuffer.v \
      $(RTL_DIR)/usb_phy_rx.v \
      $(RTL_DIR)/usb_phy_tx.v \
      $(RTL_DIR)/usb_phy_top.v

TB = $(SIM_DIR)/usb_tb.v

OUT = usb_sim.out
VCD = $(SIM_DIR)/waveforms.vcd

# Default target
all: run

# Compile the simulation
build:
	@echo "🔧 Compiling Verilog sources..."
	$(IVERILOG) -g2012 -o $(OUT) $(SRC) $(TB)

# Run the simulation
run: build
	@echo "🚀 Running simulation..."
	$(VVP) $(OUT)

# Open waveform
view:
	@echo "👁️  Opening waveform in GTKWave..."
	$(GTKWAVE) $(VCD) &

# Clean up output files
clean:
	@echo "🧹 Cleaning build artifacts..."
	rm -f $(OUT) $(VCD)

.PHONY: all build run view clean
