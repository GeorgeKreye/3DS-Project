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
			self.current_item =null
		else:
			self.count -= amount
			
	func set_item_type(obj: Node):
		if self.current_item != null:
			printerr("Error: Item type already set")
			return
		self.current_item = Item.new(obj)
	
	
func _init():
	self.inventory = []
	for i in inventory_slots:
		self.inventory.append(InventorySlot.new())
		
func add_item(obj: Node, amount: int = 1):
	# get slot
	var slot = null
	for s in len(self.inventory):
		if self.inventory[s].current_item == obj:
			slot = s
			break
	if slot == null:
		for s in len(self.inventory):
			if self.inventory[s].current_item == null:
				slot = s
				self.inventory[s].set_item_type(obj)
				break
		if slot == null:
			# inventory is full
			return
	
	# add
	self.inventory[slot].add_item(amount)
	
func remove_item(obj: Node, amount: int = 1):
	# get slot
	var slot = null
	for s in len(self.inventory):
		if self.inventory[s].current_item == obj:
			slot = s
			break
	if slot == null:
		printerr("Error: Tried to remove an item not in player inventory")
		return
		
	# remove
	self.inventory[slot].remove_item(amount)

