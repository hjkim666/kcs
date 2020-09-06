#####################################
# T test 
#####################################
mpg=as.data.frame(ggplot2::mpg)
library(dplyr)
mpg_diff=mpg%>% select(class,cty) %>%
  filter(class %in% c("compact","suv"))
head(mpg_diff)
table(mpg_diff$class)
mpg_diff

com <- mpg_diff %>% filter(class=='compact')
suv <- mpg_diff %>% filter(class=='suv')
str
com
t.test(suv$cty, com$cty, var.equal = T)
t.test(data=mpg_diff, cty~class,var.equal = T)

var.test(data=mpg_diff, cty~class)
t.test(data=mpg_diff, cty~class,var.equal = F)

# regular vs premium 
mpg_diff2=mpg %>% select(fl,cty) %>% filter(fl %in% c("r","p"))
table(mpg_diff2$fl)

var.test(data=mpg_diff2, cty~fl)
t.test(data=mpg_diff2, cty~fl, var.equal = F)

#상관분석 
library(ggplot2)
conomics =as.data.frame(ggplot2::economics)
cor.test(economics$unemploy,economics$pce)














