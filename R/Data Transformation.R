getwd()
setwd("C:/Users/thana/Desktop/DataRockie/Bootcamp/live/Live07_Data Transformation")
library(tidyverse)
library(glue)
library(lubridate)

##glue====
my_name <- "Book"
my_age <- 22
glue("Hi! my name is {my_name}. I am {my_age} years old")
#compare with paste function
paste("Hi! my name is",my_name,". I am ",my_age,"years old") #paste จะยุ่งยากกว่าเรื่อง comma

view(mtcars)
rownames(mtcars)
colnames(mtcars)
#สังเกต รุ่นรถไม่ได้อยู่ในตาราง แต่เป็น ชื่อแถว
#add new col -> model ใส่ชื่อรุ่นของรถ
rownames_to_column(mtcars, "model")
View(mtcars) #ยังไม่เห็น col model ที่สร้างใหม่ (อย่าลืม assign ค่ากลับใน mtcars ด้วย)
mtcars <- rownames_to_column(mtcars, "model")

##select====
select(mtcars,1:3)
select(mtcars,1,2,3)
select(mtcars,model,mpg,cyl) #ใส่ตำแหน่ง หรือ ชื่อ ก็ได้
select(mtcars,1,2,cyl)
select(mtcars, starts_with("a")) #ดึงคอลัมที่ชื่อขึ้นต้นด้วย a (สังเกตจะใช้ a,A ก็ได้)
select(mtcars, ends_with("p")) #ดึงคอลัมที่ลงท้ายด้วย p
select(mtcars,contains("a")) #ดึงคอลัมที่ประกอบด้วย a
select(mtcars, mile_per_gallon = mpg) #สามารถเปลี่ยนชื่อ col ได้
##pipeline ====
mtcars %>%
  select(1,2,3)

##filter====
filter(mtcars,hp > 200 & mpg >= 15) #and
filter(mtcars,hp > 200 | mpg >= 15) #or

mtcars %>% 
  select(model, am) %>%
  filter(am == 0)

mtcars %>%
  select(model,hp,mpg) %>%
  filter(hp > 200 | mpg >= 15) %>%
  head(3)

#version no pipeline
head(filter(select(mtcars,model, hp, mpg),hp > 200 | mpg >= 15),3) #ใช้ pipe line แล้วอ่านง่ายขึ้นเยอะ

grepl("^M",mtcars$model) #ดึง model ที่ขึ้นต้นด้วย M จาก mtcars output True False
grep("^M",mtcars$model) #output เป็นตำแหน่ง
grep("^M",mtcars$model, value =T) #output เป็น ชื่อ model

mtcars %>%
  select(model,hp,mpg) %>%
  filter(grepl("^M",mtcars$model))

mtcars %>%
  select(model,hp,mpg) %>%
  filter(hp > 150 & hp < 200)

mtcars %>%
  select(model,hp,mpg) %>%
  filter(between(hp,150,200))

##arrange====
mtcars %>%
  select(model,hp,) %>%
  arrange(hp) %>%
  head(10)

mtcars %>%
  select(model,hp) %>%
  arrange(desc(hp)) %>%
  head(10) #desc เรียงมากไปน้อย

m1 <- mtcars %>%
  select(model,am,hp) %>%
  arrange(am,hp) #sort am then sort hp

##write csv file====
write_csv(m1,"m3.csv")

##mutate -> create new col (จะเพิ่มที่ขวาสุด)
mtcars %>%
  select(model, mpg, am) %>%
  filter(mpg > 20) %>%
  mutate(model_upper = toupper(model),
         mpg_double = mpg*2,
         mpg_hahaha = mpg_double + 10, 
         book = "Thanat",
         am = if_else(am == 0,"auto", "manual"))
#R สามารถนำ col ที่เพิ่งสร้างมาปรับต่อได้เลย
#R สามารถใส่เงื่อนไขใน col mutate ได้
#R สามารถ mutate ทับ col เดิมได้ *ต้อง select col นั้นด้วย

##group by + summarise
mtcars %>%
  select(model,am,mpg) %>%
  mutate(am = if_else(am == 0,"auto","manual")) %>%
  group_by(am) %>%
  summarise(n = n(),
             mean_mpg = mean(mpg),
             sd_mpg = sd(mpg),
             min_mpg = min(mpg),
             max_mpg = max(mpg))
#group by ต้อง run ก่อน summarise

##join table====
band_members
band_instruments
left_join(band_members, band_instruments, by = "name")
inner_join(band_members, band_instruments, by = "name")
full_join(band_members, band_instruments, by = "name")

#ถ้าชื่อคอลัมของ table 1,2 ไม่ตรงกัน ก็ join ได้

band_members %>%
  select(member_name = name) %>%
  left_join(band_instruments,
            by = c("member_name" = "name"))

band_members %>%
  select(member_name = name) %>%
  left_join(band_instruments,
            by = c("name" = "member_name")) 
#error เพราะ  band_members อยู่ซ้าย ดังนั้นต้องเขียน  by = c("member_name" = "name")

##sample====
a <- mtcars %>%
  sample_n(2) %>%
  select(model)
a
class(a) #data.frame

b <- mtcars %>%
  sample_n(2) %>%
  pull(model)
b
class(b) #ได้เป็น vector that contain chr

mtcars %>%
  sample_frac(0.2) %>%
  summarise(avg_hp = mean(hp))
##sample_frac(0.2) คือ สุ่มตัวอย่างมา 20%

##count
mtcars <- mtcars %>%
  mutate(am = if_else(am == 0,"auto","manual"))

mtcars %>%
  group_by(am) %>%
  summarise(n=n())

#ลองใช้ function count

mtcars %>%
  count(am)

mtcars %>%
  count(am) %>%
  mutate(pct = n/sum(n)) #pct = percentage

mtcars %>%
  count(am, cyl) #count แยก 2 ตัวแปรก็ได้

##chinook====
library(RSQLite)

#connect to sqlite.db file
con <- dbConnect(SQLite(),"chinook.db")

#list tables
dbListTables(con)

#list fields(Column)
dbListFields(con, "customers")

#get data from database tables
m1 <- dbGetQuery(con, "select firstname,country, email from customers where country = 'USA'")
View(m1)

#create dataframe
products <- tribble(
  ~id, ~product_name,
  1, "chocolate",
  2, "apple",
  3, "iphone"
)

#write table to database
dbWriteTable(con, "products_write_to_db",products)

dbListTables(con) #สังเกตจะมี table products_write_to_db เพิ่มมาใหม่

dbRemoveTable(con, "products_write_to_db")

dbListTables(con) #สังเกตจะไม่มี table products_write_to_db 

#close connection
dbDisconnect(con)
