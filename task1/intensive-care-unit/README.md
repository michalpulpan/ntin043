# Úkol č.1 - Maude
## Zadání
topic: algebraic specifications in Maude

deadline: 23.11.2022

Intensive Care Unit
===================
* task 1: create algebraic specification of a control system at intensive care unit (ICU)
	- what you should capture in your model (specification, prototype):
		many dynamic characteristics (properties) of a human body (physiology) are continuously monitored (heart rate, blood pressure, temperature, breathing frequency, neural/brain signals, etc)
		in case of a problem observed by some of the sensors and monitors, the control system quickly decides that some machine will respond by some action (for example, the dropper will immediately start to deliver more fluid of some kind)
	- general principle: the control system of ICU receives inputs from various sensors, produces some outputs (reports), and performs certain actions

* task 2: document your solution
	- explain key decisions and high-level design

* task 3: prepare some test cases (scenarios, inputs)
	- common scenarios that may occur in a real hospital


Řešení
===================


Řešení se skládá z následujících souborů:
* [`icu.maude`](icu.maude) - základní soubor s definicí modulu ICU
* [`patient.maude`](patient.maude) - soubor s definicí modulu pacienta
* [`sensor.maude`](sensor.maude) - soubor s definicí modulu senzoru
* [`icu-test.maude`](icu-test.maude) - soubor s testy

## Sensor
Modul Sensor představuje jednotlivé senzory, které měří různé parametry pacienta. Senzor nese informaci o tom, jaký rozsah hodnot považuje za akceptovavatelný (tj. není nutno vykonávat žádnou dodatečnou akci). Senzory jsou definovány jako moduly, které mají následující atributy:
* `type` - název senzoru (např. `Heart Rate Monitor` nebo `Blood přessure Systolic`)
* `id` - identifikátor senzoru
* `min` - minimální hodnota, kterou senzor považuje za akceptovatelnou
* `max` - maximální hodnota, kterou senzor považuje za akceptovatelnou
* `value` - aktuální naměřená hodnota senzoru
* `status` - aktuální stav senzoru (může nabývat hodnot `OK`, `LOW` nebo `HIGH`)
Uživatel na `Sensor` může vykonávat následující operace:
* Nastavit hodnotu senzoru (`setSensorValue`) - při nastavení hodnoty senzoru se automaticky aktualizuje i stav senzoru
* Získat hodnotu senzoru (`getSensorValue`)
* Získat stav senzoru (`getSensorStatus`)

## PATIENT
Modul Pacient představuje jednotlivé pacienty. Pacient nese informaci primárně o sobě, ale také o tom, jaké senzory má připojené. Pacienti jsou definováni jako moduly, které mají následující atributy:
* `ssn` - rodné číslo pacienta
* `name` - jméno pacienta
* `age` - věk pacienta
* `sensor` - seznam senzorů, které má pacient připojené

## ICU
Modul ICU představuje hlavní část systému a reprezentuje JIP pro jednotlivá oddělení (např. Psychiatrická JIP, Chirurgická JIP, atd.). ICU nese informaci o tom, jaké pacienty má přiřazené. ICU je definován jako modul, který má následující atributy:
* `type` - identifikátor JIP
a následující operace:
* `addPatient` - přidá pacienta do JIP
* `removePatient` - odebere pacienta z JIP
* `attachSensor` - spáruje senzor s pacientem
* `handleSensorValue` - zpracuje hodnotu senzoru (pokud je hodnota mimo rozsah, vyvolá akci `Action` obsahující výsledek vyhodnocení)
ICU obsahuje definované akce pro výkyvy hodnot senzorů pro srdeční tep (`heartRate`), systolický krevní tlak (`bloodPressureSystolic`), diastolický krevní tlak (`bloodPressureDiastolic`) a teplotu (`temperature`).
Metody `performHeartRateAction` resp. `performBloodPressureSystolicAction` resp. `performBloodPressureDiastolicAction` resp. `performTemperatureAction` danou akci "spouští".


## TEST
Modul s testy je definováný v souboru [`test.maude`](test.maude). Testy jsou rozděleny do následujících částí:
* definice prostředí (definice modulu `ICU`, modulu `Patient` (příjem pacienta) a modulu `Sensor` (definice senzorů a jejich připojení k pacientům))
* potom následuje část, kde probíhá:
  * testování getter metod pacienta (`getName`)
  * testování getter metod ICU (`getICU`)
  * testování setter metod Senzoru (`setSensorValue`)
  * testování ICU metody pro kontrolu hodnoty senzoru (`handleSensorValue`)
  * testování ICU metody pro naložení s hodnotou senzoru (`performHeartRateAction`, `performBloodPressureSystolicAction`, `performBloodPressureDiastolicAction`, `performTemperatureAction`)
