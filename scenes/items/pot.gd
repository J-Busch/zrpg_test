extends StaticBody2D

func hit(_damage, body):
	if body.is_in_group("Pot"):
		Utilities.item_gen($Marker2D)
		queue_free()
