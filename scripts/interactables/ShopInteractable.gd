extends BaseInteractable
class_name ShopInteractable

@export var shop_ui_scene: PackedScene
@onready var container: Node3D = $Container

# Called when the node enters the scene tree for the first time.
func interact(player: Player) -> void:
	if container.get_child_count() == 0:
			var shop_ui: Node = shop_ui_scene.instantiate()
			shop_ui.player = player
			shop_ui.next_level = player.owner.next_day
			shop_ui.rate = player.owner.rate
			container.add_child(shop_ui)
