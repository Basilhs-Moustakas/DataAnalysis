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

error

%y = pdf(pd,data);





