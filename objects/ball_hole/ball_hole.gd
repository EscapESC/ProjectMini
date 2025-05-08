extends Node2D
@export var holeID:int = 0;

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("win"):
		body.win(holeID);
