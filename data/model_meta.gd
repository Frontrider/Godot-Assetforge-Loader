extends Resource
class_name AssetForgePartMeta

#a rotation override, to correct any orientation problems when the mesh loads
export(Vector3) var rotation_degrees = Vector3()
#the bounds of the visibility notifier that hides the mesh when it gets off-screen.
export(AABB) var visibility_bounds = AABB(Vector3(),Vector3(1,1,1))
