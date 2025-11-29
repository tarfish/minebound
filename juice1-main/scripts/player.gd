extends CharacterBody2D


@export var speed = 200
@export var gravity: int = 200
@export var jump_height = -300
@onready var healthBar = $HealthBar
var is_attacking = false
var is_climbing = false
var hit = false
var death = false
var immortality = false
var is_animating
var maxHealth = 100
var health = 100
var attack_in_progress = false
var attack_cooldown = 0.5
var can_attack = true
@export var attack_damage := 10
@onready var attack_area = $AttackArea
var slowfall: bool = velocity.y > 0 and Input.is_action_pressed("jump")




func _process(_delta):
	
	if Input.is_action_just_pressed("ui_attack"):
		
		attack()
	if Global.plantkill == true:
		Global.plantkill = false
		self.hide()
		set_physics_process(false)
		
		
func attack():
		for body in attack_area.get_overlapping_bodies():
			if body.is_in_group("enemies"):
				print("hi")
				body.take_damage(10)
				
		



			
	
	
			
			


func _ready():
	healthBar.set_health_bar(health, maxHealth)
	Global.playerBody = self
	
	
	
	

func _physics_process(delta): 
	
	if not is_on_floor():
	
		velocity.y += gravity * delta * (0.75 if slowfall else 1)
	velocity.y += gravity * delta
	horizontal_movement()
	move_and_slide()
	if !is_attacking:
		player_animations() 

	


func horizontal_movement():
	var horizontal_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = horizontal_input * speed
	

		
func player_animations():
	if Input.is_action_pressed("ui_left") || Input.is_action_just_released("ui_jump"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("run")
		
	if Input.is_action_pressed("ui_right") || Input.is_action_just_released("ui_jump"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("run")
		
	if !Input.is_anything_pressed() and hit == false:
		$AnimatedSprite2D.play("idle")
		
func _input(event):
	if event.is_action_pressed("ui_attack") and $AnimatedSprite2D.animation_finished:
		is_attacking = true
		$AnimatedSprite2D.play("attack")
		if $AnimatedSprite2D.flip_h == false:
			get_node("AttackArea/right").disabled = false
			get_node("AttackArea/left").disabled = true
		if $AnimatedSprite2D.flip_h == true:
			get_node("AttackArea/left").disabled = false
			get_node("AttackArea/right").disabled = true
		
			
		

	if event.is_action_pressed("ui_jump") and is_on_floor() and !is_attacking:
		velocity.y = jump_height
		$AnimatedSprite2D.play("jump")
	
	if is_climbing == true:
		if Input.is_action_pressed("ui_up"):
			$AnimatedSprite2D.play("climb")
			gravity = 100
			velocity.y = -200
		else:
			gravity = 200
			is_climbing = false
	

func take_damage(damage:int):
	if health > 0 and immortality == false:
		health -= damage
		healthBar.change_health(-damage)
		$AnimatedSprite2D.play("damage")
		set_physics_process(false)
		immortality = true
	if health <= 0:
		$AnimatedSprite2D.play("death2")
		
func burn():
	$AnimatedSprite2D.play("death1")
		
		
	

	

func _on_animated_sprite_2d_animation_finished():
	
	
	is_attacking = false
	

	
	set_physics_process(true)
	immortality = false
	if health <= 0:
		get_tree().reload_current_scene()
	


	
	
	
