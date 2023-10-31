extends Button

@export var audio : AudioStreamPlayer 


func _ready():
	self.pressed.connect(_ChangeSceneToTitle)
	if audio:
		audio.play()
	
func _ChangeSceneToTitle():
	GameManager.instance._ChangeScene(1)
