extends State

const SWIPE := preload('res://assets/sfx/punch.wav')

@export var cooldown: Timer
@export var hitbox: Shape3D
@export var hitbox_offset := Vector3.ZERO

@onready var _character := owner as Fighter

func _can_enter() -> bool:
	return cooldown.time_left <= 0.0

func _enter():
	_character.sfx.stream = SWIPE
	_character.sfx.play()
	
	cooldown.start()
	_detect_hit()
	_character.velocity.z = 0.0
	#_character.anim['parameters/conditions/punch'] = true
	
	# TODO: fix animation tree
	await _wait(0.25)
	# await _character.anim.animation_finished
	
	_goto('Idle')
	
func _detect_hit():
	var space = get_viewport().world_3d.direct_space_state
	var query = PhysicsShapeQueryParameters3D.new()
	
	query.exclude = [_character.get_rid()]
	query.collision_mask = 2
	query.shape = hitbox
	query.transform = _character.transform.translated(hitbox_offset)
	query.motion = _character.global_basis.z
	
	var collisions = space.intersect_shape(query)
	
	if len(collisions) > 0:
		var collision = collisions.pop_front()
		var opponent = collision.collider as Fighter
		opponent.hit(_character, 10.0)
	
func _exit():
	_character.attack = false
	#_character.anim['parameters/conditions/punch'] = false

func _physics_process(delta: float) -> void:
	var direction = _character.global_basis.z
	_character.velocity.z = direction.z * 20.0 * delta
	pass
