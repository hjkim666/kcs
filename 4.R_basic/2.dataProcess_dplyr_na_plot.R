library(dplyr)
#########################################
# left join (column)
#########################################
test1 <- data.frame(id=c(1,2,3,4,5),
                    midterm=c(60,80,70,90,95))
test2 <- data.frame(id=c(1,2,3,4,5),
                    final=c(70,83,65,95,80))
test1
test2
total <- left_join(test1,test2,by='id')
tname <- data.frame(id=c(1,2,3,4,5),
                    teacher=c("kim","lee","park","choi","jung"))
left_join(total,tname,by='id')

###########################################
# bind_row 
###########################################
test1 <- data.frame(id=c(1,2,3,4,5),
                    score=c(60,80,70,90,95))
test2 <- data.frame(id=c(1,2,3,4,5),
                    score=c(70,83,65,95,80))
test1
test2
bind_rows(test1, test2)
bind_cols(test1, test2)

###########################################
# practice 
###########################################
library(ggplot2)
midwest <- midwest %>% 
  mutate(youngratio = (poptotal-popadults)/poptotal * 100)

midwest %>% 
  select(county, youngratio) %>% 
  arrange(desc(youngratio)) %>% 
  head(5)

midwest <- midwest %>% 
  mutate(gubun=ifelse(youngratio >=40, "large", 
                      ifelse( youngratio>=30, "middle", "small")))
table(midwest$gubun)

###########################################
# 데이터 정제 
###########################################
df <- data.frame(gender=c('M',NA,'F'), score=c(NA,4,3))
df
str(df)

is.na(df)
table(is.na(df))

mean(df$score)

#1) is.na
df %>% filter(!is.na(score) & !is.na(gender))

#2) na.omit()
na.omit(df)

#3) na.rm = T
mean(df$score, na.rm=T)
sum(df$score, na.rm=T)

df %>% summarise(mean_score=mean(score, na.rm =T),
                 sum_score=sum(score, na.rm = T),
                 median_score=median(score, na.rm = T))

df$score <- ifelse(is.na(df$score), 3.5, df$score)
df
table(is.na(df$score))
#######################################
# practice
#######################################
mpg2 <- as.data.frame(mpg)
mpg2
mpg2[c(65,124,131,153,212),'hwy'] <- NA
mpg2$hwy
# 결측치의 개수 
table(is.na(mpg2$drv))
table(is.na(mpg2$hwy))

# drv별 hwy의 평균 
mpg2%>%
  filter(!is.na(hwy)) %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

#######################################
# outlier
#######################################
df <- data.frame(gender=c(1,2,3,2,1,2),
                 score=c(5,4,3,4,2,9))
df
table(df$gender)
boxplot(df$score)$stat

df$gender = ifelse(df$gender == 3, NA,df$gender)
df$score = ifelse(df$score > 5, NA, df$score)
df

boxplot(mpg$hwy)$stat

mpg2 <- mpg
mpg2$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg2$hwy))
mpg2$hwy

mpg2 %>% group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))

#######################################
# Practice
#######################################
mpg3 <- as.data.frame(mpg)
mpg3[c(10,14,58,93), "drv"] <- "k"
table(mpg3$drv)
mpg3$drv <- ifelse(mpg3$drv == "k", NA, mpg3$drv)
table(is.na(mpg3$drv))

mpg3[c(29,43,129,203), "cty"] <- c(3,4,39,42)
boxplot(mpg3$cty)
boxplot(mpg3$cty)$stats
mpg3$cty <- ifelse(mpg3$cty < 9 | mpg3$cty > 26, NA, mpg3$cty)
boxplot(mpg3$cty)
table(is.na(mpg3$cty))

mpg3 %>% 
  filter(!is.na(drv) & !is.na(cty)) %>% 
  group_by(drv) %>% 
  summarise(mean_cty = mean(cty))

#######################################
# Graph - visualization
#######################################
library(ggplot2)

x=c('a','a','b','c')
qplot(x)

mpg4 <- as.data.frame(mpg)
qplot(data=mpg4, x=hwy, bins = 30)
qplot(data=mpg4, x=cty)
qplot(data=mpg4, x=drv, y=hwy, geom='line')
qplot(data=mpg4, x=drv, y=hwy, geom='boxplot')
qplot(data=mpg4, x=drv, y=hwy, geom='boxplot', colour=drv)
qplot(data=mpg4, x=drv, y=hwy, geom='boxplot', fill=drv)

?qplot

#######################################
# scatter plot
#######################################
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() + 
  xlim(3,6)  + ylim(10,30)

#######################################
# practice
#######################################
ggplot(data = mpg, aes(x=cty, y=hwy)) + geom_point()

ggplot(data=midwest, aes(x=poptotal, y=popasian)) +
  geom_point() +
  xlim(0,500000) +
  ylim(0,10000)


#######################################
# Bar chart
#######################################
df <- mpg %>% group_by(drv) %>% 
  summarise(mean_hwy=mean(hwy))

df
ggplot(data=df, aes(x=drv, y=mean_hwy)) + geom_col(aes(fill=drv))

ggplot(data=df, aes(x=reorder(drv,-mean_hwy), y=mean_hwy)) +
  geom_col()

ggplot(data=mpg, aes(x=drv)) + geom_bar()
table(mpg$drv)

ggplot(data=mpg, aes(x=reorder(drv, ..count..))) + geom_bar()

library(dplyr)
library(ggplot2)

mpg %>%
  group_by(drv) %>%                              # calculate the counts
  summarize(counts = n()) %>%
  arrange(-counts) %>%                           # sort by counts
  mutate(drv = factor(drv, drv)) %>%             # reset factor
  ggplot(aes(x=drv, y=counts)) +                 # plot 
  geom_bar(stat="identity")                         # plot histogram



ggplot(data=mpg, aes(x=hwy)) + geom_bar()

ggplot(data=mtcars, mapping = aes(x=cyl, y=..count..,  
                                  fill=as.factor(am))) +
  geom_bar(position = "dodge", width=1.8) +   
  geom_text(stat = "count", aes(label=..count..),
            position = position_dodge(width=1.8), vjust=-0.5)

#######################################
# Bar chart practice
#######################################
df_cty <- mpg %>% 
  filter(class=="suv") %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty=mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)
df_cty

ggplot(data=df_cty, aes(x=reorder(manufacturer, -mean_cty)
                        , y=mean_cty)) + geom_col() + 
  xlab('manufacturer') + ylab('mean of cty') + 
  ggtitle('생산자별 평균연비')
#######################################
# Line Chart
#######################################
economics
ggplot(data=economics, aes(x=date, y=unemploy)) + 
  geom_line()

ggplot(data=economics, aes(x=date, y=psavert)) + 
  geom_line()


#######################################
# Boxplot
#######################################
mpg_cty <- mpg %>%
  filter(class %in% c("compact", "subcompact", "suv")) 
mpg_cty  

#x축: class, y축:cty 
ggplot(data=mpg_cty, aes(x=class, y=cty))+geom_boxplot()

ggplot(data=mpg_cty, aes(x=class, y=cty, fill=class)) +
  geom_boxplot()


