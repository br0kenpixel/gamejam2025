extends Resource
class_name Insect

@export var enemy_name: String
@export var category: InsectCategories.InsectCategory
@export var health := 100
@export var max_health := 100
@export var max_dmg := 100
@export var xp := 100
@export var sprite: Texture2D
var health_bar: ProgressBar
var info_label: Label

func update_ui():
	# Nastaví hodnotu v HealthBar
	health_bar.value = float(health) / max_health * 100
	# Zobrazí meno, kategóriu a vypočíta level
	var level := (xp / 100.0) + 1.0
	info_label.text = "%s\n%s\nLvl: %d" % [enemy_name, InsectCategories.category_to_string(category), level]

func take_damage(damage: int) -> void:
	health -= damage
	health = max(0, health)

func attack1(target: Insect) -> void:
	var hit_chance = randi_range(1, 20)
	if hit_chance % 2 == 0:
		var damage := randi_range(0.5 * max_dmg, max_dmg) * InsectCategories.get_category_damage(target.category, category)
		print("%s uses Attack 1 and deals %d damage!" % [enemy_name, damage])
		target.take_damage(damage)
	else:
		print("%s missed the attack!" % enemy_name)

func attack2(target: Insect) -> void:
	var damage = randi_range(10, 15)
	print("%s uses Attack 2 and deals %d damage!" % [enemy_name, damage])
	target.take_damage(damage)

func attack3(target: Insect) -> void:
	var damage = randi_range(15, 20)
	print("%s uses Attack 3 and deals %d damage!" % [enemy_name, damage])
	target.take_damage(damage)
