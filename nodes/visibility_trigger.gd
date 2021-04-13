tool
extends Area
# This component handles the hiding and showing of different meshes based on visibility.

#we store the mesh name, so we can emit it when sending signals to the root node.
var mesh_name = ""

signal part_visible(mesh_transform,trigger)
signal part_invisible(mesh_transform,trigger)
var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	#we do not monitor anything ourselves.
	monitoring = false
	#Do not process anything, no matter what.
	set_process(false)
	var shape = CollisionShape.new()
	var area_shape = BoxShape.new()
	area_shape.extents = Vector3(.5,.5,.5)
	shape.shape = area_shape
	set_collision_layer_bit(0,false)
	set_collision_mask_bit(0,false)
	set_collision_layer_bit(19,true)
	add_child(shape)
	if Engine.editor_hint:
		show_mesh()
	pass

func show_mesh():
	emit_signal("part_visible",transform,self)
	pass
	
func hide_mesh():
	emit_signal("part_invisible",transform,self)
	pass
