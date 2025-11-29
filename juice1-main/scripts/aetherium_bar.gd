extends AnimatedSprite2D


func _process(_delta):
	if Global.done1 == true and Global.done2 == false:
		play("1")
	if Global.done2 == true and Global.done3 == false:
		play("2")
	if Global.done3 == true and Global.done4 == false:
		play("3")
	if Global.done4 == true and Global.done5 == false:
		play("4")
