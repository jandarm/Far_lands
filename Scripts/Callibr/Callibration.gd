extends Node
#элементы сцены
var bar
var tm
var lb

#громкость
var power

var rmsSilent
var rmsBlow
var rmsClap
var tmCount

var stamps = []
var stampsMax = []
var canRecord = false
var clapRecord = false

func _ready():
	bar = get_node("Pog")
	tm = get_node("Timer")
	lb = get_node("Say")
	tmCount = 0
	pass
	
	
# warning-ignore:unused_argument
func _process(delta):
	calculate_Power()
	draw_Progress()

	if (canRecord && !clapRecord):
		stamps.append(power)		
		#можно удалить - выводит значения массива
		get_node("Mass").text += "\n"\
		+ power as String
	
	if (clapRecord):       
		calculate_Power()
		get_node("Mass").text = "Davay " + power as String
		get_node("Mass").text += "\n" + Manager.RmsBlow as String
		if (power > Manager.RmsBlow):
			stamps.append(power)
			get_node("Mass").text = "Clap! Clap!"
			get_node("Mass").text += power as String
			get_node("Mass").text += "\n" + stamps as String
	pass
	
	
func _on_Timer_timeout():
	match tmCount:
		0:
			canRecord = true
			lb.text = "Tiho tam!"
			bar.max_value = 2
			tm.wait_time = 2
			tmCount += 1
			tm.start()
		1:
			canRecord = false
			rmsSilent = calculate_RMS(stamps)
			get_node("Mass").text = rmsSilent as String
			lb.text = "Zakonchili"
			tmCount += 1
			tm.start()
			stamps.clear()
		2:
			canRecord = true
			lb.text = "A teper' duy!"
			tmCount += 1
			tm.start()
		3:
			canRecord = false
			rmsBlow = calculate_RMS(stamps)
			get_node("Mass").text = rmsBlow as String
			lb.text = "Zakonchili"
			tmCount += 1
			tm.start()
			stamps.clear()
			get_node("Mass").text = rmsBlow as String
		4:
			lb.text = "Rezultat"
			Manager.RmsBlow = ((rmsBlow + rmsSilent)/2)*(-1)
			get_node("Mass").text = Manager.RmsBlow as String
			tmCount += 1
			tm.start()
		5:
			lb.text = "Hlop-xlop 4 raza, plz"
			stamps.clear()
			canRecord = false
			clapRecord = true
			tmCount +=1
			tm.start()
		6:
			canRecord = false
			clapRecord = false
			while (stampsMax.size()<3):
				stampsMax.append(get_Max_no_dupes(stamps))
			rmsClap = calculate_RMS(stampsMax)
			Manager.RmsRhythm = rmsClap * (-1)
			get_node("Mass").text += "\n" + Manager.RmsRhythm as String\
			 + "\n" +  stampsMax as String
		_:
			canRecord = false
			clapRecord = false
			lb.text = "ne rabotayet"
			get_node("Mass").text = stampsMax as String
			tm.stop()
	pass
	
	
func calculate_RMS(mass):
	var square = 0
	var mean = 0
	var rms = 0
	#посчитать квадраты
	for i in mass:
		square += pow(i, 2)
	#среднее квадратичное
	mean = (square /  (mass.size()))

	rms =  sqrt(mean)
	#math такая **** дрянь, видите ли она положительное значение
	#выплёвывает!
	return rms

func calculate_Power():
	power = stepify(AudioServer.\
	get_bus_peak_volume_right_db(AudioServer.\
	get_bus_index("Calibr"), 0), 0.01)
	return power


func draw_Progress():
	if (bar.value !=100):
		bar.value = tm.time_left
	else:
		bar.value = 0
	pass


func get_Max_no_dupes(mass: Array):
	var maxVal
	maxVal = mass.max()
	while (mass.has(maxVal)):
		mass.erase(maxVal)
	return maxVal
