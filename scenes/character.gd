extends CharacterBody2D

@export var is_handler: bool = false
@onready var frisbee: Area2D = $"../../Frisbee"

var is_on_offense: bool = true
var is_cutter = false
var starting_position: Vector2 = global_position
var cut_number = 0

var speed = 100
signal throw

func _ready() -> void:
	if !is_on_offense:
		$Sprite.modulate = Color(1, 0, 0)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("space") and is_handler:
		is_handler = false
		frisbee.throw_frisbee()
	elif Input.is_action_pressed("left"):
		frisbee.rotate_frisbee(-1)
	elif Input.is_action_pressed("right"):
		frisbee.rotate_frisbee(1)
	elif Input.is_action_pressed("invert_left"):
		frisbee.invert_frisbee(-1)
	elif Input.is_action_pressed("invert_right"):
		frisbee.invert_frisbee(1)
	elif Input.is_action_pressed("ui_up"):
		frisbee.change_power(1)
	elif Input.is_action_pressed("ui_down"):
		frisbee.change_power(-1)
		
	if is_cutter:
		if cut_number == 0:
			cut_number = cut(delta, starting_position, 0)
		elif cut_number == 1:
			cut_number = cut(delta, starting_position, 1)
	
		
	if is_handler:
		starting_position = global_position
		is_cutter = false

#add simple player movement
func cut(delta, starting_position, cut_number) -> int:
	var cut1: Vector2 = Vector2(starting_position.x - 50, starting_position.y - 70)
	var cut2: Vector2 = Vector2(cut1.x + 250, cut1.y - 150)
	if cut_number == 0:
		position = position.move_toward(cut1, delta * speed)
		if abs(cut1.x - position.x) <= 20:
			return 1
		else:
			return 0
	elif cut_number == 1:
		position = position.move_toward(cut2, delta * speed)
		if abs(cut2.x - position.x) <= 20:
			return 2
		else:
			return 1
	else:
		return 2
