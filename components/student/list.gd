class_name StudentList
extends Node2D


var Icon = preload("res://components/student/icon.tscn")
# var icons: Array[StudentIcon] = []

# @onready var box: HBoxContainer = get_node("scroll_container/h_box")


func _init():
	DataLoader.load_students()


func reload():
	var box = get_node("scroll_container/h_box")
	for id in DataLoader.students:
		var metadata: StudentMetadata = DataLoader.students[id]
		var icon_name = "student_%d" % id
		var icon = get_node(icon_name)
		if icon == null:
			icon = Icon.instantiate()
			icon.name = icon_name
			icon.id = id
			box.add_child(icon)
		else:
			pass
		sort()


func sort():
	pass


func _enter_tree():
	reload()
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
