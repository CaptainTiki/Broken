"""
Low-poly Deciduous Tree Generator for Broken (v3)

Major improvements over v2:
- Proper branch attachment (one end rooted in the trunk)
- Branch variation: straight / bent / split
- Leaf lobes correctly placed at the actual ends of branches
- Much better scale relationship between branches and leaf lobes
- Placeholder materials (brown trunk, green leaves)

Usage:
blender.exe --background --python tools/blender/generate_deciduous_tree_03.py
"""

import bpy
import bmesh
import math
import random
from mathutils import Vector

# ------------------------------
# CONFIG
# ------------------------------
TREE_HEIGHT = 8.7
TRUNK_RADIUS_BASE = 0.48
TRUNK_RADIUS_TOP = 0.17
NUM_MAIN_BRANCHES = 6          # slightly more branches for density
LEAF_LOBE_BASE_SIZE = 2.4
SEED = 123

random.seed(SEED)

# ------------------------------
# Utilities
# ------------------------------

def clear_scene():
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete(use_global=False)
    for block in bpy.data.meshes:
        bpy.data.meshes.remove(block)
    for block in bpy.data.materials:
        bpy.data.materials.remove(block)


def add_noise(obj, strength=0.06):
    bm = bmesh.new()
    bm.from_mesh(obj.data)
    for v in bm.verts:
        v.co.x += random.uniform(-strength, strength)
        v.co.y += random.uniform(-strength, strength)
        v.co.z += random.uniform(-strength * 0.6, strength * 0.6)
    bm.to_mesh(obj.data)
    bm.free()


def create_cylinder(name, radius, depth, location, rotation=(0, 0, 0), vertices=8):
    bpy.ops.mesh.primitive_cylinder_add(
        radius=radius,
        depth=depth,
        location=location,
        rotation=rotation,
        vertices=vertices
    )
    obj = bpy.context.active_object
    obj.name = name
    return obj


def create_leaf_lobe(name, radius, location, scale=(1, 1, 1), rotation=(0, 0, 0)):
    bpy.ops.mesh.primitive_ico_sphere_add(
        subdivisions=2,
        radius=radius,
        location=location,
        rotation=rotation
    )
    obj = bpy.context.active_object
    obj.name = name
    obj.scale = scale

    # Slight organic deformation
    bm = bmesh.new()
    bm.from_mesh(obj.data)
    for v in bm.verts:
        if v.co.z < 0:
            v.co.x *= 1.12
            v.co.y *= 1.12
        v.co.x += random.uniform(-0.12, 0.12) * radius
        v.co.y += random.uniform(-0.12, 0.12) * radius
        v.co.z += random.uniform(-0.08, 0.08) * radius
    bm.to_mesh(obj.data)
    bm.free()
    return obj


def create_material(name, color):
    mat = bpy.data.materials.new(name=name)
    mat.use_nodes = True
    mat.node_tree.nodes["Principled BSDF"].inputs["Base Color"].default_value = (*color, 1.0)
    return mat


# ------------------------------
# Main Generation
# ------------------------------

