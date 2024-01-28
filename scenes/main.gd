extends Node2D

var original_position: Vector2
@onready var frisbee = $Frisbee
@onready var offensive_players = $OffensivePlayers
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_position = frisbee.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("position"):
		frisbee.global_position = original_position
		frisbee.reset_defaults()
		offensive_players.reset_players()

