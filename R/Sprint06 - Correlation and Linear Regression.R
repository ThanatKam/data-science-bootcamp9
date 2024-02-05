##1st thing to do====
getwd()
setwd("C:/Users/thana/Desktop/DataRockie/Bootcamp/sprint/Sprint06_STAT101  Intro to Statistics")

##correlation====

#pearson numerical (contineus) 2 column
#spearman for ordinal column
#kendall for non parametric

cor(mtcars$mpg, mtcars$hp) #บอกค่า correlation
cor.test(mtcars$mpg, mtcars$hp) #บอกค่า correlation และ p-value
cor.test(mtcars$mpg, mtcars$am)

mtcars[,c("mpg","wt","hp")]

cor(mtcars[,c("mpg","wt","hp")])


#ลองใช้ tidyverse
library(dplyr)
mtcars %>%
  select(mpg, wt, hp) %>%
  cor()

#plot(x,y) #pch = 16 คือเลือกรูปแบบการพลอต (วงกลมทึบ, โปร่ง, ...)
plot(mtcars$hp, mtcars$mpg, pch = 16)

##linear regression====
# mpg = fn(hp) เขียนได้ว่า mpg ~ hp
lmfit <- lm(mpg ~ hp, data = mtcars)

summary(lmfit)

#สมมติอยากทำนาย รถที่มี hp = 200
lmfit$coefficients
lmfit$coefficients[1] + lmfit$coefficients[2]*200

#ต้องใช้ double [[]] จะได้ผลลัพที่สวยขึ้น
lmfit$coefficients[[1]] + lmfit$coefficients[[2]]*200

##predicts====
new_cars <- data.frame(
  hp = c(250,320,400,410,450)
)

new_cars$hp_predict <- predict(lmfit, newdata = new_cars) 
#เอา hp ใน new_cars มาใส่ใน lmfit เพื่อ predict mpg และเซฟเป็นคอลัมใหม่ (hp_predict) ใน new_cars
new_cars

#เผลอตั้งชื่อผิด ต้องตั้งชื่อว่า mpg_predict
new_cars$mpg_predict <- predict(lmfit, newdata = new_cars)
                                
#ลบข้อมูลใน  hp_predict
new_cars$hp_predict <- NULL
new_cars

#mpg_predict มีค่าติดลบเฉย...
summary(mtcars$hp)
#จะเห็นได้ว่าข้อมูลที่เทรน max 335 แต่ข้อมูลใหม่ใน new_cars มีค่าสูงสุด 450 
#ซึ่งเกินขอบเขตข้อมูลเดิมที่โมเดลมีไปค่อนข้างเยอะ (ไม่ควรเกินข้อมูลเดิม > 10%)

##Multiple Linear Regression====
# mpg = fn(hp, wt, am)
# mpg = intercept + b0*hp + b1*wt + b2*am

lmfit2 <- lm(mpg ~ hp + wt + am, data = mtcars)
lmfit2

#สมมติอยากทำนาย รถที่มี hp = 200, wt = 3.5, am = 1
lmfit2$coefficients
lmfit2$coefficients[[1]] + lmfit2$coefficients[[2]]*200 + lmfit2$coefficients[[3]]*3.5 + lmfit2$coefficients[[4]]*1

lmfit3 <- lm(mpg ~ ., data = mtcars) #. แทนทุกตัวแปรเลย
lmfit3

lmfit4 <- lm(mpg ~ .-gear, data = mtcars) #.-gear คือเอาทุกตัวแปรยุกเว้น gear
lmfit4


##Root Mean Square Error====
#Train RMSE
lmfit3 <- lm(mpg ~ ., data = mtcars) #. แทนทุกตัวแปรเลย
mtcars$predicted <- predict(lmfit3)
squared_error <- (mtcars$mpg - mtcars$predicted)**2
rmse <- sqrt(mean(squared_error))
rmse

##split data====
sample(1:10, size = 3)

n <- nrow(mtcars)
set.seed(12) #เพื่อให้การสุ่มเหมือนเดิมทุกครั้ง
id <- sample(1:n, size = 0.8*n)
train_data <- mtcars[id,] #กำหนดให้ train_data คือ mtcars แถวที่ id
test_data <- mtcars[-id,]

##train model====
model1 <- lm(mpg ~ hp + wt,data = train_data)
model1

predict_train <- predict(model1)
predict_train

rmse_train <- sqrt(mean((train_data$mpg - predict_train)**2))
rmse_train

##test model====
predict_test <- predict(model1, newdata = test_data) 
#ใช้ model1 มาเทส เพราะต้องใช้โมเดลเดิม มาทดลองกับ unseen data
predict_test

rmse_test <- sqrt(mean((test_data$mpg - predict_test)**2))
rmse_test

##print result
paste("RMSE_Train :",rmse_train)
paste("RMSE_Test :",rmse_test)


paste("RMSE_Train :",rmse_train,"RMSE_Test :",rmse_test)

#RMSE ยิ่งน้อยคือยิ่งดี

##Logistic Regression====
library(dplyr)

mtcars %>%
  head()

#จะใช้ logistic reg ข้อมูลต้องเป็น factor
str(mtcars)
#convert am to factor
mtcars$am <- factor(mtcars$am, levels = c(0,1), labels = c("Auto","Manual"))
class(mtcars$am)
table(mtcars$am)

##split data====
n <- nrow(mtcars)
set.seed(12) #เพื่อให้การสุ่มเหมือนเดิมทุกครั้ง
id <- sample(1:n, size = 0.8*n)
logit_train_data <- mtcars[id,] #กำหนดให้ train_data คือ mtcars แถวที่ id
logit_test_data <- mtcars[-id,]

##logit train model====
logit_model <- glm(am ~ mpg, data = logit_train_data, family = "binomial")
logit_model

predict_logit_train <- predict(logit_model, type = "response")
#type = "response" จะทำให้ข้อมูลเป็น probability คืออยู่ในช่วง [0,1]
predict_logit_train

logit_train_data$pred <- if_else(predict_logit_train >= 0.5, "Manual", "Auto")
logit_train_data
logit_train_data$am #ของเดิม
logit_train_data$pred #ของใหม่

logit_train_data$am == logit_train_data$pred
mean(logit_train_data$am == logit_train_data$pred)


##logit test model====
predict_logit_test <- predict(logit_model, newdata = logit_test_data, type = "response")
#type = "response" จะทำให้ข้อมูลเป็น probability คืออยู่ในช่วง [0,1]
predict_logit_test

logit_test_data$pred <- if_else(predict_logit_test >= 0.5, "Manual", "Auto")


logit_test_data$am == logit_test_data$pred
mean(logit_test_data$am == logit_test_data$pred)
