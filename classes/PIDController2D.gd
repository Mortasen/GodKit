class_name PIDController2D

var K1: float
var K2: float
var K3: float

var previous_target_pos: Vector2
var speed: Vector2

## f - speed of reaction to change
## z - settling
## r - initial reaction
func _init (
		f_: float = 2.0,
		z_: float = 1.0,
		r_: float = 0.0,
		initial_pos: Vector2 = Vector2.ZERO
		):
	K1 = z_ / (PI * f_)
	K2 = 1 / ((2 * PI * f_) * (2 * PI * f_))
	K3 = r_ * z_ / (2 * PI * f_)
	
	previous_target_pos = initial_pos
	speed = Vector2.ZERO

func calculate (
		previous_pos: Vector2,
		new_target_pos: Vector2,
		delta: float
) -> Vector2:
	
	var input_speed = (new_target_pos - previous_target_pos) / delta
	previous_target_pos = new_target_pos
	
	var new_pos = previous_pos + delta * speed
	speed += delta * (new_target_pos + K3 * new_target_pos \
		- new_pos - K1 * speed) / K2
	return new_pos
