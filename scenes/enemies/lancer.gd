extends Enemy

func _ready():
	health = 60
	damage = 30
	speed = 70
	
func _process(delta):
	super._process(delta)
	
	move_and_slide()
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
