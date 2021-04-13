extends Resource
class_name AssetforgeModel
var constants = preload("res://addons/assetforge_loader/data/constants.gd").new()

export var terrain_data = {}

func load_model_file(path):
	print(path)
	var file = File.new()
	#if the file does not exist, do nothing.
	if not file.file_exists(path):
		return
	terrain_data = {}
	file.open(path,File.READ)
	#read the model file
	var content = file.get_as_text().split("\n")
	file.close()
	var found_models = false
	for line in content:
		if(line.begins_with(":models")):
			found_models = true
		pass

		if !found_models || line == ":models" || line.empty():
			continue

		line = line.replace("[","").replace("]","")


		var data = line.split(";",false)
		var mesh_name = ""
		var position = Vector3()
		var rotation_val = position
		var scale_val = position
		var hidden = false
		for val in data:
			var value = val.split(":")
			if(value[0] == "collection"):
				mesh_name += value[1]+";"
				pass
			if(value[0] == "type"):
				mesh_name += value[1]
				pass
			if(value[0] == "position"):
				position =  parse_vec3(value[1])
				#flip along the z axis to fix the mirroring problem.
				position.z = -position.z
				pass
			if(value[0] == "rotation"):
				rotation_val = parse_vec3(value[1])
				pass
			if(value[0] == "scale"):
				#print(value[1])
				scale_val = parse_vec3(value[1])
				#print(scale_val)
				pass
			if(value[0] == "hidden"):
				#print(value[1])
				hidden = value[1] == "true"
				#print(scale_val)
				pass
			pass

		var basis = Basis()

			#if the mesh is hidden, then do not process it.
		if(hidden):
			continue
		#load the meta if not loaded already.

		var meta:AssetForgePartMeta  = get_meta(mesh_name)
		var y_rotation = deg2rad(round(rotation_val.y)+meta.rotation_degrees.y)

		if(round(rotation_val.y) == 180):
			y_rotation += PI

		if(round(rotation_val.y) == 0):
			y_rotation += PI

		basis = basis.rotated(Vector3(0,1,0),y_rotation)
		basis = basis.rotated(Vector3(1,0,0),deg2rad(round(rotation_val.x+meta.rotation_degrees.x)))
		basis = basis.rotated(Vector3(0,0,1),deg2rad(round(rotation_val.z+meta.rotation_degrees.z)))
		basis = basis.scaled(scale_val)

		#basis = basis * transform.basis

		var transform_val = Transform(basis,position)
		if(not terrain_data.has(mesh_name)):
			terrain_data[mesh_name] = []

		terrain_data[mesh_name].append(transform_val)
		pass
	pass 

func get_meta(model):
	
	#load the meta file
	var name = model.split(";")
	var path = constants.meta_dir+"/"+name[0]+"/"+name[1]+".tres"
	if(ResourceLoader.exists(path)):
		var meta_data = ResourceLoader.load(path)
		return meta_data
	return AssetForgePartMeta.new()
	pass


func parse_vec3(vec3:String):
	var vec3_data = vec3.replace("(","").replace(")","").split(", ",false)
	return Vector3(vec3_data[0].to_float(),vec3_data[1].to_float(),vec3_data[2].to_float())
