extends ConfirmationDialog



func _on_LevelCompleteDialog_confirmed():
	get_tree().paused = false
