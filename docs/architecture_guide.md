# Architecture Style Guide

## 1. Core Structure

- Node First
- Short, Focused Scripts
- Components over inheritance

## 2. Rules

- Always Strongly Type
- Do not use := typing, always specify
- Human readable names of variables, functions, classes, files, etc...
- Do no specify GUID, always let GODOT assign GUIDs.

## 3. World Scale

- Use `1 Godot unit = 1 meter`.
- Treat the player as approximately `1.8` units tall unless a specific character design says otherwise.
- Build collision, movement, gravity, jump values, camera offsets, and level blockouts against that meter scale before tuning for feel.
- Prefer moving or resizing assets to match the shared scale before changing physics values to compensate for mismatched proportions.
