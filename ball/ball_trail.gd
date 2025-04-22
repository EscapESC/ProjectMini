class_name Trail
extends Line2D

const MAX_POINTS: int = 50;
@onready var curve := Curve2D.new()

@export var updateInterval:float = 100; #Number of updates per second 

var time:float = 0;

func _process(delta: float) -> void:
	time += delta;
	if time > 1/updateInterval:
		time = 0;
		curve.add_point(get_parent().position);
	
	if curve.get_point_count() > MAX_POINTS:
		curve.remove_point(0);

	var points = curve.get_baked_points();
	clear_points();
	self.points = points;
