extends Area2D



func _on_body_entered(body):
	if body.is_in_group("player"):  
		var lava = get_parent().get_node("rising lava")
		var lava2 = get_parent().get_node("rising lava2")
 
		lava.start_rising() 
		lava2.start_rising()
