class_name Bacteria
extends CharacterBody2D

const citosolScene = preload("res://Entity/Citosol/Citosol.tscn")
var SPEED = 5;

@onready var sprite = $BacteriaSprites
@export var data: BacteriaData = BacteriaData.new();
@onready var citosolContainer = $CitosolContainer

func _ready():
	applySettings();

func applySettings():
	sprite.modulate = data.color;
	for child in citosolContainer.get_children():
		citosolContainer.remove_child(child);
		
	for i in range(3):
		var citosol = citosolScene.instantiate();
		citosol.shape = data.shape;
		citosolContainer.add_child(citosol);

func _physics_process(delta):
	var direction = Vector2(1,0);

	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x, 0, SPEED), move_toward(velocity.y, 0, SPEED));

	move_and_slide()
