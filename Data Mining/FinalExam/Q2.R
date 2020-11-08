setwd("F:\\Data Science\\DataScience_2019501111\\Data Mining\\Final exam")

data = read.csv("AprioData.csv", header = TRUE);
View(data)
data$TID <- NULL
library(arules)

write.csv(data, "ItemList.csv", quote = FALSE, row.names = TRUE)
transactions = read.transactions("ItemList.csv", sep=',', rm.duplicates = TRUE)
inspect(transactions)

freqItemsets <- apriori(transactions, parameter = list(sup = 0.03, conf = 0.5,target="frequent itemsets"))

inspect(sort(freqItemsets)[1:15])

itemFrequencyPlot(transactions, topN = 5)
