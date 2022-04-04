extends Timer

export var enemy : PackedScene
export var spawn := 1.0 # Every 1s, an enemy spawns.
export var random := 1.0 # Random multiplier for enemy timer.
export var wave := 5 # Every 5 enemies, lots of enemies spawn.
export var min_wave := 10 # Minimum of enemies in wave.
export var max_wave := 20 # Maximum of enemies in wave.
export var level_start := 1
export var survive_till := 15

var times_spawned = 0

onready var game = get_parent()

func _ready():
    connect("timeout", self, "on_timeout")
    wait_time = spawn
    game.connect("game_start", self, "game_start")

func game_start():
    if Global.level >= level_start or Global.level == -1:
        start()
    elif Global.level + 1 == level_start:
        wave = 0
        spawn = 2
        min_wave = 1
        max_wave = 3
        yield(get_tree().create_timer(survive_till), "timeout")
        if game.get_node("Story"):
            game.get_node("Story").ohno()
        start()

func on_timeout():
    if times_spawned == wave:
        times_spawned = 0
        for i in range(rand_range(min_wave, max_wave)):
            var nme = enemy.instance()
            nme.position.y = rand_range(75, 320)
            nme.position.x = rand_range(1230, 1663)
            game.add_child(nme)
    else:
        var nme = enemy.instance()
        nme.position.y = rand_range(50, 320)
        nme.position.x = 1230
        game.add_child(nme)
        times_spawned += 1
        wait_time = rand_range(spawn / random, spawn * random)
        
