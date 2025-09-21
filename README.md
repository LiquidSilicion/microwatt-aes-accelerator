# Project Proposal
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
