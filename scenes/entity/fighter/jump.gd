extends State

const JUMP := preload('res://assets/sfx/jump.wav')

@onready var _character := owner as Fighter

var _jumps := 0

func _enter():
	_jump()
	pass
	
func _exit():
	_character.jump = false
	_character.g = _character.gravity
	#_character.anim['parameters/conditions/jump'] = false
	_jumps = 0
	pass
	 
func _jump():
	_character.sfx.stream = JUMP
	_character.sfx.play()
	
	var gravity = _character.jump_height / (2.0 * _character.jump_duration * _character.jump_duration)
	var speed = sqrt(2.0 * _character.jump_height * gravity)
	#_character.anim['parameters/conditions/jump'] = true
	_character.velocity.y = speed
	_character.g = gravity
	_jumps += 1
	
func _physics_process(delta: float):
	if _character.is_on_floor():
		_goto('Idle')
		return
		
	if _character.jump and _jumps < 2:
		_jump()
		return
			
	var speed = _character.speed
	_character.velocity.z = _character.motion * speed * delta
