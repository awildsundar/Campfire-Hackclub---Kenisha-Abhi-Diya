extends Control
class_name ShopUI

@onready var money_display: Label = $MarginContainer/HBoxContainer/Money
@onready var convert_button: Button = $MarginContainer/HBoxContainer/Convert


enum ActionType {ADD, SUBTRACT, SET}
var player: Player = null
var money: float = 0.0
var mult: float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	money = player.money
	money_display.text = "$" + str(money)
	convert_button.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func change_money(amount: float, action: ActionType) -> void:
	match action:
		ActionType.ADD:
			money += amount
		ActionType.SUBTRACT:
			money -= amount
		ActionType.SET:
			money = amount
	money_display.text = "$" + str(money)


func _on_exit_button_pressed() -> void:
	player.money = money
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	queue_free()


func _on_convert_pressed() -> void:
	var converted: float = player.ore * mult
	change_money(converted, ShopUI.ActionType.ADD)
	player.ore = 0
	convert_button.disabled = true
