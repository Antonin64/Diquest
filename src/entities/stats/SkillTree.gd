extends Control
class_name SkillTree

@export var Player : Node2D
@export var Stats : Node2D

func update_talent_point():
	$TalentPtsNum.text = str(Stats.talent_point) + " talent points"
