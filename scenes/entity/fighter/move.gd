extends State

@onready var _character := self.owner as Fighter

func _can_enter():
	return _character.is_on_floor()

func _enter():
	#_character.anim['parameters/conditions/walk'] = true
	pass
	
func _exit():
	_character.motion = 0.0
	#_character.anim['parameters/conditions/walk'] = false
	_character.velocity.z = 0.0
	
func _physics_process(delta):
	if _character.attack:
		_goto('Attack1')
		return
	if _character.jump:
		_goto('Jump')
		return
	if abs(_character.motion) < 0.001:
		_goto('Idle')
		return
	_character.velocity.z = _character.motion * _character.max_speed * delta
	_character.motion = 0.0
	pass
