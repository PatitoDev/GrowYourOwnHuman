extends Node2D

const BacteriaScene = preload("res://Entity/Bacteria/Bacteria.tscn")

func _ready():
	Global.SetMicroscopeData.connect(onSetBacteriaData);

func onSetBacteriaData(data: BacteriaData):
	for node in get_children():
		remove_child(node);
	
	if data == null:
		return;

	generateBacteria(data);

func generateBacteria(data: BacteriaData):
	for i in range(1):
		var bacteria = BacteriaScene.instantiate();
		bacteria.data = data;
		add_child(bacteria);
