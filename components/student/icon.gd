class_name StudentIcon
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


var margin: int = 0
var border: int = 1
var padding: int = 4


@onready var metadata: StudentMetadata = DataLoader.load_student_by_id(id)
@onready var student: Student = SaveManager.get_student_by_id(id)

@onready var avatar_sprite = get_node("upper/clip/avatar")
@onready var name_label = get_node("lower/name")
@onready var attack_type_block = get_node("upper/clip/attack_type")
@onready var armor_type_block = get_node("upper/clip/armor_type")
@onready var not_owned_mask = get_node("upper/clip/not_owned")
@onready var rank_sprite = get_node("upper/clip/rank")
@onready var combat_class_block = get_node("upper/clip/combat_class")
@onready var role_sprite = get_node("upper/clip/combat_class/role")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	pass


func update():
	var avatar_texture = load("res://assets/images/students/icon/%d.webp" % id)
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
	
	match metadata.combat_class:
		StudentMetadata.CombatClass.Striker: combat_class_block.set_color(ColorCombatClassStriker)
		StudentMetadata.CombatClass.Special: combat_class_block.set_color(ColorCombatClassSpecial)

	var role_name = null
	match metadata.role:
		StudentMetadata.Role.Dealer: role_name = "dealer"
		StudentMetadata.Role.Tank: role_name = "tank"
		StudentMetadata.Role.Healer: role_name = "healer"
		StudentMetadata.Role.Support: role_name = "support"
		StudentMetadata.Role.TacticalSupport: role_name = "tactical_support"
	if role_name != null:
		var role_texture = load("res://assets/images/roles/%s.png" % role_name)
		role_sprite.set_texture(role_texture)

	var rank: int = 5
	if student != null:
		not_owned_mask.hide()
		rank = student.rank
		pass
	else:
		not_owned_mask.show()
		rank = metadata.rarity
		pass
	var rank_texture = load("res://assets/images/ui/rank_%d.png" % rank)
	rank_sprite.set_texture(rank_texture)

	pass
