"""
Low-poly Deciduous Tree Generator for Broken (v2 - Aggressive Spread)

Generates a chunky, stylized low-poly tree with:
- Tapered trunk
- Visible chunky branches with strong outward angles (wide spread test)
- 4-5+ distinct leaf lobes, many positioned near branch tips
- Separate meshes + placeholder materials (Trunk vs Leaves)

Usage:
blender.exe --background --python tools/blender/generate_deciduous_tree_01.py
"""

import bpy
import bmesh
import math
import random
from mathutils import Vector, Matrix

# ------------------------------
# CONFIG - tweak these for iteration
# ------------------------------
TREE_HEIGHT = 8.5
TRUNK_RADIUS_BASE = 0.42
TRUNK_RADIUS_TOP = 0.18
NUM_BRANCHES = 5
NUM_LEAF_LOBES = 5
LEAF_LOBE_BASE_SIZE = 2.6
SEED = 42

random.seed(SEED)

# ------------------------------
# Utility functions
# ------------------------------

def clear_scene():
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete(use_global=False)
    for block in bpy.data.meshes:
        bpy.data.meshes.remove(block)
    for block in bpy.data.materials:
        bpy.data.materials.remove(block)


def create_cylinder(name, radius1, radius2, depth, location, rotation=(0,0,0)):
    bpy.ops.mesh.primitive_cylinder_add(
        radius=radius1,
        depth=depth,
        location=location,
        rotation=rotation,
        vertices=8  # chunky low-poly look
    )
    obj = bpy.context.active_object
    obj.name = name

    # Taper the top
    bm = bmesh.new()
    bm.from_mesh(obj.data)
    for v in bm.verts:
        if v.co.z > 0:
            v.co.x *= (radius2 / radius1)
            v.co.y *= (radius2 / radius1)
    bm.to_mesh(obj.data)
    bm.free()

    return obj


def add_simple_noise(obj, strength=0.08):
    """Add a little bit of organic wobble to vertices"""
    bm = bmesh.new()
    bm.from_mesh(obj.data)
    for v in bm.verts:
        v.co.x += random.uniform(-strength, strength)
        v.co.y += random.uniform(-strength, strength)
        v.co.z += random.uniform(-strength * 0.5, strength * 0.5)
    bm.to_mesh(obj.data)
    bm.free()


def create_leaf_lobe(name, size, location, scale=(1.0, 1.0, 1.0), rotation=(0,0,0)):
    """Create a chunky low-poly leaf lobe using an icosphere"""
    bpy.ops.mesh.primitive_ico_sphere_add(
        subdivisions=2,
        radius=size,
        location=location,
        rotation=rotation
    )
    obj = bpy.context.active_object
    obj.name = name

    # Make it slightly irregular and wider at the bottom
    bm = bmesh.new()
    bm.from_mesh(obj.data)
    for v in bm.verts:
        # Push bottom out a bit for "wider at bottom" feel
        if v.co.z < 0:
            v.co.x *= 1.15
            v.co.y *= 1.15
        # Add some organic variation
        v.co.x += random.uniform(-0.15, 0.15) * size
        v.co.y += random.uniform(-0.15, 0.15) * size
        v.co.z += random.uniform(-0.12, 0.12) * size
    bm.to_mesh(obj.data)
    bm.free()

    obj.scale = scale
    return obj


# ------------------------------
# Main generation
# ------------------------------

