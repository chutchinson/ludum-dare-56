extends State

const BLOCK := preload('res://assets/sfx/block.wav')

@onready var _character := owner as Fighter

func _enter():
	#_character.anim['parameters/conditions/guard'] = true
	_character.sfx.stream = BLOCK
	_character.sfx.play()
	pass
	
func _exit():
	#_character.anim['parameters/conditions/guard'] = false
	pass

func _physics_process(delta: float):
	# _character.velocity.z = _character.max_speed * 0.8 * delta
	if not _character.guard: _goto('Idle')
	pass
