extends RigidBody2D

var ALLOW_SHOOT:bool = true;
var CAN_SHOOT:bool = false;

func _ready() -> void:
	apply_impulse(Vector2(100,100),Vector2(0,0));
	
func _physics_process(delta: float) -> void:
	pass
