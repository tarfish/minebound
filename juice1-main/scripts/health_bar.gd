extends ProgressBar

@onready var label = $Label

func set_health_bar(health,health_max):
	max_value = health_max
	value = health
	
	label.text = str(health)

func change_health(newValue):
	value += newValue
	label.text = str(value)
