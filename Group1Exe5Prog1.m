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

% for j=1:length(strings_array)  
%     lambda(j) = countries{j,1}'\countries{j,2}';  
% end

estimated_deaths = cell(21,6);


for tau=0:20
X = cell(length(strings_array),1);
    for i=1:length(strings_array)
        confirmed = countries{i,1}(1+tau:end);
        deaths = countries{i,2}(1:end-tau);
        X{i} = [ones(length(confirmed'),1) confirmed'];
        b(:,i) = X{i}\deaths';
        estimated_deaths{tau+1,i} = X{i}*b(:,i);
    end
end

errors = zeros(21,6);

for i=1:length(strings_array)
    for tau=0:20
        errors(tau+1,i) = immse(estimated_deaths{tau+1,i},countries{i,2}(1:end-tau)');
    end
end

days_delay=zeros(1,6);

for i=1:length(strings_array)
    [~,days_delay(i)] = min(errors(:,i));
end
% days_delay

plot(countries{1,1}(1:end-18),estimated_deaths{19,1})
hold on
scatter(countries{1,1}(1:end-18),countries{1,2}(1:end-18))













