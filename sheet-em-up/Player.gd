extends KinematicBody2D

## class member variables go here, for example:
#const GRAVITY = 200.0
#const WALK_SPEED = 200
#var velocity = Vector2()
#
#func _ready():
#	# Called when the node is added to the scene for the first time.
#	# Initialization here
#	pass
#
##func _process(delta):
##	# Called every frame. Delta is time since last frame.
##	# Update game logic here.
##	pass
#
#func _physics_process(delta):
#	velocity.y += delta * GRAVITY
#
#	if Input.is_action_pressed("ui_left"):
#		velocity.x = -WALK_SPEED
#	elif Input.is_action_pressed("ui_right"):
#		velocity.x =  WALK_SPEED
#	else:
#		velocity.x = 0
#
#	move_and_slide(velocity, Vector2(0, -1))

var run_speed = 250
var jump_speed = -250
var gravity = 2500

var velocity = Vector2()

var jump_y_modifier = 1
var jump_x_modifier = 1


func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_up')


	var property_id = $"../../SpreadsheetContainer/GridContainer/PropertyOptionButton".selected
	var operator_id = $"../../SpreadsheetContainer/GridContainer/OperatorOptionButton".selected
	var value_id = $"../../SpreadsheetContainer/GridContainer/ValueOptionButton".selected

	if is_on_floor():
		jump_y_modifier = 1

	if ((property_id > -1) and (operator_id > -1) and (value_id > -1)):
		var property_text = $"../../SpreadsheetContainer/GridContainer/PropertyOptionButton".get_item_text(property_id)
		var operator_text = $"../../SpreadsheetContainer/GridContainer/OperatorOptionButton".get_item_text(operator_id)
		var value_text = $"../../SpreadsheetContainer/GridContainer/ValueOptionButton".get_item_text(value_id)

		if (property_text == "Jump Y"):
			if (operator_text == "*"):
				jump_y_modifier = value_text.to_int()

		elif (property_text == "Jump X"):
			if (operator_text == "*"):
				jump_x_modifier = value_text.to_int()

	if is_on_floor() and jump:
			velocity.y = jump_speed * jump_y_modifier

	if right:
			velocity.x += run_speed
	if left:
			velocity.x -= run_speed


func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))



func _on_PropertyPowerUp_area_shape_entered(area_id, area, area_shape, self_shape):
	printt("zoo")
	printt(area)


func _on_PropertyPowerUp_body_entered(body):
	printt("woo")
	printt(body)


# TODO: Don't duplicate this?
enum PowerUpType {PROPERTY_POWERUP, OPERATOR_POWERUP, VALUE_POWERUP}

func add_to_inventory(new_item):

	match new_item.powerup_type:
		PROPERTY_POWERUP:
			$"../../SpreadsheetContainer/GridContainer/PropertyOptionButton".add_item(new_item.get_powerup_value_as_text())

		OPERATOR_POWERUP:
			$"../../SpreadsheetContainer/GridContainer/OperatorOptionButton".add_item(new_item.get_powerup_value_as_text())

