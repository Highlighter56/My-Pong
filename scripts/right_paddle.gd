extends AnimatableBody2D

@onready var top_ray = $TopRay
@onready var bottom_ray = $BottomRay

@export var speed = 300
var direction = 0

func _ready():
	pass

func _physics_process(delta):
# Sets Direction based on input
	if(Input.is_action_just_pressed("right_up")):
		direction = -1
	if(Input.is_action_just_pressed("right_down")):
		direction = 1
# If traveling in direction of collision stop
	if(top_ray.is_colliding() && direction==-1):
			direction = 0
	if(bottom_ray.is_colliding() && direction==1):
			direction = 0
	
	#print("Top: "+str(top_ray.is_colliding())+" Bottom: "+str(bottom_ray.is_colliding()))
	#print(str(top_ray.is_colliding())+" "+str(direction))
# Move
	position.y += direction * speed * delta

func resetPoint():
	position.y=0
	#print("Right Paddle Reset")	
