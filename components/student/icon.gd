extends Node2D


# 部队类型颜色
const ColorCombatClassStriker = Color("#CC1A25")
const ColorCombatClassSpecial = Color("#006BFF")

# 攻击护甲类型颜色
const ColorExplosive: Color = Color("#A70C19", 0.75)
const ColorPiercing: Color = Color("#B26D1F", 0.75)
const ColorMystic: Color = Color("#216F9C", 0.75)
const ColorSonic: Color = Color("#9431A5", 0.75)


@export_range(10000, 99999, 1, "学生编号")
var id: int = 10003

@export
var owned: bool = false


var margin: int = 0
var border: int = 1
var padding: int = 4


@onready var metadata: StudentMetadata = DataLoader.load_student_by_id(id)
@onready var avatar_sprite = get_node("upper/clip/avatar")
@onready var name_label = get_node("lower/name")
@onready var attack_type_block = get_node("upper/clip/attack_type")
@onready var armor_type_block = get_node("upper/clip/armor_type")
@onready var not_owned_mask = get_node("upper/clip/not_owned")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	pass


func update():
	var avatar_path = "res://assets/images/students/icon/%d.webp" % id
	var avatar_texture = load(avatar_path)
	avatar_sprite.set_texture(avatar_texture)
	
	var name = DataLoader.i18n["student.%d.name" % id]
	name_label.set_text(name)
	
	match metadata.attack_type:
		StudentMetadata.AttackType.Explosive: attack_type_block.set_color(ColorExplosive)
		StudentMetadata.AttackType.Piercing: attack_type_block.set_color(ColorPiercing)
		StudentMetadata.AttackType.Mystic: attack_type_block.set_color(ColorMystic)
		StudentMetadata.AttackType.Sonic: attack_type_block.set_color(ColorSonic)
	
	match metadata.armor_type:
		StudentMetadata.ArmorType.Light: armor_type_block.set_color(ColorExplosive)
		StudentMetadata.ArmorType.Heavy: armor_type_block.set_color(ColorPiercing)
		StudentMetadata.ArmorType.Special: armor_type_block.set_color(ColorMystic)
		StudentMetadata.ArmorType.Elastic: armor_type_block.set_color(ColorSonic)

	var rank = 5
	if owned:
		not_owned_mask.hide()
		pass
	else:
		not_owned_mask.show()
		pass

	pass
