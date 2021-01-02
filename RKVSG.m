function error = RKVSG(distribution,array,normalized_deaths)
data=1:142;
temp  = fitdist(data',distribution,'frequency',array);
fitted = pdf(temp,data);
error = immse(normalized_deaths,fitted);


pd = fitdist(data',distribution,'frequency',array);
y = pdf(pd,data);
figure
data=1:142;
bar(data,normalized_deaths);
hold on;
plot(data,y, 'Color','magenta','LineWidth',2 );
title(distribution, 'fontsize',17);
ylabel('Density', 'fontsize',14)
xlabel('Day', 'fontsize',14)


end
