extends CanvasLayer

func change_scene(target: String):
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("fade")

func you_died():
	get_tree().paused = true
	$DeathRect.color.a = 0.5
	$PauseTimer.start()

func _on_pause_timer_timeout() -> void:
	$DeathTimer.start()
	$DeathRect.color.a = 0
	$AnimationPlayer.play("fade")
	$LabelAnimation.play("fade")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/outside.tscn")

func _on_death_timer_timeout() -> void:
	PlayerGlobals.health = 100
	PlayerGlobals.money = 0
	PlayerGlobals.position = Vector2.ZERO
	get_tree().paused = false
	$AnimationPlayer.play_backwards("fade")
	$LabelAnimation.play_backwards("fade")
