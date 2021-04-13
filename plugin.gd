tool
extends EditorPlugin

var constants = preload("res://addons/assetforge_loader/data/constants.gd").new()

var eds = get_editor_interface().get_selection()

#the nodes used by the plugin by default.
var MeshVisibilityTrigger = preload("res://addons/assetforge_loader/nodes/visibility_trigger.gd")
var ManagedMultimesh = preload("res://addons/assetforge_loader/nodes/multimesh.gd")
var ModelReference = preload("res://addons/assetforge_loader/nodes/model_reference.gd")
var ModelManager = preload("res://addons/assetforge_loader/nodes/model_manager.gd")
var VisibilityShape = preload("res://addons/assetforge_loader/nodes/visibility_shape.gd")
#ui controls
var ModelControl = preload("res://addons/assetforge_loader/gui/ModelManagerControl.tscn").instance()
var ModelInfo = preload("res://addons/assetforge_loader/gui/ModelDataDock.tscn").instance()

func _enter_tree():
	print("enabling assetforge loader")
	add_custom_type("AssetforgeModelManager","Spatial",ModelManager,preload("res://addons/assetforge_loader/icons/icon.png"))
	add_custom_type("AssetforgeModel","Spatial",ModelReference,preload("res://addons/assetforge_loader/icons/icon.png"))
	add_custom_type("AssetforgeModelVisibilityShape","Area",VisibilityShape,preload("res://addons/assetforge_loader/icons/icon.png"))
	
	if not (ModelControl is preload("res://addons/assetforge_loader/gui/ModelManagerControl.gd")):
		print("controls for assetforge node are invalid!!!")
		pass
	add_control_to_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU,ModelControl)

	eds.connect("selection_changed", self, "_on_selection_changed")
	
	pass

func _ready():
	var asset_folder = Directory.new()
	asset_folder.make_dir_recursive(constants.model_dir)
	asset_folder.make_dir_recursive(constants.meta_dir)
	asset_folder.make_dir_recursive(constants.data_dir)
	asset_folder.make_dir_recursive(constants.data_meta_dir)
	asset_folder.make_dir_recursive(constants.collision_dir)
	asset_folder.make_dir_recursive(constants.material_dir)
	pass

func _exit_tree():
	print("disabling assetforge loader")
	remove_custom_type("AssetforgeModelManager")
	remove_custom_type("AssetforgeModel")
	remove_custom_type("AssetforgeModelVisibilityShape")

	#remove_control_from_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU,ModelControl)
	ModelControl.queue_free()

	#we also disconnect from the selection listener, just to be safe.
	eds.disconnect("selection_changed", self, "_on_selection_changed")
	pass
	
func _on_selection_changed():
	# Returns an array of selected nodes
	var selected = eds.get_selected_nodes() 
	#we update the control, hiding and showing it depending on what we have selected.
	ModelControl.selected_nodes.clear()
	if not selected.empty():
		for selected_node in selected:
			if selected_node is ModelReference:
				ModelControl.selected_nodes.append(selected_node)
			pass
	ModelControl.update_controls()
	
	if not ModelControl.selected_nodes.empty():
		ModelInfo.visible = true
		ModelInfo.manager = ModelControl.selected_nodes[0]
		ModelInfo.update_view()
	else:
		ModelInfo.visible = false
	
