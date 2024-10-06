extends State

@onready var _brain := owner as Brain

func _enter():
	_brain.fighter.motion = 0.0
	_brain.fighter.damaged.connect(_on_damaged)
	
func _exit():
	_brain.fighter.damaged.disconnect(_on_damaged)
	
func _on_damaged(fighter: Fighter):
	_goto('Attack')

func _physics_process(delta: float):
	return
	var direction = _brain.fighter.global_position.direction_to(_brain.target.global_position)
	var distance = _brain.fighter.global_position.distance_to(_brain.target.global_position)
	
	if distance > 1.5:
		_brain.fighter.motion = direction.z
	else:
		_brain.fighter.motion = 0.0
