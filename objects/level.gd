extends Node2D

class_name level

@export_category("LevelProperties")
@export var id:int;
@export var mutiplayer:bool;
@export var walls_layer:TileMapLayer;
@export var goals:Array[hole];
@export var spawns:Array[player_spawn];
@export var mode:int;

func _ready() -> void:
	addPlayer(); ## Later will be managed by a levels manager
	spawnHoles();
	
func player_die(player) -> void:
	player.linear_velocity = Vector2(0,0);
	player.global_transform.origin = player.lastPos;
	
func player_win(player) -> void:
	if spawns.size() > player.currentHole+1:
		player.linear_velocity = Vector2(0,0);
		player.global_transform.origin = spawns[player.currentHole+1].position;
		player.lastPos = spawns[player.currentHole+1].position;
	else:
		player.queue_free();
		print("Level has ended.")

func spawnHoles():
	var num = 0;
	for hole in goals:
		var tempHole = preload("res://objects/ball_hole/ball_hole.tscn").instantiate();
		self.add_child(tempHole);
		tempHole.holeID = num;
		tempHole.position = hole.position;
		num = num + 1;

func loadLevel(path:String):
	pass # to be implemented

func addPlayer():
	if spawns.size() >= 1:
		var tempBall = preload("res://ball/ball.tscn").instantiate();
		self.add_child(tempBall);
		tempBall.position = spawns[0].position;
