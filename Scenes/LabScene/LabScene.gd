extends Node2D

signal OpenMicroscope;

var SPEED = 5;
@onready var camera = $Camera
@onready var cameraLeftLimit = $CameraLeftLimit
@onready var cameraRightLimit = $CameraRightLimit
@onready var vialHolder = $VialHolder
@onready var microscope = $Microscope
@onready var land = $Land
@onready var grabbedContainer = $GrabbedContainer
@onready var hand = $Hand

var blockCamera = false;
var grabbedVial = null;

func _physics_process(delta):
	if (blockCamera):
		return;
	
	var direction = Input.get_axis('Left', 'Right');
	var velocity = Vector2(direction * SPEED, 0);
	if (direction == 0):
		velocity = velocity.move_toward(Vector2(0,0), delta);
	
	camera.global_position = Vector2(clamp(velocity.x + camera.global_position.x, cameraLeftLimit.global_position.x, cameraRightLimit.global_position.x), 0);
	
	if (grabbedVial):
		grabbedVial.global_position = get_global_mouse_position();

func _on_vial_holder_on_vial_grabbed(who):
	var prevPos = who.global_position;
	
	who.get_parent().remove_child(who);
	grabbedContainer.add_child(who);
	who.global_position = prevPos;
	
	var moveToMouseTween = create_tween().tween_property(who, 'global_position', 
		get_global_mouse_position(), 0.2
	).set_trans(Tween.TRANS_CUBIC);
	
	await moveToMouseTween.finished;
	grabbedVial = who;
	hand.setIsGrabbed(true);

func _on_vial_holder_on_store():
	if (grabbedVial != null):
		vialHolder.leaveVial(grabbedVial);
		grabbedVial = null;
		hand.setIsGrabbed(false);

func _on_microscope_on_click():
	if (grabbedVial == null && microscope.hasSample):
		OpenMicroscope.emit();
		return;
	
	if (grabbedVial != null):
		Global.SetMicroscopeData.emit(grabbedVial.data);
		microscope.setHasSample(true);
		vialHolder.leaveVial(grabbedVial);
		grabbedVial = null;
		hand.setIsGrabbed(false);
		return;

func _on_land_on_click():
	if (grabbedVial != null):
		land.growHuman();
		vialHolder.leaveVial(grabbedVial);
		grabbedVial = null;
		hand.setIsGrabbed(false);
		return;

func _on_vial_holder_on_mix():
	if (grabbedVial != null):
		grabbedVial = null;
		hand.setIsGrabbed(false);
