extends CanvasLayer

func _ready():
    if OS.has_feature("web"):
        $Web.show()
        $TextureRect.hide()
