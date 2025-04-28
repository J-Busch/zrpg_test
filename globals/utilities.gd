extends Node

func item_gen(marker):
	var green_gem_scene = preload("res://scenes/items/gems/green_gem.tscn")
	var blue_gem_scene = preload("res://scenes/items/gems/blue_gem.tscn")
	var red_gem_scene = preload("res://scenes/items/gems/red_gem.tscn")
	
	var d100 = randi_range(0, 100)
	
	if d100 < 40:
		pass
	elif d100 < 75:
		var green_gem = green_gem_scene.instantiate()
		green_gem.global_position = marker.global_position
		get_tree().current_scene.get_node("Items").call_deferred("add_child", green_gem)
	elif d100 < 95:
		var blue_gem = blue_gem_scene.instantiate()
		blue_gem.global_position = marker.global_position
		get_tree().current_scene.get_node("Items").call_deferred("add_child", blue_gem)
	elif d100 < 100:
		var red_gem = red_gem_scene.instantiate()
		red_gem.global_position = marker.global_position
		get_tree().current_scene.get_node("Items").call_deferred("add_child", red_gem)
