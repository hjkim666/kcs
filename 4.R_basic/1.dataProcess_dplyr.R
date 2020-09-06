##################################
# 데이터 가공하기 (dplyr)
##################################
install.packages('readxl')
library(dplyr)
library(readxl)
result <- read_excel("./data/excel_exam.xlsx")
exam <- as.data.frame(result)
exam
exam %>% filter(class==1 & math==50)

exam %>% filter(class==1) %>% filter(math==50)

exam %>% filter(class==1 | class==2)
exam %>% filter(class %in% c(1,3,5))
class1 <- exam %>% filter(class==1)
mean(class1$math)

############################
# practice (filter)
############################
hw1 <- mpg %>% filter(displ <= 4)
hw2 <- mpg %>% filter(displ >= 5)
mean(hw1$hwy) 
mean(hw2$hwy)

c1 <- mpg %>% filter(manufacturer == 'audi')
c2 <- mpg %>% filter(manufacturer == 'hyundai')
mean(c1$cty)
mean(c2$cty)

h3 <- mpg %>% filter(manufacturer %in% c('land rover', 'ford', 'honda'))
mean(h3$hwy)

############################
# select()
############################
exam %>% select(class, english, math)
exam %>% select(-math)
exam %>% filter(class==1) %>% select(english)
exam %>% filter(class==1) %>% select(english) %>% head

############################
# select practice
############################
s <- mpg %>% select(class, cty)
s
suv <- s %>% filter(class=='suv') 
com <- s %>% filter(class =='compact')
mean(suv$cty)
mean(com$cty)

############################
# arrange
############################
exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class, math)

############################
# arrange practice
############################
mpg %>% filter(manufacturer=='audi') %>% arrange(hwy) %>% head(5)
mpg %>% filter(manufacturer=='audi') %>% 
  arrange(desc(hwy)) %>% 
  head(5)



############################
# mutate
############################
exam %>% mutate(total=math+english+science) %>% head
exam %>%
  mutate(total=math+english+science, mean=(math+english+science)/3) %>% 
  head

exam %>% mutate(test=ifelse(science >= 60, 'pass','fail')) %>% head
exam %>% mutate(total = math + english + science) %>% 
  arrange(total) %>% head

############################
# mutate pratice
############################
mpg_new <- mpg
mm <- mpg_new %>% mutate(tot = cty+hwy)

mpg_new %>% mutate(tot = cty+hwy) %>% 
          mutate(mean = (cty+hwy)/2)

mpg_new %>% mutate(tot = cty+hwy, mean = (cty+hwy)/2) %>% 
  arrange(desc(mean)) %>% head(3)





############################
# summarise
############################
exam %>% summarise(mean_math=mean(math))
exam %>% group_by(class) %>% 
  summarise(mean_math=mean(math))

exam %>% group_by(class) %>% 
  summarise(mean_math=mean(math),
            sum_math=sum(math),
            median_math = median(math),
            n=n())

mpg %>%  group_by(manufacturer, drv) %>% 
  summarise(mean_cty=mean(cty)) %>% head(10)

mpg %>% group_by(manufacturer) %>% 
  filter(class=='suv') %>% 
  mutate(tot=(cty+hwy)/2) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)

############################
# summarise practice
############################
mpg <- as.data.frame(ggplot2::mpg)
mpg %>% group_by(class) %>% 
  summarise(mean = mean(cty)) %>% 
  arrange(desc(mean)) %>% 
  head(3)

mpg %>%  
  group_by(manufacturer) %>% 
  summarise(mean_hwy=mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% head(3)

mpg %>% filter(class=='compact') %>%  
  group_by(manufacturer) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n)) %>% head(3)



############################
# 데이터합치기 
############################
#c:CNG, d:disel, e:ethanol, p:premium, r:regular

fuel <- data.frame(fl=c("c", "d", "e", "p", "r")
                   , price_fl=c(2.35, 2.38, 2.11, 2.76, 2.22)
                   )
fuel$fl <- as.character(fuel$fl)
#Mpg 데이터에 가격변수 없음 가격변수 추가 (left_join 이용)
#연료가격이 잘 추가됐는지 확인하기 위해 model, fl, price_fl 변수를 추출해서
#앞 5행만 출력해 보세요
str(fuel)
str(mpg)
all <- left_join(mpg, fuel, by="fl")
head(all,5)

