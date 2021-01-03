function error = MSE(distribution,array,data)
sum=0;
for i=1:length(array)
    sum = sum+array(i);
end
normalized_array =array / sum;
temp  = fitdist(data',distribution,'frequency',array);
fitted = pdf(temp,data);
error = immse(normalized_array,fitted);
end

