extends Node2D

@export var active:bool = true;

@export var timeActivated: float = 1.0;
@export var timeDeactivated: float = 1.0;

@onready var collisionObject: Area2D = $Area2D;
@onready var currentState:bool = active;

var transitioning:bool = false;

var objectsInside = [];

func _on_area_2d_area_entered(area: Area2D) -> void:
	objectsInside.push_back(area);
	
func _on_area_2d_area_exited(area: Area2D) -> void:
	var found:int = objectsInside.find(area);
	if found >= 0

func _process(delta: float) -> void:
	if active != currentState:
		pass
