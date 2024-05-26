extends Node2D

@onready var items = [
	$"Vial Container/Vial",
	$"Vial Container/Vial2",
	$"Vial Container/Vial3",
	$"Vial Container/Vial4"
];

signal OnMix();
signal OnStore();
signal OnVialGrabbed(who: Node2D);

@onready var bottomLimit = $VialBottomLimit
@onready var exitLimit = $VialExitLimit
@onready var vialContainer = $"Vial Container"

var isOnLeaveArea = false;

var focused = null;
var grabbed = null;

const VIAL_HEIGTH = 62;

func _physics_process(delta):
	if Input.is_action_just_pressed('Interact') \
		&& focused != null \
		&& grabbed != null:
		if (grabbed.data == null):
			return;
		onMix();
		OnMix.emit();
		return;

	if Input.is_action_just_pressed('Interact') \
		&& isOnLeaveArea:
		OnStore.emit();
		return;
	
	if Input.is_action_just_pressed('Interact') \
		&& focused != null \
		&& grabbed == null:
		grabbed = focused;
		var grabTween = create_tween().tween_property(focused, 'global_position', 
			Vector2(focused.global_position.x, exitLimit.global_position.y), 0.3
		).set_trans(Tween.TRANS_CUBIC);
		grabTween.finished.connect(onGrabEnd);
		return;

func onGrabEnd():
	if (grabbed != null):
		items[items.find(grabbed)] = null;
		OnVialGrabbed.emit(grabbed);

func _on_vial_on_mouse_entered(who: Node2D):
	if (grabbed == who):
		return;
	
	create_tween().tween_property(who, 'global_position', 
		who.global_position + Vector2(0, -10), 0.3
	).set_trans(Tween.TRANS_CUBIC);
	focused = who;

func _on_vial_on_mouse_exited(who: Node2D):
	if (focused == who):
		focused = null;
	
	if (grabbed == who):
		return;

	create_tween().tween_property(who, 'global_position', 
		Vector2(who.global_position.x, bottomLimit.global_position.y - VIAL_HEIGTH), 0.3
	).set_trans(Tween.TRANS_CUBIC);

func _on_click_area_mouse_entered():
	isOnLeaveArea = true;

func _on_click_area_mouse_exited():
	isOnLeaveArea = false;

func onMix():
	var target = focused;
	var emptyIndex = items.find(null);
	
	if (emptyIndex == -1):
		print('no space')
		return;

	items[emptyIndex] = grabbed;
	
	await create_tween().tween_property(grabbed, 'global_position', 
		Vector2(target.global_position.x - 10, exitLimit.global_position.y + 20), 0.3
	).set_trans(Tween.TRANS_CUBIC).finished;
	
	var prevPos = grabbed.global_position;
	grabbed.get_parent().remove_child(grabbed);
	vialContainer.add_child(grabbed);
	grabbed.global_position = prevPos;
	
	await create_tween().tween_property(grabbed, 'rotation_degrees', 
		95, 0.3
	).set_trans(Tween.TRANS_CUBIC).finished;
	
	if (target.data == null):
		target.setData(grabbed.data);
	else:
		print('mixed')
		target.mixData(grabbed.data);
	grabbed.setData(null);

	await create_tween().tween_property(grabbed, 'rotation_degrees', 
		0, 0.3
	).set_trans(Tween.TRANS_CUBIC).finished;
	
	var x = exitLimit.global_position.x + (15 * emptyIndex);
	await create_tween().tween_property(grabbed, 'global_position', 
		Vector2(x, bottomLimit.global_position.y - VIAL_HEIGTH), 0.3
	).set_trans(Tween.TRANS_CUBIC).finished;
	grabbed = null;

func leaveVial(what: Node2D):
	var emptyIndex = items.find(null);
	if (emptyIndex == -1):
		print('no space')
		return;

	items[emptyIndex] = what;
	var x = exitLimit.global_position.x + (15 * emptyIndex);
	await create_tween().tween_property(what, 'global_position', 
		Vector2(x, exitLimit.global_position.y), 0.3
	).set_trans(Tween.TRANS_CUBIC).finished;
	
	var prevPos = what.global_position;
	what.get_parent().remove_child(what);
	vialContainer.add_child(what);
	what.global_position = prevPos;
	
	await create_tween().tween_property(what, 'global_position', 
		Vector2(x, bottomLimit.global_position.y - VIAL_HEIGTH), 0.3
	).set_trans(Tween.TRANS_CUBIC).finished;
	grabbed = null;
