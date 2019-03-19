library(tidyverse)
library(data.table)
library(reshape2)

my_df <- read.table("Ordered_All_Pop_pwc", header = TRUE)
options("scipen"=100, "digits"=4)
#boxplot(my_df[,9:34], las=2)

x <- data.frame(do.call(cbind, lapply(my_df[sapply(my_df,is.numeric)], summary)))
x <- x[4:31]

y <-  melt(data.frame(my_df[9:36]))
y$variable <- as.factor(y$variable)
mean <- aggregate(value~variable,y,mean)
my_bar_plot <- ggplot(y,aes(variable,value))+
  geom_boxplot(aes(fill=ifelse(y$variable=="diff.11.18","Population 11 vs 18","Rest")))+
  geom_text(data= mean, aes(label=round((value),3), y = (value) + 0.001), 
            size=2, position=position_dodge(width=0.7))+
  theme_minimal()+
  theme(legend.position="none")+
  xlab("Two Populations under comparison")+
  ylab("Difference in Allele Frequency")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("Allele_freq_diff_barplot.png", plot = my_bar_plot, width = 8.04, height = 5.01)