devtools::install_github("abresler/forbesListR")
library(forbesListR)
library(tidyr)
library(dplyr)
library(ggplot2)


vcs_2012_2016 <-get_years_forbes_list_data(years = 2012:2016, list_name = "Top VCs")

ggplot(vcs_2012_2016, aes(year, fill=gender)) + geom_bar()
ggplot(vcs_2012_2016, aes(year, fill=country)) + geom_bar()


vc16 <- subset(vcs_2012_2016, year == 2016)
vc15 <- subset(vcs_2012_2016, year == 2015)
vc14 <- subset(vcs_2012_2016, year == 2014)
vc13 <- subset(vcs_2012_2016, year == 2013)
vc12 <- subset(vcs_2012_2016, year == 2012)
vc15 <- select(vc15, year, name, rank)
vc14 <- select(vc14, year, name, rank)
vc13 <- select(vc13, year, name, rank)
vc12 <- select(vc12, year, name, rank)
vc2012 <- head(vc12, -25)
vc13 <- head(vc13, -25)
vc14 <- head(vc14, -25)
vc15 <- head(vc15, -25)
vc16 <- head(vc16, -25)
rank <- aggregate(df$rank, list(df$name), sum)
rank$name <- rank$Group.1
rank$Group.1 <- NULL
merge <- merge(vcs_2012_2016, rank, by=c("name"))
merge <- subset(merge, x <= 62)

p1 <- p + geom_line() + geom_text(data = subset(merge,
                                                year == "2016"), aes(x = factor(year +
                                                                                  0.5)), size = 3.5, hjust = 0.8)
p1 + theme_bw() + theme(legend.position = "none",
                        panel.border = element_blank(), axis.ticks = element_blank()) + xlab(NULL) + ylab(NULL) + scale_y_reverse( lim=c(100,0))

