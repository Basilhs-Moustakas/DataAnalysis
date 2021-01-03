close all;
% Deaths = readtable('Covid19Deaths.xlsx');
% Confirmed = readtable('Covid19Confirmed.xlsx');

% country = cell(14,2);
 
country = load("country.mat");
country = country.country;



%% Data from every Country

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
end
country_errors{1,3}='Russia';
country_errors{2,3}='Germany';
country_errors{3,3}='France';
country_errors{4,3}='UK';
country_errors{5,3}='Italy';
country_errors{6,3}='Spain';
country_errors{7,3}='Romania';
country_errors{8,3}='Netherlands';
country_errors{9,3}='Greece';
country_errors{10,3}='Portugal';
country_errors{11,3}='Belgium';
country_errors{12,3}='Czechia';
country_errors{13,3}='Hungary';
country_errors{14,3}='Sweden';


sorted_confirmed = sortrows(country_errors,1);
sorted_deaths = sortrows(country_errors,2); 

figure()
X = categorical(sorted_confirmed(:,3));
X = reordercats(X,sorted_confirmed(:,3));
Y = cell2mat(sorted_confirmed(:,1));
hb=bar(X,Y);
my_colors=colormap(cool);
hb.FaceColor = 'flat';
hb.CData(1,:) = my_colors(60,:);
hb.CData(2,:) = my_colors(56,:);
hb.CData(3,:) = my_colors(52,:);
hb.CData(4,:) = my_colors(48,:);
hb.CData(5,:) = my_colors(44,:);
hb.CData(6,:) = my_colors(40,:);
hb.CData(7,:) = my_colors(36,:);
hb.CData(8,:) = my_colors(32,:);
hb.CData(9,:) = my_colors(28,:);
hb.CData(10,:) = my_colors(24,:);
hb.CData(11,:) = my_colors(20,:);
hb.CData(12,:) = my_colors(16,:);
hb.CData(13,:) = my_colors(12,:);
hb.CData(14,:) = my_colors(8,:);

title('Confirmed Cases','FontSize',16 ) 
ylabel('Mean Square Error - Log Normal','FontSize',14 )
grid on;


figure()
X = categorical(sorted_deaths(:,3));
X = reordercats(X,sorted_deaths(:,3));
Y = cell2mat(sorted_deaths(:,2));
hb=bar(X,Y);
my_colors=colormap(cool);
hb.FaceColor = 'flat';
hb.CData(1,:) = my_colors(60,:);
hb.CData(2,:) = my_colors(56,:);
hb.CData(3,:) = my_colors(52,:);
hb.CData(4,:) = my_colors(48,:);
hb.CData(5,:) = my_colors(44,:);
hb.CData(6,:) = my_colors(40,:);
hb.CData(7,:) = my_colors(36,:);
hb.CData(8,:) = my_colors(32,:);
hb.CData(9,:) = my_colors(28,:);
hb.CData(10,:) = my_colors(24,:);
hb.CData(11,:) = my_colors(20,:);
hb.CData(12,:) = my_colors(16,:);
hb.CData(13,:) = my_colors(12,:);
hb.CData(14,:) = my_colors(8,:);

title('Deaths','FontSize',16 ) 
ylabel('Mean Square Error - Log Normal','FontSize',14 )
grid on;




%% Plots for every Country 
% Corona_Plot(data{1},'lognormal','Log Normal',country{1,1},' Russia',' Confirmed Cases');
% Corona_Plot(data{1},'lognormal','Log Normal',country{1,2},' Russia',' Deaths');
% Corona_Plot(data{2},'lognormal','Log Normal',country{2,1},' Germany',' Confirmed Cases');
% Corona_Plot(data{2},'lognormal','Log Normal',country{2,2},' Germany',' Deaths');
% Corona_Plot(data{3},'lognormal','Log Normal',country{3,1},' France',' Confirmed Cases');
% Corona_Plot(data{3},'lognormal','Log Normal',country{3,2},' France',' Deaths');
% Corona_Plot(data{4},'lognormal','Log Normal',country{4,1},' UK',' Confirmed Cases');
% Corona_Plot(data{4},'lognormal','Log Normal',country{4,2},' UK',' Deaths');
% Corona_Plot(data{5},'lognormal','Log Normal',country{5,1},' Italy',' Confirmed Cases');
% Corona_Plot(data{5},'lognormal','Log Normal',country{5,2},' Italy',' Deaths');
% Corona_Plot(data{6},'lognormal','Log Normal',country{6,1},' Spain',' Confirmed Cases');
% Corona_Plot(data{6},'lognormal','Log Normal',country{6,2},' Spain',' Deaths');
% Corona_Plot(data{7},'lognormal','Log Normal',country{7,1},' Romania',' Confirmed Cases');
% Corona_Plot(data{7},'lognormal','Log Normal',country{7,2},' Romania',' Deaths');
% Corona_Plot(data{8},'lognormal','Log Normal',country{8,1},' Netherlands',' Confirmed Cases');
% Corona_Plot(data{8},'lognormal','Log Normal',country{8,2},' Netherlands',' Deaths');
% Corona_Plot(data{9},'lognormal','Log Normal',country{9,1},' Greece',' Confirmed Cases');
% Corona_Plot(data{9},'lognormal','Log Normal',country{9,2},' Greece',' Deaths');
% Corona_Plot(data{10},'lognormal','Log Normal',country{10,1},' Portugal',' Confirmed Cases');
% Corona_Plot(data{10},'lognormal','Log Normal',country{10,2},' Portugal',' Deaths');
% Corona_Plot(data{11},'lognormal','Log Normal',country{11,1},' Belgium',' Confirmed Cases');
% Corona_Plot(data{11},'lognormal','Log Normal',country{11,2},' Belgium',' Deaths');
% Corona_Plot(data{12},'lognormal','Log Normal',country{12,1},' Czechia',' Confirmed Cases');
% Corona_Plot(data{12},'lognormal','Log Normal',country{12,2},' Czechia',' Deaths');
% Corona_Plot(data{13},'lognormal','Log Normal',country{13,1},' Hungary',' Confirmed Cases');
% Corona_Plot(data{13},'lognormal','Log Normal',country{13,2},' Hungary',' Deaths');
% Corona_Plot(data{14},'lognormal','Log Normal',country{14,1},' Sweden',' Confirmed Cases');
% Corona_Plot(data{14},'lognormal','Log Normal',country{14,2},' Sweden',' Deaths');






