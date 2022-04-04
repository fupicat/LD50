extends Area2D

export var speed = 150

var target
var origin
onready var sprite = $Sprite
const HIT = preload("res://SFX/hitHurt.wav")

func shoot(org, tgt):
    position = org.position
    origin = org
    target = tgt
    connect("area_entered", self, "on_area_entered")
    target.get_node("Anim").play("Blink")

func _process(delta):
    if sprite.visible:
        if target == null:
            queue_free()
            return
        if target.position.x < 0:
            queue_free()
        if target != null:
            look_at(target.position)
        position += Vector2(speed * delta, 0).rotated(rotation)

func on_area_entered(area):
    if area == target:
        area.queue_free()
        $Col.queue_free()
        sprite.visible = false
        $SFX.stream = HIT
        $SFX.connect("finished", self, "queue_free")
        $Boom.emitting = true
        $SFX.play()
