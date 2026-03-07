extends BaseInteractable
class_name ShopInteractable

@export var shop_ui_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func interact(player: Player) -> void:
	var shop_ui: Node = shop_ui_scene.instantiate()
	shop_ui.player = player
	add_child(shop_ui)
