extends Node2D

@onready var BGmusic : AudioStreamPlayer = $CanvasLayer/AudioStreamPlayer
@onready var TitleAnimation : AnimationPlayer = $CanvasLayer/Global/MenuPrincipal/Title/AnimationPlayer

@onready var MenuPrincipal : Control = $CanvasLayer/Global/MenuPrincipal
@onready var Instruciones : Control = $CanvasLayer/Global/Instructions

#control var 
var GM : GameManager = GameManager.instance

# Called when the node enters the scene tree for the first time.
func _ready():
	BGmusic.play()
	TitleAnimation.play("Intro")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_short_night_pressed():
	GM.dificultyTime = 6
	GM._ChangeScene(2)


func _on_long_night_pressed():
	GM._ChangeScene(2)
	
	
func _on_instructions_pressed():
	MenuPrincipal.visible = false
	Instruciones.visible = true
	pass # Replace with function body.


func _on_back_pressed():
	Instruciones.visible = false
	MenuPrincipal.visible = true
	pass # Replace with function body.



