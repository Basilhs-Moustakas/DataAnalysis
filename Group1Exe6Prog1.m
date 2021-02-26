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

estimated_deaths_total = cell(number_of_countries,1);
estimated_deaths_ridge = cell(number_of_countries,1);

b = zeros(22,length(strings_array));
X = cell(length(strings_array),1);
for i=1:length(strings_array)
    deaths = countries{i,2}(1+20:end);
    X{i} = ones(length(deaths),1);
    for tau=0:20
        X{i} = [X{i}  countries{i,1}(1+tau:end-20+tau)'];
    end
    b(:,i) = regress(deaths',X{i});
    estimated_deaths_total{i} = X{i}*b(:,i);
end

for i=1:length(strings_array)
    B1 = ridge(countries{i,2}(1+20:end)',X{i}(:,2:end),5,0);
    estimated_deaths_ridge{i} = B1(1) + X{i}(:,2:end)*B1(2:end);
end

errors_one_variable=zeros(1,length(strings_array));
X = cell(length(strings_array),1);
for i=1:length(strings_array)
    if i==1 tau=18;
    elseif i==2 tau=13;
    elseif i==3 tau=0;
    elseif i==4 tau=6;
    elseif i==5 tau=7;
    elseif i==6 tau=5;
    end
    confirmed = countries{i,1}(1:end-tau);
    deaths = countries{i,2}(1+tau:end);
    X{i} = [ones(length(confirmed'),1) confirmed'];
    b = X{i}\deaths';
    estimated_deaths{i} = X{i}*b;
    errors_one_variable(i) = immse(estimated_deaths{i},deaths');
end


errors_total=zeros(1,length(strings_array));
errors_ridge=zeros(1,length(strings_array));
for i=1:length(strings_array)
        errors_total(i) = immse(estimated_deaths_total{i},countries{i,2}(1+20:end)');
        errors_ridge(i) = immse(estimated_deaths_ridge{i},countries{i,2}(1+20:end)');
end

for i=1:length(strings_array)
    X{i} = ones(length(countries{i,1}(1+tau:end-20+tau)),1);
    for tau=0:20
        X{i} = [X{i}  countries{i,1}(1+tau:end-20+tau)'];
    end
    B2 = lasso(X{i}(:,2:end),countries{i,2}(1+20:end),'Lambda',1e-03);
    estimated_deaths_lasso = X{i}(:,2:end)*B2;
    errors_lasso(i) = immse(estimated_deaths_lasso,countries{i,2}(1+20:end)');
end
% errors_total
% errors_ridge
% errors_one_variable
errors = [errors_total ; errors_ridge ; errors_one_variable];
figure()
X = categorical({'Russia','Germany','UK','Italy','Spain','Netherlands'});
X = reordercats(X,{'Russia','Germany','UK','Italy','Spain','Netherlands'});
Y = errors;
hb=bar(X,Y');
my_colors=colormap(bone);
hb(1).FaceColor = my_colors(10,:);
hb(2).FaceColor = my_colors(25,:);
hb(3).FaceColor = my_colors(40,:);

legend('Using All Data','Using Ridge Regression','Using Data from exercise 4','Location','northwest')
title('Errors with Different Regression Methods','FontSize',14 ) 
ylabel('Mean Square Error','FontSize',14 )
grid on;


% for c=1:6
% figure
% scatter(countries{c,2}(1+20:end),estimated_deaths_total{c})
% hold on
% plot(countries{c,2}(1+20:end),countries{c,2}(1+20:end))
% xlabel('Actual deaths')
% ylabel('Predicted deaths')
% hold off
% end
