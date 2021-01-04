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
        confirmed = countries{i,1}(1:end-tau);
        deaths = countries{i,2}(1+tau:end);
        X{i} = [ones(length(confirmed'),1) confirmed'];
        b(:,i) = X{i}\deaths';
        estimated_deaths{tau+1,i} = X{i}*b(:,i);
    end
end

errors = zeros(21,6);

for i=1:length(strings_array)
    for tau=0:20
        errors(tau+1,i) = immse(estimated_deaths{tau+1,i},countries{i,2}(1+tau:end)');
    end
end

days_delay=zeros(1,6);

for i=1:length(strings_array)
    [~,days_delay(i)] = min(errors(:,i));
end
days_delay=days_delay-1;
% days_delay
% tau=18;
% c=4;
% plot(countries{c,1}(1:end-tau),estimated_deaths{1+tau,c})
% hold on
% scatter(countries{c,1}(1:end-tau),countries{c,2}(1+tau:end))


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
title('Russia','FontSize',16 ) 
ylabel('Mean Square Error','FontSize',14 )
xlabel('Days Difference','FontSize',14 )
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
title('Germany','FontSize',16 ) 
ylabel('Mean Square Error','FontSize',14 )
xlabel('Days Difference','FontSize',14 )
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
title('United Kingdom','FontSize',16 ) 
ylabel('Mean Square Error','FontSize',14 )
xlabel('Days Difference','FontSize',14 )
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
title('Italy','FontSize',16 ) 
ylabel('Mean Square Error','FontSize',14 )
xlabel('Days Difference','FontSize',14 )
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
title('Spain','FontSize',16 ) 
ylabel('Mean Square Error','FontSize',14 )
xlabel('Days Difference','FontSize',14 )
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
title('Netherlands','FontSize',16 ) 
ylabel('Mean Square Error','FontSize',14 )
xlabel('Days Difference','FontSize',14 )
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

title('Days Delay for Minimum Error','FontSize',16 ) 
ylabel('Days','FontSize',14 )
grid on;

