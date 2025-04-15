extends RigidBody2D

var ALLOW_SHOOT:bool = true;
var CAN_SHOOT:bool = false;

var shoot_pos_start:Vector2;
var shoot_pos_end:Vector2;
var SHOOTING:bool = false;

var range:int = 50;
@export var forceMultiplayer = 50;

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and get_global_mouse_position().x-self.position.x < range and get_global_mouse_position().x-self.position.x > -range and get_global_mouse_position().y-self.position.y < range and get_global_mouse_position().y-self.position.y > -range and self.linear_velocity < Vector2(1,1):
		shoot_pos_start = get_global_mouse_position();
		print("Starting shooting!")
		SHOOTING = true;
	elif event.is_action_released("shoot") and SHOOTING:
		shoot_pos_end = get_global_mouse_position();
		apply_force((shoot_pos_start-shoot_pos_end)*forceMultiplayer,Vector2(0,0));
		print("Shooting!");
		SHOOTING = false;
		
func _process(delta: float) -> void:
	print(self.linear_velocity);
	queue_redraw()
	
func _draw() -> void:
	if SHOOTING == true:
		draw_line(self.position, get_global_mouse_position(), Color.WHITE, 5.0)
