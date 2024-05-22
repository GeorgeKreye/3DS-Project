class_name Inventory extends Node

@export var inventory_slots: int

class Item:
	func _init(obj: Node, stack_size: int = 99):
		self.obj = obj
		self.stack_size = stack_size
		
	func get_item():
		return self.obj
		
class InventorySlot:
	func _init():
		self.current_item = null
		self.count = 0
		
	func add_item(amount: int = 1):
		if self.current_item == null:
			printerr("Error: Item type not set before adding to slot")
			return
		if self.count + amount <= self.current_item.stack_size:
			self.count += amount
		else:
			self.count = self.current_item.stack_size
		
	func remove_item(amount: int = 1):
		if self.count - amount <= 0:
			self.count = 0
			self.current_item = null
		else:
			self.count -= amount
			
	func set_item_type(obj: Node):
		if self.current_item != null:
			printerr("Error: Item type already set")
			return
		self.current_item = obj
	
	
func _ready():
	self.inventory = []
	for i in inventory_slots:
		self.inventory.append(InventorySlot.new())
