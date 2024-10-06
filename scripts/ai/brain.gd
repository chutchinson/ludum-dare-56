extends StateMachine
class_name Brain

@onready var fighter := get_parent() as Fighter
@onready var target := _find_target()

func _find_target() -> Fighter:
	for fighter: Fighter in get_tree().get_nodes_in_group('fighter'):
		if fighter != get_parent():
			return fighter
	return null
		
func _ready():
	for fighter in get_tree().get_nodes_in_group('fighter'):
		if fighter != get_parent():
			target = fighter
	fighter.died.connect(_on_died)
	super._ready()
	
func _on_died():
	goto('Dead')

func wait_for(target: String):
	while not fighter.dead:
		var key = await fighter.state_machine.travel
		if key == target:
			return
