close all;
clear all;

country = load("country.mat");
country = country.country;
difference_maxima=zeros(1,14);
for i=1:14
    difference_maxima(i) = Group1Exe3Fun1(country{i,1},country{i,2});
    
end

alpha = 0.05;

m_bootstrap = bootci(1000,{@mean,difference_maxima(1:13)},'alpha',alpha);

m2 = mean(difference_maxima(1:13));
s2 = std(difference_maxima(1:13));
stud = tinv(1-alpha,length(difference_maxima(1:13))-1) * s2 /sqrt(length(difference_maxima(1:13)));

m_parametric = [m2-stud ;m2+stud];


clc;
disp(newline);
str = "Days difference between estimation maxima for deaths and confirmed cases";
str = str + newline + "Russia       " + difference_maxima(1);
str = str + newline + "Germany      " + difference_maxima(2);
str = str + newline + "France       " + difference_maxima(3);
str = str + newline + "UK           " + difference_maxima(4);
str = str + newline + "Italy        " + difference_maxima(5);
str = str + newline + "Spain        " + difference_maxima(6);
str = str + newline + "Romania      " + difference_maxima(7);
str = str + newline + "Netherlands  " + difference_maxima(8);
str = str + newline + "Greece       " + difference_maxima(9);
str = str + newline + "Portugal     " + difference_maxima(10);
str = str + newline + "Belgium      " + difference_maxima(11);
str = str + newline + "Czechia      " + difference_maxima(12);
str = str + newline + "Hungary      " + difference_maxima(13);
str = str + newline + "Sweden       " + difference_maxima(14);
disp(str);
disp(newline);

disp("95% bootstrap confidence interval");
disp("[" + m_bootstrap(1) + "," + m_bootstrap(2) + "]"); 
disp(newline);
disp("95% parametric confidence interval");
disp("[" + m_parametric(1) + "," + m_parametric(2) + "]"); 
disp(newline);


disp("Sweden was excluded from the calculations, due to ");
disp("the unrealistic result for the days difference between the maxima");
disp(newline);


