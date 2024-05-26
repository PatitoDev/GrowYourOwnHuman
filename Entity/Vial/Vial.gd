extends Node2D

@onready var liquid = $Liquid
@onready var sprite = $Vials
@export var data: BacteriaData = BacteriaData.new();

signal OnMouseEntered(who:Node2D);
signal OnMouseExited(who:Node2D);

func _ready():
	setData(data);

func _on_area_2d_mouse_entered():
	OnMouseEntered.emit(self);

func _on_area_2d_mouse_exited():
	OnMouseExited.emit(self);

func setData(newData: BacteriaData):
	if (newData == null):
		sprite.frame = 0;
		liquid.visible = false;
	else:
		sprite.frame = 1;
		liquid.visible = true;
		liquid.modulate = newData.color;
		liquid.modulate.a = 0.5;
	data = newData;

func mixData(newData: BacteriaData):
	data.addColor(newData.color);
	liquid.visible = true;
	liquid.modulate = data.color.clamp(Color.from_string('#ababab', Color.RED), Color.from_string('#fafafa', Color.RED));
	liquid.modulate.a = 0.5;
