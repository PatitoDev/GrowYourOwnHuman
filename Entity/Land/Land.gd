extends Node2D

signal OnClick;
signal OnHeadClick;
var isFocused = false;
var isHeadFocused = false;
var hasGrowned = false;

@onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	if isFocused && Input.is_action_just_pressed("Interact"):
		OnClick.emit();
	
	if hasGrowned && isHeadFocused && Input.is_action_just_pressed("Interact"):
		OnHeadClick.emit();

func growHuman():
	animationPlayer.play("Grow");
	await animationPlayer.animation_finished;
	
func _on_click_area_mouse_entered():
	isFocused = true;

func _on_click_area_mouse_exited():
	isFocused = false;

func _on_head_grab_area_mouse_entered():
	if !hasGrowned:
		return;
	isHeadFocused = true;

func _on_head_grab_area_mouse_exited():
	if !hasGrowned:
		return;
	isHeadFocused = false;
