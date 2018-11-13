extends Area2D

enum PowerUpType {PROPERTY_POWERUP, OPERATOR_POWERUP, VALUE_POWERUP}

export (PowerUpType) var powerup_type = PROPERTY_POWERUP


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_PropertyPowerUp_body_entered(body):
	#printt("foo")
	#printt(body)
	if self.visible:
		$"PowerUpPickUpAnim".play("PowerUp")


func _on_PowerUpPickUpAnim_animation_finished(anim_name):
	self.visible = false


# TODO: Handle all this properly...

func get_powerup_value():
	return $"CollisionShape2D/ColorRect/Label".text

func get_powerup_value_as_text():
	var result

	match self.get_powerup_value():
		"JY":
			result = "Jump Y"

	return result
