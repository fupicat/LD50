extends Camera2D

var shake = false
var time_spent = 0
var shake_time = 1.0
var pan_int = 5.0
var rotate_int = 10.0

func _process(delta):
    if shake:
        offset = Vector2(
            lerp(
                rand_range(-pan_int, pan_int), 0,
                range_lerp(time_spent, 0, shake_time, 0, 1)),
            lerp(
                rand_range(-pan_int / 2, pan_int / 2), 0,
                range_lerp(time_spent, 0, shake_time, 0, 1)))
        rotation_degrees = lerp(
            rand_range(-rotate_int, rotate_int), 0,
            range_lerp(time_spent, 0, shake_time, 0, 1))
        time_spent += delta
        if time_spent > shake_time:
            shake = false

func shake(time, pan, rot):
    shake = true
    shake_time = time
    pan_int = pan
    rotate_int = rot
    time_spent = 0
