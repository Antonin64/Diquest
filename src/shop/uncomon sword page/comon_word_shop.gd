extends Control

var nb_item
var nb_bitcoin
var money

func _ready():
	
	nb_item = 0
	nb_bitcoin = 10
	money = 100
	$Background/nb_item.text = "quantity : " + str(nb_item)
	$Background/player_nb_item.text = "You have " + str(nb_bitcoin) + " Bitcoin"
	$Background/player_money.text = "You have " + str(money) + " $"
