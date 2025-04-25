extends Node2D

@export_category("Editor properties")
@export var editor_active:bool = true;

@export var editor_timeActivated: float = 1.0;
@export var editor_timeDeactivated: float = 1.0;

@onready var collisionObject: Area2D = $Area2D;
@onready var currentState:bool = editor_active;

var transitioning:bool = false;

var objectsInside = [];

var timeCheckpoint;

func _ready() -> void:
	if editor_active == true:
		$AnimatedSprite2D.play("in");
		currentState = true;
	else:
		$AnimatedSprite2D.play("out");
	timeCheckpoint = Time.get_ticks_msec()

func _process(delta: float) -> void:
	if editor_active and currentState: ## Checking to change the state.
		if Time.get_ticks_msec()-timeCheckpoint >= editor_timeActivated*1000:
			editor_active = false;
	elif editor_active and currentState == false: ## If its set to active, but its still inactive
		if $AnimatedSprite2D.animation == "in" and $AnimatedSprite2D.is_playing() == false:
			timeCheckpoint = Time.get_ticks_msec();
			currentState = true;
			killObjectsInside();
		if $AnimatedSprite2D.animation != "in":
			$AnimatedSprite2D.play("in");
	elif editor_active == false and currentState == false: ## Checking to change the state.
		if Time.get_ticks_msec()-timeCheckpoint >= editor_timeDeactivated*1000:
			editor_active = true;
	elif editor_active == false and currentState == true: ## If its set to inactive, but its still active
		if $AnimatedSprite2D.animation == "out" and $AnimatedSprite2D.is_playing() == false:
			timeCheckpoint = Time.get_ticks_msec();
			currentState = false;
		if $AnimatedSprite2D.animation != "out":
			$AnimatedSprite2D.play("out");

func _on_area_2d_body_entered(body: Node2D) -> void:
	if editor_active:
		if body.has_method("die"):
			body.die();
		else:
			print("Object "+body.name+" has no die() function.");
	else:
		objectsInside.push_back(body);
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	var found:int = objectsInside.find(body);
	if found >= 0:
		objectsInside.remove_at(found);

func killObjectsInside() -> void:
	var eraseCache = [];
	for object in objectsInside:
		if is_instance_valid(object) != null:
			if object.has_method("die"):
				object.die();
			else:
				print("Object "+object.name+" has no die() function.");
		else:
			eraseCache.push_back(object);
	for erase in eraseCache:
		objectsInside.erase(erase);
