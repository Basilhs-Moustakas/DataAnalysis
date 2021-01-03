function error = RKVSG(distribution,array,normalized_deaths,data)
temp  = fitdist(data',distribution,'frequency',array);
fitted = pdf(temp,data);
error = immse(normalized_deaths,fitted);
end

