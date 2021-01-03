close all;
% Deaths = readtable('Covid19Deaths.xlsx');
% Confirmed = readtable('Covid19Confirmed.xlsx');

% country = cell(14,2);
 
country = load("country.mat");
country = country.country;



%% Data from every Country
% country{1,1} =  table2array(Confirmed(117,74:242));
% country{1,2}    =  table2array(Deaths(117,74:242));
% country{2,1} =  table2array(Confirmed(52,59:169));
% country{2,2}    =  table2array(Deaths(52,59:169));
% country{3,1} =  table2array(Confirmed(48,59:148));
% country{3,2}    =  table2array(Deaths(48,59:148));
% country{4,1} =  table2array(Confirmed(147,59:198));
% country{4,2}    =  table2array(Deaths(147,59:198));
% country{5,1} =  table2array(Confirmed(67,55:196));
% country{5,2}    =  table2array(Deaths(67,55:196));
% country{6,1} =  table2array(Confirmed(130,58:162));
% country{6,2}    =  table2array(Deaths(130,58:162));
% country{7,1} =  table2array(Confirmed(116,69:157));
% country{7,2}    =  table2array(Deaths(116,69:157));
% country{8,1} =  table2array(Confirmed(97,61:158));
% country{8,2}    =  table2array(Deaths(97,61:158));
% country{9,1} =  table2array(Confirmed(54,68:156));
% country{9,2}    =  table2array(Deaths(54,68:156));
% country{10,1} =  table2array(Confirmed(113,67:142));
% country{10,2}    =  table2array(Deaths(113,67:142));
% country{11,1} =  table2array(Confirmed(13,63:156));
% country{11,2}    =  table2array(Deaths(13,63:156));
% country{12,1} =  table2array(Confirmed(35,64:151));
% country{12,2}    =  table2array(Deaths(35,64:151));
% country{13,1} =  table2array(Confirmed(60,70:153));
% country{13,2}    =  table2array(Deaths(60,70:153));
% country{14,1} =  table2array(Confirmed(133,60:211));
% country{14,2}    =  table2array(Deaths(133,60:211));


distribution = 'lognormal';


%% Plots for every Country with 

strings_array = ["Russia","Germany","France","UK","Italy","Spain","Romania","Netherlands","Greece","Portugal",...
    "Belgium","Czechia","Hungary","Sweden"];

data = cell(length(strings_array),1);
for i=1:length(strings_array)
    data{i} = 1:length(country{i,1});
end

for i=1:length(strings_array)
    fitted(i,1) = fitdist((1:length(country{i,1}))',distribution,'frequency',country{i,1});
    fitted(i,2) = fitdist((1:length(country{i,2}))',distribution,'frequency',country{i,2});
end

for i=1:length(strings_array)
    error(i,1) = MSE(distribution,country{i,1},data{i});
    error(i,2) = MSE(distribution,country{i,2},data{i});
end

country_errors = cell(length(strings_array),3);
for i=1:length(strings_array)
    country_errors{i,1} = error(i,1);
    country_errors{i,2} = error(i,2);
    country_errors{i,3} = strings_array(i);
end

sorted_confirmed = sortrows(country_errors,1)
sorted_deaths = sortrows(country_errors,2)


%% Plots for every Country 
Corona_Plot(data{1},'lognormal','Log Normal',country{1,1},' Russia');
Corona_Plot(data{1},'lognormal','Log Normal',country{1,2},' Russia');
Corona_Plot(data{2},'lognormal','Log Normal',country{2,1},' Germany');
Corona_Plot(data{2},'lognormal','Log Normal',country{2,2},' Germany');
Corona_Plot(data{3},'lognormal','Log Normal',country{3,1},' France');
Corona_Plot(data{3},'lognormal','Log Normal',country{3,2},' France');
Corona_Plot(data{4},'lognormal','Log Normal',country{4,1},' UK');
Corona_Plot(data{4},'lognormal','Log Normal',country{4,2},' UK');
Corona_Plot(data{5},'lognormal','Log Normal',country{5,1},' Italy');
Corona_Plot(data{5},'lognormal','Log Normal',country{5,2},' Italy');
Corona_Plot(data{6},'lognormal','Log Normal',country{6,1},' Spain');
Corona_Plot(data{6},'lognormal','Log Normal',country{6,2},' Spain');
Corona_Plot(data{7},'lognormal','Log Normal',country{7,1},' Romania');
Corona_Plot(data{7},'lognormal','Log Normal',country{7,2},' Romania');
Corona_Plot(data{8},'lognormal','Log Normal',country{8,1},' Netherlands');
Corona_Plot(data{8},'lognormal','Log Normal',country{8,2},' Netherlands');
Corona_Plot(data{9},'lognormal','Log Normal',country{9,1},' Greece');
Corona_Plot(data{9},'lognormal','Log Normal',country{9,2},' Greece');
Corona_Plot(data{10},'lognormal','Log Normal',country{10,1},' Portugal');
Corona_Plot(data{10},'lognormal','Log Normal',country{10,2},' Portugal');
Corona_Plot(data{11},'lognormal','Log Normal',country{11,1},' Belgium');
Corona_Plot(data{11},'lognormal','Log Normal',country{11,2},' Belgium');
Corona_Plot(data{12},'lognormal','Log Normal',country{12,1},' Czechia');
Corona_Plot(data{12},'lognormal','Log Normal',country{12,2},' Czechia');
Corona_Plot(data{13},'lognormal','Log Normal',country{13,1},' Hungary');
Corona_Plot(data{13},'lognormal','Log Normal',country{13,2},' Hungary');
Corona_Plot(data{14},'lognormal','Log Normal',country{14,1},' Sweden');
Corona_Plot(data{14},'lognormal','Log Normal',country{14,2},' Sweden');





%y = pdf(pd,data);





