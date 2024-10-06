extends State

const HURT := preload('res://assets/sfx/hurt.wav')

@onready var _character := owner as Fighter

func _enter():
	_character.sfx.stream = HURT
	_character.sfx.play()
	_character.velocity.y = 0.0
	
	_disable_collision()
	_character.health = 0
	_character.velocity.x = 0.0
	_character.velocity.z = 0.0
	#_character.anim['parameters/conditions/dead'] = true
	_character.died.emit()
	
func _disable_collision():
	_character.collision_layer = 0
	_character.collision_mask = 0
	pass

func _ragdoll():
	pass
