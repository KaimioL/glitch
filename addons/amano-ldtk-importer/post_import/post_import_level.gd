@tool
extends Node

var scripts = [
	preload("res://addons/amano-ldtk-importer/post_import/post_import_add_level_areas.gd")
]

func post_import(level: Node2D) -> Node2D:
	for script in scripts:
		var instance = script.new()
		level = instance.post_import(level)

	return level
