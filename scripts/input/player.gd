extends Node

@onready var _fighter := get_parent() as Fighter

func _physics_process(delta):
	_fighter.motion = Input.get_axis(&'move_left', &'move_right')
	_fighter.jump = Input.is_action_just_pressed(&'jump')
	_fighter.attack = Input.is_action_just_pressed(&'attack_1')
	_fighter.debug = Input.is_action_just_pressed(&'debug')
	_fighter.guard = Input.is_action_just_pressed(&'guard')
