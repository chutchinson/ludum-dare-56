extends Node
class_name StateMachine

signal travel(key: String)

@export var default_state := ''

var _state: State = null

func _ready():
	for child in get_children():
		child.set_process(false)
		child.set_physics_process(false)
	if len(default_state) > 0:
		goto.call_deferred(default_state)

func goto(key: String) -> bool:
	var state = find_child(key, false, true) as State
	if state == null or _state == state: return false
	if not state._can_enter(): return false
	if _state != null:
		if not _state._can_exit(): return false
		_exit(_state)
	_enter(state)
	_state = state
	travel.emit(_state.name)
	return true
	
func _enter(state: State):
	state.set_process(true)
	state.set_physics_process(true)
	state._enter()
	
func _exit(state: State):
	state._exit()
	state.set_process(false)
	state.set_physics_process(false)
