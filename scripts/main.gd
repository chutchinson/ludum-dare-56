extends Node

func _ready():
	get_tree().change_scene_to_file.call_deferred('res://scenes/ui/title.tscn')