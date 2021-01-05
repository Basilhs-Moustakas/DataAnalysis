close all;
clear all;
 
country = load("countries_second_wave.mat");
countries = country.countries_second_wave;
country_first = load("country.mat");
country_first = country_first.country;

B = load("b_norm");
B = B.b;

for i=1:6  
    means(i) = mean(countries{i,1});
    stddevs(i) = std(countries{i,1});
end

X = cell(6,1);
estimated_deaths=cell(6,1);
for i=1:6
    deaths = countries{i,2}(1+20:end);
    X{i} = ones(length(deaths),1);
    for tau=0:20
        X{i} = [X{i}  (countries{i,1}(1+tau:end-20+tau)'-means(i))/stddevs(i)];     
    end
    
    estimated_deaths{i} = X{i}*B(:,i);
end
for i=1:6
figure
plot(countries{i,2}(1+20:end))
hold on;
plot(estimated_deaths{i}')
grid on;
hold off;
end