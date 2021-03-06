% VASILEIOS-PANAGIOTIS MOUSTAKAS 9424
% ROMANOS VOULGARAKIS 9383
close all;
clear all;
 
country = load("countries_second_wave.mat");
countries = country.countries_second_wave;

%% Calculating moving average for 3 days and flooring for second wave

for i=1:6
    for j=1:2
        countries{i,j} = movmean(countries{i,j},[2 0]);
        for k=1:length(countries{i,j})
            countries{i,j}(k) = floor(countries{i,j}(k));
        end
    end
end



country_first = load("country_first.mat");
country_first = country_first.country;

country_first{1,1} = country_first{1,1};
country_first{1,2} = country_first{1,2};
country_first{2,1} = country_first{2,1};
country_first{2,2} = country_first{2,2};
country_first{3,1} = country_first{4,1};
country_first{3,2} = country_first{4,2};
country_first{4,1} = country_first{5,1};
country_first{4,2} = country_first{5,2};
country_first{5,1} = country_first{6,1};
country_first{5,2} = country_first{6,2};
country_first{6,1} = country_first{8,1};
country_first{6,2} = country_first{8,2};

strings_array = ["Russia","Germany","UK","Italy","Spain","Netherlands"];

%% Calculating moving average for 3 days and flooring for first wave

for i=1:6
    for j=1:2
        country_first{i,j} = movmean(country_first{i,j},[2 0]);
        for k=1:length(country_first{i,j})
            country_first{i,j}(k) = floor(country_first{i,j}(k));
        end
    end
end

%% Principal component regression for first wave MSE
X = cell(6,1);
estimated_deaths_first=cell(6,1);
for i=1:length(strings_array)
    deaths = country_first{i,2}(1+20:end)';
    for tau=0:20
        X{i} = [X{i}  country_first{i,1}(1+tau:end-20+tau)'];
    end
    [~,~,~,~,beta,~] = plsregress(X{i},deaths,20);
   estimated_deaths_first{i} = beta(1) + X{i}*beta(2:end);
end

%% Training PCR model with standardized data
b = zeros(22,6);
X = cell(6,1);
for i=1:6
    deaths = (country_first{i,2}(1+20:end) - mean(country_first{i,2}(1+20:end)))/std(country_first{i,2}(1+20:end));
    for tau=0:20
        X{i} = [X{i}  (country_first{i,1}(1+tau:end-20+tau)'-mean(country_first{i,1}(1+tau:end-20+tau)))/std(country_first{i,1}(1+tau:end-20+tau))];
    end
    [~,~,~,~,b(:,i),~] = plsregress(X{i},deaths',20);
end

%% Deaths estimation for the second wave using standardized PCR model
X = cell(6,1);
estimated_deaths=cell(6,1);
for i=1:6
    deaths = (countries{i,2}(1+20:end));
    for tau=0:20
        X{i} = [X{i}  ((countries{i,1}(1+tau:end-20+tau)')-mean(countries{i,1}(1+tau:end-20+tau)))/std(countries{i,1}(1+tau:end-20+tau))];
    end
    estimated_deaths{i} = b(1,i) + X{i}*b(2:end,i);
    for j=1:length(estimated_deaths{i})
        if j<21
            estimated_deaths{i}(j) = estimated_deaths{i}(j)*std(deaths(1:j)) + mean(deaths(1:j));
        else
            estimated_deaths{i}(j) = estimated_deaths{i}(j)*std(deaths(1:j)) + mean(deaths(j-20:j));
        end
    end
end

for i=1:6  
    means(i) = mean(country_first{i,1});
    stddevs(i) = std(country_first{i,1});
end

for i=1:6  
    means_deaths(i) = mean(country_first{i,2});
    stddevs_deaths(i) = std(country_first{i,2});
end

%% MSE calculation
for i=1:6
    errors(1,i) = immse(estimated_deaths_first{i,1},country_first{i,2}(1+20:end)');
    errors(2,i) = immse(estimated_deaths{i,1},countries{i,2}(1+20:end)');
end

figure()
X = categorical({'First wave','Second wave'});
X = reordercats(X,{'First wave','Second wave'});
Y = errors;
hb=bar(X,Y);
    my_colors=colormap(bone);
    hb(1).FaceColor = my_colors(10,:);
    hb(2).FaceColor = my_colors(20,:);
    hb(3).FaceColor = my_colors(30,:);
    hb(4).FaceColor = my_colors(40,:);
    hb(5).FaceColor = my_colors(50,:);
    hb(6).FaceColor = my_colors(60,:);
    legend(strings_array)
title('MSE for both waves', 'interpreter','latex','FontSize',16 ) 
ylabel('Mean Square Error', 'interpreter','latex','FontSize',16 )
grid on;



for i=1:6
figure
plot(countries{i,2}(1+20:end),'LineWidth',1.5, 'Color','blue')
hold on;
plot(estimated_deaths{i}','LineWidth',1.5, 'Color','m')
grid on;
hold off;
legend('Actual deaths','Predicted deaths');
title(strings_array(i), 'interpreter','latex','FontSize',16 ) 
end

clc;
disp("For better data handling the moving average technique for 3 days was implemented"); 
disp(newline);
disp("From figures 2-7 we can observe that PCR developed for the first wave");
disp("seems to achieve moderately accurate predictions for the second wave as well.");
disp(newline);
str = "Country      " + "  First wave MSE  " + "  Second wave MSE";
str = str + newline + "------------------------------------------------";
str = str + newline + "Russia       " + "   " + errors(1,1) + "          " + errors(2,1);
str = str + newline + "Germany      " + "   " + errors(1,2) + "          " + errors(2,2);
str = str + newline + "UK           " + "  " + errors(1,3) + "          " + errors(2,3);
str = str + newline + "Italy        " + "   " + errors(1,4) + "          " + errors(2,4);
str = str + newline + "Spain        " + "  " + errors(1,5) + "         " + errors(2,5);
str = str + newline + "Netherlands  " + "   " + errors(1,6) + "           " + errors(2,6);
disp(str);


disp(newline);
disp("From figure 1 we can observe that when using PCR the MSE has minor difference");
disp("compared to exercise 7");

