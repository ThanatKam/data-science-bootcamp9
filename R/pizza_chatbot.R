tn_pizza <- function(){
pizza_menu <- data.frame(
    pizza_ID = c(1:3),
    name = c("Meat", "BBQ", "Sea food"),
    price = c(200,250,300)
)
crust_menu <- data.frame(
    crust_ID = c(1:3),
    name = c("Normal", "Cheese", "Sausage"),
    price = c(0,50,100)
)
size_menu <- data.frame(
    size_ID = c(1:3),
    name = c("Medium", "Large", "Extra Large"),
    price = c(0,100,200)
)

greeting <- function(){
    name <- readline("Hello !! what is your name 😉 :")
    print(paste("Hello 😉!!",name,"Welcome to my TN Pizza shop 🍕"))
}
greeting()
print("Let's design your pizza!!🍕😜")
readline("press enter to continue")

more_order <- function(){
    question <- readline("Would you like to order any thing else (Yes/ No) :")
}

answer <- "Y"
bill <- 0
total_bill <- 0

while(answer == "Y"){
#step 1 choose your pizza

print("step 1 choose your pizza🍕")
print(pizza_menu)
flush.console()
pizza <- readline("select your 'pizza_ID' 🍕:")
if (pizza == 1 | pizza == 2 | pizza == 3){
    TRUE
} else{
    print("wrong syntax pls try again😵")
    pizza <- "wrong syntax pls try again😵"
}
flush.console()
while (pizza == "wrong syntax pls try again😵"){
    pizza <- readline("select your 'pizza_ID' 🍕:")
    if (pizza == 1 | pizza == 2 | pizza == 3){
        TRUE
} else{
    print("wrong syntax pls try again😵")
    pizza <- "wrong syntax pls try again😵"
    flush.console()
}
}
print("wow !!  good choice😉")
flush.console()
readline("press enter to continue")

#step 2 choose your crust

print("step 2 choose your crust🧀")
print(crust_menu)
flush.console()
crust <- readline("select your 'crust_ID' 🧀:")
if (crust == 1 | crust == 2 | crust == 3){
    TRUE
} else{
    print("wrong syntax pls try again😵")
    crust <- "wrong syntax pls try again😵"
}
flush.console()
while (crust == "wrong syntax pls try again😵"){
    crust <- readline("select your 'crust_ID' 🧀:")
    if (crust == 1 | crust == 2 | crust == 3){
    TRUE
} else{
    print("wrong syntax pls try again😵")
    crust <- "wrong syntax pls try again😵"
    flush.console()
}
}
print("wow !!  good choice😉")
flush.console()
readline("press enter to continue")

#step 3 choose your size

print("step 3 choose your size ✨")
print(size_menu)
flush.console()
size <- readline("select your 'size_ID' ✨:")

if (size == 1 | size == 2 | size == 3){
    TRUE
} else{
    print("wrong syntax pls try again😵")
    size <- "wrong syntax pls try again😵"
}
flush.console()
while (size == "wrong syntax pls try again😵"){
    size <- readline("select your 'size_ID' ✨:")
    if (size == 1 | size == 2 | size == 3){
    TRUE
} else{
    print("wrong syntax pls try again😵")
    size <- "wrong syntax pls try again😵"
    flush.console()
}
}
print("wow !!  good choice😉")
flush.console()
readline("press enter to continue")


print("Good Job !! ✨")
print(paste("Your order is",pizza_menu[pizza,2],"pizza which",crust_menu[crust,2],"crust","and your size is",size_menu[size,2]))
bill <- pizza_menu[pizza,3] + crust_menu[crust,3] + size_menu[size,3]
print(paste("Pizza =",pizza_menu[pizza,3],"THB Crust =",crust_menu[crust,3],"THB Size =",size_menu[size,3],"THB"))
print(paste("This bill =",bill,"THB💸"))
flush.console()

answer <- substr(toupper(more_order()),1,1)

if(answer == "Y" | answer == "N"){
    TRUE
} else{
    print("wrong syntax pls try again😵")
    answer <- "wrong syntax pls try again😵"
}
flush.console()
while (answer == "wrong syntax pls try again😵"){
    answer <- substr(toupper(more_order()),1,1)
    if(answer == "Y" | answer == "N"){
    TRUE
} else{
    print("wrong syntax pls try again😵")
    answer <- "wrong syntax pls try again😵"
}
 flush.console()
}
total_bill <- total_bill + bill
}

print("thank you for your order🥰🥰")
print(paste("Total bill :",total_bill,"THB"))
}
tn_pizza()
