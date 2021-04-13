extends Resource
class_name AssetForgeMeta

#arbitrary rotation for the entire mesh. Does not work as of yet.
export(Vector3) var rotation_degrees = Vector3()
#filled in by the loader, determined by the bounds of the model.
var size = Vector3()
#the name of the associated model file
export var mesh_name = ""


#positive z
export var left =""
#negative z
export var right =""
#positive x
export var front =""
#negative x
export var back =""
#positive y
export var up =""
#negative y
export var down =""
