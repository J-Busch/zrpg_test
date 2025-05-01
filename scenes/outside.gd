extends Node2D

func _ready():
	if (PlayerGlobals.health > 0):
		$Player.global_position = PlayerGlobals.last_scene_position

func _on_house_enter_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		PlayerGlobals.last_scene_position = Vector2(PlayerGlobals.position.x, PlayerGlobals.position.y + 20)
		TransitionLayer.change_scene("res://scenes/inside.tscn")
