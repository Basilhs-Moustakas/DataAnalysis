% VASILEIOS-PANAGIOTIS MOUSTAKAS 9424
% ROMANOS VOULGARAKIS 9383
close all;
clear all;
 
country = load("country.mat");
country = country.country;



%% Data from every Country

distribution = 'lognormal';


%% Plots for every Country with 
strings_array = ["Russia","Germany","UK","Italy","Spain","Netherlands"];
% strings_array = ["Russia","Germany","France","UK","Italy","Spain","Romania","Netherlands","Greece","Portugal",...
%     "Belgium","Czechia","Hungary","Sweden"];

data = cell(length(strings_array),1);
for i=1:length(strings_array)
    data{i} = 1:length(country{i,1});
end

% countries=country;

countries{1,1} = country{1,1};
countries{1,2} = country{1,2};
countries{2,1} = country{2,1};
countries{2,2} = country{2,2};
countries{3,1} = country{4,1};
countries{3,2} = country{4,2};
countries{4,1} = country{5,1};
countries{4,2} = country{5,2};
countries{5,1} = country{6,1};
countries{5,2} = country{6,2};
countries{6,1} = country{8,1};
countries{6,2} = country{8,2};

for j=1:length(strings_array)
    coeff_matrix = zeros(1,length(strings_array));
    for i=-20:20
        if i>=0
            temp = corrcoef(countries{j,1}(1:end-i),countries{j,2}(i+1:end));
            coeff_matrix(i+21)= temp(1,2);
        else
            temp = corrcoef(countries{j,2}(1:end+i),countries{j,1}(abs(i)+1:end));
            coeff_matrix(i+21)= temp(1,2);
        end
    end
    [~,tau] = max(coeff_matrix);
    tau_of_max_correlation(j) = tau - 21;   
end

country_correlation = cell(length(strings_array),2);
for i=1:length(strings_array)
    country_correlation{i,1} = tau_of_max_correlation(i);
end
% country_correlation{1,2}='Russia';
% country_correlation{2,2}='Germany';
% country_correlation{3,2}='France';
% country_correlation{4,2}='UK';
% country_correlation{5,2}='Italy';
% country_correlation{6,2}='Spain';
% country_correlation{7,2}='Romania';
% country_correlation{8,2}='Netherlands';
% country_correlation{9,2}='Greece';
% country_correlation{10,2}='Portugal';
% country_correlation{11,2}='Belgium';
% country_correlation{12,2}='Czechia';
% country_correlation{13,2}='Hungary';
% country_correlation{14,2}='Sweden';

country_correlation{1,2}='Russia';
country_correlation{2,2}='Germany';
country_correlation{3,2}='UK';
country_correlation{4,2}='Italy';
country_correlation{5,2}='Spain';
country_correlation{6,2}='Netherlands';

sorted_correlations = sortrows(country_correlation,1);



figure()
X = categorical(sorted_correlations(:,2));
X = reordercats(X,sorted_correlations(:,2));
Y = cell2mat(sorted_correlations(:,1));
hb=bar(X,Y);
my_colors=colormap(cool);
hb.FaceColor = 'flat';
hb.CData(1,:) = my_colors(60,:);
hb.CData(2,:) = my_colors(50,:);
hb.CData(3,:) = my_colors(40,:);
hb.CData(4,:) = my_colors(30,:);
hb.CData(5,:) = my_colors(20,:);
hb.CData(6,:) = my_colors(10,:);


title('Maximum Correleation - Days Difference', 'interpreter', 'latex','FontSize',16 ) 
ylabel('Days', 'interpreter', 'latex','FontSize',14 )
grid on;


strings_array = ["Russia","Germany","France","UK","Italy","Spain","Romania","Netherlands","Greece","Portugal",...
    "Belgium","Czechia","Hungary","Sweden"];

countries=country;

data = cell(length(strings_array),1);
for i=1:length(strings_array)
    data{i} = 1:length(country{i,1});
end

for j=1:length(strings_array)
    coeff_matrix = zeros(1,length(strings_array));
    for i=-20:20
        if i>=0
            temp = corrcoef(countries{j,1}(1:end-i),countries{j,2}(i+1:end));
            coeff_matrix(i+21)= temp(1,2);
        else
            temp = corrcoef(countries{j,2}(1:end+i),countries{j,1}(abs(i)+1:end));
            coeff_matrix(i+21)= temp(1,2);
        end
    end
    [~,tau] = max(coeff_matrix);
    tau_of_max_correlation(j) = tau - 21;   
end


country_correlation = cell(length(strings_array),2);
for i=1:length(strings_array)
    country_correlation{i,1} = tau_of_max_correlation(i);
end
country_correlation{1,2}='Russia';
country_correlation{2,2}='Germany';
country_correlation{3,2}='France';
country_correlation{4,2}='UK';
country_correlation{5,2}='Italy';
country_correlation{6,2}='Spain';
country_correlation{7,2}='Romania';
country_correlation{8,2}='Netherlands';
country_correlation{9,2}='Greece';
country_correlation{10,2}='Portugal';
country_correlation{11,2}='Belgium';
country_correlation{12,2}='Czechia';
country_correlation{13,2}='Hungary';
country_correlation{14,2}='Sweden';



sorted_correlations = sortrows(country_correlation,1);



figure()
X = categorical(sorted_correlations(:,2));
X = reordercats(X,sorted_correlations(:,2));
Y = cell2mat(sorted_correlations(:,1));
hb=bar(X,Y);
my_colors=colormap(cool);
hb.FaceColor = 'flat';
hb.CData(1,:) = my_colors(63,:);
hb.CData(2,:) = my_colors(59,:);
hb.CData(3,:) = my_colors(55,:);
hb.CData(4,:) = my_colors(51,:);
hb.CData(5,:) = my_colors(47,:);
hb.CData(6,:) = my_colors(43,:);
hb.CData(7,:) = my_colors(39,:);
hb.CData(8,:) = my_colors(35,:);
hb.CData(9,:) = my_colors(31,:);
hb.CData(10,:) = my_colors(27,:);
hb.CData(11,:) = my_colors(23,:);
hb.CData(12,:) = my_colors(19,:);
hb.CData(13,:) = my_colors(15,:);
hb.CData(14,:) = my_colors(11,:);

title('Maximum Correleation - Days Difference', 'interpreter', 'latex','FontSize',16 ) 
ylabel('Days', 'interpreter', 'latex','FontSize',14 )
grid on;

clc;
disp(newline);
disp("In figure 2 the hysteresis needed to achieve the maximum");
disp("correlation is presented for each country. The results ");
disp("agree with those of exercise 3 for countries that Log-Normal");
disp("distribution fitted sufficiently. In figure 1 the results");
disp("of countries selected for later exercises are presented.");
disp(newline);



