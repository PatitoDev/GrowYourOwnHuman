extends Resource
class_name BacteriaData

const SPEED = 5.0

enum COLORS {
	RED,
	BLUE,
	YELLOW,
	PURPLE,
	GREEN,
	ORANGE
}

enum SIZE {
	SMALL,
	MEDIUM,
	BIG
}

enum SHAPE {
	DOT,
	TRIANGLE,
	SQUARE,
	CIRCLE
}

@export var color: Color = Color.RED;
@export var size:SIZE = SIZE.BIG;
@export var shape: SHAPE = SHAPE.CIRCLE;
@export var hasHair:bool = false;

func addColor(target: Color):
	if (color == target):
		return;
	color = color + target;
