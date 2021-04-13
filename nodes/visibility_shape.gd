tool
extends Area


# Called when the node enters the scene tree for the first time.
func _ready():
	set_collision_layer_bit(0,false)
	set_collision_mask_bit(0,false)
	
	set_collision_mask_bit(19,true)
	
	connect("area_entered",self,"entered")
	connect("area_exited",self,"exited")
	monitorable = false
	pass # Replace with function body.

func entered(area):
	area.show_mesh()
	pass # Replace with function body.

func exited(area):
	area.hide_mesh()
	pass
