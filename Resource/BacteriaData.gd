extends Resource
class_name BacteriaData

const SPEED = 5.0

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

@export var color: Color = Color.AQUA;
@export var size:SIZE = SIZE.BIG;
@export var shape: SHAPE = SHAPE.CIRCLE;
@export var hasHair:bool = false;
