extends Enemy

var noticed: bool = false

func _ready():
	health = 60
	damage = 30
	speed = 70
	
func _process(delta):
	super._process(delta)
	
	move_and_slide()
	#look_at(PlayerGlobals.position)
	
	var dir = (self.position - PlayerGlobals.position).normalized()
	if noticed:
		velocity = speed * -dir
		if (dir.y < 0 and abs(dir.x) < 0.7):
			$AnimatedSprite2D.play("walk_down")
		elif (dir.y > 0 and abs(dir.x) < 0.7):
			$AnimatedSprite2D.play("walk_up")
		elif (dir.x > 0.7):
			$AnimatedSprite2D.scale = Vector2(-0.8,0.8)
			$AnimatedSprite2D.play("walk_side")
		elif (dir.x < 0.7):
			$AnimatedSprite2D.play("walk_side")
			$AnimatedSprite2D.scale = Vector2(0.8,0.8)

func hit(damage: int, body: CharacterBody2D):
	super.hit(damage, body)
	body.get_node("AnimationPlayer").play("take_damage")

func _on_notice_area_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		noticed = true
