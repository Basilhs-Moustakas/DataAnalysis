close all;
clear all;
 
country = load("country.mat");
country = country.country;



%% Data from every Country

distribution = 'lognormal';


%% Plots for every Country with 

strings_array = ["Russia","Germany","UK","Italy","Spain","Netherlands"];

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

