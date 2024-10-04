clc;
clear;

%-----------------------------------------------------------------
% We need 273 Kj/mol to electrolysis 1 mole of water
% Number of moles of water is 16666.7 (from chemisrty_anylsis.m)
%-----------------------------------------------------------------
number_of_moles = 16666.7;
number_of_kilo_joules = 273 * number_of_moles;

%----------------------
% For 1 KW.H = 3600 Kj
%---------------------
joules_per_kwh = 3600;
KW_H = number_of_kilo_joules / joules_per_kwh;

%----------------------------------------------------------------------
% Efficiency of electricity for electrolysis is between 60-80%
% We take the average, which is 70% = 0.7
% Number of days is 25.6 days (from chemisrty_anylsis.m)
%----------------------------------------------------------------------
efficiency = 0.7;
number_of_days = 25.6;
accurate_kilo_watt_hours = KW_H / efficiency;
number_of_hours_per_day = 6;
total_hours = number_of_days * number_of_hours_per_day;
kw_per_hour = accurate_kilo_watt_hours / total_hours; % Output per hour
per_day_output = kw_per_hour * number_of_hours_per_day; % Output per day

% Display the results
disp(['Total kilowatt-hours needed: ', num2str(KW_H)]);
disp(['Accurate kilowatt-hours (adjusted for efficiency): ', num2str(accurate_kilo_watt_hours)]);
disp(['Kilowatt output per hour: ', num2str(kw_per_hour)]);
disp(['Kilowatt output per day: ', num2str(per_day_output)]);

