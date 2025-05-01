extends CanvasLayer

var index = 0
var changed = false
var talking = false
var in_menu = false
var menu = []
var cursor_pos = 0
var dia = ""

func _process(_delta: float) -> void:
	if changed and talking:
		if index < dia.size():
			if dia[index] is String:
				$MarginContainer/Label.text = dia[index]
				changed = false
			if dia[index] is Array:
				$MarginContainer/Label.text = ""
				in_menu = true
				for i in range(dia[index].size()):
					var label = Label.new()
					label.text = dia[index][i]
					menu.append(dia[index][i])
					label.add_theme_font_size_override("font_size", 30)
					label.add_theme_color_override("font_color", "2a2a2a")
					$MarginContainer/HBoxContainer.add_child(label)
				var cur_label = $MarginContainer/HBoxContainer.get_child(cursor_pos)
				cur_label.add_theme_color_override("font_color", "f12728")
				changed = false
		else:
			index = 0
			talking = false
			stop_talking()
		
	if Input.is_action_just_pressed("action") and talking:
		index += 1
		changed = true
		
	if in_menu:
		if Input.is_action_just_pressed("right") and cursor_pos < menu.size()-1:
			var prev_label = $MarginContainer/HBoxContainer.get_child(cursor_pos)
			prev_label.add_theme_color_override("font_color", "2a2a2a")
			
			cursor_pos += 1
			
			var cur_label = $MarginContainer/HBoxContainer.get_child(cursor_pos)
			cur_label.add_theme_color_override("font_color", "f12728")
		if Input.is_action_just_pressed("left") and cursor_pos > 0:
			var prev_label = $MarginContainer/HBoxContainer.get_child(cursor_pos)
			prev_label.add_theme_color_override("font_color", "2a2a2a")
			
			cursor_pos -= 1
			
			var cur_label = $MarginContainer/HBoxContainer.get_child(cursor_pos)
			cur_label.add_theme_color_override("font_color", "f12728")
		if Input.is_action_just_pressed("action"):
			var cur_label = $MarginContainer/HBoxContainer.get_child(cursor_pos)
			in_menu = false
			print(cur_label.text)
			
			#HANDLE
			#BUY
			#BOMBS
	

func talk(dialogue):
	get_tree().paused = true
	self.visible = true
	$RectAnimation.play("blink")
	dia = dialogue
	talking = true
	changed = true

func stop_talking():
	get_tree().paused = false
	delete_all_children($MarginContainer/HBoxContainer)
	talking = false
	menu = []
	cursor_pos = 0
	$RectAnimation.stop()
	self.visible = false

func delete_all_children(node: Node) -> void:
	for child in node.get_children():
		child.queue_free()
