close all;
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
figure
bar(confirmed_first_wave_array);
title('Moufa Gripes');

data = 1:length(confirmed_first_wave_array);

normalized_deaths = deaths_first_wave_array/sum2;

%% Deaths - RKVSG

err_fitted_deaths_gev = RKVSG('generalized extreme value',deaths_first_wave_array,normalized_deaths,data);
err_fitted_deaths_lognormal = RKVSG('lognormal',deaths_first_wave_array,normalized_deaths,data);
err_fitted_deaths_log_logistic = RKVSG('log logistic',deaths_first_wave_array,normalized_deaths,data);
err_fitted_deaths_normal = RKVSG('normal',deaths_first_wave_array,normalized_deaths,data);
err_fitted_deaths_birnsaund = RKVSG('birnbaumsaunders',deaths_first_wave_array,normalized_deaths,data);

Corona_Plot(data,'generalized extreme value','Generalized Extreme Value',deaths_first_wave_array,'Italy',normalized_deaths);
Corona_Plot(data,'lognormal','Log Normal',deaths_first_wave_array,'Italy',normalized_deaths);
Corona_Plot(data,'log logistic','Log Logistic',deaths_first_wave_array,'Italy',normalized_deaths);
Corona_Plot(data,'normal','Normal',deaths_first_wave_array,'Italy',normalized_deaths);
Corona_Plot(data,'birnbaumsaunders','Birnbaum-Saunders',deaths_first_wave_array,'Italy',normalized_deaths);

%% Confirmed - RKVSG

err_fitted_confirmed_gev = RKVSG('generalized extreme value',confirmed_first_wave_array,normalized_confirmed,data);
err_fitted_confirmed_lognormal = RKVSG('lognormal',confirmed_first_wave_array,normalized_confirmed,data);
err_fitted_confirmed_log_logistic =  RKVSG('log logistic',confirmed_first_wave_array,normalized_confirmed,data);
err_fitted_confirmed_normal = RKVSG('normal',confirmed_first_wave_array,normalized_confirmed,data);
err_fitted_confirmed_birnsaund = RKVSG('birnbaumsaunders',confirmed_first_wave_array,normalized_confirmed,data);

Corona_Plot(data,'generalized extreme value','Generalized Extreme Value',confirmed_first_wave_array,'Italy',normalized_confirmed);
Corona_Plot(data,'lognormal','Log Normal',confirmed_first_wave_array,'Italy',normalized_confirmed);
Corona_Plot(data,'log logistic','Log Logistic',confirmed_first_wave_array,'Italy',normalized_confirmed);
Corona_Plot(data,'normal','Normal',confirmed_first_wave_array,'Italy',normalized_confirmed);
Corona_Plot(data,'birnbaumsaunders','Birnbaum-Saunders',confirmed_first_wave_array,'Italy',normalized_confirmed);

% sum=0;
% for i=1:length(confirmed_first_wave_array)
% sum = sum+confirmed_first_wave_array(i);
% end

% data=1:142;
% pd = fitdist(data','log normal','frequency',confirmed_first_wave_array);
% y = pdf(pd,data);
% confirmed_first_wave_array=confirmed_first_wave_array/sum;
% figure
% data=1:142;
% b = bar(data,confirmed_first_wave_array);
% hold on;
% p = plot(data,y, 'Color','magenta','LineWidth',2 );
% title('Log Normal', 'fontsize',17);
% ylabel('Density', 'fontsize',14)
% xlabel('Day', 'fontsize',14)



