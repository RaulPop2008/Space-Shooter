extends CharacterBody2D

const MOVEMENT_SPEED_X:int=720
const MOVEMENT_SPEED_Y:int=540
const LASER_SCENE:PackedScene=preload("res://scenes/laser.tscn")
const LASER_COOLDOWN:float=0.8

var laser_index:int=1
var can_shoot:bool=true

func _process(delta: float) -> void:
	inputs(delta)
	move_and_slide()

func inputs(delta:float):
## movement
	if Input.is_action_pressed("move_right"):
		velocity.x=MOVEMENT_SPEED_X
	elif Input.is_action_pressed("move_left"):
		velocity.x=-MOVEMENT_SPEED_X
	else:
		velocity.x=0
	if Input.is_action_pressed("move_up"):
		velocity.y=-MOVEMENT_SPEED_Y
	elif Input.is_action_pressed("move_down"):
		velocity.y=MOVEMENT_SPEED_Y
	else:
		velocity.y=0
## attack
	if Input.is_action_pressed("shoot") and can_shoot==true:
		shoot_laser()
		can_shoot=false
		await get_tree().create_timer(LASER_COOLDOWN-float(World.wave_index)/20).timeout
		can_shoot=true

func shoot_laser():
	var laser=LASER_SCENE.instantiate()
	get_tree().current_scene.add_child(laser)
	laser.position=$LaserStartingPosition.global_position


func _on_area_2d_area_entered(area: Area2D) -> void:
	World.win_lose=-1
