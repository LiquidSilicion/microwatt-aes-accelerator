# OpenFrame Overview

The OpenFrame Project provides an empty harness chip that differs significantly from the Caravel and Caravan designs. Unlike Caravel and Caravan, which include integrated SoCs and additional features, OpenFrame offers only the essential padframe, providing users with a clean slate for their custom designs.

<img width="256" alt="Screenshot 2024-06-24 at 12 53 39 PM" src="https://github.com/efabless/openframe_timer_example/assets/67271180/ff58b58b-b9c8-4d5e-b9bc-bf344355fa80">

## Key Characteristics of OpenFrame

1. **Minimalist Design:** 
   - No integrated SoC or additional circuitry.
   - Only includes the padframe, a power-on-reset circuit, and a digital ROM containing the 32-bit project ID.

2. **Padframe Compatibility:**
   - The padframe design and pin placements match those of the Caravel and Caravan chips, ensuring compatibility and ease of transition between designs.
   - Pin types are identical, with power and ground pins positioned similarly and the same power domains available.

3. **Flexibility:**
   - Provides full access to all GPIO controls.
   - Maximizes the user project area, allowing for greater customization and integration of alternative SoCs or user-specific projects at the same hierarchy level.

4. **Simplified I/O:**
   - Pins that previously connected to CPU functions (e.g., flash controller interface, SPI interface, UART) are now repurposed as general-purpose I/O, offering flexibility for various applications.

The OpenFrame harness is ideal for those looking to implement custom SoCs or integrate user projects without the constraints of an existing SoC.

## Features

1. 44 configurable GPIOs.
2. User area of approximately 15mm².
3. Supports digital, analog, or mixed-signal designs.

# openframe_timer_example

This example implements a simple timer and connects it to the GPIOs.

## Installation and Setup

First, clone the repository:

```bash
git clone https://github.com/efabless/openframe_timer_example.git
cd openframe_timer_example
```

Then, download all dependencies:

```bash
make setup
```

## Hardening the Design

In this example, we will harden the timer. You will need to harden your own design similarly.

```bash
make user_proj_timer
```

Once you have hardened your design, integrate it into the OpenFrame wrapper:

```bash
make openframe_project_wrapper
```

## Important Notes

1. **Connecting to Power:**
   - Ensure your design is connected to power using the power pins on the wrapper.
   - Use the `vccd1_connection` and `vssd1_connection` macros, which contain the necessary vias and nets for power connections.

2. **Flattening the Design:**
   - If you plan to flatten your design within the `openframe_project_wrapper`, do not buffer the analog pins using standard cells.

3. **Running Custom Steps:**
   - Execute the custom step in OpenLane that copies the power pins from the template DEF. If this step is skipped, the precheck will fail, and your design will not be powered.

## The Challenge
AES (Advanced Encryption Standard) is a computationally intensive algorithm involving many shifts, XORs, and table lookups. Performing these operations in software on a minimalistic CPU like Microwatt can be a major bottleneck for applications requiring secure communication or data storage. By moving the core cryptographic operations into dedicated silicon logic within the CPU, we can perform them in a single clock cycle, dramatically increasing throughput and reducing energy consumption per encryption.

## Project Goals & Expected Outcomes
**ISA Extension:**: Define and implement new custom instructions in the Microwatt core (e.g., aesenc for an AES round).

**Hardware Engine**: Design a efficient, combinatorial hardware unit that executes one round of AES-128.

**Software Integration**: Develop low-level software macros and a library to allow C programs to utilize the new instructions.

**Verification & Benchmarking**: Rigorously verify functional correctness against known test vectors and measure the performance speedup versus a pure software implementation.

**Full Documentation**: Provide complete, clear documentation to allow for easy replication of the project and results.

**Expected Outcome**: A fully functional, modified Microwatt core that demonstrates a 10x-50x speedup for the AES-128 encryption routine.

## Technical Approach
**Micro-architecture**: The AES accelerator will be implemented as a combinatorial logic block integrated directly into the Microwatt execute pipeline stage.

**Instruction Decoding**: New, unused major opcodes will be assigned to the custom AES instructions in the decode stage.

**Software Interface**: GNU inline assembly will be used to create C macros that allow application code to call the new instructions.

**Verification**: A test bench will be created to verify the hardware module. System-level verification will use a known-good software AES implementation to generate test vectors for the hardware-accelerated version, ensuring bit-accurate results.

## Project Plan
Phase 0 (Complete by Sep 22): Toolchain setup, baseline software AES performance established on vanilla Microwatt. (PROPOSAL PHASE)

Phase 1 (Oct 1 - Oct 15): RTL design of the AES round engine and integration into the Microwatt execute unit. Functional simulation with isolated test vectors.

Phase 2 (Oct 16 - Oct 27): Software integration. Development of the AES library using custom instructions. Full system verification and benchmarking.

Phase 3 (Oct 28 - Nov 3): Final documentation, creation of demonstration video, and project submission. (FINAL SUBMISSION)

Judge Criteria Alignment
Project Documentation: This README is the start. Final documentation will include detailed build instructions, a block architecture diagram, and full results.

Prompt Documentation: LLM prompts used for generating boilerplate code (e.g., test vectors, documentation templates) will be documented in a dedicated section.

Code Quality: The HDL code will be modular, well-commented, and follow best practices. Changes to the core Microwatt code will be minimal and focused.

Verification Coverage: Verification is a core part of the plan, using both unit testbenches for the AES module and full system-level checks against a software golden model.

Design Technical Merit: Adding application-specific custom instructions is a fundamental advantage of open-source silicon. This project provides a clear, measurable improvement for a critical workload.


# Building and Running the Baseline
(Instructions to be filled in as project progresses)

bash
# Clone the repository
```bash
git clone https://github.com/your-username/microwatt-aes-accelerator.git
cd microwatt-aes-accelerator
```

# Build the vanilla Microwatt simulator
```bash
make sim
```

# Build and run the software AES benchmark
```bash
cd software
make benchmark_software
```

# Runs in simulation and reports cycle count
License
This project will be licensed under the same open-source license as the Microwatt project itself.
