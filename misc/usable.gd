class_name Usable

static func is_usable(usable):
	return (is_instance_of(usable, Node) and 
		usable.is_in_group('usable') and
		usable.can_be_used()
	)
