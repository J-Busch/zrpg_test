extends Area2D

func _ready():
	$FullTimer.start()

func _on_swing_timer_timeout() -> void:
	$CollisionShape2D.set_deferred("disabled", true)

func _on_full_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("hit"):
		body.hit(20, body)
