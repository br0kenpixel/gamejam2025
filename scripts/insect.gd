extends Node
class_name Enemy

@export var enemy_name: String
@export var category: InsectCategories.InsectCategory
@export var health: int = 100
@export var max_health: int = 100
@export var max_dmg: int = 100
@export var xp: int = 100
@onready var health_bar = $UI/HealthBar
@onready var info_label = $UI/InfoLabel

func _ready():
	update_ui()

func update_ui():
	# Nastaví hodnotu v HealthBar
	health_bar.value = float(health) / max_health * 100
	# Zobrazí meno, kategóriu a vypočíta level
	var level = (xp / 100) + 1
	info_label.text = "%s\n%s\nLvl: %d" % [enemy_name, category, level]

func take_damage(damage: int):
	health -= damage
	health = max(0, health)
	update_ui()
	if health == 0:
		die()

func die():
	print("%s has been defeated!" % enemy_name)
	queue_free()

func attack1(target):
	var hit_chance = randi_range(1, 20)
	if hit_chance % 2 == 0:
		var damage = randi_range(0.5*max_dmg, max_dmg)# * target category bonus atack
		print("%s uses Attack 1 and deals %d damage!" % [enemy_name, damage])
		target.take_damage(damage)
	else:
		print("%s missed the attack!" % enemy_name)

func attack2(target):
	var damage = randi_range(10, 15)
	print("%s uses Attack 2 and deals %d damage!" % [enemy_name, damage])
	target.take_damage(damage)

func attack3(target):
	var damage = randi_range(15, 20)
	print("%s uses Attack 3 and deals %d damage!" % [enemy_name, damage])
	target.take_damage(damage)
	
