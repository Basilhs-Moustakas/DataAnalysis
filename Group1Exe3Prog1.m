close all;
clear all;

country = load("country.mat");
country = country.country;
difference_maxima=zeros(1,14);
for i=1:14
    difference_maxima(i) = Maxima_difference_calc(country{i,1},country{i,2});
    
end
difference_maxima
