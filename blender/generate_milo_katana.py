# generate_milo_katana.py
# Blender 3.x / 4.x Python script to procedurally model Milo's 3D Katana & Sheath
# Run inside Blender: blender --background --python generate_milo_katana.py

import bpy

def create_katana():
    # Clear existing objects
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete()

    # 1. Create Blade (Curved Steel)
    bpy.ops.mesh.add_cube(location=(0, 0, 1.0))
    blade = bpy.context.active_object
    blade.name = "Katana_Blade"
    blade.scale = (0.02, 0.08, 1.2)

    # Steel Material
    mat_steel = bpy.data.materials.new(name="Material_Steel")
    mat_steel.use_nodes = True
    bsdf = mat_steel.node_tree.nodes.get("Principled BSDF")
    bsdf.inputs['Base Color'].default_value = (0.8, 0.85, 0.9, 1.0)
    bsdf.inputs['Metallic'].default_value = 0.9
    bsdf.inputs['Roughness'].default_value = 0.2
    blade.data.materials.append(mat_steel)

    # 2. Create Hand Guard (Tsuba)
    bpy.ops.mesh.add_cylinder(radius=0.18, depth=0.03, location=(0, 0, -0.2))
    tsuba = bpy.context.active_object
    tsuba.name = "Katana_Guard"

    mat_gold = bpy.data.materials.new(name="Material_Gold")
    mat_gold.use_nodes = True
    bsdf_gold = mat_gold.node_tree.nodes.get("Principled BSDF")
    bsdf_gold.inputs['Base Color'].default_value = (1.0, 0.8, 0.1, 1.0)
    bsdf_gold.inputs['Metallic'].default_value = 0.8
    tsuba.data.materials.append(mat_gold)

    # 3. Create Handle (Tsuka)
    bpy.ops.mesh.add_cylinder(radius=0.04, depth=0.5, location=(0, 0, -0.45))
    handle = bpy.context.active_object
    handle.name = "Katana_Handle"

    mat_wrap = bpy.data.materials.new(name="Material_RedWrap")
    mat_wrap.use_nodes = True
    bsdf_wrap = mat_wrap.node_tree.nodes.get("Principled BSDF")
    bsdf_wrap.inputs['Base Color'].default_value = (0.8, 0.1, 0.1, 1.0)
    handle.data.materials.append(mat_wrap)

    # 4. Export to FBX
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.export_scene.fbx(filepath="milo_katana.fbx", use_selection=True)
    print("Milo Katana FBX exported successfully!")

if __name__ == "__main__":
    create_katana()
