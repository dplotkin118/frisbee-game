extends Node2D

@onready var players: Array[Node]
@onready var starting_locations: Array[Node] = $"../Starting Locations".get_children()
@onready var frisbee: Node2D = $"../Frisbee"
var handler_location: Vector2
@onready var initial_positions: Array = get_player_positions() 
var start: bool = false

@onready var character_scene = preload("res://scenes/character.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(4):
		var char = character_scene.instantiate()
		add_child(char)
	players = get_children()
	initialize_player_locations()
	for player in players:
		if player.is_handler:
			frisbee.set_relative_position(player)

func _init() -> void:
	pass
	
func initialize_player_locations() -> void:
	for i in range(players.size()):
		players[i].global_position = starting_locations[i].global_position
		if i == 3:
			players[i].is_handler = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#	if !start:
#		initialize_player_locations()
#		start = !start
		
	if !is_player_cutting():
		get_cutter()

# get all offensive players from scene tree
# the one who is furthest up and not a handler makes a cut

func get_cutter() -> void:
	var player_locations: Array = []
	for player in players:
		if player.is_handler:
			handler_location = player.global_position
		else:
			player_locations.append([player, player.global_position])
	
	var max_dist: float = 0
	var cutter: Node
	for i in player_locations:
		var curr_dist = i[1].x - handler_location.x
		if abs(curr_dist) > max_dist:
			max_dist = curr_dist
			cutter = i[0]

	init_cutter(cutter)
# can have multiple cutters at once rn
func init_cutter(cutter: Node) -> void:
	cutter.is_cutter = true
	cutter.starting_position = cutter.global_position
	
func is_player_cutting() -> bool:
	var cutter: bool = false
	for player in players:
		if player.is_cutter:
			cutter = true
	return cutter
		
	
func get_player_positions() -> Array:
	var player_locations: Array = []
	for player in players:
		if player.is_handler:
			handler_location = player.global_position
		else:
			player_locations.append([player, player.global_position])
	
	return player_locations

func reset_players() -> void:
	var i: int = 0
	for player in initial_positions:
		player[0].global_position = player[1]
