tool
extends MultiMeshInstance
#the node's name is the model's id.

var max_visible_instance_count =100


var constants = preload("res://addons/assetforge_loader/data/constants.gd").new()

#all of the multimesh ids that are assigned, but currently unused.
var mesh_data = []
var raw_data = []


func _ready():
	multimesh= MultiMesh.new()
	var path = name.split(";")
	var res_path = constants.model_dir+"/"+path[0]+"/"+path[1]+".obj"
	if !ResourceLoader.exists(res_path):
		queue_free()
		return
	
	multimesh.visible_instance_count = max_visible_instance_count
	multimesh.instance_count = 0
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = load(res_path)
	var faces = multimesh.mesh.get_faces()
	for face in faces:
		face.z = -face.z
	
	build()
#We only modifly the meshes that we need to.

func build():
	var size = mesh_data.size()
	if multimesh == null:
		return
	if(size == 0):
		multimesh.instance_count = 0
		return
	multimesh.instance_count = 0
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.instance_count = size
	#we iterate like this, because arrays are optimized for foreach loops.
	var i = 0
	for data in mesh_data:
		multimesh.set_instance_transform(i,data)
		i+=1

	pass
func _add_mesh(mesh_transform,_visibility_handler):
	mesh_data.append(mesh_transform)
	build()
	pass

func _remove_mesh(mesh_transform,_visibility_handler):
	mesh_data.erase(mesh_transform)
	build()
	pass
