extends CharacterBody2D

const TRAVEL_SPEED:int=-1680

func _ready() -> void:
	velocity.y=TRAVEL_SPEED

func _process(delta: float) -> void:
	if is_on_ceiling()==true:
		get_tree().current_scene.remove_child(self)
	move_and_slide()

func _on_laser_hurtbox_area_entered(area: Area2D) -> void:
	queue_free()
	area.get_parent().lives-=1
