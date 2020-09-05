############################################################
#   Text mining & Word Cloud
############################################################

# java, rJava 설치 
#install.packages("multilinguer")
#library(multilinguer)
#install_jdk()
Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_171")

#자바와 연동하기 위한 패키지 설치
install.packages("rJava")
install.packages("memoise")  #Cache
install.packages("KoNLP")
install.packages("dplyr")
#install.packages("bitops")

# 의존성 패키지 설치
install.packages(c("hash", "tau", "Sejong", "RSQLite", "devtools", "bit", "rex", "lazyeval", "htmlwidgets", "crosstalk", "promises", "later", "sessioninfo", "xopen", "bit64", "blob", "DBI", "memoise", "plogr", "covr", "DT", "rcmdcheck", "rversions"), type = "binary")
# github 버전 설치
install.packages("remotes")
# 64bit 에서만 동작합니다.
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

library(rJava)
library(KoNLP)
library(dplyr)

#사전 설정하기
useNIADic()

#data load
txt <- readLines("D:/r_workspace/kcs/data/song.txt")
head(txt)

#특수문자 제거
install.packages("stringr")
library(stringr)

txt <- str_replace_all(txt, "\\W", " ")

#가사에서 명사 추출하기
nouns <- extractNoun(txt)
nouns

?unlist
#추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))
wordcount

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
str(df_word)

#변수명 수정
df_word <- rename(df_word, word=Var1, freq=Freq)

#자주 사용된 단어 빈도표 만들기 : nchar(글자수 리턴)
df_word <- filter(df_word, nchar(word) >=2)

#top 20 조회
top_20 <- df_word %>% arrange(desc(freq)) %>% head(20)
top_20

# 워드 클라우드 만들기
install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)

# 색상목록에서 8개 색상 추출
pal <- brewer.pal(8, "Dark2")

#난수 고정을 통한 워드 클라우드 모양 고정
set.seed(1234)
?wordcloud
#워드 클라우드 만들기
wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(4,0.3),
          colors = pal
          )





