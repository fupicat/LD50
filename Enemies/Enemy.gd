extends Area2D

export var speed = 100
onready var game = get_parent()
var targeted = false

func _process(delta):
    position.x -= speed * delta
    if position.x < -50:
        game.hurt()
        queue_free()
