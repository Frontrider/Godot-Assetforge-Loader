extends Resource

#the directories used by the plugin
export var source_dir = "res://assets/assetforge_parts"
export(String) var model_dir = source_dir+"/models"
export(String) var meta_dir = source_dir+"/meta"
export(String) var data_dir = source_dir+"/data"
export(String) var data_meta_dir = source_dir+"/data_meta"
export(String) var collision_dir = source_dir+"/collision"
export(String) var material_dir = source_dir+"/materials"

#this is the bit used by the terrain loader
#we use an area to load terrain instead of visibility to avoid looping over every single element.
export var loader_collosion_bit = 19
