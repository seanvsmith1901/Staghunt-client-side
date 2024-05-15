extends Node


# Called when the node enters the scene tree for the first time.
func instance_node(node, parent, location):
	var node_instance = node.instantiate()
	node_instance.global_position = location
	parent.add_child(node_instance)
	return node_instance
