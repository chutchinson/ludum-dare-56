extends Node
class_name State

@onready var entity := owner as CharacterBody3D
@onready var state_machine := get_parent() as StateMachine

func _can_enter() -> bool:
	return true
	
func _can_exit() -> bool:
	return true

func _enter():
	pass
	
func _exit():
	pass
	
func _goto(key: String):
	state_machine.goto.call_deferred(key)

func _wait(time: float):
	var timer = get_tree().create_timer(time)
	await timer.timeout
