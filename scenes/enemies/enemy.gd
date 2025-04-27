extends CharacterBody2D
class_name Enemy

var health: int = 100
var damage: int = 10
var speed = 60
var launch_distance: int = 250
var launch_vel: Vector2 = Vector2(0,0)
var player_in: bool = false

func _process(delta: float) -> void:
	if launch_vel != Vector2.ZERO:
		move_and_collide(launch_vel * delta)
		await get_tree().create_timer(0.1).timeout
		velocity = Vector2.ZERO
		launch_vel = Vector2.ZERO
	
	if (health <= 0):
		queue_free()
		
	if player_in:
		PlayerGlobals.health -= damage

func hit(damage: int, _body: CharacterBody2D):
	health -= damage
	var launch_dir = (self.position - PlayerGlobals.position).normalized()
	launch_vel = launch_dir * launch_distance

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in = false
