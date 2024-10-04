clc;
clear;

%----------------
% Given Equations
%----------------
density_of_water = 300 / 300; % Assuming mass and volume are equal (Density = 1 kg/m³)
number_of_moles_of_water = 300000 / 18; % Moles of water, molar mass of water = 18 g/mol
number_of_moles_of_hydrogen = number_of_moles_of_water; % Equal to water since it's derived from water
mass_of_hydrogen = 2 * number_of_moles_of_hydrogen; % 2 grams of hydrogen per mole

%--------------------------------------------------------------
% Since every kilogram of hydrogen produces 120*10^6 joules
%--------------------------------------------------------------
number_of_joules = mass_of_hydrogen * 120 * 10^6; % Energy from hydrogen combustion

%------------------------------------------------------------------------------------------
% We Will Calculate the Final Temperature by Specific Heat Capacity
%------------------------------------------------------------------------------------------
specific_capacity_of_heat_of_hydrogen = 14300; % J/kg*K
room_temperature = 25; % Room temperature in Celsius

% Calculating the change in temperature (delta T)
delta_temperature = number_of_joules / (specific_capacity_of_heat_of_hydrogen * mass_of_hydrogen);

% Total final temperature
Total_Temperature = delta_temperature + room_temperature;

%------------------------------------------------------------------------------------------
% We Need a daily temperature of 330 Celsius
%------------------------------------------------------------------------------------------
required_temperature = 330;

% Calculate the number of days we can maintain 330°C
number_of_days = Total_Temperature / required_temperature;

%----------------
% Display Results
%----------------
disp(['Density of water: ', num2str(density_of_water), ' kg/m³']);
disp(['Number of moles of water: ', num2str(number_of_moles_of_water)]);
disp(['Number of moles of hydrogen: ', num2str(number_of_moles_of_hydrogen)]);
disp(['Mass of hydrogen: ', num2str(mass_of_hydrogen), ' kg']);
disp(['Number of joules produced: ', num2str(number_of_joules), ' J']);
disp(['Change in temperature: ', num2str(delta_temperature), ' °C']);
disp(['Total final temperature: ', num2str(Total_Temperature), ' °C']);
disp(['Number of days at 330°C: ', num2str(number_of_days), ' days']);

%----------------------
% Plot Water Consumption Per Day
%----------------------
% Assuming linear consumption over the number of days
water_consumed_per_day = number_of_moles_of_water / number_of_days; % Total water divided by number of days
time = linspace(0, number_of_days, 100); % 100 points over the number of days
water_consumption = water_consumed_per_day * time; % Water consumption over time

figure;

% Plot: Water Consumption over Time
plot(time, water_consumption, 'b', 'LineWidth', 2);
xlabel('Days');
ylabel('Water Consumed (moles)');
title('Water Consumption Over Days');
grid on;
