extends Sprite


# Declare member variables here
var CENTER_X = 512
var LEFT_LIMIT = CENTER_X - 300
var RIGHT_LIMIT = CENTER_X + 300

var ACCELERATION = 50
var MAX_SPEED = 10
var FRICTION_COEFF = 0.02
var TURBULENCE_LIMIT = 10
var ATTRACTION_COEFF = 0.00001

var speed = 0

func turbulence():
	var turbulence_acceleration = rand_range(-TURBULENCE_LIMIT,TURBULENCE_LIMIT)
	return turbulence_acceleration
	
func position_displacement(position):
	var displacement_acceleration = 0
	displacement_acceleration -= ATTRACTION_COEFF * (RIGHT_LIMIT - position) * (RIGHT_LIMIT - position)
	displacement_acceleration += ATTRACTION_COEFF * (position - LEFT_LIMIT) * (position - LEFT_LIMIT)
	return displacement_acceleration

#signal ball_hit_edge()

# Called when the node enters the scene tree for the first time.
func _ready():
	var initial_pos = Vector2.ZERO;
	initial_pos.x = CENTER_X
	initial_pos.y = 300
	position = initial_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_acceleration = Input.get_axis("move_left", "move_right")
	var final_acceleration = input_acceleration * ACCELERATION + turbulence() + position_displacement(position.x)
	speed += final_acceleration * delta
	if speed > MAX_SPEED:
		speed = MAX_SPEED
	elif (speed < (0 - MAX_SPEED)):
		speed = (0 - MAX_SPEED)
	var velocity = Vector2.RIGHT * speed
	var pos = position + velocity
	speed *= 1 - FRICTION_COEFF
	if pos.x < LEFT_LIMIT:
#		emit_signal("ball_hit_edge")
		pos.x = LEFT_LIMIT
		velocity = 0
	elif pos.x > RIGHT_LIMIT:
#		emit_signal("ball_hit_edge")
		pos.x = RIGHT_LIMIT
		velocity = 0
	position = pos


