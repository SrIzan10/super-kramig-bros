extends CharacterBody2D

@onready var sprite = $Sprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

var coin_count: int = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	if direction == -1.0:
		sprite.scale = Vector2(-4, 4)
	elif direction == 1:
		sprite.scale = Vector2(4, 4)
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _process(delta: float) -> void:
	$CanvasLayer/Control/Label.text = "scoer; %d" % coin_count
	if coin_count == 19:
		get_tree().change_scene_to_file("res://congratulations.tscn")

func _add_coin() -> void:
	coin_count += 1

func _on_the_shitter_area_entered(area: Area2D) -> void:
	if (area.name.begins_with('coin')):
		_add_coin()
		var sound: AudioStreamPlayer = area.get_node("CoinCollect")
		sound.play()
		area.hide()
		area.set_deferred("monitorable", false)
		await sound.finished
		area.queue_free()
