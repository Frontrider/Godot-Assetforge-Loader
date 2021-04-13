tool
extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var manager;

var MeshContainerScene = preload("res://addons/assetforge_loader/gui/MeshContainer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func update_view():
	for child in $Panel/ScrollContainer/VBoxContainer.get_children():
		child.queue_free()

	#we add a mesh for each known loaded model
	for key in manager.model.terrain_data.keys():
		var mesh = MeshContainerScene.instance()
		mesh.model_name = key
		$Panel/ScrollContainer/VBoxContainer.add_child(mesh)
		pass
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
