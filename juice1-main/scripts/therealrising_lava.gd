extends Area2D



func _on_body_entered(body):
	if body.is_in_group("player"):  
		var lava = get_parent().get_node("rising lava")

		lava.start_rising() 
