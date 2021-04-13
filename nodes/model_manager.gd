tool
extends Spatial

var constants = preload("res://addons/assetforge_loader/data/constants.gd").new()

export var instance_count = 100 setget _set_instance_count 

var MeshVisibilityTrigger = preload("res://addons/assetforge_loader/nodes/visibility_trigger.gd")
var ManagedMultimesh = preload("res://addons/assetforge_loader/nodes/multimesh.gd")
var ModelReference = preload("res://addons/assetforge_loader/nodes/model_reference.gd")

#all of the meta information for  the loaded meshes
var terrain_meta = {}

var meshes = Spatial.new()
var mesh_cache = {}

signal added_on_position(mesh_name,mesh_transform)
signal removed_from_position(mesh_name,mesh_transform)

# Called when the node enters the scene tree for the first time.
func _ready():
	meshes.name = "meshes"
	add_child(meshes,true)
	pass
#create and return the multimesh for this key
func create_multimesh(mesh_name):

	if(not mesh_cache.has(mesh_name)):
		var multimesh_instance =  ManagedMultimesh.new()
		multimesh_instance.name = mesh_name
		if !Engine.editor_hint:
			multimesh_instance.max_visible_instance_count = instance_count
		else:
			multimesh_instance.max_visible_instance_count = 10000
		meshes.add_child(multimesh_instance,true)
		mesh_cache[mesh_name] = multimesh_instance
		multimesh_instance.use_in_baked_light = true
		return multimesh_instance
	
	return mesh_cache[mesh_name]

func _set_instance_count(new_instance_count):
	instance_count = new_instance_count
	for child in meshes.get_children():
		child.visible_instance_count = instance_count
		pass

func _add_mesh(mesh_transform,_visibility_handler):
	emit_signal("added_on_position",_visibility_handler.mesh_name,mesh_transform)
	_visibility_handler.mesh_name
	pass

func _remove_mesh(mesh_transform,_visibility_handler):
	emit_signal("removed_from_position",_visibility_handler.mesh_name,mesh_transform)
	pass

