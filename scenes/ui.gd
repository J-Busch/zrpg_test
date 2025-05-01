extends CanvasLayer

func _ready():
	PlayerGlobals.connect('update_ui', update_ui)
	update_ui()

func update_ui():
	# update health
	var progress_label = $MarginContainer/HBoxContainer/VBoxContainer/Control/ProgressBar
	progress_label.value = PlayerGlobals.health
	
	var money_label = $MarginContainer/HBoxContainer/VBoxContainer2/Label2
	money_label.text = str(PlayerGlobals.money)
	
	if PlayerGlobals.has_bombs:
		$MarginContainer/HBoxContainer/VBoxContainer3.visible = true
		$ColorRect.size = Vector2(290, 123)
		$MarginContainer/HBoxContainer/VBoxContainer/Control/ProgressBar.set_size(Vector2(85,12))
		var bomb_label = $MarginContainer/HBoxContainer/VBoxContainer3/Label2
		bomb_label.text = str(PlayerGlobals.bombs)
	else:
		$MarginContainer/HBoxContainer/VBoxContainer3.visible = false
		$ColorRect.size = Vector2(260, 112)
		$MarginContainer/HBoxContainer/VBoxContainer/Control/ProgressBar.set_size(Vector2(148,12))
