extends CharacterBody2D

#Controlable variables 
@export var Speed = 25.0
@export var run_speed = 50
@export var jump_impulse = -100
@export var gravity = 300

func _physics_process(delta):
	velocity.y += gravity * delta
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.flip_h = false
		velocity.x = Speed
	elif Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.flip_h = true
		velocity.x = -Speed
	else:
		velocity.x = 0
		
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y =  jump_impulse
		
	if Input.is_action_pressed("run_left"):
		velocity.x = -run_speed
		$AnimatedSprite2D.flip_h = true
	elif Input.is_action_pressed("run_right"):
		velocity.x = run_speed
		$AnimatedSprite2D.flip_h = false
		
	move_and_slide()
#Animation code 
func _process(_delta):
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = velocity.x < 0	
		
	elif Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = false
		
	if velocity.x == 0 and velocity.y == 0:
		$AnimatedSprite2D.play("idle1")
		
	if Input.is_action_just_pressed("jump") && is_on_floor():
		$AnimatedSprite2D.play("jump")
		
	if Input.is_action_pressed("run_left"):
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true
		
	elif Input.is_action_pressed("run_right"):
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = false
		
	if Input.is_action_pressed("fireattack"):
		$AnimatedSprite2D.play("attack")