def generate_tree_v3():
    clear_scene()

    trunk_mat = create_material("Trunk", (0.38, 0.24, 0.13))
    leaf_mat = create_material("Leaves", (0.16, 0.38, 0.16))

    # === TRUNK ===
    trunk = create_cylinder("Trunk", TRUNK_RADIUS_BASE, TREE_HEIGHT, (0, 0, TREE_HEIGHT / 2), vertices=10)
    # Taper
    bm = bmesh.new()
    bm.from_mesh(trunk.data)
    for v in bm.verts:
        if v.co.z > 0:
            factor = TRUNK_RADIUS_TOP / TRUNK_RADIUS_BASE
            v.co.x *= factor
            v.co.y *= factor
    bm.to_mesh(trunk.data)
    bm.free()
    add_noise(trunk, 0.05)
    trunk.data.materials.append(trunk_mat)

    # === BRANCHES WITH VARIATION ===
    branches = []
    branch_heights = [2.8, 3.7, 4.6, 5.4, 6.2, 7.0]

    for i in range(NUM_MAIN_BRANCHES):
        height = branch_heights[i]
        angle = (i * 58) + random.uniform(-14, 14)
        rad = math.radians(angle)

        # Decide branch type
        r = random.random()
        if r < 0.25:
            branch_type = "split"
        elif r < 0.55:
            branch_type = "bent"
        else:
            branch_type = "straight"

        # Strong outward angle (60-80 degrees from vertical)
        dir_x = math.cos(rad)
        dir_y = math.sin(rad)
        dir_z = random.uniform(0.20, 0.35)

        length = random.uniform(2.3, 3.4)
        thickness = random.uniform(0.085, 0.115)

        # Base position on trunk surface
        base_pos = Vector((dir_x * (TRUNK_RADIUS_BASE * 0.92), dir_y * (TRUNK_RADIUS_BASE * 0.92), height))

        # === STRAIGHT BRANCH ===
        if branch_type == "straight":
            bpy.ops.mesh.primitive_cylinder_add(
                radius=thickness,
                depth=length,
                location=base_pos,
                vertices=6
            )
            branch = bpy.context.active_object
            branch.name = f"Branch_{i+1:02d}_Straight"

            direction = Vector((dir_x, dir_y, dir_z)).normalized()
            up = Vector((0, 0, 1))
            axis = up.cross(direction)
            angle_rad = math.acos(up.dot(direction))
            branch.rotation_mode = 'AXIS_ANGLE'
            branch.rotation_axis_angle = [angle_rad, axis.x, axis.y, axis.z]
            add_noise(branch, 0.04)
            branch.data.materials.append(trunk_mat)
            branches.append(branch)

        # === BENT BRANCH ===
        elif branch_type == "bent":
            # First segment
            seg1_len = length * 0.55
            bpy.ops.mesh.primitive_cylinder_add(radius=thickness, depth=seg1_len, location=base_pos, vertices=6)
            seg1 = bpy.context.active_object
            seg1.name = f"Branch_{i+1:02d}_Seg1"

            direction1 = Vector((dir_x, dir_y, dir_z)).normalized()
            up = Vector((0, 0, 1))
            axis = up.cross(direction1)
            angle_rad = math.acos(up.dot(direction1))
            seg1.rotation_mode = 'AXIS_ANGLE'
            seg1.rotation_axis_angle = [angle_rad, axis.x, axis.y, axis.z]
            seg1.data.materials.append(trunk_mat)

            # Second segment (different angle)
            tip1 = seg1.matrix_world @ Vector((0, 0, seg1_len / 2))
            dir2 = direction1 + Vector((random.uniform(-0.6, 0.6), random.uniform(-0.6, 0.6), random.uniform(-0.1, 0.2)))
            dir2 = dir2.normalized()

            seg2_len = length * 0.45
            bpy.ops.mesh.primitive_cylinder_add(radius=thickness * 0.85, depth=seg2_len, location=tip1, vertices=6)
            seg2 = bpy.context.active_object
            seg2.name = f"Branch_{i+1:02d}_Seg2"

            axis2 = Vector((0, 0, 1)).cross(dir2)
            angle2 = math.acos(Vector((0, 0, 1)).dot(dir2))
            seg2.rotation_mode = 'AXIS_ANGLE'
            seg2.rotation_axis_angle = [angle2, axis2.x, axis2.y, axis2.z]
            add_noise(seg2, 0.035)
            seg2.data.materials.append(trunk_mat)

            branches.append(seg2)   # we only care about the outermost segment for leaves

        # === SPLIT BRANCH ===
        else:
            # Main segment
            main_len = length * 0.7
            bpy.ops.mesh.primitive_cylinder_add(radius=thickness, depth=main_len, location=base_pos, vertices=6)
            main = bpy.context.active_object
            main.name = f"Branch_{i+1:02d}_Main"

            direction = Vector((dir_x, dir_y, dir_z)).normalized()
            up = Vector((0, 0, 1))
            axis = up.cross(direction)
            angle_rad = math.acos(up.dot(direction))
            main.rotation_mode = 'AXIS_ANGLE'
            main.rotation_axis_angle = [angle_rad, axis.x, axis.y, axis.z]
            main.data.materials.append(trunk_mat)

            # One secondary branch coming off the main one
            split_point = main.matrix_world @ Vector((0, 0, main_len * 0.65))
            split_dir = direction + Vector((random.uniform(-0.9, 0.9), random.uniform(-0.9, 0.9), 0.1))
            split_dir = split_dir.normalized()

            split_len = length * 0.45
            bpy.ops.mesh.primitive_cylinder_add(radius=thickness * 0.7, depth=split_len, location=split_point, vertices=5)
            split = bpy.context.active_object
            split.name = f"Branch_{i+1:02d}_Split"

            axis_s = Vector((0, 0, 1)).cross(split_dir)
            angle_s = math.acos(Vector((0, 0, 1)).dot(split_dir))
            split.rotation_mode = 'AXIS_ANGLE'
            split.rotation_axis_angle = [angle_s, axis_s.x, axis_s.y, axis_s.z]
            split.data.materials.append(trunk_mat)

            branches.append(main)
            branches.append(split)

    # === LEAF LOBES ===
    leaf_lobes = []

    # Place lobes at the outer tips of branches
    for i, branch in enumerate(branches):
        # Get the far end of the branch
        tip = branch.matrix_world @ Vector((0, 0, branch.dimensions.z / 2))

        size = LEAF_LOBE_BASE_SIZE * random.uniform(0.72, 0.95)   # smaller on branches
        lobe = create_leaf_lobe(
            f"LeafLobe_B{i+1:02d}",
            size,
            tip,
            scale=(1.0, 1.0, 0.85),
            rotation=(random.uniform(-0.5, 0.5), random.uniform(-0.5, 0.5), random.uniform(-1.2, 1.2))
        )
        lobe.data.materials.append(leaf_mat)
        leaf_lobes.append(lobe)

    # Top crown lobes (larger)
    top_lobes = [
        (0.0, 0.0, 7.3),
        (0.7, -0.4, 6.7),
        (-0.5, 0.9, 6.5),
    ]
    for idx, pos in enumerate(top_lobes):
        size = LEAF_LOBE_BASE_SIZE * random.uniform(1.05, 1.35)
        lobe = create_leaf_lobe(
            f"LeafLobe_Top{idx+1:02d}",
            size,
            pos,
            scale=(1.0, 1.0, 0.9),
            rotation=(random.uniform(-0.3, 0.3), random.uniform(-0.3, 0.3), random.uniform(-0.9, 0.9))
        )
        lobe.data.materials.append(leaf_mat)
        leaf_lobes.append(lobe)

    # === HIERARCHY ===
    bpy.ops.object.empty_add(type='PLAIN_AXES', location=(0, 0, 0))
    root = bpy.context.active_object
    root.name = "Tree_Root"

    all_objects = [trunk] + branches + leaf_lobes
    for obj in all_objects:
        obj.parent = root

    root.location = (0, 0, 0)

    # === EXPORT ===
    export_path = "D:/Godot/REPOs/Broken/art/models/forest/Tree_03_Deciduous_V3.gltf"
    bpy.ops.export_scene.gltf(
        filepath=export_path,
        export_format='GLTF_SEPARATE',
        export_materials='EXPORT',
        export_yup=True,
        export_apply=False,
        export_animations=False
    )

    print(f"Tree v3 generated and exported to: {export_path}")
    return root


if __name__ == "__main__":
    generate_tree_v3()
