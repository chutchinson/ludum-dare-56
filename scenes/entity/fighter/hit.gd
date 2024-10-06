extends State

const HIT := preload('res://assets/sfx/hit.wav')

@onready var _character := owner as Fighter

var _material: ShaderMaterial
var _time := 0.0

func _ready():
	_material = _find_hit_overlay_material()
	_apply_hit_effects(0.0)

func _enter():
	_time = 0.0
	#_character.anim['parameters/conditions/hit'] = true
	_character.sfx.stream = HIT
	_character.sfx.play()

	await _wait(0.1667 + 0.01)
	#await _character.anim.animation_finished
	
	if _character.health <= 0.0:
		_goto('Dead')
		return
		
	_goto('Idle')
	
func _exit():
	_character.knockback = Vector3.ZERO
	#_character.anim['parameters/conditions/hit'] = false
	_apply_hit_effects(0.0)

func _physics_process(delta):
	_character.velocity.z = _character.knockback.z * 100.0 * delta
	pass

func _find_hit_overlay_material() -> ShaderMaterial:
	var surface_material = _character.mesh.get_active_material(0)
	var overlay_material = surface_material.next_pass
	return overlay_material as ShaderMaterial

func _apply_hit_effects(alpha: float):
	if _material == null: return
	_material.set_shader_parameter('time', _time)
	_material.set_shader_parameter('alpha', alpha)
	
func _process(delta: float):
	_apply_hit_effects(1.0)
	_time += delta
