extends Area2D

var speed = 500

func _physics_process(delta):
	position += transform.x.normalized() * speed * delta
	position += transform.x.normalized() * speed * delta


func _on_NormalArrow_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
