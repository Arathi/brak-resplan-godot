extends Node2D

const VIEWPORT_WIDTH = 1600
const VIEWPORT_HEIGHT = 900

@export var id: int = 10003

@onready var metadata: StudentMetadata = DataLoader.load_student_by_id(id)
@onready var student: Student = SaveManager.get_student_by_id(id)

@onready var portrait_sprite: Sprite2D = get_node("portrait")
@onready var background_sprite: Sprite2D = get_node("background")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	pass


func update():
	update_portrait()
	update_background()

func update_portrait():
	var texture: Texture2D = load("res://assets/images/students/portrait/%d.webp" % id)
	var texture_height = texture.get_height()
	var scale = VIEWPORT_HEIGHT * 1.0 / texture_height
	portrait_sprite.set_texture(texture)
	portrait_sprite.set_scale(Vector2(scale, scale))


func update_background():
	var texture: Texture2D = load("res://assets/images/background/%s.jpg" % metadata.background)
	background_sprite.set_texture(texture)

