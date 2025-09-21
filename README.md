# Project Proposal
## The Challenge
AES (Advanced Encryption Standard) is a computationally intensive algorithm involving many shifts, XORs, and table lookups. Performing these operations in software on a minimalistic CPU like Microwatt can be a major bottleneck for applications requiring secure communication or data storage. By moving the core cryptographic operations into dedicated silicon logic within the CPU, we can perform them in a single clock cycle, dramatically increasing throughput and reducing energy consumption per encryption.

# High-Level System Architecture

<img width="529" height="1004" alt="aes" src="https://github.com/user-attachments/assets/de29b95d-4e7f-4688-b1dc-60c14a8e6186" />

## Key Components:

* **Software Application**: The C code that calls the encryption function.

* **Inline Assembly**: The macros you write that contain the custom instructions (aesenc).

* **CPU Pipeline**: The modified parts of the Microwatt core (Decode, Execute, Writeback).

* **AES Round Engine**: Your custom Verilog/VDHL module that performs the encryption round.

* **Verification System**: The critical loop that checks the hardware output against known correct values.

# Detailed Hardware Integration Flow

<img width="603" height="949" alt="aes3" src="https://github.com/user-attachments/assets/796fafab-ea50-4162-ac46-2814ba3be6a9" />

## Key Components:

* **Opcode Decoding**: The first step is recognizing your new instruction.

* **Register File Access**: The POWER ISA uses 64-bit General Purpose Registers (GPRs). Since AES uses 128-bit data, your instruction must read from two source registers (e.g., SRa and SRa+1) and write to two destination registers (e.g., SRt and SRt+1).

* **AES Round Engine**: This is a purely combinatorial block. Its output is ready in the same clock cycle.

* **Bypass Standard Logic**: The control logic must multiplex between the standard ALU and your new AES engine for the result.

# Verification and Benchmark

<img width="3446" height="2117" alt="aes" src="https://github.com/user-attachments/assets/19b1ab6c-fc71-4d3b-9e27-3eb848c495ec" />

## Key Components:

* **Golden Model**: A trusted software implementation used to generate correct answers.

* **Device Under Test (DUT)**: Your modified Microwatt core running the new program.

* **Comparison**: The final step to ensure functional correctness. Any mismatch requires debugging the hardware.

* **Cycle Counting**: The simulator (verilator) can report how many cycles it took to complete a task. Comparing these counts gives you your performance benchmark.

## Project Goals & Expected Outcomes
* **ISA Extension:**: Define and implement new custom instructions in the Microwatt core (e.g., aesenc for an AES round).

* **Hardware Engine**: Design a efficient, combinatorial hardware unit that executes one round of AES-128.

* **Software Integration**: Develop low-level software macros and a library to allow C programs to utilize the new instructions.

* **Verification & Benchmarking**: Rigorously verify functional correctness against known test vectors and measure the performance speedup versus a pure software implementation.

* **Full Documentation**: Provide complete, clear documentation to allow for easy replication of the project and results.

* **Expected Outcome**: A fully functional, modified Microwatt core that demonstrates a 10x-50x speedup for the AES-128 encryption routine.

## Technical Approach
* **Micro-architecture**: The AES accelerator will be implemented as a combinatorial logic block integrated directly into the Microwatt execute pipeline stage.

* **Instruction Decoding**: New, unused major opcodes will be assigned to the custom AES instructions in the decode stage.

* **Software Interface**: GNU inline assembly will be used to create C macros that allow application code to call the new instructions.

* **Verification**: A test bench will be created to verify the hardware module. System-level verification will use a known-good software AES implementation to generate test vectors for the hardware-accelerated version, ensuring bit-accurate results.

## Project Plan
* **Phase 0 (Complete by Sep 22)**: Toolchain setup, baseline software AES performance established on vanilla Microwatt. (PROPOSAL PHASE)

* **Phase 1 (Oct 1 - Oct 15)**: RTL design of the AES round engine and integration into the Microwatt execute unit. Functional simulation with isolated test vectors.

* **Phase 2 (Oct 16 - Oct 27)**: Software integration. Development of the AES library using custom instructions. Full system verification and benchmarking.

* **Phase 3 (Oct 28 - Nov 3)**: Final documentation, creation of demonstration video, and project submission. (FINAL SUBMISSION)

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
