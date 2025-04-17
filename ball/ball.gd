extends RigidBody2D

var ALLOW_SHOOT:bool = true;
var CAN_SHOOT:bool = false;

var shoot_pos_start:Vector2;
var shoot_pos_end:Vector2;
var SHOOTING:bool = false;

var maxShootingStrengthPx:int = 500;

var range:int = 50;
@export var forceMultiplayer:float = 1;

@export var powerMeter:TextureProgressBar

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and get_global_mouse_position().x-self.position.x < range and get_global_mouse_position().x-self.position.x > -range and get_global_mouse_position().y-self.position.y < range and get_global_mouse_position().y-self.position.y > -range and linear_velocity.length() < 10:
		shoot_pos_start = self.position
		SHOOTING = true;
		powerMeter.visible = true;
	elif event.is_action_released("shoot") and SHOOTING:
		shoot_pos_end = get_global_mouse_position();
		var distance = shoot_pos_end.distance_to(shoot_pos_start);
		
		if distance > maxShootingStrengthPx:
			var direction = (shoot_pos_end - self.position).normalized();
			shoot_pos_end = self.position + direction * maxShootingStrengthPx;
			
		var forceX = (self.position.x - shoot_pos_end.x)/5;
		var forceY = (self.position.y - shoot_pos_end.y)/5;
		
		apply_impulse(Vector2(forceX,forceY));
		
		SHOOTING = false;
		powerMeter.visible = false;
func _process(delta: float) -> void:
	queue_redraw()
	
func _draw() -> void:
	if SHOOTING == true:
		if to_local(self.position).distance_to(get_local_mouse_position()) > maxShootingStrengthPx:
			var start = to_local(self.position)
			var dir = (get_local_mouse_position() - start).normalized()
			var end = start + dir * maxShootingStrengthPx;
			draw_line(start, end, Color.WHITE, 5.0)

		else:
			draw_line(to_local(self.position), get_local_mouse_position(), Color.WHITE, 5.0)
			powerMeter.value = min(to_local(self.position).distance_to(get_local_mouse_position())/maxShootingStrengthPx,1)*100; 
