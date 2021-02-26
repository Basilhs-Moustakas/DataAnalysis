close all;
clear all;

country = load("country.mat");
country = country.country;
difference_maxima=zeros(1,14);
for i=1:14
    difference_maxima(i) = Maxima_difference_calc(country{i,1},country{i,2});
    
end
difference_maxima

alpha = 0.05;

m_bootstrap = bootci(1000,{@mean,difference_maxima(1:13)},'alpha',alpha)

m2 = mean(difference_maxima(1:13));
s2 = std(difference_maxima(1:13));
stud = tinv(1-alpha,length(difference_maxima(1:13))-1) * s2 /sqrt(length(difference_maxima(1:13)));

m_parametric = [m2-stud ;m2+stud]