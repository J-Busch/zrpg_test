extends Node

signal player_hit
signal update_ui

var position: Vector2
var last_scene_position: Vector2 = Vector2.ZERO
var has_bombs: bool = false:
	set(value):
		has_bombs = value
		update_ui.emit()
var bombs: int = 5:
	set(value):
		bombs = value
		update_ui.emit()

var player_vulnerable: bool = true
var money = 0:
	set(value):
		if value >= 0:
			money = value
		update_ui.emit()
var health = 100:
	set(value):
		if value > health:
			health = min(value, 100)
			update_ui.emit()
		else:
			if player_vulnerable:
				player_hit.emit()
				health = value
				player_vulnerable = false
				player_invulnerable_timer()
				update_ui.emit()
				if (health <= 0):
					TransitionLayer.you_died()
func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true
