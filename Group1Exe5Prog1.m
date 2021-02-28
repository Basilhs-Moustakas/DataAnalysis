% VASILEIOS-PANAGIOTIS MOUSTAKAS 9424
% ROMANOS VOULGARAKIS 9383
close all;
clear all;
 
country = load("country.mat");
country = country.country;

number_of_countries=6;

strings_array = ["Russia","Germany","UK","Italy","Spain","Netherlands"];
% strings_array = ["Russia","Germany","France","UK","Italy","Spain","Romania","Netherlands","Greece","Portugal",...
%     "Belgium","Czechia","Hungary","Sweden"];


data = cell(length(strings_array),1);
for i=1:length(strings_array)
    data{i} = 1:length(country{i,1});
end

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

% countries=country;

estimated_deaths = cell(21,number_of_countries);

%% Fitting simple linear regression models for various hystereses

for tau=0:20
X = cell(length(strings_array),1);
    for i=1:length(strings_array)
        confirmed = countries{i,1}(1:end-tau);
        deaths = countries{i,2}(1+tau:end);
        X{i} = [ones(length(confirmed'),1) confirmed'];
        b(:,i) = X{i}\deaths';
        estimated_deaths{tau+1,i} = X{i}*b(:,i);
    end
end

errors = zeros(21,number_of_countries);
%% MSE for various hystereses
for i=1:length(strings_array)
    for tau=0:20
        errors(tau+1,i) = immse(estimated_deaths{tau+1,i},countries{i,2}(1+tau:end)');
    end
end

days_delay=zeros(1,number_of_countries);

%% Selecting the best-fit hysteresis 
for i=1:length(strings_array)
    [~,days_delay(i)] = min(errors(:,i));
end
days_delay=days_delay-1;


%% Plots

figure()
X = 0:20;
Y = errors(:,1);
hb=bar(X,Y);
my_colors=colormap(bone);
hb.FaceColor = 'flat';
for i=1:21
hb.CData(i,:) = my_colors(3*i,:);
end
title('Russia', 'interpreter','latex','FontSize',16 ) 
ylabel('Mean Square Error', 'interpreter','latex','FontSize',14 )
xlabel('Days Difference', 'interpreter','latex','FontSize',14 )
grid on;

figure()
X = 0:20;
Y = errors(:,2);
hb=bar(X,Y);
my_colors=colormap(bone);
hb.FaceColor = 'flat';
for i=1:21
hb.CData(i,:) = my_colors(3*i,:);
end
title('Germany', 'interpreter','latex','FontSize',16 ) 
ylabel('Mean Square Error', 'interpreter','latex','FontSize',14 )
xlabel('Days Difference', 'interpreter','latex','FontSize',14 )
grid on;

figure()
X = 0:20;
Y = errors(:,3);
hb=bar(X,Y);
my_colors=colormap(bone);
hb.FaceColor = 'flat';
for i=1:21
hb.CData(i,:) = my_colors(3*i,:);
end
title('United Kingdom', 'interpreter','latex','FontSize',16 ) 
ylabel('Mean Square Error', 'interpreter','latex','FontSize',14 )
xlabel('Days Difference', 'interpreter','latex','FontSize',14 )
grid on;

figure()
X = 0:20;
Y = errors(:,4);
hb=bar(X,Y);
my_colors=colormap(bone);
hb.FaceColor = 'flat';
for i=1:21
hb.CData(i,:) = my_colors(3*i,:);
end
title('Italy', 'interpreter','latex','FontSize',16 ) 
ylabel('Mean Square Error', 'interpreter','latex','FontSize',14 )
xlabel('Days Difference', 'interpreter','latex','FontSize',14 )
grid on;

figure()
X = 0:20;
Y = errors(:,5);
hb=bar(X,Y);
my_colors=colormap(bone);
hb.FaceColor = 'flat';
for i=1:21
hb.CData(i,:) = my_colors(3*i,:);
end
title('Spain', 'interpreter','latex','FontSize',16 ) 
ylabel('Mean Square Error', 'interpreter','latex','FontSize',14 )
xlabel('Days Difference', 'interpreter','latex','FontSize',14 )
grid on;

figure()
X = 0:20;
Y = errors(:,6);
hb=bar(X,Y);
my_colors=colormap(bone);
hb.FaceColor = 'flat';
for i=1:21
hb.CData(i,:) = my_colors(3*i,:);
end
title('Netherlands', 'interpreter','latex','FontSize',16 ) 
ylabel('Mean Square Error', 'interpreter','latex','FontSize',14 )
xlabel('Days Difference', 'interpreter','latex','FontSize',14 )
grid on;



country_days = cell(length(strings_array),2);
for i=1:length(strings_array)
    country_days{i,1} = days_delay(i);
end

 
country_days{1,2}='Russia';
country_days{2,2}='Germany';
country_days{3,2}='UK';
country_days{4,2}='Italy';
country_days{5,2}='Spain';
country_days{6,2}='Netherlands';

% country_days{1,2}='Russia';
% country_days{2,2}='Germany';
% country_days{3,2}='France';
% country_days{4,2}='UK';
% country_days{5,2}='Italy';
% country_days{6,2}='Spain';
% country_days{7,2}='Romania';
% country_days{8,2}='Netherlands';
% country_days{9,2}='Greece';
% country_days{10,2}='Portugal';
% country_days{11,2}='Belgium';
% country_days{12,2}='Czechia';
% country_days{13,2}='Hungary';
% country_days{14,2}='Sweden';




sorted_days = sortrows(country_days,1);

figure()
X = categorical(sorted_days(:,2));
X = reordercats(X,sorted_days(:,2));
Y = cell2mat(sorted_days(:,1));
hb=bar(X,Y);
my_colors=colormap(bone);
hb.FaceColor = 'flat';
hb.CData(1,:) = my_colors(60,:);
hb.CData(2,:) = my_colors(50,:);
hb.CData(3,:) = my_colors(40,:);
hb.CData(4,:) = my_colors(30,:);
hb.CData(5,:) = my_colors(20,:);
hb.CData(6,:) = my_colors(10,:);
% for i=1:14
% hb.CData(i,:) = my_colors(3*i,:);
% end

title('Days Delay for Minimum Error', 'interpreter','latex','FontSize',16 ) 
ylabel('Days', 'interpreter','latex','FontSize',14 )
grid on;


tau_best=days_delay;
for c=1:6
figure
scatter(1:length(countries{c,2}(1+tau_best(c):end)),countries{c,2}(1+tau_best(c):end))
hold on
plot(estimated_deaths{tau_best(c)+1,c},'LineWidth',1.5, 'Color','m')
legend('Predicted deaths','Actual deaths');
title(strings_array(c), 'interpreter','latex','FontSize',16 ) 
xlabel('Days', 'interpreter','latex','FontSize',14 )
ylabel('Deaths', 'interpreter','latex','FontSize',14 )
grid on;
hold off
end




clc;
disp("In figures 1-6 the MSE for various hystereses and countries is presented.");
disp("The hysteresis for which the MSE is minimized seems to agree with previous");
disp("results from excercises 3 and 4.");
disp(newline);
str = "Country    " + "   Days Delay   " + "  MSE";
str = str + newline + "--------------------------------------";
str = str + newline + "Russia        " + days_delay(1) +"              " + errors(1+days_delay(1),1);
str = str + newline + "Germany       " + days_delay(2) +"              "+ errors(1+days_delay(2),2);
str = str + newline + "UK            " + days_delay(3) +"              "+ errors(1+days_delay(3),3);
str = str + newline + "Italy         " + days_delay(4) +"               "+ errors(1+days_delay(4),4);
str = str + newline + "Spain         " + days_delay(5) +"              "+ errors(1+days_delay(5),5);
str = str + newline + "Netherlands   " + days_delay(6) +"                "+ errors(1+days_delay(6),6);
disp(str);
disp(newline);
disp("As obvious from the above table, for Russia and UK the minimum MSE is");
disp("significantly higher than the rest. This agrees with figures 8 and 10");
disp("where significant errors are produced.");
disp("From figures 8-13 we can observe that a rough estimation of daily deaths ");
disp("is possible using the hysteresis with the smallest MSE for each country.");
disp(newline);
disp("Although the MSE metric appears to be sufficient for selecting the optimal");
disp("delay for each country, it does not provide enough information to compare");
disp("the models' efficiency for different countries. For example, while the");
disp("minimum MSE for Netherlands is less than the one of Italy, from figures 11");
disp("and 13 we can observe that the model has adapted better for the Italian data.");








