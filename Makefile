# Simple Microwatt AES Accelerator Makefile

TARGET = microwatt_aes
SIM = verilator
CROSS = powerpc64le-linux-gnu-

# Verilog sources
VSRC = core/*.v aes_engine/*.v

# Software sources  
CSRC = software/*.c

.PHONY: all sim clean

all: sim

# Build the simulator
sim:
	$(MAKE) -f Makefile.sim $(TARGET)

# Build software test
software/test_aes: software/test_aes.c
	$(CROSS)gcc -O2 -o $@ $<

# Run test
test: sim software/test_aes
	./$(TARGET) software/test_aes

# Clean everything
clean:
	$(MAKE) -f Makefile.sim clean
	rm -f software/test_aes
	rm -f *.vcd *.log

help:
	@echo "Available targets:"
	@echo "  sim     - Build Microwatt simulator with AES"
	@echo "  test    - Build and run AES test"
	@echo "  clean   - Clean all generated files"
