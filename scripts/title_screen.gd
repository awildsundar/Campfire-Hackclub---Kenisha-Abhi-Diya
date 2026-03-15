extends Control

@onready var credits: PanelContainer = $PanelContainer
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	credits.hide()

func _on_button_pressed() -> void:
	audio.play()
	get_tree().change_scene_to_file("res://scenes/days/Day1.tscn")


func _on_button_2_pressed() -> void:
	audio.play()
	credits.show()


func _on_exit_button_pressed() -> void:
	audio.play()
	credits.hide()
