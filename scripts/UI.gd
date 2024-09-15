extends Control

@onready var coin_amount_label = $CoinBox/CoinAmountLabel





# Called when the node enters the scene tree for the first time.
func _ready():
	coin_amount_label.text = str(global.global_coin)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func increase_coin(increment_amount):
	#coin_number
	print("increasing coin")
	print(increment_amount)
	print(coin_amount_label.text)
	global.global_coin = global.global_coin + increment_amount
	
	coin_amount_label.text = str(global.global_coin)


func _on_bronze_coin_touch():
	print("Coin Collected")
	return increase_coin(1)


