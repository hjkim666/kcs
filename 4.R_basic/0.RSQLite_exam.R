##############################################################
# SQLite DB 연동하기 
# 
# https://www.datacamp.com/community/tutorials/sqlite-in-r
##############################################################
library(RSQLite)
data("mtcars")
mtcars$car_names <- rownames(mtcars)
rownames(mtcars) <- c()
head(mtcars)

##############################################################
# DB생성 
##############################################################
conn <- dbConnect(RSQLite::SQLite(), "CarsDB.db")

# 새테이블 만들기(car_data) / 데이터 입력   
dbWriteTable(conn, "cars_data", mtcars)
dbListTables(conn)

# 새테이블 만들기(Cars_and_Makes)/ 데이터 입력 
car <- c('Camaro', 'California', 'Mustang', 'Explorer')
make <- c('Chevrolet','Ferrari','Ford','Ford')
df1 <- data.frame(car,make)
car <- c('Corolla', 'Lancer', 'Sportage', 'XE')
make <- c('Toyota','Mitsubishi','Kia','Jaguar')
df2 <- data.frame(car,make)
dfList <- list(df1,df2)
for(k in 1:length(dfList)){
  dbWriteTable(conn,"Cars_and_Makes", dfList[[k]], append = TRUE)
}
dbListTables(conn)
###############################################################
# SELECT - 데이터 조회 
###############################################################
dbGetQuery(conn, "SELECT * FROM Cars_and_Makes")

dbGetQuery(conn, "SELECT * FROM cars_data LIMIT 10")

dbGetQuery(conn,"SELECT car_names, hp, cyl FROM cars_data
                 WHERE cyl = 8")

dbGetQuery(conn,"SELECT car_names, hp, cyl FROM cars_data
                 WHERE car_names LIKE 'M%' AND cyl IN (6,8)")

dbGetQuery(conn,"SELECT cyl, AVG(hp) AS 'average_hp', AVG(mpg) AS 'average_mpg' FROM cars_data
                 GROUP BY cyl
                 ORDER BY average_hp")

avg_HpCyl <- dbGetQuery(conn,"SELECT cyl, AVG(hp) AS 'average_hp'FROM cars_data
                 GROUP BY cyl
                 ORDER BY average_hp")
avg_HpCyl
class(avg_HpCyl)

mpg <-  18
cyl <- 6
Result <- dbGetQuery(conn, 'SELECT car_names, mpg, cyl FROM cars_data WHERE mpg >= ? AND cyl >= ?', params = c(mpg,cyl))
Result

###############################################################
# 파이썬으로 작업하면서 만들었던 데이터 베이스와 연동 
###############################################################
conn2 <- dbConnect(RSQLite::SQLite(), "C:/py_workspace/2.sql_summary/test2.db")
dbListTables(conn2)
