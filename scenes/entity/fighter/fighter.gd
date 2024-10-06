extends CharacterBody3D
class_name Fighter

signal died()
signal damaged(source: Fighter)

@onready var state_machine = $StateMachine
@onready var avatar: Avatar = $Avatar
@onready var sfx: AudioStreamPlayer = $Sfx

@export var mesh: MeshInstance3D

@export var max_health := 100
@export var max_speed := 200.0
@export var gravity := 10.0
@export var jump_duration := 0.1
@export var jump_height := 0.5
@export var air_control := 0.75

var health := max_health : set = _set_health
var dead := false
var debug := false
var g := gravity
var speed := max_speed
var motion := 0.0
var attack := false
var guard := false
var jump := false
var facing := 1
var knockback := Vector3.ZERO

func _ready() -> void:
	%StateMachine.goto('Idle')
	pass
	
func _process(delta: float):
	if motion != 0: facing = sign(motion)
	rotation.y = PI if facing == 1 else 0.0
	
func _physics_process(delta: float):
	if debug: %StateMachine.goto('Hit')
		
	if not dead and not is_on_floor():
		velocity.y -= g * delta
		
	velocity.x = 0.0
	
	move_and_slide()
	
	var count = get_slide_collision_count()
	
	for idx in range(0, count):
		var collision = get_slide_collision(idx)
		var collider = collision.get_collider()
		if collider is Fighter:
			collider.velocity.z += velocity.z
			collider.move_and_slide()
	
	if global_position.y <= -5.0:
		%StateMachine.goto('Dead')
		return
	
func _set_health(value: float):
	health = clamp(value, 0, max_health)
	dead = health <= 0
	
func hit(attacker: Fighter, damage: float) -> bool:
	if dead: return false
	if not guard:
		_set_health(health - damage)
		damaged.emit(attacker)
	knockback = attacker.global_basis.z
	return %StateMachine.goto('Hit')
