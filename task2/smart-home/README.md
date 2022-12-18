# Task 2: Alloy
- important aspects: various sensors, control, security and other equipment
- you have to decide what entities and operations to capture in the model
    - example: temperature (heating), smoke, lights, cameras, movement, automated locking
    - example: automatically turn on/off some devices based on values recorded by sensors
- do not forget to define some assertions (facts) and commands (run, check)

# Řešení
- [Alloy model](smart-home.als)

Smart home představuje domácnost s různými senzory v různých místnostech. Řešení se skládaá z několika základních signatur:
- [Task 2: Alloy](#task-2-alloy)
- [Řešení](#řešení)
  - [Signatura `Home`](#signatura-home)
  - [Signatura `Room`](#signatura-room)
  - [Signatura `SmartHub`](#signatura-smarthub)
  - [Signatura `Device`](#signatura-device)
  - [Fakty, Asserty a Predikáty](#fakty-asserty-a-predikáty)

Základem je signatura `Home` reprezentující domácnost. Každý dům se zkládá z několika pokojů (`Room`) jenž obsahuje chytrá zařízení `Device`. Jednotlivá zařízení jsou připojena k centrálnímu hubu `SmartHub`.
Dále využijeme prázdnou signaturu `ID` pro identifikaci jednotlivých entit.


## Signatura `Home`
Signatura `Home` obsahuje identifikátor `ID`, několik pokojů `Room` a jeden `SmartHub`.

```alloy
sig Home {
    id: one ID,
    rooms: set Room,
    hub: one SmartHub,
}
```

## Signatura `Room`
Signatura `Room` obsahuje identifikátor `ID` a několik zařízení `Device` v daném pokoji.

```alloy
sig Room {
    id: one ID,
    devices: set Device,
}
```

## Signatura `SmartHub`
Signatura `SmartHub` obsahuje identifikátor `ID` a několik zařízení `Device` připojených k hubu.

```alloy
sig SmartHub {
    id: one ID,
    devices: set Device,
}
```

## Signatura `Device`
Signatura `Device` obsahuje identifikátor `ID`, typ `DeviceType` a stav `State`.

```alloy
abstract sig Device {
    id: one ID,
    type: one DeviceType,
    state: one State,
}
```
`State` definuje jen, zda-li je zařízení zapnuto nebo vypnuto. `DeviceType` definuje typ zařízení, které může být jedním z následujících:
- `LightbulbDevice`
  - jenž má naví atribut `Color` uchovávající barvu světla v RGB.
- `HeaterDevice`
  - s atributem `Temperature` definující teplotu v °C.
- `AirConditionerDevice`
  - s atributem `Temperature` definující teplotu v °C.
- `WindowDevice`
  - s atributem `Closed` obsahující informaci, zda je okno zavřené nebo otevřené.
- `DoorLockDevice`
  - s atributem `Locked` nesoucí informaci, zda jsou dveře zamčené či odemčené.
- `AlarmDevice`
  - s atributem `Armed` obsahující informaci, zda je alarm zakódovaný nebo odkódovaný.
- `TemperatureSensorDevice`
  - s atributem `Temperature` definující teplotu v °C.
- `LuxSensorDevice`
  - s atributem `Lux` definující světelnost v luxech.

## Fakty, Asserty a Predikáty
Druhou částí řešení jsou fakty, asserty a predikáty definované a okomentované přímo v [řešení](smart-home.als#L103).