extends RigidBody2D

@export var damage_to_player := 100
var initial_position: Vector2



func _ready():
	await get_tree().process_frame
	initial_position = global_position
	apply_impulse(Vector2(-300, 0))  # Apply force to start rolling
	gravity_scale = 2.0  # Keeps it grounded
	linear_damp = 0.0  # No artificial slowdown
	angular_damp = 0.0  # No artificial rotation stop

func _physics_process(delta):
	
	if linear_velocity.length() > 0.1:  # Only apply rotation if moving
		angular_velocity = linear_velocity.x / 50.0  # Adjust for realistic rolling

func _on_body_entered(body):
	if body.is_in_group("player"):  # Make sure it's the player
		body.take_damage(damage_to_player)  # Call take_damage on the player
func teleport(new_position: Vector2):
	  # Temporarily disable physics
	global_position = new_position  # Instantly move to new position
	  # Re-enable physics



		
