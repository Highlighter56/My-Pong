extends Node2D

@onready var rigid_body_2d = $RigidBody2D
@onready var bum = $Bum

#var direction
var angle
var travel = Vector2()
var speed = 200
var timesHit = 0
# Bounce Buffer - Simulates that the paddle is loacted x units further than it really is. This
# allowed me to keep the current algorithm for ball bounces, but make shrink the angles that the 
# ball bounces off at.
var bounceBuffer = 100


func _ready():
	#travel = initialTravel()
	visible = false

func _physics_process(delta):
# Assignes travel to the new vector that will be added to position
	position+=travel*speed*delta

func initialTravel():
	# Chooses the random direction (left or right) for ball to travel in at start 
	#direction = randi_range(0,1)
	if(randi_range(0,1)==0):
	# Chooses the random angle that the ball will travel in at start (IN RADIANS)
		angle=randf_range(PI*5/6,PI*7/6)
	else:
		angle=randf_range(-PI/6,PI/6)
	
	#angle=PI/6
	return Vector2(cos(angle),sin(angle))
	#print(direction)
	#print(angle)

# Gets called when ball interacts with a collision shape
func _on_area_2d_body_entered(body):
	#print("Current: "+str(position))
	#print("Body: "+str(body.position))
# Increases the Hits / Sets speed of ball
	timesHit+=1
	speed = timesHit*40+480
	print(str(timesHit)+" "+str(speed))
	#print(body)
# Play sound
	bum.play()
# Checks if the objects that the ball collided with is either paddle
	var objectName = body.name
	if(objectName=="Left Paddle" || objectName=="Right Paddle"):
		hits_paddle(body, objectName)
# else -> if the ball hits a wall
	else:
		hits_wall()

func hits_paddle(body, objectName):
	var lORr = 0
# Hit Right or Left Paddle?
	if(objectName=="Right Paddle"):
		lORr = 1
	else:
		lORr=-1
# Creates a new vector to represent the location of the ball
	var temp = body.position
# Applies the bounce buffer
	temp.x+=lORr*bounceBuffer
# Take the vector required to move the paddle to the ball then apply that to the ball
	travel = position - temp
# travel is a vector, look at it as a triangle. Set h = to the hypotenuse of that triangle
	var h = sqrt((pow(travel.x,2)+pow(travel.y,2)))
# By dividing the x and y values of travel by their hypotenuse you normalize the vectors
	travel/=h

func hits_wall():
	travel.y*=-1

func resetPoint():
	position.x=0
	position.y=0
	travel = initialTravel()
	timesHit=0
	speed=200


func _on_game_manager_start_game():
	visible = true
	travel = initialTravel()
