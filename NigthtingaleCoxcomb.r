library(HistData)
library(tidyverse)
library(ggplot2)
library(reshape)
data(Nightingale)

CoxcombFiltered <- melt(Nightingale[,c(1,8:10)], "Date")
names(CoxcombFiltered) <- c("Date", "Cause", "Deaths")
CoxcombFiltered$Cause <- sub("\\.rate", "", CoxcombFiltered$Cause)

CoxcombFiltered <- subset(CoxcombFiltered, Date < as.Date("1855-04-01"))

CoxcombFiltered <- CoxcombFiltered[order(CoxcombFiltered$Deaths, decreasing=TRUE),]

NightingaleCoxcomb <- ggplot(CoxcombFiltered, aes(x = factor(Date), y=Deaths, fill = Cause))+
		xlab("")+
		geom_bar(width = 1, position="identity", stat="identity", color="black")+
		scale_y_sqrt()
		
NightingaleCoxcomb + scale_fill_manual(values = c("#006666", "#e62e00", "#ffcc00")) + coord_polar(start=3*pi/2) +
theme(panel.border=element_rect(fill=NA, size = 1))
#+ 
	      # theme(axis.text.x = element_text(angle = 180, hjust = 1))
		
NightingaleCoxcomb + coord_polar() + aes(x=reorder(factor(Date), Deaths))  + 
		  scale_fill_manual(values = c("#006666", "#e62e00", "#ffcc00")) +
		  xlab("") + theme(panel.border=element_rect(fill=NA, size = 1))
		