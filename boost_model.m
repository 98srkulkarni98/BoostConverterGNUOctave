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

clc;clear all; close all;

##boost_converter_gui();
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

## Average model of Boost converter
A = [0 -(1-a)/L;
    (1-a)/C -1/(R*C)];
Bu = [1/L;0];
Bl = [0;-1/C ];

## ON and OFF Period
Aon = [0 0;
      0 -1/(R*C)];
Aoff = [0,-1/L;1/C,-1/(R*C)];

## Simulation Parameters
tmin = 0;
tmax = 0.005;
dt = 1e-6;


## creation of time vector
t = (tmin:dt:tmax-dt)';

## Creation of switching sequence
Hop_on = round(Ton/dt);    ## On period hop samples
Hop_off = round(Toff/dt);  ## Off period hop  samples
Hop_p = round(Ts/dt);
Hop = [Hop_on;Hop_off;Hop_p];


x0 = [0;0];

## Actual Model Simulation
y = Simulate(t,x0,Hop,Aon,Aoff,Bu,uz,Bl,il);

## Average Model Simulation
x0 = [0;0];
yavg = lsode (@(x,t)f(x,t,A,Bu,uz,Bl,il), x0, t);

## Text File Generation for Pgf plot
data = [t,y(:,1),y(:,2),yavg(:,1),yavg(:,2)];

fid = fopen('boost_model_output_data.txt', 'w');
fprintf(fid, 'time i_l(t) u_c(t) I_L U_C\n');
## Loop through each row of the matrix
for i = 1:size(data, 1)
    fprintf(fid, '%d %d %d %d %d\n', data(i, 1), data(i, 2), data(i, 3), data(i, 4), data(i, 5));
end
## Close the file
fclose(fid);


figure('Name', 'Boost Converter');
subplot(2,1,1);
plot(t,y(:,1));
hold on;
plot(t,yavg(:,1));
legend('Actual','Average');
title("Inductor Current")
xlabel("t in seconds");ylabel("i_L(t)");
grid on;

subplot(2,1,2);
plot(t,y(:,2));
hold on;
plot(t,yavg(:,2));
legend('Actual','Average');
title("Capacitor Voltage")
xlabel("t in seconds");ylabel("u_c(t)");
grid on;


