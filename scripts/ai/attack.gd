extends State

@onready var _brain := owner as Brain

func _enter():
	_attack()
	
func _attack():
	var direction = _brain.fighter.global_position.direction_to(_brain.target.global_position)
	_brain.fighter.motion = direction.z
	_brain.fighter.attack = true
	await _brain.wait_for('Attack1')
	_goto('Idle')
