extends Control
class_name ShopUI

@export var money_display: Label
@export var clock_out_display: HBoxContainer
@export var clock_out_text: Label

@onready var change_scene_button: Button = $MarginContainer/Panel/VBoxContainer/Info/HBoxContainer/Button
@onready var clock_out_container: HBoxContainer = $MarginContainer/Panel/VBoxContainer/Info/HBoxContainer
@onready var black_screen: ColorRect = $BlackScreen
@onready var button_sfx: AudioStreamPlayer = $button_sfx
@onready var money_sfx: AudioStreamPlayer = $money_sfx

enum ActionType {ADD, SUBTRACT, SET}
var player: Player = null
var money: float = 0.0
var rate: float = 50.0
var next_level: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clock_out_display.hide()
	position.y = 1080
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2.ZERO, 0.25).set_trans(
		Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	money = player.money
	money_display.text = "$" + str(money) + " / " + str(player.owner.quota)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func change_money(amount: float, action: ActionType) -> void:
	match action:
		ActionType.ADD:
			money += amount
		ActionType.SUBTRACT:
			money -= amount
		ActionType.SET:
			money = amount
	player.money = money
	money_display.text = "$" + str(money) + " / " + str(player.owner.quota)
	
	if player.owner.quota_reached(player.money) == true:
		clock_out_display.show()
		if player.owner.day_number == 5:
			clock_out_text.text = "We'd like to promote you..."
			change_scene_button.queue_free()
			var choices = preload("res://scenes/final_choice.tscn").instantiate()
			choices.black_screen = black_screen
			clock_out_container.add_child(choices)
			
	

func _on_exit_button_pressed() -> void:
	button_sfx.play()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(0.0, 1080.0), 0.25).set_trans(
		Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	await tween.finished
	queue_free()

func _on_convert_pressed() -> void:
	money_sfx.play()
	var converted: float = player.ore * rate
	change_money(converted, ShopUI.ActionType.ADD)
	player.ore = 0

func _on_clock_out_pressed() -> void:
	button_sfx.play()
	get_tree().change_scene_to_packed(next_level)
