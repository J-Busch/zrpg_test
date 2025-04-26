extends Node

signal player_hit

var position: Vector2
var player_vulnerable: bool = true
var health = 100:
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if player_vulnerable:
				player_hit.emit()
				health = value
				player_vulnerable = false
				player_invulnerable_timer()

func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true
