extends Node

var _fighters: Array[Fighter] = []

func _ready():
	for fighter: Fighter in get_tree().get_nodes_in_group(&'fighter'):
		_fighters.push_back(fighter)
	%Status1.fighter = _fighters[0]
	%Status2.fighter = _fighters[1]
