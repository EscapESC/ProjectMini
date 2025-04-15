extends RigidBody2D

var ALLOW_SHOOT:bool = true;
var CAN_SHOOT:bool = false;

var shoot_pos_start:Vector2;
var shoot_pos_end:Vector2;
var SHOOTING:bool = false;

var range:int = 500;
@export var forceMultiplayer = 5;

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and get_global_mouse_position().x-self.position.x < range and get_global_mouse_position().x-self.position.x > -range and get_global_mouse_position().y-self.position.y < range and get_global_mouse_position().y-self.position.y > -range and self.linear_velocity.x < 1 and linear_velocity.y < 1:
		shoot_pos_start = get_global_mouse_position();
		SHOOTING = true;
	elif event.is_action_released("shoot") and SHOOTING:
		shoot_pos_end = get_global_mouse_position();
		apply_force(Vector2(clamp((shoot_pos_start-shoot_pos_end).x*forceMultiplayer,-10000000,10000000),clamp((shoot_pos_start-shoot_pos_end).y*forceMultiplayer,-100000,100000)),Vector2(0,0));
		SHOOTING = false;
		
func _process(delta: float) -> void:
	queue_redraw()
	
func _draw() -> void:
	if SHOOTING == true:
		draw_line(to_local(self.position), get_local_mouse_position(), Color.WHITE, 5.0)
