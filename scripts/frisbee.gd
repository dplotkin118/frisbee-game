extends Area2D

var t = 0.0

var linear_velocity: Vector2
var angular_velocity: float = 1
@export var air_resistance: float
@export var invert_factor: float
@export var initial_speed: float
var initial_direction: Vector2

var can_fly: bool = false
var thrown: bool = false

@export var arrow: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial_direction = Vector2(0, -1)
	linear_velocity = initial_direction * initial_speed
	var characters = $"../Characters".get_children()
	for character in characters:
		character.throw.connect(_on_character_throw)
	
func rotate_vector(vector: Vector2, angle: float) -> Vector2:
	var temp_vector: Vector2 = vector
	var x_rotated: float = temp_vector.x * cos(angle) - temp_vector.y * sin(angle)
	var y_rotated: float = temp_vector.x * sin(angle) + temp_vector.y * cos(angle)
	var return_vector: Vector2 = Vector2(x_rotated, y_rotated)
	return return_vector
	
func fly(delta: float) -> void:
	#linear motion
	position.x += linear_velocity.x * delta
	position.y += linear_velocity.y * delta
	
	#angular motion
	#linear_velocity = rotate_vector(linear_velocity, angular_velocity * delta)
	angular_velocity -= air_resistance * angular_velocity * delta
	if invert_factor <= 0:
		rotation -= angular_velocity/10
	elif invert_factor > 0:
		rotation += angular_velocity/10
	
	if invert_factor != 0:
		linear_velocity = rotate_vector(linear_velocity, invert_factor * 10 * (PI/180))
		
	linear_velocity.x -= air_resistance * linear_velocity.x * delta
	linear_velocity.y -= air_resistance * linear_velocity.y * delta
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if thrown and !can_fly:
		initial_direction = rotate_vector(initial_direction, rotation)
		linear_velocity = initial_direction * initial_speed
		can_fly = true
	if can_fly:	
		fly(delta)
		arrow.visible = false
	else:
		arrow.visible = true

	if initial_speed <= 50:
		initial_speed = 50

# make frisbee stop if it has reached x point on its arc (height factor?)

func rotate_frisbee(direction: float) -> void:
	rotation += .1 * direction
	
func invert_frisbee(direction: float) -> void:
	invert_factor += .001 * direction
	
func change_power(direction: float) -> void:
	initial_speed += 10 * direction

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		can_fly = false
		linear_velocity = Vector2.ZERO
		rotation = 0
		position = Vector2(body.position.x + 23, body.position.y)
		body.is_handler = true
		thrown = false


func _on_character_throw() -> void:
	thrown = true
