extends Node2D

var plugged = 0
var lives = 3
onready var fire = $FireHazard
onready var fire_anim = $FireHazard/Anim
var time_survived = 0
var lost = false
onready var vignette = $Vignette
onready var smoke1 = $Smoke
onready var smoke2 = $Smoke2
onready var smoke3 = $Smoke3
var win = false

signal game_start

func _ready():
    if Global.level == 1:
        $OutletExtender.texture = load("res://Outlet.png")
        $Outlet1.queue_free()
        $Outlet3.queue_free()
        $TriangleB.queue_free()
        $SquareB.queue_free()
        $CubicB.queue_free()
    if Global.level == 2:
        $OutletExtender.texture = load("res://Outlet.png")
        $Outlet1.queue_free()
        $Outlet3.queue_free()
        $SquareB.queue_free()
        $CubicB.queue_free()
    if Global.level == 3:
        $CubicB.queue_free()
    if Global.level == -1:
        $Story.queue_free()
        emit_signal("game_start")

func _process(delta):
    time_survived += delta
    if plugged > 0:
        fire.value += plugged * 2 * delta
        if fire.value > 40:
            smoke1.emitting = true
        if fire.value > 60:
            smoke2.emitting = true
        if fire.value > 80:
            smoke3.emitting = true
            if not fire_anim.current_animation == "Blink":
                fire_anim.play("Blink")
        if fire.value >= 100:
            lose()
    else:
        if fire.value > 0:
            fire.value -= delta * 10
            if fire.value < 40:
                smoke1.emitting = false
            if fire.value < 60:
                smoke2.emitting = false
            if fire.value < 80:
                smoke3.emitting = false
                if fire_anim.current_animation == "Blink":
                    fire_anim.play("RESET")
    vignette.modulate.a = range_lerp(fire.value, 50, 100, 0, 1)

func check_outlets(blaster):
    for outlet in get_tree().get_nodes_in_group("outlet"):
        if outlet.mouse_over:
            outlet.line.default_color = blaster.line.default_color
            outlet.plug(blaster)
            break

func unplug(blaster):
    for outlet in get_tree().get_nodes_in_group("outlet"):
        if outlet.plugged == blaster:
            outlet.unplug()
            break

func hurt():
    if not lost:
        if has_node("Life" + str(lives)):
            get_node("Life" + str(lives)).queue_free()
        lives -= 1
        $Damage.play()
        $Hurt/Anim.play("Hurt")
        $Camera2D.shake(0.6, 30, 4)
        if lives <= 0:
            lose()

func lose():
    if not lost:
        lost = true
        $Lose/SFX.play()
        $Damage.play()
        $Music.pitch_scale = 0.3
        $Lose/Control/Fade/Label.text = "You lasted\n" + str(stepify(time_survived, 0.01)) + "\nseconds."
        var rec = "Your record: "
        if Global.level == -1:
            if Global.record < time_survived:
                Global.record = time_survived
                $Hooray.play()
                rec = "New record! "
            $Lose/Control/Fade/Record.text = rec + str(stepify(Global.record, 0.01)) + "s"
        else:
            $Lose/Control/Fade/Record.hide()
        $Lose/Anim.play("Go")
        $Camera2D.shake(2, 30, 4)
        if has_node("Outlet1"):
            $Outlet1.unplug(lost)
        if has_node("Outlet2"):
            $Outlet2.unplug(lost)
        if has_node("Outlet3"):
            $Outlet3.unplug(lost)
        if fire.value > 95:
            $OutletExtender/Anim.play("Explode")
        if has_node("Story"):
            $Story.queue_free()

func retry():
    if win and Global.level > 0:
        Global.level += 1
    get_tree().reload_current_scene()

func menu():
    get_tree().change_scene("res://Menu.tscn")

func win_final():
    $CubicSpawner.queue_free()
    $RoundSpawner.queue_free()
    $SquareSpawner.queue_free()
    $TriangleSpawner.queue_free()
    for i in get_tree().get_nodes_in_group("enemy"):
        i.queue_free()
    if has_node("Outlet1"):
        $Outlet1.unplug(true)
    if has_node("Outlet2"):
        $Outlet2.unplug(true)
    if has_node("Outlet3"):
        $Outlet3.unplug(true)
    $Hooray.play(0.24)
    $Music.stop()
    $YouWin/Anim.play("Go")
    yield(get_tree().create_timer(5), "timeout")
    get_tree().change_scene("res://FinalCutscene.tscn")
