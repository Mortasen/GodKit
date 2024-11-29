extends Camera2D


func _ready() -> void:
	if not get_viewport().get_camera_2d():
		print("Camera not found. Enabling debugging camera.")
		enabled = true
		
