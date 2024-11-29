extends Node


@export var label: Label

#@onready var viewport: Viewport = get_viewport()
@onready var window: Window = get_window()
@onready var initial_window_size: Vector2 = get_window().size


func _ready() -> void:
	if OS.get_name() == 'Android':
		var default_width = ProjectSettings.get_setting("display/window/size/viewport_width")
		var actual_width := DisplayServer.screen_get_size().x
		var width_ratio_rounded = round(float(actual_width) / default_width * 2) / 2
		#var message := """
		#AutoDisplayScaler:
			#default_width= %d,
			#actual_width= %d,
			#actual_width / default_width= %f,
			#round(actual_width / default_width * 2)= %f
			#width_ratio= %f
		#""" % [default_width, actual_width, actual_width / default_width, round(actual_width / default_width * 2), width_ratio_rounded]
		#label.text = message
		window.content_scale_factor = width_ratio_rounded
	else:
		#viewport.size_changed.connect(_on_resize)
		window.size_changed.connect(_on_resize)
		print('initial', initial_window_size)


func _on_resize() -> void:
	var window_size = window.size
	var width_dif: float = round(window_size.y / initial_window_size.y * 2) / 2
	print(width_dif)
	window.content_scale_factor = width_dif
	#window.content_scale_mode = 0
	#get_viewport().get_camera_2d().zoom = Vector2(width_dif, width_dif)
	#get_tree().root.content_scale_factor = 1.5
