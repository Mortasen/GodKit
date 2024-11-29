class_name PIDController

var K1: float
var K2: float
var K3: float

var previous_target_value
var speed

## f - speed of reaction to change
## z - settling
## r - initial reaction
func _init (
		initial_value,
		f_: float = 2.0,
		z_: float = 1.0,
		r_: float = 0.0,
		):
	K1 = z_ / (PI * f_)
	K2 = 1 / ((2 * PI * f_) * (2 * PI * f_))
	K3 = r_ * z_ / (2 * PI * f_)
	
	previous_target_value = initial_value
	speed = initial_value * 0

func update (
		previous_value,
		new_target_value,
		delta: float
):
	
	var input_speed = (new_target_value - previous_target_value) / delta
	previous_target_value = new_target_value
	
	var new_value = previous_value + delta * speed
	speed += delta * (new_target_value + K3 * new_target_value \
		- new_value - K1 * speed) / K2
	return new_value
