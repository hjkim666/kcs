##################################
# Linear Regression 
##################################
attach(faithful)
faithful

#plotting
plot(waiting, eruptions)
abline(lm(eruptions ~ waiting))
 
#model
eruption.lm <- lm(eruptions ~ waiting)
summary(eruption.lm)

par(mfrow=c(2,2))
plot(eruption.lm)

# 추정회귀식
# eruptions = 0.07568*waiting - 1.874016 

newdata <- data.frame(waiting=80)
predict(eruption.lm, newdata, type="response")
predict(eruption.lm, newdata, interval="confidence")
?predict
