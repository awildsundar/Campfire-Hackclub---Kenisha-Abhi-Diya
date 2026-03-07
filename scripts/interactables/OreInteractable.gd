extends BaseInteractable
class_name OreInteractable

# Called when the node enters the scene tree for the first time.
func interact(player: Player) -> void:
	player.ore += 1
	print(player.ore)
	queue_free()
