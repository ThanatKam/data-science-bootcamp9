##1st thing to do====
getwd()
setwd("C:/Users/thana/Desktop/DataRockie/Bootcamp/sprint/Sprint06_STAT101  Intro to Statistics")

##logistic regression====

happiness <- c(10,8,9,7,8,5,9,6,8,7,1,1,3,1,4,5,6,3,2,0)
divorce <- c(0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1)
df <- data.frame(happiness, divorce)

#binary classification (set family = "binomial")
model <- glm(divorce ~ happiness, data = df, family = "binomial")
model

#อยากรู้ว่าตัวแปร happiness ส่งผลต่อ divorce มั้ย ?
#(is happiness significant?)
summary(model)
#สังเกตได้ p = 0.0705 คือมั่นใจที่ระดับ 90% (ไม่ถึง 95%)

##predict and evaluate model====

#หาความน่าจะเป็น (เทียบใน gg sheet คือการใส่ sigmoid fn)
df$prob_divorce <- predict(model, type  = "response") #type  = "response" คือได้ผลเป็นความน่าจะเป็น [0,1]

#ใส่ผลลัพธ์ของความน่าจะเป็น ; prob > 50% ถือว่าหย่า (1)
df$predict_divorce <- ifelse(df$prob_divorce>=0.5, 1, 0)
df

##confusion matrix====
table(df$predict_divorce, df$divorce) #table(x,y)
conf_mtx <- table(df$predict_divorce, df$divorce, dnn = c("predicted", "actual")) #ตั้งชื่อได้ dnn = c(ชื่อแกน x, ชื่อแกน y)

##model evaluation====
paste("Accuracy :",(conf_mtx[1,1] + conf_mtx[2,2])/(sum(conf_mtx))) #(yes&yes + no&no)/sum(conf_mtx)
paste("Precision :",(conf_mtx[2,2])/(conf_mtx[2,1] + conf_mtx[2,2])) #(yes&yes)/total yes of predict
paste("Recall :",(conf_mtx[2,2]/(conf_mtx[1,2] + conf_mtx[2,2]))) #(yes&yes)/total yes of actual
paste("Accuracy :",(conf_mtx[1,1] + conf_mtx[2,2])/(sum(conf_mtx)))
paste("F1 score :",2 * (0.9 * 0.9)/(0.9 + 0.9))

##example titanic====
library(titanic)
head(titanic_train)

#ลบข้อมูล N/A
titanic_train <- na.omit(titanic_train)

#split data
set.seed(12)
n <- nrow(titanic_train)
id <- sample(1:n, size = 0.7*n)
TT_train_data <- titanic_train[id,]
TT_test_data <- titanic_train[-id,]

#train model
TT_model <- glm(Survived ~ Pclass, data = TT_train_data, family = "binomial")
TT_train_data$Prob <- predict(TT_model, type = "response")
TT_train_data$Predict <- ifelse(TT_train_data$Prob>=0.5,1,0)
head(TT_train_data)

#evaluate train model
TT_train_mtx <- table(TT_train_data$Survived, TT_train_data$Predict, dnn = c("actual", "predicted"))
TT_train_mtx

paste("Accuracy :",(TT_train_mtx[1,1] + TT_train_mtx[2,2])/(sum(TT_train_mtx))) #(yes&yes + no&no)/sum(conf_mtx)
paste("Precision :",(TT_train_mtx[2,2])/(TT_train_mtx[1,2] + TT_train_mtx[2,2])) #(yes&yes)/total yes of predict
paste("Recall :",(TT_train_mtx[2,2]/(TT_train_mtx[2,1] + TT_train_mtx[2,2]))) #(yes&yes)/total yes of actual
paste("F1 score :",2 * (0.32 * 0.062)/(0.62 + 0.062))

#test model
TT_test_data$Prob <- predict(TT_model, newdata = TT_test_data, type = "response")
TT_test_data$Predict <- ifelse(TT_test_data$Prob >= 0.5,1,0)
head(TT_test_data)

#evaluate test model
TT_test_mtx <- table(TT_test_data$Survived, TT_test_data$Predict, dnn = c("actual", "predicted"))
TT_test_mtx

paste("Accuracy :",(TT_test_mtx[1,1] + TT_test_mtx[2,2])/(sum(TT_test_mtx))) #(yes&yes + no&no)/sum(conf_mtx)
paste("Precision :",(TT_test_mtx[2,2])/(TT_test_mtx[1,2] + TT_test_mtx[2,2])) #(yes&yes)/total yes of predict
paste("Recall :",(TT_test_mtx[2,2]/(TT_test_mtx[2,1] + TT_test_mtx[2,2]))) #(yes&yes)/total yes of actual
paste("F1 score :",2 * (0.78 * 0.09)/(0.78 + 0.09))
