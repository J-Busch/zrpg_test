extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		TransitionLayer.change_scene("res://scenes/outside.tscn")
