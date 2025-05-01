extends StaticBody2D

var player_in = false
var talking = false

var dialogue = [
	"Hello traveler. You look weary.",
	"May I interest you in some bombs?",
	"Only 20 monies for the haul.",
	["Yes", "No"]
]

func _process(_delta):
	if player_in and Input.is_action_just_pressed("action"):
		if PlayerGlobals.has_bombs:
			DialogueManager.talk(["Go away!"])
		else:
			DialogueManager.talk(dialogue)
	
	var dir = (global_position - PlayerGlobals.position).normalized()
	
	if (dir.y < 0 and abs(dir.x) < 0.7):
		$AnimatedSprite2D.play("down")
	elif (dir.y > 0 and abs(dir.x) < 0.7):
		$AnimatedSprite2D.play("up")
	elif (dir.x > 0.7):
		$AnimatedSprite2D.scale = Vector2(-0.8,0.8)
		$AnimatedSprite2D.play("side")
	elif (dir.x < 0.7):
		$AnimatedSprite2D.play("side")
		$AnimatedSprite2D.scale = Vector2(0.8,0.8)

func _on_talk_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in = true

func _on_talk_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in = false
