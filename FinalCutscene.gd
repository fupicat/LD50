extends Control

const TEXTS = [
    "Congrats, you did it!!",
    "See? You were made for this job, really.",
    "Now let me see the changes you made to your workplace.",
    "...",
    "Oh, very nice, there's plenty of new outlets now.",
    "Enough for all the weapons!",
    "No overheating too anymore? Awesome!",
    "I don't know how you nerds do it, seriously.",
    "...",
    "So now we can plug in every weapon at the same time? No issues?",
    "No way??!",
    "Oh that's great to hear.",
    "That means we don't need anyone to watch over them anymore!",
    "...",
    "so",
    "I guess you're fired."
   ]
var text = 0

func _ready():
    $Label.hide()
    $Next.hide()
    yield(get_tree().create_timer(2.7), "timeout")
    $Ayo.play()
    $Label.text = TEXTS[0]
    $Label.show()
    $Next.show()

func next():
    text += 1
    if text < len(TEXTS):
        $Label.text = TEXTS[text]
        $Ayo.play()
    else:
        $Label.hide()
        $Next.hide()
        $Lose/Anim.play("Go")
        $Lose/SFX.play()

func menu():
    get_tree().change_scene("res://Menu.tscn")
