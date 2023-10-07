extends Node


var lang: String = "zh"
var students: Dictionary = {}
var i18n: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func load_student_by_id(id: int) -> StudentMetadata:
	if students.is_empty():
		load_students(lang)
	return students[id] as StudentMetadata


func load_students(lang: String = "zh"):
	var metadata_list = load_metadata(lang, "students")
	for metadata in metadata_list:
		var student = convert_student(metadata)
		students[student.id] = student
	print("加载学生数据（%s）%d条" % [lang, students.size()])


func convert_student(metadata):
	var student = StudentMetadata.new()
	student.id = metadata.Id
	student.name = metadata.PathName
	student.rarity = metadata.StarGrade
	match metadata.SquadType:
		"Main": student.combat_class = StudentMetadata.CombatClass.Striker
		"Support": student.combat_class = StudentMetadata.CombatClass.Special
	match metadata.TacticRole:
		"DamageDealer": student.role = StudentMetadata.Role.Dealer
		"Tanker": student.role = StudentMetadata.Role.Tank
		"Healer": student.role = StudentMetadata.Role.Healer
		"Supporter": student.role = StudentMetadata.Role.Support
		"Vehicle": student.role = StudentMetadata.Role.TacticalSupport
	match metadata.BulletType:
		"Explosion": student.attack_type = StudentMetadata.AttackType.Explosive
		"Pierce": student.attack_type = StudentMetadata.AttackType.Piercing
		"Mystic": student.attack_type = StudentMetadata.AttackType.Mystic
		"Sonic": student.attack_type = StudentMetadata.AttackType.Sonic
	match metadata.ArmorType:
		"LightArmor": student.armor_type = StudentMetadata.ArmorType.Light
		"HeavyArmor": student.armor_type = StudentMetadata.ArmorType.Heavy
		"Unarmed": student.armor_type = StudentMetadata.ArmorType.Special
		"ElasticArmor": student.armor_type = StudentMetadata.ArmorType.Elastic
	
	i18n["student.%d.name" % student.id] = metadata.Name
	
	return student


func load_metadata(lang: String, file_name: String):
	var path = "user://metadata/%s/%s.json" % [lang, file_name]
	var content: String = ""
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		content = file.get_as_text()
	else:
		printerr("资源文件不存在：%s" % path)
		# TODO 下载资源文件
		return null
	
	var metadata = JSON.parse_string(content)
	return metadata
