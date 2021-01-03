close all;
clear all;

country = load("country.mat");
country = country.country;

max_confirmed = zeros(1,14);
max_deaths = zeros(1,14);
difference_max2max = zeros(1,14);
i=1;
for i=1:14
    [~,max_confirmed(i)]=max(country{i,1});
    [~,max_deaths(i)]=max(country{i,2});
    difference_max2max(i)=max_deaths(i)-max_confirmed(i);
end
difference_max2max