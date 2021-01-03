close all;
% Deaths = readtable('Covid19Deaths.xlsx');
% Confirmed = readtable('Covid19Confirmed.xlsx');


%% Data from every Country
Russia_confirmed =  table2array(Confirmed(117,74:242));
Russia_deaths    =  table2array(Deaths(117,74:242));
Germany_confirmed =  table2array(Confirmed(52,59:169));
Germany_deaths    =  table2array(Deaths(52,59:169));
France_confirmed =  table2array(Confirmed(48,59:148));
France_deaths    =  table2array(Deaths(48,59:148));
UK_confirmed =  table2array(Confirmed(147,59:198));
UK_deaths    =  table2array(Deaths(147,59:198));
Italy_confirmed =  table2array(Confirmed(67,55:196));
Italy_deaths    =  table2array(Deaths(67,55:196));
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