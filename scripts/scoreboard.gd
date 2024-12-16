extends Node2D

@onready var left_score_display = $leftScoreDisplay
@onready var right_score_display = $rightScoreDisplay
@onready var left_paddle = %"Left Paddle"
@onready var right_paddle = %"Right Paddle"
@onready var ball = %Ball
@onready var goal = $"goal!!"
@onready var center_line = %"Center Line"
@onready var team_wins = %teamWins
@onready var win_screen = %"Win Screen"
@onready var game_manager = %GameManager

signal leftWins
signal rightWins

var leftScore = 0
var rightScore = 0
var winningScore = 5

func _ready():
	visible = false
	win_screen.visible = false
	center_line.visible = false
	
func _process(delta):
	pass

func _on_left_goal_area_entered(area):
	print("Left Side")
	rightScore+=1
	#print(rightScore)
	right_score_display.text = str(rightScore)
	goal.play()
	if(rightScore==winningScore):
		endGame("Right")
	else:
		resetPoint()

func _on_right_goal_area_entered(area):
	print("Right Side")
	leftScore+=1
	#print(leftScore)
	left_score_display.text = str(leftScore)
	goal.play()
	if(leftScore==winningScore):
		endGame("Left")
	else:
		resetPoint()

func resetPoint():
	left_paddle.resetPoint()
	right_paddle.resetPoint()
	ball.resetPoint()
	#Engine.time_scale=0

# This function gets called when a team reaches the winning score
# winningTeam:Stirng - this means that the parameter entered must be a string
func endGame(winningTeam:String):
	print("Game Won")
	ball.speed=0
	ball.visible = false
	center_line.visible = false
	team_wins.text = winningTeam+" Wins!!!"
	win_screen.visible = true
	game_manager.notPlaying = true
	game_manager.hasPlayed = true


func _on_game_manager_start_game():
	visible = true
