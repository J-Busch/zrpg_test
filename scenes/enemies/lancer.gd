extends Enemy

func _ready():
	health = 60
	damage = 30
	speed = 70
	$NavigationAgent2D.target_position = PlayerGlobals.position
	
func _process(delta):
	super._process(delta)

func _physics_process(_delta):
	var next_path_pos = $NavigationAgent2D.get_next_path_position()
	var dir = (global_position - next_path_pos).normalized()
	move_and_slide()
	
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


func _on_nav_timer_timeout() -> void:
	$NavigationAgent2D.target_position = PlayerGlobals.position
	
func _on_notice_area_body_entered(body: Node2D) -> void:
	super._on_notice_area_body_entered(body)
	$NavTimer.start()
