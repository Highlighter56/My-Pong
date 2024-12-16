extends Node

@onready var scoreboard = %Scoreboard
@onready var center_line = %"Center Line"
@onready var ui = %UI
@onready var ball = %Ball

signal startGame

var winningScore = 5
var notPlaying = true
var hasPlayed = false

func _ready():
	ui.visible = true

func _process(delta):
	#To Quit
	if(Input.is_action_just_pressed("quit")):
		get_tree().quit()
	# Checks if there is a game going on
	if(notPlaying):
		# Start Game
		if(Input.is_action_just_pressed("start_game")):
# For after the game is played, this will reset the game if the player chooses
			if(hasPlayed):
				get_tree().reload_current_scene()
# For when the game hasnt yet been played, this will start it
			else:
				notPlaying = false
				startGame.emit()
				ui.visible = false
				center_line.visible = true
	





