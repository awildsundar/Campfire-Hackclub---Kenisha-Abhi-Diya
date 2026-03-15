extends HBoxContainer
class_name FinalChoices
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var black_screen: ColorRect

func _on_button_pressed() -> void:
	audio.play()
	black_screen.show()
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
