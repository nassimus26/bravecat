# generate_dojo_building.py
# Blender Python script to procedurally model a 3D Japanese Pagoda Dojo
# Run inside Blender: blender --background --python generate_dojo_building.py

import bpy

def create_dojo():
    # Clear existing objects
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete()

    # 1. Base Wooden Floor
    bpy.ops.mesh.add_cube(location=(0, 0, 0.2))
    base = bpy.context.active_object
    base.name = "Dojo_Base"
    base.scale = (4.0, 4.0, 0.2)

    mat_wood = bpy.data.materials.new(name="Material_Wood")
    mat_wood.use_nodes = True
    bsdf_wood = mat_wood.node_tree.nodes.get("Principled BSDF")
    bsdf_wood.inputs['Base Color'].default_value = (0.35, 0.18, 0.08, 1.0)
    base.data.materials.append(mat_wood)

    # 2. Columns / Pillars
    pillar_coords = [(-3.6, -3.6), (3.6, -3.6), (-3.6, 3.6), (3.6, 3.6)]
    for x, y in pillar_coords:
        bpy.ops.mesh.add_cylinder(radius=0.25, depth=3.0, location=(x, y, 1.7))
        col = bpy.context.active_object
        col.data.materials.append(mat_wood)

    # 3. Pagoda Tiled Roof
    bpy.ops.mesh.add_cone(radius1=5.2, depth=1.5, location=(0, 0, 3.8))
    roof = bpy.context.active_object
    roof.name = "Dojo_Roof"

    mat_roof = bpy.data.materials.new(name="Material_RedRoof")
    mat_roof.use_nodes = True
    bsdf_roof = mat_roof.node_tree.nodes.get("Principled BSDF")
    bsdf_roof.inputs['Base Color'].default_value = (0.6, 0.05, 0.05, 1.0)
    roof.data.materials.append(mat_roof)

    # Export
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.export_scene.fbx(filepath="japanese_dojo.fbx", use_selection=True)
    print("Japanese Dojo FBX exported successfully!")

if __name__ == "__main__":
    create_dojo()
