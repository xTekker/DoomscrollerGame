extends Camera2D

var player

func _ready():
	player = get_node("/root/HomeLevel/Archer")
	
func _process(_delta):
	if player:
		# Calculate the target position for the camera
		var target_position = player.global_position
		# Set the camera's position to match the player's position
		global_position = target_position
