extends CharacterBody2D

var is_alive:bool=true
var has_waited:bool=false
var lives:int=5

func _ready() -> void:
	add_to_group("enemies")
	move()

func _physics_process(delta: float) -> void:
	if is_on_floor():
		World.win_lose=-1
	if lives<=0:
		World.kill_count+=1
		World.wave_count+=1
		is_alive=false
		queue_free()
	move_and_slide()

func move():
	if has_waited==false:
		await get_tree().create_timer(1.5).timeout
		has_waited=true
	while is_alive==true:
		velocity.y=1200
		await get_tree().create_timer(0.05).timeout
		velocity.y=0
		await get_tree().create_timer(1).timeout
		velocity.x=1200
		await get_tree().create_timer(0.025).timeout
		velocity.x=0
		await get_tree().create_timer(1.5).timeout
		velocity.y=1200
		await get_tree().create_timer(0.05).timeout
		velocity.y=0
		await get_tree().create_timer(1).timeout
		velocity.x=-1200
		await get_tree().create_timer(0.025).timeout
		velocity.x=0
		await get_tree().create_timer(1.5).timeout
