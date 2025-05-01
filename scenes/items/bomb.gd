extends CharacterBody2D

var launch_vel = Vector2.ZERO
var launch_distance: int = 250
var damage = 50

func _ready():
	$FuseTimer.start()
	
func _process(delta):
	if launch_vel != Vector2.ZERO:
		move_and_collide(launch_vel * delta)
		await get_tree().create_timer(0.1).timeout
		velocity = Vector2.ZERO
		launch_vel = Vector2.ZERO

func hit(_damage, _body):
	var launch_dir = (self.position - PlayerGlobals.position).normalized()
	launch_vel = launch_dir * launch_distance

func _on_explosion_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		PlayerGlobals.health -= damage
	elif body.is_in_group("Enemy") or body.name == "Pot":
		body.hit(damage, body)
	elif body.name == "Boulder":
		body.queue_free()


func _on_fuse_timer_timeout() -> void:
	$ExplosionArea/CollisionShape2D.disabled = false
	$ExplosionSprite.visible = true
	var tween = create_tween()
	tween.tween_property($ExplosionSprite, "rotation", PI, 0.3)
	await get_tree().create_timer(0.3).timeout
	queue_free()
