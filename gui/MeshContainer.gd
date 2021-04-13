tool
extends Control
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var constants = preload("res://addons/assetforge_loader/data/constants.gd").new()
export var model_name = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	print(model_name)
	var path = model_name.split(";")
	$ViewportContainer/Viewport/MeshInstance.mesh = load(constants.model_dir+"/"+path[0]+"/"+path[1]+".obj")
	$Label.text = path[0]+"/"+path[1]
	pass # Replace with function body.

