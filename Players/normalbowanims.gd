extends CharacterBody2D

#Animation OnReady Variables
@onready var aplay = $AnimationPlayer
@onready var atree = $AnimationTree
@onready var sprite = $Sprite2D

var can_shoot = true
var shoot_cooldown = 1.2
@export var IceArrow : PackedScene
#Shooting Code
func update_animation_parameters():
#_________________Start Movement Animation Code
#Walking Animation code
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		atree["parameters/conditions/N_is_walking"] = true
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
