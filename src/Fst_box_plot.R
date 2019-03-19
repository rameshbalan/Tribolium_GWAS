library(tidyverse)
library(data.table)
library(reshape2)
options("scipen"=100, "digits"=4)
fst_df <- read.table("Ordered_All_Pop_tidy.fst", header = TRUE)
not_required_columns <- c("SNP_window","fraction","average_minimum_coverage")
x <- fst_df[,!(names(fst_df) %in% not_required_columns)]
y <- melt(fst_df[6:33])
summary_table <- data.frame(do.call(cbind, lapply(fst_df[sapply(fst_df,is.numeric)], summary)))
summary_table <- summary_table[5:32]
y$variable <- as.factor(y$variable)
means_text <- aggregate(value~variable,y,mean)
Fst_bar_plot <- ggplot(y,aes(variable,value))+
  geom_boxplot(aes(fill=ifelse(y$variable=="Fst.11.18","Population 11 vs 18","Rest")))+
  geom_text(data= means_text, aes(label=round((value),3), y = (value) + 0.01), 
            size=2, position=position_dodge(width=0.7))+
  theme_minimal()+
  theme(legend.position="none")+
  xlab("Two Populations under comparison")+
  ylab("Fst")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("Fst_barplot.png", plot = Fst_bar_plot, width = 8.04, height = 5.01)
write.csv(summary_table,"Pairwise_Pop_Comp_Fst.csv", row.names=TRUE)