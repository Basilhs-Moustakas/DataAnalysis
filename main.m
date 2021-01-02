clear all
% Deaths = readtable('Covid19Deaths.xlsx');
% Confirmed = readtable('Covid19Confirmed.xlsx');
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
sum1=0;
for i=1:length(confirmed_first_wave_array)
    sum1 = sum1+confirmed_first_wave_array(i);
end

normalized_confirmed = confirmed_first_wave_array / sum1;

sum2=0;
for i=1:length(deaths_first_wave_array)
    sum2 = sum2+deaths_first_wave_array(i);
end

%deaths_first_wave_array = deaths_first_wave_array / sum2;

figure
bar(deaths_first_wave_array);
title('Moufa Psofoi');

data = 1:length(confirmed_first_wave_array);

normalized_deaths = deaths_first_wave_array/sum2;

%% Deaths - MSE
temp1  = fitdist(data','generalized extreme value','frequency',deaths_first_wave_array);
fitted_deaths_gen_ext_val = pdf(temp1,data);
err_fitted_deaths_gev = immse(normalized_deaths,fitted_deaths_gen_ext_val);

temp2 = fitdist(data','lognormal','frequency',deaths_first_wave_array);
fitted_deaths_lognormal = pdf(temp2,data);
err_fitted_deaths_lognormal = immse(normalized_deaths,fitted_deaths_lognormal);

temp3 = fitdist(data','log logistic','frequency',deaths_first_wave_array);
fitted_deaths_log_logistic = pdf(temp3,data);
err_fitted_deaths_log_logistic = immse(normalized_deaths,fitted_deaths_log_logistic);

temp4 = fitdist(data','normal','frequency',deaths_first_wave_array);
fitted_deaths_normal  = pdf(temp4,data);
err_fitted_deaths_normal = immse(normalized_deaths,fitted_deaths_gen_ext_val);

temp5 = fitdist(data','birnbaumsaunders','frequency',deaths_first_wave_array);
fitted_deaths_birnsaund = pdf(temp5,data);
err_fitted_deaths_birnsaund = immse(normalized_deaths,fitted_deaths_birnsaund);

%% Confirmed - MSE

temp1  = fitdist(data','generalized extreme value','frequency',confirmed_first_wave_array);
fitted_confirmed_gen_ext_val = pdf(temp1,data);
err_fitted_confirmed_gev = immse(normalized_confirmed,fitted_confirmed_gen_ext_val);

temp2 = fitdist(data','lognormal','frequency',confirmed_first_wave_array);
fitted_confirmed_lognormal = pdf(temp2,data);
err_fitted_confirmed_lognormal = immse(normalized_confirmed,fitted_confirmed_lognormal);

temp3 = fitdist(data','log logistic','frequency',confirmed_first_wave_array);
fitted_confirmed_log_logistic = pdf(temp3,data);
err_fitted_confirmed_log_logistic = immse(normalized_confirmed,fitted_confirmed_log_logistic);

temp4 = fitdist(data','normal','frequency',confirmed_first_wave_array);
fitted_confirmed_normal  = pdf(temp4,data);
err_fitted_confirmed_normal = immse(normalized_confirmed,fitted_confirmed_normal);

temp5 = fitdist(data','birnbaumsaunders','frequency',confirmed_first_wave_array);
fitted_confirmed_birnsaund = pdf(temp5,data);
err_fitted_confirmed_birnsaund = immse(normalized_confirmed,fitted_confirmed_birnsaund);
