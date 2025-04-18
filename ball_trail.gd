class_name Trail
extends Line2D

const MAX_POINTS: int = 500;
@onready var curve := Curve2D.new()

func _process(delta: float) -> void:
	curve.add_point(get_parent().position)
	
	if curve.get_point_count() > MAX_POINTS:
		curve.remove_point(0)

	var points = curve.get_baked_points()
	clear_points()
	for point in points:
		add_point(point)
