close all;
% Deaths = readtable('Covid19Deaths.xlsx');
% Confirmed = readtable('Covid19Confirmed.xlsx');
Italy_deaths = load("italy_deaths.mat");
Italy_deaths = Italy_deaths.Italy_deaths;
Italy_confirmed = load("italy_confirmed.mat");
Italy_confirmed = Italy_confirmed.Italy_confirmed;
deaths = Italy_deaths(1,4:end);
confirmed = Italy_confirmed(1,4:end);

%% Data from every Country
Russia_confirmed =  table2array(Confirmed(117,74:242));
Russia_deaths    =  table2array(Deaths(117,74:242));
Germany_confirmed =  table2array(Confirmed(52,59:169));
Germany_deaths    =  table2array(Deaths(52,59:169));
France_confirmed =  table2array(Confirmed(48,59:148));
France_deaths    =  table2array(Deaths(48,59:148));
UK_confirmed =  table2array(Confirmed(147,59:198));
UK_deaths    =  table2array(Deaths(147,59:198));
Spain_confirmed =  table2array(Confirmed(130,58:162));
Spain_deaths    =  table2array(Deaths(130,58:162));
Romania_confirmed =  table2array(Confirmed(116,69:157));
Romania_deaths    =  table2array(Deaths(116,69:157));
Netherlands_confirmed =  table2array(Confirmed(97,61:158));
Netherlands_deaths    =  table2array(Deaths(97,61:158));
Greece_confirmed =  table2array(Confirmed(54,68:156));
Greece_deaths    =  table2array(Deaths(54,68:156));
Portugal_confirmed =  table2array(Confirmed(113,67:142));
Portugal_deaths    =  table2array(Deaths(113,67:142));
Belgium_confirmed =  table2array(Confirmed(13,63:156));
Belgium_deaths    =  table2array(Deaths(13,63:156));
Czechia_confirmed =  table2array(Confirmed(35,64:151));
Czechia_deaths    =  table2array(Deaths(35,64:151));
Hungary_confirmed =  table2array(Confirmed(60,70:153));
Hungary_deaths    =  table2array(Deaths(60,70:153));
Sweden_confirmed =  table2array(Confirmed(133,60:211));
Sweden_deaths    =  table2array(Deaths(133,60:211));


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



