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
