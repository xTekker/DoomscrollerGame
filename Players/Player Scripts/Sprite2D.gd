extends CharacterBody2D

#Animation OnReady Variables
@onready var aplay = $AnimationPlayer
@onready var atree = $AnimationTree
@onready var sprite = $Sprite2D
#Arrow OnReady Variables

#Movement OnReady Variables
@export var Speed = 25.0
@export var run_speed = 50
@export var jump_impulse = -100
@export var gravity = 300
#Fire Rate and Arrow Variables
@export var IceArrow : PackedScene
var can_shoot = true
var shoot_cooldown = 1.2

func _ready():
	atree.active = true
func _process(delta):
	update_animation_parameters()
	
func _physics_process(delta):
	
	velocity.y += gravity * delta
	if Input.is_action_pressed("move_right"):
		$Sprite2D.flip_h = false
		velocity.x = Speed
	elif Input.is_action_pressed("move_left"):
		$Sprite2D.flip_h = true
		velocity.x = -Speed
	else:
		velocity.x = 0
		
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y =  jump_impulse
		
	if Input.is_action_pressed("run_left"):
		velocity.x = -run_speed
		$Sprite2D.flip_h = true
	elif Input.is_action_pressed("run_right"):
		velocity.x = run_speed
		$Sprite2D.flip_h = false
		
	move_and_slide()
	is_on_floor()
#Shooting Code
func update_animation_parameters():
#_________________Start Movement Animation Code
#Walking Animation code
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		atree["parameters/conditions/is_walking"] = true
		atree["parameters/conditions/is_not_walking"] = false
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		atree["parameters/conditions/is_walking"] = false
		atree["parameters/conditions/is_not_walking"] = true
#Running Animation Code
	if Input.is_action_pressed("run_left") or Input.is_action_pressed("run_right"):
		atree["parameters/conditions/is_running"] = true
		atree["parameters/conditions/is_walking"] = false
		atree["parameters/conditions/is_not_running"] = false
	if Input.is_action_just_released("run_left") or Input.is_action_just_released("run_right"):
		atree["parameters/conditions/is_running"] = false
		atree["parameters/conditions/is_not_running"] = true
#Jumping Animation Code
	if Input.is_action_pressed("jump"):
		atree["parameters/conditions/is_jumping"] = true
		atree["parameters/conditions/is_not_jumping"] = false
	if Input.is_action_just_released("jump"):
		atree["parameters/conditions/is_jumping"] = false
		atree["parameters/conditions/is_not_jumping"] = true
		
#_________________Start Combat Animation Code
#Melee Attack Animation Code
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		atree["parameters/conditions/idleattack"] = true
		atree["parameters/conditions/melee2idle"] = false
		await get_tree().create_timer(0.45).timeout
		atree["parameters/conditions/idleattack"] = false
		atree["parameters/conditions/melee2idle"] = true
#Shooting Animation Code
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and can_shoot:
		atree["parameters/conditions/icebow_yes"] = true
		atree["parameters/conditions/icebow_return"] = false
		shoot()
		can_shoot = false
		$Timer.start(shoot_cooldown)  # Start a timer for the cooldown
		
func _on_Timer_timeout():
	can_shoot = true
	atree["parameters/conditions/icebow_yes"] = false
	atree["parameters/conditions/icebow_return"] = true
	
func shoot():
	var b = IceArrow.instantiate()
	add_child(b)
	b.transform = $Marker2D.transform	
#_________________Start Healing Animation Code
#Item Use Animation Code
