rps <- function(){
    greeting <- function(){
    username <- readline("Hi Player! What is your name :")
    print(paste("Hi !",username,"🎉Welcome to my Rock Paper Scissors Game😜"))
    print("press R for (R)ock✊🏻")
    print("press P for (P)aper🖐🏻")
    print("press S for (S)cissors✌🏻")
}
greeting()

player_decision <- function() {
    player_choice <- readline("What is your decision (R)ock✊🏻/ (P)aper🖐🏻/ (S)cissors✌🏻 :")
    paste(player_choice)
}

flush.console() #ทำให้โค้ดเกิดการแสดงผลทันที

choice <- c("R", "P", "S")

com_decision <- function() {
    com_choice <- sample(choice, 1)
}

want_to_play <- function() {
    play_again_decision <- readline("Do you want to play again ? (Y)es/ (N)o :")
    paste(play_again_decision)
}

play_again <- "Y"
player_score <- 0
com_score <- 0
Round <- 0
draw <- 0

while (play_again == "Y") {

    Round <- Round + 1
    print(paste("Round :",Round,"!"))

    player_hand <- substr(toupper(player_decision()),1,1)

    com_hand <- com_decision()


    if (player_hand == "R" & com_hand == "S"){
    player_score = player_score + 1
    print("Player hand 😊: Rock✊🏻")
    print("COM hand 🤖: Scissors✌🏻")
    print("Player wins !!😋")
} else if (player_hand == "R" & com_hand == "P"){
    com_score = com_score + 1
    print("Player hand 😊: Rock✊🏻")
    print("COM hand 🤖: Paper🖐🏻")
    print("Com wins !! 😥")
} else if (player_hand == "P" & com_hand == "R"){
    player_score = player_score + 1
    print("Player hand 😊: Paper🖐🏻")
    print("COM hand 🤖: Rock✊🏻")
    print("Player wins !!😋")
} else if (player_hand == "P" & com_hand == "S"){
    com_score = com_score + 1
    print("Player hand 😊: Paper🖐🏻")
    print("COM hand 🤖: Scissors✌🏻")
    print("Com wins !! 😥")
} else if (player_hand == "S" & com_hand == "P"){
    player_score = player_score + 1
    print("Player hand 😊: Scissors✌🏻")
    print("COM hand 🤖: Paper🖐🏻")
    print("Player wins !!😋")
} else if (player_hand == "S" & com_hand == "R"){
    com_score = com_score + 1
    print("Player hand 😊: Scissors✌🏻")
    print("COM hand 🤖: Rock✊🏻")
    print("Com wins !! 😥")
} else if (player_hand == com_hand){
    player_score = player_score + 0
    com_score = com_score + 0
    draw <- draw + 1
    print("It's Draw !! 😐")
} else {
    print("wrong syntax pls try again😵")
}

    print(paste("Player_score ",player_score," : ",com_score,"COM_score"))
    print("----------------------")

    flush.console()
play_again <- substr(toupper(want_to_play()),1,1)

if (play_again == "Y"){
    play_again <- "Y"
} else if (play_again == "N"){
    play_again <- "N"
} else{
    print("wrong syntax pls try again😵")
    play_again <- "wrong syntax pls try again😵"
}
flush.console()
while (play_again == "wrong syntax pls try again😵"){
    play_again <- substr(toupper(want_to_play()),1,1)

    if (play_again == "Y"){
    play_again <- "Y"
} else if (play_again == "N"){
    play_again <- "N"
} else{
    print("wrong syntax pls try again😵")
    play_again <- "wrong syntax pls try again😵"
    flush.console()
}

}

}

print("✨✨✨✨Result !! ✨✨✨✨")
print(paste("Player_score ",player_score," : ",com_score,"COM_score"))
print(paste("WIN",player_score,"times"))
print(paste("LOSE",com_score,"times"))
print(paste("DRAW",draw,"times"))
print(paste("Win Rate",round(player_score/(player_score+com_score+draw),2)*100,"%"))

if (player_score > com_score){
    print("Player wins !!😋")
} else if(player_score == com_score){
    print("It's Draw !! 😐")
} else{
    print("Com wins !! 😥")
}
}
rps()
