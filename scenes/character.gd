extends CharacterBody2D

@export var is_handler: bool = false
@onready var frisbee: Area2D = $"../../Frisbee"

var is_on_offense: bool = true
signal throw

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("space") and is_handler:
		throw.emit()
		is_handler = false
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

#add frisbee initial position for reset game 
#add simple player movement
