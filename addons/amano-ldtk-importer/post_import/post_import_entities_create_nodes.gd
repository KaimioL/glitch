@tool
extends Node

func post_import(entity_layer: Node2D) -> Node2D:
	var data :Array = entity_layer.get_meta("LDtk_entity_instances")
	var entities_defs :Array = entity_layer.get_meta("LDtk_raw_defs").entities
	var entities_defs_uid := entities_defs.map(func(item): return int(item.uid))
	var label_settings := LabelSettings.new()
	label_settings.font_size = 8
	label_settings.line_spacing = 0

	for entity_data in data:
		var entity_def_index :int = entities_defs_uid.find(int(entity_data.def_uid))
		var entity_def :Dictionary = entities_defs[entity_def_index]
		var node
		var entity_size := Vector2(entity_data.width, entity_data.height)
		var entity_extents := entity_size * 0.5

		match entity_def.renderMode:
			"Ellipse":
				node = Area2D.new()
				var collision_shape := CollisionShape2D.new()
				collision_shape.shape = CircleShape2D.new()
				collision_shape.shape.radius = entity_data.width / 2
				node.add_child(collision_shape)
				collision_shape.debug_color = entity_data.smart_color
			"Rectangle":
				node = Polygon2D.new()
				node.polygon = PackedVector2Array([
					Vector2(-entity_extents.x, -entity_extents.y),
					Vector2(entity_extents.x, -entity_extents.y),
					Vector2(entity_extents.x, entity_extents.y),
					Vector2(-entity_extents.x, entity_extents.y),
				])
				node.color = entity_data.smart_color
				if entity_def.hollow:
					node.invert_enabled = true
					node.invert_border = 2
			"Cross":
				node = Marker2D.new()
			_:
				if entity_def.tags.has("Enemy"):
					node = load(str("res://src/enemies/" + entity_def.identifier.to_lower() + ".tscn")).instantiate()

		if entity_def.identifier == "Labels":
			var label := Label.new()
			label.label_settings = label_settings
			label.text = entity_data.fields.text
			label.position = -entity_extents
			label.autowrap_mode = TextServer.AUTOWRAP_WORD
			label.custom_minimum_size = entity_size
			node.add_child(label)

		var pivot = entity_data.pivot
		node.name = entity_data.identifier
		node.position = entity_data.px
		node.position += entity_extents
		node.position -= entity_size * pivot
		node.set_meta("entity_data", entity_data)
		entity_layer.add_child(node)

	return entity_layer
