extends Button

func _on_pressed():
	if $"..".nb_item > 0:
		$"..".nb_item -= 1
	$"../nb_item".text = "quantity : " + str($"..".nb_item)
	if $"..".nb_bitcoin >= $"..".nb_item:
		$"../SELL".text = "sell for : " + str($"..".nb_item * (20 - 2))
	else:
		$"../SELL".text = "You do not have enough Bitcoin"
	$"../BUY".text = "BUY FOR : " + str($"..".nb_item * 20)
