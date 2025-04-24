@tool
extends StaticBody2D

@export_category("Editor properties")
@export var property_skin = 0;
@export_enum("0°:0","90°:1","180°:2","270°:3") var property_rotation:int = 0;
var property_canRotate:int = true;

@export var textureFrameSize:int = 16;

func _ready() -> void:
	update();

func update() -> void:
	$Sprite2D.hframes = $Sprite2D.texture.get_width()/textureFrameSize;
	$Sprite2D.vframes = $Sprite2D.texture.get_height()/textureFrameSize;
	
	self.rotation = PI*2*property_rotation/4;
	$Sprite2D.rotation = PI*2*-property_rotation/4;
	$Sprite2D.frame_coords.x = property_rotation;
	$Sprite2D.frame_coords.y = property_skin;
	
func _process(delta):
	if Engine.is_editor_hint():
		update()
