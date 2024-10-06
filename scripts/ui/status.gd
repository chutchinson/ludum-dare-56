extends Control

var fighter: Fighter = null : set = _set_fighter
var health := 0.0 : set = _set_health

func _set_fighter(target: Fighter):
	fighter = target
	
func _set_health(value: float):
	health = clamp(value, 0.0, fighter.max_health)
	%Health.value = 100.0 * (health / fighter.max_health)
	
func _process(delta: float):
	if fighter == null: return
	_set_health(fighter.health)
	_debug()
	
func _debug():
	var state_machine = fighter.find_child('StateMachine') as StateMachine
	%StateLabel.text = state_machine._state.name
	pass
