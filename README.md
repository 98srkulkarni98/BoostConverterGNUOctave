# BoostConverterGNUOctave
Solution to state space equation. This model simply solves the ODE in the On duration and off duration of the switch by updating the initial condition.
The model assumes a constant load current and all components are ideal. This is not a circuit simulation, but a simple state space solution using lsode.
The idea is to show the difference in average model and actual model. 
```
##* ========================================================================
##* Title             : Boost Converter Simulation
##* Author            : Shreekar Kulkarni
##* Date of Creation  : 26-01-2025
##* Modification Date : 26-01-2025
##* Version           : 1.0
##* ========================================================================
##* Version History:
##* ------------------------------------------------------------------------
##* Version 1.1 - 26-01-2025:
##* - Initial creation of the boost converter simulation circuit.
##* ========================================================================
##* Notes:
##* - This simulation models a boost converter using typical parameters.
##* - The switching frequency is set to 10 kHz, and duty cycle is 0.25.
##* - The circuit assumes ideal components unless otherwise noted.
##* - The circuit is shown in the boost_converter_diagram.svg.
##* ========================================================================
```
## How to Use?
1. Download and Install GNU Octave. ([Here](https://octave.org/download))
2. Copy all these file in a new directory in your system.
3. Open GNUOctave and run the boost_model.m

## Set Parameters of Boost Circuit:
In boost_model.m
```
% Input Voltage
uz = 10;

## Boost Circuit Parameter
## According to Figure boost_converter_diagram.svg
L = 10e-3;
C = 10e-6;
R = 10;

## Load Requires constant current
il = 2;

## Duty ratio of the transistor/switch
a = 0.25;
fs = 10e+3;
Ts = 1/fs;
Ton = a*Ts;
Toff = (1-a)*Ts;
```

## Set Simulation Parameters:
In boost_model.m
```
## Simulation Parameters
tmin = 0;
tmax = 0.005;
dt = 1e-6;
```
Note tmin will be the time at which inital state values are selected. Keeping it at 0 and changing the inital state vector for different simulation is logical.

## Disclaimer
This model is for the information and example purpose. 

## References
[1] Switched Mode Power Conversion by Prof. L. Umanand & Prof. V. Ramanarayanan,Department of Electrical Engineering,IISc Bangalore.For more details on NPTEL visit [http://nptel.ac.in](http://nptel.ac.in)

[2] [Boost Converter](https://en.wikipedia.org/wiki/Boost_converter "wiki")
