extends Node

func _ready():
	for fighter: Fighter in get_tree().get_nodes_in_group('fighter'):
		fighter.died.connect(_on_fighter_died.bind(fighter))
		
func _on_fighter_died(fighter: Fighter):
	var tree = get_tree()
	var timer = tree.create_timer(2.0)
	await timer.timeout
	tree.reload_current_scene()
