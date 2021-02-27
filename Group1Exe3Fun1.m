function difference_est = Group1Exe3Fun1(country_data_confirmed,country_data_deaths)
data=1:length(country_data_confirmed);
pd = fitdist(data','lognormal','frequency',country_data_confirmed);
[~,max_confirmed_day_est]=max(pdf(pd,data));
data=1:length(country_data_deaths);
pd = fitdist(data','lognormal','frequency',country_data_deaths);
[~,max_deaths_day_est]=max(pdf(pd,data));
difference_est=max_deaths_day_est-max_confirmed_day_est;
end

