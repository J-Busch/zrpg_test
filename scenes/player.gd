extends CharacterBody2D

var speed: int = 60
var direction: Vector2
var moving: bool = false
var facing: String = "down"
var last_facing: String = "down"
var sword_scene: PackedScene = preload("res://scenes/items/sword.tscn")
var sword: Area2D
var can_attack: bool = true

func _ready() -> void:
	PlayerGlobals.connect("player_hit", handle_player_hit)
	
func handle_player_hit():
	$AnimationPlayer.play("take_damage")

func _process(_delta):
	PlayerGlobals.position = self.global_position
	direction = Input.get_vector("left", "right", "up", "down")
	handle_movement(direction)
	handle_sword()
	
func handle_sword():
	if Input.is_action_just_pressed("main"):
		if (can_attack):
			can_attack = false
			sword = sword_scene.instantiate() as Area2D
			
			if facing == "down":
				$AnimatedSprite2D.play("use_down")
			elif facing == "up":
				$AnimatedSprite2D.play("use_up")
			elif facing == "left":
				$AnimatedSprite2D.scale = Vector2(-0.8,0.8)
				$AnimatedSprite2D.play("use_side")
			elif facing == "right":
				$AnimatedSprite2D.scale = Vector2(0.8,0.8)
				$AnimatedSprite2D.play("use_side")
				
			set_sword_pos()
			
			var tween = create_tween()
			tween.tween_property(sword, "rotation", sword.rotation + PI/2, 0.1)
			
			$Items.add_child(sword)
			
			var timer = sword.get_node("FullTimer")
			timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	$AnimatedSprite2D.play("walk_" + facing)
	can_attack = true
	
func handle_movement(dir):	
	if (dir.x != 0 or dir.y != 0):

		if not moving:
			$AnimatedSprite2D.frame = 1
			moving = true
			
		velocity = dir * speed
		move_and_slide()
		
		if can_attack:
			if (dir.y == -1.0):
				facing = "up"
			elif (dir.y == 1.0):
				facing = "down"
			elif (dir.x == -1.0):
				facing = "left"
			elif (dir.x == 1.0):
				facing = "right"
			elif (dir.y < 0):
				facing = "up"
			elif (dir.y > 0):
				facing = "down"
				
			if last_facing != facing or !$AnimatedSprite2D.is_playing():
				if facing == "left":
					$AnimatedSprite2D.scale = Vector2(-0.8,0.8)
				if facing == "right":
					$AnimatedSprite2D.scale = Vector2(0.8,0.8)
				$AnimatedSprite2D.play("walk_" + facing)
	else:
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.stop()
		moving = false
	
	if (sword != null):
		set_sword_pos()
	
	last_facing = facing

func set_sword_pos():
	if facing == "down":
		sword.scale = Vector2(1,1)
		sword.global_position = self.global_position + Vector2(0,6)
	elif facing == "up":
		sword.scale = Vector2(-1,-1)
		sword.global_position = self.global_position + Vector2(0,-6)
	elif facing == "left":
		sword.scale = Vector2(-1,1)
		sword.global_position = self.global_position + Vector2(-6,0)
	elif facing == "right":
		sword.scale = Vector2(1,-1)
		sword.global_position = self.global_position + Vector2(6,0)
