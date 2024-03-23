extends TextureButton
class_name SkillNode


@onready var panel = $Panel
@onready var label  = $MarginContainer/Label
@onready var line2d = $Line2D

@export var Stats : Node2D
@export var Modifier : Modifier
@export var max_level = 1
var level : int = 0

func _ready():
	if get_parent() is SkillNode:
		Stats = get_parent().Stats
		line2d.add_point(global_position + size / 2)
		line2d.add_point(get_parent().global_position + size / 2)
	if get_parent() is SkillTree:
		Stats = get_parent().Stats

func set_level(amt : int):
	if (amt > max_level):
		return
	if (amt < 0):
		return

	level = amt
	label.text = str(level) + "/" + str(max_level)

func get_level():
	return level
	
func get_max_level():
	return max_level

func _on_pressed():
	#if (Stats.get_talent_point() > 0):
	#	if (get_level() + 1 > get_max_level()):
	#		return

	#	Stats.spend_talent_point()
		set_level(get_level() + 1)
		panel.show_behind_parent = true
		line2d.default_color = Color(1, 1, 0)
		
		var skills_child = get_children()
		for skill in skills_child:
			if skill is SkillNode and level == 1:
				skill.disabled = false
