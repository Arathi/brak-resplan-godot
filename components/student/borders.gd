@tool
extends Node2D


var border: int = 1
const sqrt2: float = sqrt(2)


@export var padding: int = 4
@export var radius: int = 8
@export var color: Color = Color("#D7DBDC")


var size: int:
	get:
		return 120 + 2*(border + padding)


var gap: int:
	get:
		return 2*(border + padding) + 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func draw_polygon_by_apex(
	lt: Vector2,
	rt: Vector2,
	rb: Vector2,
	lb: Vector2,
): 
	var points = PackedVector2Array()
	points.append(lt)
	points.append(rt)
	points.append(rb)
	points.append(lb)
	var colors = PackedColorArray()
	colors.append(color)
	draw_polygon(points, colors)
	pass


func _draw():
	# top
	draw_polygon_by_apex(
		Vector2(gap, 0),
		Vector2(size - radius, 0),
		Vector2(size - radius, 1),
		Vector2(gap, 1)
	)
	
	# tr
	draw_arc(
		Vector2(size - radius, radius),
		radius - 0.5,
		0,
		-PI / 2,
		128,
		color,
		1
	)
	
	# right
	draw_polygon_by_apex(
		Vector2(size - border, radius),
		Vector2(size, radius),
		Vector2(size, size - gap),
		Vector2(size - border, size - gap)
	)
	
	# rb
	draw_polygon_by_apex(
		Vector2(size - sqrt2, size - gap),
		Vector2(size, size - gap),
		Vector2(size - gap, size),
		Vector2(size - gap - sqrt2, size)
	)
	
	# bottom
	draw_polygon_by_apex(
		Vector2(radius, size - border),
		Vector2(size - gap, size - border),
		Vector2(size - gap, size),
		Vector2(radius, size)
	)
	
	# lb
	draw_arc(
		Vector2(radius, size - radius),
		radius - 0.5,
		PI,
		PI / 2,
		128,
		color,
		1
	)
	
	# left
	draw_polygon_by_apex(
		Vector2(0, gap),
		Vector2(border, gap),
		Vector2(border, size - radius),
		Vector2(0, size - radius)
	)
	
	# tl
	draw_polygon_by_apex(
		Vector2(gap, 0),
		Vector2(gap + sqrt2, 0),
		Vector2(0, gap + sqrt2),
		Vector2(0, gap)
	)
	
	pass
