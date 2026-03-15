extends VBoxContainer

@export var icon: CompressedTexture2D
@export_enum("STRENGTH", "SPEED") var item_type: String
@export var price: float = 0.0
@export var value: float = 1.0

@onready var icon_display: TextureRect = $TextureRect
@onready var price_display: Label = $Label
@onready var button: Button = $Button
@onready var audio: AudioStreamPlayer = $audio

var player: Player

func _ready() -> void:
	icon_display.texture = icon
	price_display.text = "$" + str(price)
	player = owner.player

func _on_button_pressed() -> void:
	audio.play()
	if player.money >= price:
		match item_type:
			"STRENGTH":
				PlayerAutoloads.strength = player.base_strength * value
			"SPEED":
				PlayerAutoloads.speed = player.base_speed * value
		owner.change_money(price, owner.ActionType.SUBTRACT)
		button.disabled = true
	
