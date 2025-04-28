extends Area2D
class_name Gem

var money_value = 1
var grabbable: bool = false
var player_in: bool = false

func _process(_delta):
	grab()
	
func grab():
	if player_in and grabbable:
		PlayerGlobals.money += money_value
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	player_in = true
	if (body.name == "Player"):
		grab()

func _on_body_exited(_body: Node2D) -> void:
	player_in = false

func _on_area_entered(area: Area2D) -> void:
	if (area.name == "Sword" and grabbable):
		PlayerGlobals.money += money_value
		queue_free()

func _on_timer_timeout() -> void:
	grabbable = true
