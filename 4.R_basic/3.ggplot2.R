#######################################
# ggplot2 
#######################################
install.packages("ggthemes")
library(ggplot2)
library(ggthemes)

mpg
mpg1 <- mpg

### qplot examl ########################
qplot(data=mpg1, x=cty)
qplot(data=mpg1, x=drv, y=hwy, geom="boxplot", 
      colour="drv")

### ggplot ##############################
ggplot(data=mpg1, aes(x=displ, y=hwy))+
  geom_point() +
  xlim(3,6) + ylim(10,30)

g1 <- ggplot(data=mpg1, aes(x=displ, y=hwy))
g2 <- geom_point()
g3 <- xlim(3,6) + ylim(10,30)
g1 + g2

ggplot(data=diamonds, aes(x=carat,y=price,colour=clarity))+
  geom_point() +
  theme_wsj()

stu_df = read.csv('./data/newStudent.csv') 
g1<-ggplot(data=stu_df, aes(x=height, y=weight, 
                        colour=blood)) +
  geom_point()
g1 + geom_line(size=1)+geom_point(size=5) +
  facet_grid(gender~.)

ggplot(mpg1, aes(displ, hwy)) + geom_point() +
  facet_grid(.~class)

ggplot(mpg1, aes(cty, hwy)) + geom_point()

ggplot(midwest, aes(poptotal, popasian)) + geom_point() +
  xlim(0,500000) + ylim(0,10000)

df_mpg <- mpg1 %>% group_by(drv) %>% 
  summarise(mean_hwy=mean(hwy))

df_mpg

ggplot(df_mpg, aes(x=drv, y=mean_hwy)) + geom_col()
ggplot(df_mpg, aes(x=reorder(drv, -mean_hwy), 
                   y=mean_hwy)) + geom_col()


ggplot(mpg1, aes(x=drv)) + geom_bar()
ggplot(mpg1, aes(x=hwy)) +geom_bar()


stu_df
ggplot(stu_df, aes(x=blood, fill=gender)) + geom_bar()
ggplot(stu_df, aes(x=blood, fill=gender)) + 
  geom_bar(position = "dodge")

new_df <- mpg1 %>% filter(class == "suv") %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty=mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)

new_df

ggplot(new_df, aes(x=reorder(manufacturer, -mean_cty), y=mean_cty)) +
  geom_col()

ggplot(mpg1, aes(x=class)) + geom_bar()

str(economics)

?economics

ggplot(economics, aes(x=date, y=psavert))+
  geom_line()






