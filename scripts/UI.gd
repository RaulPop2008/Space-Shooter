extends CanvasLayer

func _process(delta: float) -> void:
	if World.win_lose==0:
		$MarginContainer/Label3.text="Score: "+str(World.kill_count*100)
	if World.win_lose==1:
		World.reset()
		$MarginContainer/Label2.visible=true
		await get_tree().create_timer(3).timeout
		$MarginContainer/Label2.visible=false
	if World.win_lose==-1:
		World.reset()
		$MarginContainer/Label.visible=true
		await get_tree().create_timer(3).timeout
		$MarginContainer/Label.visible=false
