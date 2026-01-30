extends AnimatableBody2D

var is_selected = false
#Variables for scaling the box
var x = 1
var y = 1

#The check to select the box
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		select_box()
		get_viewport().set_input_as_handled()

#The check to deselect the box
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if is_selected:
			deselect_box()

#Labels the box as selected and changes the color
func select_box():
	is_selected = true
	modulate = Color(0.0, 0.4, 1.0, 1.0)
	print("Box Selected")

#Labels the box as deselected and reverts the color
func deselect_box():
	is_selected = false
	modulate = Color(1,1,1)
	print("Box Deselected")

#Scales the box based off the input and if it is selected
func _input(event):
	if is_selected:
		if event is InputEventKey and event.pressed:
			if event.keycode == KEY_Q:
				if event.shift_pressed:
					if y > 1:
						y -= 1
					print("y down")
				else:
					y += 1
					print("y up")
		if event is InputEventKey and event.pressed:
			if event.keycode == KEY_E:
				if event.shift_pressed:
					if x > 1:
						x -= 1
					print("x down")
				else:
					x += 1
					print("x up")
	scale = Vector2(x, y)
