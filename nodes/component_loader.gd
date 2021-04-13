extends Node

enum LoaderType{
	SCENE,RESOURCE
}

var data = {
	
}

export var base_path = "res://assets/terrain/tiles/effect/"
export var type = LoaderType.SCENE

export(PackedScene) var default_value 

# Called when the node enters the scene tree for the first time.
func _ready():
	data["default"] = default_value.instance()
	pass # Replace with function body.


func load_data(resource_name):
	if(data.has(resource_name)):
		return data[resource_name]
	
	#load the meta file
	var name = resource_name.split(";")
	var path = base_path+name[0]+"/"+name[1]
	if(type == LoaderType.SCENE):
		path += ".tscn"
	else:
		path += ".tres"
	
	if(ResourceLoader.exists(path)):
		var value = load(path)
		data[resource_name] = value
	else:
		data[resource_name] = data["default"]
	
	return data[resource_name]
