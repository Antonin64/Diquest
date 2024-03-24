extends Button

func _on_pressed():
	$"..".nb_item += 1
	$"../nb_item".text = "quantity : " + str($"..".nb_item)
	
	if $"..".nb_bitcoin >= $"..".nb_item:
		$"../SELL".text = "sell for : " + str($"..".nb_item * (20 - 2))
	else:
		$"../SELL".text = "You do not have enough Bitcoin"
		
	if $"..".money < $"..".nb_item * 20:
		$"../BUY".text = "T TROP PAUVRE"
	else:
		$"../BUY".text = "BUY FOR : " + str($"..".nb_item * 20)
