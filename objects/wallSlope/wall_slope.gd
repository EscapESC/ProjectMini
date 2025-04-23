extends StaticBody2D

@export_category("Editor properties")
@export var property_skin = 0;
@export var property_rotation:int = 0;
var property_canRotate:int = true;

func _ready() -> void:
	update()

func update() -> void:
	self.rotation = PI*2*property_rotation/4;
	$Sprite2D.rotation = PI*2*-property_rotation/4;
	$Sprite2D.frame_coords.x = property_rotation;
	$Sprite2D.frame_coords.y = property_skin
