function [] = Corona_Plot(data,distribution,Title,array,country)
sum=0;
for i=1:length(array)
    sum = sum+array(i);
end
normalized_array = array / sum;
pd = fitdist(data',distribution,'frequency',array);
y = pdf(pd,data);
figure
bar(data,normalized_array);
hold on;
plot(data,y, 'Color','magenta','LineWidth',2 );

title(strcat(Title , country) , 'fontsize',17);
ylabel('Density', 'fontsize',14)
xlabel('Day', 'fontsize',14)
end

