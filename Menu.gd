extends Node2D

onready var logo = $Logo
onready var logo2 = $Logo/FireHazard

func _process(delta):
    logo.position.x = sin(OS.get_ticks_msec() / 800.0) * 15
    logo.position.y = sin(OS.get_ticks_msec() / 1300.0) * 15
    logo2.rotation_degrees = sin(OS.get_ticks_msec() / 1300.0) * 2

func endless():
    Global.level = -1
    get_tree().change_scene("res://Main.tscn")

func story():
    Global.level = 1
    get_tree().change_scene("res://Main.tscn")
