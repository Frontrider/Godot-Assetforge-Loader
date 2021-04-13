tool
extends Control

var constants = preload("res://addons/assetforge_loader/data/constants.gd").new()

var selected_nodes = []
var dialog = EditorFileDialog.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	dialog.add_filter("*.model ; assetforge models")
	add_child(dialog)
	dialog.popup_centered()
	dialog.mode = FileDialog.MODE_OPEN_FILE
	dialog.visible = false
	dialog.dialog_hide_on_ok = true
	dialog.hide()
	dialog.connect("file_selected",self,"load_model_file")
	pass # Replace with function body.

func update_controls():
	visible = not selected_nodes.empty()
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button2_pressed():
	if visible :
		for node in selected_nodes:
			node.update_models()
			pass
		pass
	pass # Replace with function body.


func _on_ImportButton_pressed():
	dialog.show()
	pass # Replace with function body.

func load_model_file(path):
	var model = AssetforgeModel.new()
	model.load_model_file(path)
	var name_data = path.split("/",false)
	print(name_data)
	var model_name = name_data[name_data.size()-1].split(".",false)[0]
	var save_path = constants.data_dir+"/"+model_name+".res"
	ResourceSaver.save(save_path,model)
	pass 
