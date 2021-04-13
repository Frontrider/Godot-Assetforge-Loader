tool
extends Spatial

var constants = preload("res://addons/assetforge_loader/data/constants.gd").new()
var MeshVisibilityTrigger = preload("res://addons/assetforge_loader/nodes/visibility_trigger.gd")
var manager = load("res://addons/assetforge_loader/nodes/model_manager.gd")
var visibility:Spatial

export(Resource) var model = AssetforgeModel.new() setget _update_model

export var model_offset = Vector3()
export var model_rotation = Vector3()

func _ready():
	set_notify_transform(true)
	if( not has_node("visibility")):
		var visibility = Spatial.new()
		visibility.name = "visibility"
		add_child(visibility,true)
	visibility = get_node("visibility")
	_update_model(model)
	build()
	
func update_models():
	_update_model(model)
	
#load the model's data
func _update_model(new_model):
	var parent = get_parent()
	if(new_model == null):
		return
	
	model = new_model
	if !parent is manager:
		return
	
	build()
	pass 

	pass
func build():
	var terrain_data = model.terrain_data
	var keys = terrain_data.keys()
	var parent = get_parent()
	for key in keys:
		for i in range(terrain_data[key].size()):
			var data = terrain_data[key][i]
			data as Transform
			var multimesh = get_parent().create_multimesh(key)
			var visibility_enabler = MeshVisibilityTrigger.new()
			var basis = data.basis
			var pos = data.origin+model_offset
			
			#pos = _rotate_transform(pos,model_rotation.x,AXIS.X)
			#pos = _rotate_transform(pos,model_rotation.y,AXIS.Y)
			#pos = _rotate_transform(pos,model_rotation.z,AXIS.Z)
			
			visibility_enabler.mesh_name = key
			visibility_enabler.transform = Transform(basis,pos)
			visibility_enabler.connect("part_visible",multimesh,"_add_mesh")
			visibility_enabler.connect("part_visible",parent,"_add_mesh")
			visibility_enabler.connect("part_invisible",multimesh,"_remove_mesh")
			visibility_enabler.connect("part_invisible",parent,"_remove_mesh")
			add_child(visibility_enabler)
			pass
		pass
		

	pass

func parse_vec3(vec3:String):
	var vec3_data = vec3.replace("(","").replace(")","").split(", ",false)
	return Vector3(vec3_data[0].to_float(),vec3_data[1].to_float(),vec3_data[2].to_float())

enum AXIS{
	X,Y,Z
}

func _rotate_transform(trans,angle,axis):
	var x_origin
	var y_origin
	var x
	var y
	angle = deg2rad(angle)
	if axis == AXIS.Z:
		x_origin = model_offset.x
		y_origin = model_offset.y
		#offset the positions
		x = trans.x
		y = trans.y
	if axis == AXIS.Y:
		x_origin = model_offset.x
		y_origin = model_offset.z
		#offset the positions
		x = trans.x
		y = trans.z
	if axis == AXIS.X:
		x_origin = model_offset.z
		y_origin = model_offset.y
		#offset the positions
		x = trans.z
		y = trans.y
	
	var x_rotated = ((x - x_origin) * cos(angle)) - ((y_origin - y) * sin(angle)) + x_origin
	var y_rotated = ((y_origin - y) * cos(angle)) - ((x - x_origin) * sin(angle)) + y_origin
	
	if axis == AXIS.Z:
		trans.x = x_rotated
		trans.y = y_rotated
		pass
	if axis == AXIS.Y:
		trans.x = x_rotated
		trans.z = y_rotated
		pass
	if axis == AXIS.X:
		trans.z = x_rotated
		trans.y = y_rotated
		pass
	return trans
	pass
