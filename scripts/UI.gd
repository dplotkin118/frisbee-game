extends CanvasLayer

@onready var frisbee: Node2D = $"../Frisbee"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Power.text = "Power: " + str(frisbee.initial_speed)
	$Invert.text = "Invert: " + str(frisbee.invert_factor * 100)
