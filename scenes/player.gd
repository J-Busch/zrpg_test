extends CharacterBody2D

var speed: int = 60
var direction: Vector2
var moving: bool = false
var facing: String = "down"
var last_facing: String = "down"
var sword_scene: PackedScene = preload("res://scenes/items/sword.tscn")
var sword: Area2D
var bomb_scene: PackedScene = preload("res://scenes/items/bomb.tscn")
var bomb: CharacterBody2D
var can_attack: bool = true

func _ready() -> void:
	PlayerGlobals.connect("player_hit", handle_player_hit)
	
func handle_player_hit():
	$AnimationPlayer.play("take_damage")
		

func _process(_delta):
	PlayerGlobals.position = self.global_position
	direction = Input.get_vector("left", "right", "up", "down")
	handle_movement(direction)
	handle_use()
	
func handle_use():
	if Input.is_action_just_pressed("main") and can_attack:
		can_attack = false
		sword = sword_scene.instantiate() as Area2D
		
		set_use_dir()
		set_use_pos(sword, true, 6)
		
		var tween = create_tween()
		tween.tween_property(sword, "rotation", sword.rotation + PI/2, 0.1)
		
		$Items.add_child(sword)
		
		var timer = sword.get_node("FullTimer")
		timer.timeout.connect(_on_timer_timeout)
	elif Input.is_action_just_pressed("secondary") and can_attack and PlayerGlobals.has_bombs and PlayerGlobals.bombs > 0:
		can_attack = false
		PlayerGlobals.bombs -= 1
		bomb = bomb_scene.instantiate() as CharacterBody2D
		
		set_use_dir()
		set_use_pos(bomb, false, 10)
		
		$Items.add_child(bomb)
		
		await get_tree().create_timer(0.25).timeout
		_on_timer_timeout()
		
func set_use_dir():
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
		set_use_pos(sword, true, 6)
	
	last_facing = facing

func set_use_pos(useable, rotated, dist):
	if facing == "down":
		if rotated:
			useable.scale = Vector2(1,1)
		useable.global_position = self.global_position + Vector2(0,dist)
	elif facing == "up":
		if rotated:
			useable.scale = Vector2(-1,-1)
		useable.global_position = self.global_position + Vector2(0,-dist)
	elif facing == "left":
		if rotated:
			useable.scale = Vector2(-1,1)
		useable.global_position = self.global_position + Vector2(-dist,0)
	elif facing == "right":
		if rotated:
			useable.scale = Vector2(1,-1)
		useable.global_position = self.global_position + Vector2(dist,0)
