extends Blaster

export var secs_to_shoot = 0.3
export var bullet : PackedScene
export var group : String
var timer = 0
onready var meter = $Icon/Time

class CustomSort:
    static func closest(a, b):
        return a.position.x < b.position.x

func work(delta):
    if active:
        if timer < secs_to_shoot:
            timer += delta
        else:
            timer = 0
            var target = null
            var target_list = get_tree().get_nodes_in_group(group)
            target_list.sort_custom(CustomSort, "closest")
            for enemy in target_list:
                if !enemy.targeted:
                    enemy.targeted = true
                    target = enemy
                    break
            if target != null:
                var bull = bullet.instance()
                game.add_child(bull)
                bull.shoot(self, target)
    else:
        if timer > 0:
            timer -= delta
    meter.value = range_lerp(timer, 0, secs_to_shoot, 0, 100)
