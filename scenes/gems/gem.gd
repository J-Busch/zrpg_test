extends Area2D
class_name Gem

var money_value = 1

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		PlayerGlobals.money += money_value
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if (area.name == "Sword"):
		PlayerGlobals.money += money_value
		queue_free()
