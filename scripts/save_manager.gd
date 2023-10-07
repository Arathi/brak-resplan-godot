extends Node


var students: Dictionary = {}
var inventory: Dictionary = {}


func get_student_by_id(id: int) -> Student:
	return students.get(id)


func load_from_file(slot: String = "default"):
	var path = get_file_path(slot)
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var json = file.get_as_text()
		var save = JSON.parse_string(json)
		students = save.students
		inventory = save.inventory
		pass
	else:
		print("存档文件%s不存在" % path)
	pass


func save_to_file(slot: String = "default"):
	var path = get_file_path(slot)
	var file = FileAccess.open(path, FileAccess.WRITE)
	var save = Dictionary()
	save["students"] = students
	save["inventory"] = inventory
	var json = JSON.stringify(save)
	file.store_string(json)


func get_file_path(slot: String = "default"):
	return "user://saves/%s.json" % slot


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