def generate_tree():
    clear_scene()

    # === TRUNK ===
    trunk = create_cylinder(
        "Trunk",
        TRUNK_RADIUS_BASE,
        TRUNK_RADIUS_TOP,
        TREE_HEIGHT,
        (0, 0, TREE_HEIGHT / 2)
    )
    add_simple_noise(trunk, strength=0.06)

    # === BRANCHES ===
    branches = []
    branch_heights = [2.2, 3.4, 4.6, 5.7, 6.6]

    for i in range(NUM_BRANCHES):
        height = branch_heights[i]
        angle = (i * 72) + random.uniform(-18, 18)
        length = random.uniform(2.4, 3.6)
        thickness = random.uniform(0.09, 0.13)   # noticeably thinner than trunk

        # Very wide outward spread (~65-80 degrees from vertical)
        rad = math.radians(angle)
        dir_x = math.cos(rad)
        dir_y = math.sin(rad)
        dir_z = random.uniform(0.18, 0.32)   # low z = wide horizontal spread

        # Position on trunk
        pos = Vector((dir_x * 0.22, dir_y * 0.22, height))

        bpy.ops.mesh.primitive_cylinder_add(
            radius=thickness,
            depth=length,
            location=pos,
            vertices=6
        )
        branch = bpy.context.active_object
        branch.name = f"Branch_{i+1:02d}"

        # Orient the branch outward
        direction = Vector((dir_x, dir_y, dir_z)).normalized()
        up = Vector((0, 0, 1))
        axis = up.cross(direction)
        angle_rad = math.acos(up.dot(direction))
        branch.rotation_mode = 'AXIS_ANGLE'
        branch.rotation_axis_angle = [angle_rad, axis.x, axis.y, axis.z]

        # Small wobble for organic feel
        add_simple_noise(branch, strength=0.05)

        branches.append(branch)

    # === LEAF LOBES ===
    leaf_lobes = []

    # Place one lobe near the tip of each branch (this is key for seeing structure when branches spread)
    for i, branch in enumerate(branches):
        # Get the world position of the outer end of the branch
        tip_offset = branch.matrix_world @ Vector((0, 0, branch.dimensions.z / 2 * 0.85))
        size = LEAF_LOBE_BASE_SIZE * random.uniform(0.9, 1.25)
        lobe = create_leaf_lobe(
            f"LeafLobe_Branch{i+1:02d}",
            size,
            tip_offset,
            scale=(1.05, 1.05, 0.85),
            rotation=(random.uniform(-0.4, 0.4), random.uniform(-0.4, 0.4), random.uniform(-1.0, 1.0))
        )
        leaf_lobes.append(lobe)

    # Add 1-2 extra lobes near the top of the trunk for the crown
    top_positions = [
        (0.0, 0.0, 7.1),
        (0.6, -0.5, 6.6),
    ]
    for i, pos in enumerate(top_positions):
        size = LEAF_LOBE_BASE_SIZE * random.uniform(0.95, 1.15)
        lobe = create_leaf_lobe(
            f"LeafLobe_Top{i+1:02d}",
            size,
            pos,
            scale=(1.0, 1.0, 0.9),
            rotation=(random.uniform(-0.3, 0.3), random.uniform(-0.3, 0.3), random.uniform(-0.8, 0.8))
        )
        leaf_lobes.append(lobe)

    # === HIERARCHY ===
    # Create empty root
    bpy.ops.object.empty_add(type='PLAIN_AXES', location=(0, 0, 0))
    root = bpy.context.active_object
    root.name = "Tree_01_Root"

    # Parent everything to root
    for obj in [trunk] + branches + leaf_lobes:
        obj.parent = root
        obj.matrix_parent_inverse = root.matrix_world.inverted()

    # Move root so base of trunk is at origin (good for Godot placement)
    root.location = (0, 0, 0)

    # === MATERIALS (placeholder so we can see structure in Godot) ===
    trunk_mat = bpy.data.materials.new(name="Trunk_Mat")
    trunk_mat.use_nodes = True
    trunk_mat.node_tree.nodes["Principled BSDF"].inputs["Base Color"].default_value = (0.35, 0.22, 0.12, 1.0)

    leaf_mat = bpy.data.materials.new(name="Leaf_Mat")
    leaf_mat.use_nodes = True
    leaf_mat.node_tree.nodes["Principled BSDF"].inputs["Base Color"].default_value = (0.18, 0.42, 0.18, 1.0)

    # Assign materials
    for obj in [trunk] + branches:
        if obj.data.materials:
            obj.data.materials[0] = trunk_mat
        else:
            obj.data.materials.append(trunk_mat)

    for obj in leaf_lobes:
        if obj.data.materials:
            obj.data.materials[0] = leaf_mat
        else:
            obj.data.materials.append(leaf_mat)

    # === EXPORT ===
    export_path = "D:/Godot/REPOs/Broken/art/models/forest/Tree_02_Deciduous_Wide.gltf"

    bpy.ops.export_scene.gltf(
        filepath=export_path,
        export_format='GLTF_SEPARATE',
        export_materials='EXPORT',
        export_yup=True,
        export_apply=False,
        export_animations=False
    )

    print(f"Tree generated and exported to: {export_path}")
    return root


if __name__ == "__main__":
    generate_tree()
