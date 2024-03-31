extends CharacterBody2D

var health = 3

@onready var player = get_node("/root/Game/Player")

func _ready():
	$Bat.play("fly")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 200.0
	move_and_slide()


func take_damage():
	health -= 1
	$Bat.play("hurt")
	if health != 0:
		await get_tree().create_timer(0.5).timeout
		$Bat.play("fly")
	
	if health == 0:
		queue_free()
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position


func _on_hurt_cooldown_timeout():
	$Bat.play("fly")
