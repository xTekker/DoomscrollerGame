extends CharacterBody2D

#Controlable variables 
@export var Speed = 15.0
@export var run_speed = 50
@export var jump_impulse = -100
@export var gravity = 300

func _physics_process(delta):
	velocity.y += gravity * delta
	if Input.is_action_pressed("move_right"):
		velocity.x = 50
	elif Input.is_action_pressed("move_left"):
		velocity.x = -50
	else:
		velocity.x = 0
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y =  jump_impulse
		
	if Input.is_action_pressed("run_left"):
		velocity.x = -run_speed
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
		
	if Input.is_action_just_pressed("jump"):
		$AnimatedSprite2D.play("jump")
		
	if Input.is_action_pressed("run_left"):
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true
		
	elif Input.is_action_pressed("run_right"):
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = false
