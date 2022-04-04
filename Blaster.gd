class_name Blaster

extends Area2D

var active = false
var mouse_over = false
var being_dragged = false
const LINERES = 15
const line_curve = preload("res://LineCurve.tres")
onready var game = get_parent()
onready var line = $Line2D
onready var plug = $Plug
onready var sfx = $SFX

func _ready():
    connect("mouse_entered", self, "on_mouse_enter")
    connect("mouse_exited", self, "on_mouse_exit")

func _process(delta):
    if line.get_point_count() > 0:
        line.clear_points()
    plug.visible = being_dragged
    if being_dragged:
        var mouse = get_local_mouse_position()
        for i in range(LINERES + 1):
            line.add_point(Vector2(
                lerp(0, mouse.x, range_lerp(i, 0, LINERES, 0, 1)),
                lerp(0, mouse.y, line_curve.interpolate_baked(
                    range_lerp(i, 0, LINERES, 0, 1)))))
        plug.position = get_local_mouse_position()
    work(delta)

func work(delta):
    pass

func _input(event):
    if mouse_over and event.is_action_pressed("click"):
        if active:
            game.unplug(self)
            being_dragged = true
        else:
            being_dragged = true
        sfx.pitch_scale = rand_range(1, 1.3)
        sfx.play()
    if being_dragged and event.is_action_released("click"):
        game.check_outlets(self)
        being_dragged = false

func on_mouse_enter():
    mouse_over = true

func on_mouse_exit():
    mouse_over = false
