extends CanvasLayer

onready var text = $Control/ColorRect/Label
onready var button = $Control/ColorRect/Button

onready var ohtext = $Ohno/ColorRect/Label
onready var countdown = $FinalDay
onready var ayo = $Ayo
var done = false

func skip():
    $Control.hide()
    get_parent().emit_signal("game_start")
    if Global.level == 4:
        done = true
        countdown.show()

func _ready():
    $Ohno.hide()
    $Control.show()
    $FinalDay.hide()
    if Global.level == 1:
        text.text = "Hello, new intern! Welcome abord the Duhmès Corporation!"
        yield(button, "pressed")
        ayo.play()
        text.text = "We are very pleased to have another qualified technician!"
        yield(button, "pressed")
        ayo.play()
        text.text = "The turnover rate for this area is insane, I tell you."
        yield(button, "pressed")
        ayo.play()
        text.text = "So anyway, your job is pretty simple."
        yield(button, "pressed")
        ayo.play()
        text.text = "Our company is constantly being attacked by monsters. (Don't ask)"
        yield(button, "pressed")
        ayo.play()
        text.text = "So, your job is just to keep the anti-monster gun plugged in. That's it."
        yield(button, "pressed")
        ayo.play()
        text.text = "Click and drag from the gun to the outlet to plug it in."
        yield(button, "pressed")
        ayo.play()
        text.text = "If you want to unplug it, just pull the plug out."
        yield(button, "pressed")
        ayo.play()
        text.text = "See? It's a breeze. You'll do amazing, don't worry!"
        yield(button, "pressed")
        ayo.play()
        text.text = "Enough talking. Now get to work. Remember, all you need to do is keep it plugged in."
        yield(button, "pressed")
        ayo.play()
        text.text = "I'll see you at the end of the day."
        yield(button, "pressed")
        $Control.hide()
        get_parent().emit_signal("game_start")
    if Global.level == 2:
        text.text = "Uh..."
        yield(button, "pressed")
        ayo.play()
        text.text = "So, that was a disaster."
        yield(button, "pressed")
        ayo.play()
        text.text = "We've never encountered that kind of monster before."
        yield(button, "pressed")
        ayo.play()
        text.text = "Luckily, we've just taken enough money off your salary to pay for a new gun!"
        yield(button, "pressed")
        ayo.play()
        text.text = "And also to compensate the families of the workers who were ruthlessly slaughtered in the attack..."
        yield(button, "pressed")
        ayo.play()
        text.text = "Anyway, you have a second gun now. Just plug in the right gun to kill the right monster."
        yield(button, "pressed")
        ayo.play()
        text.text = "We do still only have one outlet, so don't let it overheat please."
        yield(button, "pressed")
        ayo.play()
        text.text = "If you start smelling carbon out of a sudden, please unplug everything and wait."
        yield(button, "pressed")
        ayo.play()
        text.text = "I'll let you be, please please don't let that happen again."
        yield(button, "pressed")
        $Control.hide()
        get_parent().emit_signal("game_start")
    if Global.level == 3:
        text.text = "So you've failed us again."
        yield(button, "pressed")
        ayo.play()
        text.text = "Seriously, I don't know how much longer we can hold on before the lawsuits start coming."
        yield(button, "pressed")
        ayo.play()
        text.text = "You're the technician! You should already know all this! And be prepared for anything!"
        yield(button, "pressed")
        ayo.play()
        text.text = "..."
        yield(button, "pressed")
        ayo.play()
        text.text = "What's that? You thought you were being hired to maintain electrical fixtures, not defend against monsters?"
        yield(button, "pressed")
        ayo.play()
        text.text = "I don't know what you're talking about. This is a technical job. I got no time to learn this machinery!"
        yield(button, "pressed")
        ayo.play()
        text.text = "Anyway, I got you a new gun. And... an extender!! Now you can plug more stuff in and we don't need to install more outlets!"
        yield(button, "pressed")
        ayo.play()
        text.text = "Neat huh?"
        yield(button, "pressed")
        ayo.play()
        text.text = "Whoops, the monsters are calling. Go take care of that."
        yield(button, "pressed")
        $Control.hide()
        get_parent().emit_signal("game_start")
    if Global.level == 4:
        text.text = "Ughhhhh"
        yield(button, "pressed")
        ayo.play()
        text.text = "Those pink pricks are the worst."
        yield(button, "pressed")
        ayo.play()
        text.text = "They aren't blood-thirsty like the others but... once they enter..."
        yield(button, "pressed")
        ayo.play()
        text.text = "They just spread goop everywhere. Nasty."
        yield(button, "pressed")
        ayo.play()
        text.text = "So intern, I realize this job is maybe a bit more difficult than you'd have hoped?"
        yield(button, "pressed")
        ayo.play()
        text.text = "But I want to help you, I really do."
        yield(button, "pressed")
        ayo.play()
        text.text = "How about we make a deal?"
        yield(button, "pressed")
        ayo.play()
        text.text = "If you make it to the end of the day today, which is like, one minute..."
        countdown.show()
        yield(button, "pressed")
        ayo.play()
        text.text = "I'll let you upgrade your work place however you want!"
        yield(button, "pressed")
        ayo.play()
        text.text = "I'll let you install those new outlets you want so much."
        yield(button, "pressed")
        ayo.play()
        text.text = "Out of your pocket, of course."
        yield(button, "pressed")
        ayo.play()
        text.text = "All to make your job better! Sounds good?"
        yield(button, "pressed")
        ayo.play()
        text.text = "Great! Cause here they come!!!"
        yield(button, "pressed")
        $Control.hide()
        done = true
        get_parent().emit_signal("game_start")

func _process(delta):
    if Global.level == 4 and done:
        countdown.value -= delta
        if countdown.value <= 0:
            done = false
            get_parent().win_final()

func ohno():
    if Global.level == 1:
        yield(get_tree().create_timer(8), "timeout")
        $Ohno.show()
        ohtext.text = "??????"
        yield(get_tree().create_timer(3), "timeout")
        ohtext.text = "I've never seen these ones before?"
        yield(get_tree().create_timer(5), "timeout")
        ohtext.text = "Intern, you're the expert! Do something!!"
        yield(get_tree().create_timer(5), "timeout")
        ohtext.text = "Come on, figure it out! It's your job!"
        yield(get_tree().create_timer(7), "timeout")
        $Ohno.hide()
        get_parent().win = true
    if Global.level == 2:
        yield(get_tree().create_timer(8), "timeout")
        $Ohno.show()
        ohtext.text = "Oh no"
        yield(get_tree().create_timer(8), "timeout")
        $Ohno.hide()
        get_parent().win = true
    if Global.level == 3:
        yield(get_tree().create_timer(6), "timeout")
        $Ohno.show()
        ohtext.text = "Are you serious?!"
        yield(get_tree().create_timer(5), "timeout")
        ohtext.text = "INTERN IF YOU LET THESE PINK BASTARDS IN I SWEAR"
        yield(get_tree().create_timer(6), "timeout")
        $Ohno.hide()
        get_parent().win = true
