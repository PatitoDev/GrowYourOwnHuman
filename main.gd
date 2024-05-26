extends Node2D

@onready var labScene = $LabScene
@onready var microscopeCanvas = $CanvasLayer

func _physics_process(delta):
	if Input.is_action_just_pressed("Close"):
		microscopeCanvas.visible = false;
		labScene.blockCamera = false;

func _on_lab_scene_open_microscope():
	microscopeCanvas.visible = true;
	labScene.blockCamera = true;
