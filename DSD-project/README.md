# CE40223 - Digital Systems Design

This repository contains the project for this course in the Spring 2024 semester.


# University Parking Management System

This Verilog project simulates a comprehensive parking management system for a university. The system prioritizes parking spaces for faculty and staff, dynamically adjusts based on the hour of the day, and provides clear outputs for the number of parked cars and available spaces.


## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Tools](#tools)
- [Module Parameters](#module-parameters)
- [Module Ports](#module-ports)
- [Testbench](#testbench)
- [Timing Analysis](#timing-analysis)
- [Documentation](#documentation)
- [Usage](#usage)
- [Authors](#authors)

## Overview
The `parking` module is designed to efficiently manage university parking spaces. It dynamically adjusts the allocation of spaces for university and non-university cars based on the current hour, ensuring optimal usage of available parking.

## Features
- **Priority Parking:** Ensures priority for university faculty and staff.
- **Dynamic Adjustment:** Adjusts parking allocation based on the time of day.
- **Detailed Outputs:** Provides real-time counts of parked cars and available spaces.

## Tools
- **Verilog:** Hardware Description Language used for designing the module.
- **[Icarus Verilog (Iverilog):](https://github.com/steveicarus/iverilog)** Used for simulation and testing.
- **[Quartus Prime:](https://www.intel.de/content/www/de/de/products/details/fpga/development-tools/quartus-prime.html)** Used for synthesis and timing analysis on the Cyclone II FPGA.

## Module Parameters
- `init_uni_space`: Initial number of spaces allocated to university cars (default: 500).
- `final_uni_space`: Final number of spaces allocated to university cars after 4 PM (default: 200).
- `total_space`: Total number of parking spaces (default: 700).
- `increment`: Decrease in university parking spaces per hour from 1 PM to 4 PM (default: 50).

## Module Ports
### Inputs
- `car_entered`: Signal indicating a car has entered.
- `is_uni_car_entered`: Indicates if the entering car is a university car.
- `car_exited`: Signal indicating a car has exited.
- `is_uni_car_exited`: Indicates if the exiting car is a university car.
- `hour`: Current hour (6-bit wide).

### Outputs
- `uni_parked_car`: Number of university cars currently parked.
- `parked_car`: Number of non-university cars currently parked.
- `uni_vacated_space`: Number of vacant spaces for university cars.
- `vacated_space`: Number of vacant spaces for non-university cars.
- `uni_is_vacated_space`: Indicates if there are vacant university spaces.
- `is_vacated_space`: Indicates if there are vacant non-university spaces.

## Testbench
The provided testbench (`testbench`) thoroughly tests the `parking` module, ensuring it operates correctly under various conditions.

### Test Scenarios
1. Initial state
2. Entering university and non-university cars at different hours
3. Exiting university and non-university cars at different hours
4. Dynamic adjustment of parking spaces from 1 PM to 4 PM
5. Overflow handling when university parking is full
6. Handling maximum capacity in general parking

## Simulation Results
The simulation results demonstrate the correct functionality of the module. Here’s an excerpt of the simulation output:

## Timing Analysis
The module was synthesized using Quartus Prime on the Cyclone II FPGA. Timing analysis provided the following results:

- **Maximum Frequency (Fmax):** [23.45 MHz]
- **Setup Time:** [20.818 ns]
- **Hold Time:** [6.425 ns]

These results ensure the design operates reliably at the intended clock speeds.

## Documentation
The project is thoroughly documented to ensure clarity and ease of understanding. All design decisions, parameter explanations, and operational descriptions are detailed in the `Documentation.pdf` file included in the repository. This document serves as an extensive guide for anyone looking to understand, modify, or extend the project.

### Contents of Documentation.pdf:
- **Design Overview:** Detailed explanation of the project design and its components.
- **Parameter Definitions:** Comprehensive descriptions of all parameters used in the design.
- **Operational Flow:** Step-by-step explanation of how the module operates under various conditions.
- **Testbench Details:** In-depth information on the test scenarios and how to interpret the results.
- **Synthesis and Timing Analysis:** Detailed results and interpretations from the Quartus Prime synthesis and timing analysis.

## Usage
1. **Simulation:** Use Icarus Verilog for simulating the design.
   ```sh
   iverilog -o tb testbench.v
   vvp tb

2. **Synthesis:** Use Quartus Prime to synthesize the design for the ARIA II GX FPGA.

## Authors

- [Radin Shahdaei](https://github.com/radinshahdaei)
