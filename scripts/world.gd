extends Node2D

const ENEMY_WAVES: Array[Array] = [
	[Vector3(600, 500, 1)],
	[Vector3(400, 400, 1), Vector3(800, 400, 1)],
	[Vector3(600, 500, 2)],
	[Vector3(300, 500, 1), Vector3(600, 500, 1), Vector3(900, 500, 1), Vector3(400, 300, 2), Vector3(800, 300, 2)],
	[Vector3(200, 500, 1), Vector3(400, 500, 1), Vector3(600, 500, 1), Vector3(800, 500, 1), Vector3(1000, 500, 1), Vector3(300, 300, 2), Vector3(600, 300, 2), Vector3(900, 300, 2)],
	[Vector3(200, 750, 1), Vector3(400, 750, 1), Vector3(600, 750, 1), Vector3(800, 750, 1), Vector3(1000, 750, 1), Vector3(200, 500, 1), Vector3(400, 500, 1), Vector3(600, 500, 1), Vector3(800, 500, 1), Vector3(1000, 500, 1), Vector3(200, 350, 2), Vector3(400, 350, 2), Vector3(600, 350, 2), Vector3(800, 350, 2), Vector3(1000, 350, 2), Vector3(600, 200, 3)],
	[Vector3(200, 750, 1), Vector3(400, 750, 1), Vector3(600, 750, 1), Vector3(800, 750, 1), Vector3(1000, 750, 1), Vector3(200, 500, 1), Vector3(400, 500, 1), Vector3(600, 500, 1), Vector3(800, 500, 1), Vector3(1000, 500, 1), Vector3(200, 350, 2), Vector3(400, 350, 2), Vector3(600, 350, 2), Vector3(800, 350, 2), Vector3(1000, 350, 2), Vector3(300, 200, 3), Vector3(600, 200, 3), Vector3(900, 200, 3)]
]

const ENEMY_COUNT_WAVE:Array[int]=[1,2,1,5,8,16,18]
const SMALL_ENEMY:PackedScene=preload("res://scenes/small_alien_enemy.tscn")
const MEDIUM_ENEMY:PackedScene=preload("res://scenes/medium_alien_enemy.tscn")
const BIG_ENEMY:PackedScene=preload("res://scenes/big_alien_enemy.tscn")

var win_lose:int=0

var wave_index:int=0
var wave_count:int=0
var enemy_index:int=1
var can_spawn:bool=true
var is_waiting:bool=false
var kill_count:int=0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	enemy_spawning()

func enemy_spawning():
	if ENEMY_COUNT_WAVE[6]==wave_count:
		win_lose=1
	if can_spawn==true:
		for i in range(ENEMY_COUNT_WAVE[wave_index]):
			if ENEMY_WAVES[wave_index][i].z==1:
				var small=SMALL_ENEMY.instantiate()
				get_tree().current_scene.add_child(small)
				small.name="small_"+str(enemy_index)
				enemy_index+=1
				small.position.x=ENEMY_WAVES[wave_index][i].x
				small.position.y=ENEMY_WAVES[wave_index][i].y
			if ENEMY_WAVES[wave_index][i].z==2:
				var medium=MEDIUM_ENEMY.instantiate()
				get_tree().current_scene.add_child(medium)
				medium.name="medium_"+str(enemy_index)
				enemy_index+=1
				medium.position.x=ENEMY_WAVES[wave_index][i].x
				medium.position.y=ENEMY_WAVES[wave_index][i].y
			if ENEMY_WAVES[wave_index][i].z==3:
				var big=BIG_ENEMY.instantiate()
				get_tree().current_scene.add_child(big)
				big.name="big_"+str(enemy_index)
				enemy_index+=1
				big.position.x=ENEMY_WAVES[wave_index][i].x
				big.position.y=ENEMY_WAVES[wave_index][i].y
		can_spawn=false
	if wave_count==ENEMY_COUNT_WAVE[wave_index] and is_waiting==false and wave_index!=6:
		is_waiting=true
		await get_tree().create_timer(1.5).timeout
		can_spawn=true
		if wave_index<=5:
			wave_index+=1
		enemy_index=1
		wave_count=0
		is_waiting=false

func reset():
	get_tree().call_group("enemies", "queue_free")
	wave_index=0
	wave_count=0
	is_waiting=false
	kill_count=0
	win_lose=0
	enemy_index=1
	await get_tree().create_timer(5).timeout
	can_spawn=true
