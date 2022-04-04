extends Area2D

var mouse_over = false
var plugged = null
const LINERES = 15
const line_curve = preload("res://LineCurve.tres")
onready var game = get_parent()
onready var line = $Line2D
onready var sprite = get_parent().get_node("OutletExtender/" + name)
onready var sfx = $SFX

func _ready():
    connect("mouse_entered", self, "on_mouse_enter")
    connect("mouse_exited", self, "on_mouse_exit")
        
func plug(blaster):
    if plugged == null:
        game.plugged += 1
    else:
        plugged.active = false
    
    sfx.play()
    
    plugged = blaster
    plugged.active = true
    sprite.visible = true
    var blast = to_local(plugged.global_position)
    line.clear_points()
    for i in range(LINERES + 1):
        line.add_point(Vector2(
            lerp(0, blast.x, range_lerp(i, 0, LINERES, 0, 1)),
            lerp(0, blast.y, line_curve.interpolate_baked(
                range_lerp(i, 0, LINERES, 0, 1)))))

func unplug(lost = false):
    if plugged != null:
        game.plugged -= 1
        plugged.being_dragged = !lost
        plugged.active = false
        plugged = null
        sprite.visible = false
        line.clear_points()

func _input(event):
    if event.is_action_pressed("click") and mouse_over and plugged != null:
        unplug()

func on_mouse_enter():
    mouse_over = true

func on_mouse_exit():
    mouse_over = false
