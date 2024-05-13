extends Node

func getAnimalDetection():
	var animalDetection = get_node("AnimalDetection/DetectionPolygon")
	return animalDetection

func getBatDetection():
	var batDetection = get_node("BatDetection/DetectionShape")
	return batDetection

func getSpiderDetection():
	var spiderDetection = get_node("SpiderDetection/CollisionShape2D")
	return spiderDetection
	
func enableBatDetection():
	get_node("BatDetection/BatShape").disabled = false
	#get_node("BatDetection/DetectionShape").disabled = false
	
func enableSpiderDetection():
	get_node("SpiderDetection/CollisionShape2D").disabled = false
	#get_node("SpiderDetection/CollisionShape2D").disabled = false
	
func disableDetection():
	get_node("BatDetection/BatShape").disabled = true
	get_node("SpiderDetection/CollisionShape2D").disabled = true
	
