extends RigidBody2D

var ALLOW_SHOOT:bool = true;
var CAN_SHOOT:bool = false;

var shoot_pos_start:Vector2;
var shoot_pos_end:Vector2;
var SHOOTING:bool = false;

var maxShootingStrengthPx:int = 500;

var currentHole:int = 1;

var range:int = 50;
@export var forceMultiplayer:float = 1;

@export var powerMeter:TextureProgressBar;
@export var Arrow:Sprite2D;

var lastPos:Vector2;
var playerID:int;

func _ready() -> void:
	Arrow.visible = false;
	lastPos = self.position;

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("shoot") or event is InputEventScreenTouch) and get_global_mouse_position().x-self.position.x < range and get_global_mouse_position().x-self.position.x > -range and get_global_mouse_position().y-self.position.y < range and get_global_mouse_position().y-self.position.y > -range and linear_velocity.length() < 10:
		shoot_pos_start = self.position;
		lastPos = self.position;
		SHOOTING = true;
		powerMeter.visible = true;
		Arrow.visible = true;
	elif (event.is_action_released("shoot") or event is InputEventScreenTouch) and SHOOTING:
		shoot_pos_end = get_global_mouse_position();
		var distance = shoot_pos_end.distance_to(shoot_pos_start);
		
		if distance > maxShootingStrengthPx:
			var direction = (shoot_pos_end - self.position).normalized();
			shoot_pos_end = self.position + direction * maxShootingStrengthPx;
			
		var forceX = (self.position.x - shoot_pos_end.x)/5;
		var forceY = (self.position.y - shoot_pos_end.y)/5;
		
		apply_impulse(Vector2(forceX,forceY));
		
		SHOOTING = false;
		Arrow.visible = false;
		powerMeter.visible = false;
func _process(delta: float) -> void:
	queue_redraw()
	
func _draw() -> void:
	if SHOOTING == true:
		Arrow.rotation = (get_local_mouse_position() - to_local(self.position)).normalized().angle() - PI/2;
		Arrow.scale = Vector2(min(to_local(self.position).distance_to(get_local_mouse_position())/maxShootingStrengthPx,1)*5,min(to_local(self.position).distance_to(get_local_mouse_position())/maxShootingStrengthPx,1)*5);
		
		if to_local(self.position).distance_to(get_local_mouse_position()) > maxShootingStrengthPx:
			var start = to_local(self.position)
			var dir = (get_local_mouse_position() - start).normalized()
			var end = start + dir * maxShootingStrengthPx;
			draw_line(start, end, Color.WHITE, 10)

		else:
			draw_line(to_local(self.position), get_local_mouse_position(), Color.WHITE, 10.0)
			powerMeter.value = min(to_local(self.position).distance_to(get_local_mouse_position())/maxShootingStrengthPx,1)*100; 

func die() -> void:
	var parent = self.get_parent();
	if parent != null:
		if parent.has_method("player_win"):
			parent.player_die(self);
	print("DEAD")
	
func win(holeID:int) -> void:
	var parent = self.get_parent();
	currentHole = holeID;
	if parent != null:
		if parent.has_method("player_win"):
			parent.player_win(self);
	print("win")
	
