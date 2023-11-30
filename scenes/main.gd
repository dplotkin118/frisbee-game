extends Node2D

var original_position: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_position = $Frisbee.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("position"):
		$Frisbee.global_position = original_position

func reset_frisbee() -> void:
	pass
