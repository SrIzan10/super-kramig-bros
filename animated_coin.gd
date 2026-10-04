extends AnimatedSprite2D
@onready var sprite = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play('new_animation')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
