#############################################################
# correlation 상관분석 
#############################################################
install.packages("corrplot")
library(corrplot)

data(mtcars)
mtcars.cor<-cor(mtcars) 
mtcars.cor
mtcars.cor<-round(mtcars.cor, digits=2)
mtcars.cor

### visualization ###########################################
corrplot(mtcars.cor,method="shade",shade.col=NA,tl.col="black",tl.srt=45,addCoef.col="black")
corrplot(mtcars.cor) 
corrplot(mtcars.cor,method="shade")
corrplot(mtcars.cor,method="shade",shade.col=NA)
corrplot(mtcars.cor,method="shade",shade.col=NA,tl.col="black")
corrplot(mtcars.cor,method="shade",shade.col=NA,tl.col="black",tl.srt=45)
corrplot(mtcars.cor,method="shade",shade.col=NA,tl.col="black",tl.srt=45,addCoef.col="black")

###############################################################
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD",
"#4477AA"))
corrplot(mtcars.cor,method="shade",shade.col=NA,tl.col="black"
         ,tl.srt=45,col=col(200),addCoef.col="black"
         #,addcolorlabel="no"
         ,order="AOE")
