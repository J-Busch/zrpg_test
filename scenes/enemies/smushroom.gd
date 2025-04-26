extends Enemy

func hit(damage: int, body: CharacterBody2D):
	super.hit(damage, body)
	body.get_node("AnimationPlayer").play("take_damage")
	
