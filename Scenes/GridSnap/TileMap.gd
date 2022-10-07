extends TileMap

func _ready() -> void:
	SignalHub.connect("grid_drag_stop", self, "_handle_drag_stop")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_pos : Vector2 = get_global_mouse_position()
		var coord : Vector2 = map_to_world(world_to_map(mouse_pos))
		
		SignalHub.emit_signal("grid_position", coord)

func _handle_drag_stop(item : Node2D, new_pos : Vector2, old_pos : Vector2) -> void:
	var coord = world_to_map(new_pos)
	var cell : int = get_cell(coord.x, coord.y)
	
	if cell == INVALID_CELL:
		item.set_global_position(old_pos)
	else:
		item.update_position(new_pos)
