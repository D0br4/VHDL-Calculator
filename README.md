# VHDL Arithmetic Calculator

A modular arithmetic calculator written in **VHDL** for use with **Xilinx Vivado**. The design accepts two 8-bit operands, selects an operation using a 2-bit opcode, and drives a multiplexed four-digit seven-segment display.

## Features

- 8-bit ripple-carry adder and ripple-borrow subtractor built from 1-bit arithmetic blocks
- Signed shift-and-add multiplication with a 16-bit output
- Signed iterative-style combinational division logic with a 16-bit quotient output
- Operation selection using a 2-bit opcode
- Binary-to-decimal digit conversion and multiplexed seven-segment output
- Negative-result indication using a minus-sign digit

## Operation selection

| `opcode` | Operation |
|---|---|
| `00` | Addition |
| `01` | Subtraction |
| `10` | Multiplication |
| `11` | Division |

## Top-level module

The top-level VHDL entity is **`pocket_computer`**, defined in `src/main.vhd`.

| Port | Direction | Width | Purpose |
|---|---|---|---|
| `clk` | Input | 1 | Display multiplexing clock |
| `op1`, `op2` | Input | 8 each | Operands |
| `opcode` | Input | 2 | Selects the arithmetic operation |
| `seg` | Output | 7 | Seven-segment pattern |
| `an` | Output | 4 | Display digit enables |

## Source files

- `main.vhd` — top-level integration and operation selection
- `adder.vhd`, `adder8bits.vhd`, `hadder.vhd` — addition building blocks
- `substractor.vhd`, `substractor8bits.vhd` — subtraction blocks
- `inmultire.vhd` — signed multiplier (`multiplier` entity)
- `impartire.vhd` — signed divider (`divider` entity)
- `convertor.vhd` — binary-to-decimal digit conversion
- `MUX.vhd` — digit multiplexing controller
- `ssd7seg.vhd` — seven-segment decoder

## Open in Vivado

1. Create a new RTL project in Xilinx Vivado.
2. Add all `.vhd` files from the `src/` folder as design sources.
3. Set `pocket_computer` as the top module.
4. Select the FPGA device or board appropriate to your setup.
5. Supply a board-specific `.xdc` constraints file if implementing on physical hardware.
6. Run syntax checks, elaboration, simulation, and/or synthesis as appropriate.

**Note:** The original Vivado `.xpr` project file and board `.xdc` constraints were not included in the source archive, so they are not packaged here. No simulator testbench was included either.

## Current limitations / verification notes

This repository preserves the original student-project source code. The code was inspected but **not formally simulated or hardware-validated** as part of preparing this repository.

- The addition and subtraction outputs are 8 bits; carry and borrow outputs are not propagated into the 16-bit displayed result.
- Addition/subtraction are performed on `std_logic_vector` operands, then the 8-bit result is interpreted as signed in the top module. Overflow and signed/unsigned edge cases need testing.
- The converter uses four decimal digit positions; its thousands-digit calculation can exceed four bits for some 16-bit values. For negative results, the fourth digit is replaced by a minus sign.
- Division by zero currently returns zero; this is a defined code behavior, not an error indication.
- FPGA pin constraints and a testbench must be added for reproducible board demonstrations and full functional verification.

## Possible improvements

- Add a simulation testbench and edge-case tests.
- Clarify signed operand conventions and implement explicit overflow handling.
- Improve decimal conversion and negative-number display.
- Include board pin constraints and a demonstration of FPGA output.

## Author

Bogdan Dobra — [GitHub](https://github.com/D0br4)
