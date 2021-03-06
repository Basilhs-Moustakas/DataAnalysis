% VASILEIOS-PANAGIOTIS MOUSTAKAS 9424
% ROMANOS VOULGARAKIS 9383

close all;

%% Initializing matrices

Italy_deaths = load("italy_deaths.mat");
Italy_deaths = Italy_deaths.Italy_deaths;
Italy_confirmed = load("italy_confirmed.mat");
Italy_confirmed = Italy_confirmed.Italy_confirmed;
deaths = Italy_deaths(1,4:end);
confirmed = Italy_confirmed(1,4:end);

last_day = 193;

deaths_first_wave = deaths(1,52:last_day);
confirmed_first_wave = confirmed(1,52:last_day);

deaths_first_wave_array = table2array(deaths_first_wave);
for i=1:length(deaths_first_wave_array)
    if deaths_first_wave_array(i) < 0
        deaths_first_wave_array(i) = -deaths_first_wave_array(i);
    end
end
confirmed_first_wave_array = table2array(confirmed_first_wave);
for i=1:length(confirmed_first_wave_array)
    if confirmed_first_wave_array(i) < 0
        confirmed_first_wave_array(i) = -confirmed_first_wave_array(i);
    end
end

%% Calculating 7-day moving average 
confirmed_first_wave_array = movmean(confirmed_first_wave_array,[6 0]);
for k=1:length(confirmed_first_wave_array)
     confirmed_first_wave_array(k) = floor(confirmed_first_wave_array(k));
end
deaths_first_wave_array = movmean(deaths_first_wave_array,[6 0]);
for k=1:length(deaths_first_wave_array)
     deaths_first_wave_array(k) = floor(deaths_first_wave_array(k));
end


data = 1:length(confirmed_first_wave_array);


%% Deaths - MSE

err_fitted_deaths_gev = Group1Exe1Fun2('generalized extreme value',deaths_first_wave_array,data);
err_fitted_deaths_lognormal = Group1Exe1Fun2('lognormal',deaths_first_wave_array,data);
err_fitted_deaths_log_logistic = Group1Exe1Fun2('log logistic',deaths_first_wave_array,data);
err_fitted_deaths_normal = Group1Exe1Fun2('normal',deaths_first_wave_array,data);
err_fitted_deaths_birnsaund = Group1Exe1Fun2('birnbaumsaunders',deaths_first_wave_array,data);

Group1Exe1Fun1(data,'generalized extreme value','Generalized Extreme Value',deaths_first_wave_array,'Deaths',' - Generalized Extreme Value');
Group1Exe1Fun1(data,'lognormal','Log Normal',deaths_first_wave_array,'Deaths',' - Log-Normal');
Group1Exe1Fun1(data,'log logistic','Log Logistic',deaths_first_wave_array,'Deaths',' - Log-Logistic');
Group1Exe1Fun1(data,'normal','Normal',deaths_first_wave_array,'Deaths',' - Normal');
Group1Exe1Fun1(data,'birnbaumsaunders','Birnbaum-Saunders',deaths_first_wave_array,'Deaths',' - Birnbaum-Saunders');

%% Confirmed - MSE

err_fitted_confirmed_gev = Group1Exe1Fun2('generalized extreme value',confirmed_first_wave_array,data);
err_fitted_confirmed_lognormal = Group1Exe1Fun2('lognormal',confirmed_first_wave_array,data);
err_fitted_confirmed_log_logistic =  Group1Exe1Fun2('log logistic',confirmed_first_wave_array,data);
err_fitted_confirmed_normal = Group1Exe1Fun2('normal',confirmed_first_wave_array,data);
err_fitted_confirmed_birnsaund = Group1Exe1Fun2('birnbaumsaunders',confirmed_first_wave_array,data);

Group1Exe1Fun1(data,'generalized extreme value','Generalized Extreme Value',confirmed_first_wave_array,'Confirmed Cases',' - Generalized Extreme Value');
Group1Exe1Fun1(data,'lognormal','Log Normal',confirmed_first_wave_array,'Confirmed Cases',' - Log-Normal');
Group1Exe1Fun1(data,'log logistic','Log Logistic',confirmed_first_wave_array,'Confirmed Cases',' - Log-Logistic');
Group1Exe1Fun1(data,'normal','Normal',confirmed_first_wave_array,'Confirmed Cases',' - Normal');
Group1Exe1Fun1(data,'birnbaumsaunders','Birnbaum-Saunders',confirmed_first_wave_array,'Confirmed Cases',' - Birnbaum-Saunders');

clc;
disp(newline + "For more precise data-handling the moving average technique for 7 days was implemented in the initial data");

str = newline + "MSE for various distributions (Confirmed Cases)";
str = str + newline + "  -Log-Normal                 " + err_fitted_confirmed_lognormal;
str = str + newline + "  -Generalized extreme value  " + err_fitted_confirmed_gev;
str = str + newline + "  -Birnbaum-Saunders          " + err_fitted_confirmed_birnsaund;
str = str + newline + "  -Log Logistic               " + err_fitted_confirmed_log_logistic;
str = str + newline + "  -Normal                     " + err_fitted_confirmed_normal;
disp(str)

str = newline + "MSE for various distributions (Deaths)";
str = str + newline + "  -Birnbaum-Saunders          " + err_fitted_deaths_birnsaund;
str = str + newline + "  -Log-Normal                 " + err_fitted_deaths_lognormal;
str = str + newline + "  -Generalized extreme value  " + err_fitted_deaths_gev;
str = str + newline + "  -Log Logistic               " + err_fitted_deaths_log_logistic;
str = str + newline + "  -Normal                     " + err_fitted_deaths_normal;
disp(str)

disp(newline);

disp("The minimum MSE for the confirmed cases seems to be achieved by using the Log-Normal distribution.");
disp("However, the Birnbaum-Saunders distribution produces a marginally smaller MSE when fitted to deaths. Nevertheless,");
disp("Log-Normal fitting is considered sufficient for daily deaths, since the difference between the MSE ");
disp("of the two distributions is negligible");

disp(newline);






