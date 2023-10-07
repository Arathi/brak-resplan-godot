extends Node2D


var Icon: Node2D = load("res://components/student/icon.tscn")


func _init():
	DataLoader.load_students()
	for iter in DataLoader.students:
		var metadata: StudentMetadata = iter
		var icon = Icon.inst
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
