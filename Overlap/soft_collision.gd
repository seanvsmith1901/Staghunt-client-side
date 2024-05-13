extends Area2D


#just detect if something is touching us
#and then create a push vector from it 
#this is to push the bats away from eachtoher. 

func is_colliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0
	#if we have some overlapping bodies, returns 1 or 2 or whatever
	#if not, we get false. 
	
func get_push_vector():
	var areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO
	if is_colliding():
		var area = areas[0] #get just the first area and not all the areas. one at at time. 
		push_vector = area.global_position.direction_to(global_position)
		push_vector = push_vector.normalized()
		#this makes it as a unit of one and we can go from there. 
	return push_vector #returns 0 if we are not colliding and our vector if we did. 

		#generates a vector that shows the difference between our position and their vector. 
		
