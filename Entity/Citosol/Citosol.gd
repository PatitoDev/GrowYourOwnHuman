extends RigidBody2D

var shape: BacteriaData.SHAPE;
@onready var sprite = $Shapes

func _on_timer_timeout():
	apply_central_impulse(Vector2(5,0));

func _ready():
	applyData();

func applyData():
	match shape:
		BacteriaData.SHAPE.DOT:
			sprite.frame = 3;
		BacteriaData.SHAPE.TRIANGLE:
			sprite.frame = 0;
		BacteriaData.SHAPE.SQUARE:
			sprite.frame = 2;
		BacteriaData.SHAPE.CIRCLE:
			sprite.frame = 1;
