extends State

@onready var _character := owner as Fighter

func _enter():
	_character.velocity.z = 0.0
	# _character.anim['parameters/conditions/idle'] = true
	pass
	
func _exit():
	# _character.anim['parameters/conditions/idle'] = false
	pass
	
func _physics_process(delta: float):

	if _character.jump:
		_goto('Jump')
		return
		
	if _character.guard:
		_goto('Guard')
		return
	
	if _character.attack:
		_goto('Attack1')
		return
	
	if abs(_character.motion) > 0.001: 
		_goto('Move')
		return
