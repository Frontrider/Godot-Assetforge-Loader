Experimental godot addon to load assetforge files directly, primarily intended for terrain.

Culling within the model included.


Setup:
clone this repository inside your <godot_project>/addons folder.

You must structure your nodes this way.
![image](https://user-images.githubusercontent.com/6755034/114614679-1e7d5800-9ca5-11eb-9848-33fb8b635a6d.png)

The AssetforgeModelManager node creates the rendering system. under the hood, it creates a multimesh that stores all of the individual pieces you used. It MUST be the parent of all AssetforgeModels. it also creates areas for each node, currently with the same size, used by the visibility system detailed bellow.
It has 2 signals added_on_position, and removed_from_position that can be used to add any new nodes/scenes dynamically as they come into view.


The AssetforgeModel node is the reference to the actual model.
![image](https://user-images.githubusercontent.com/6755034/114614870-571d3180-9ca5-11eb-8ede-4f43016ca6dc.png)

You have to first import the \*.model file.it is done like this to speed up loading times, godot is much faster with loading it's own resource format, then parsing custom files from gdscript. The imported model is saved to /assets/assetforge_parts/data/<model_name>.res, you can add this resource to the "model" field of the AssetforgeModel node. it will render immidietly in the editor.

The model can be offset by "model_offset" field, this is relative to the parent model manager, as that is the node that renders this.

The reload model, and visibility buttons meant to be used in the editor, but they don't work well. Visibility is unimplemented, intended to disable models you don't need now to get some frames if needed.
To reload the model, use the "reload saved scene" button in the scene menu.

Meshes:
All meshes must be placed inside res://assets/assetforge_parts/models/. for a model in the "terrain" group named "ground", the path would be res://assets/assetforge_parts/models/terrain/ground.obj. 

The plugin creates the res://assets/assetforge_parts/meta folder, you can store additional transforms for each mesh, if something went wrong with the import. This part is highly experimental, and may or may not break down.


Caveats:
- the z-axis is flipped when importing from assetforge, the negative z is pointed in the direction of positive z in godot, that can cause unforeseen problems.
