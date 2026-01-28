extends AnimatableBody2D

@onready var visuals = $NinePatchRect
@onready var collision = $CollisionShape2D
@onready var handle = $Area2D

var dragging = false
var min_size = Vector2(32, 32)

func _ready():
	# Connect the handle signals
	handle.input_event.connect(_on_handle_input)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			dragging = false

	if event is InputEventMouseMotion and dragging:
		update_block_size(get_global_mouse_position())

func _on_handle_input(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dragging = true

func update_block_size(mouse_pos: Vector2):
	# Calculate new size based on distance from block origin to mouse
	var new_size = mouse_pos - global_position
	
	# Clamp the size so it doesn't disappear or flip inside out
	new_size.x = max(new_size.x, min_size.x)
	new_size.y = max(new_size.y, min_size.y)
	
	# Apply to visuals
	visuals.size = new_size
	
	# Apply to physics (center the collision to match the visual growth)
	collision.shape.set_size(new_size)
	collision.position = new_size / 2
	
	# Move the handle icon to the new corner
	handle.position = new_size
