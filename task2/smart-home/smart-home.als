// ******************* Signatures

// ID is unique identifier for each object in the same room
// it's type without internal structure
sig ID {}

// Main signature for whole home with installed SmartHub under which are all devices assigned
sig Home {
    id: one ID,
    rooms: set Room,
    hub: one SmartHub,
}
// signature SmartHub represents a main controll unit in the home
// contains a set of all devices in the home
sig SmartHub {
    id: one ID,
    devices: set Device,
}

// signature Room represents a room in the home with ID
// contains a set of all devices in the room
sig Room {
    id: one ID,
    devices: set Device,
}

// signature Device represents a device in the room with ID
// contains a current state of the device
abstract sig Device {
    id: one ID,
    type: one DeviceType,
    state: one State,
}

// signature State represents a current state of the device
abstract sig State {}
sig On extends State {}
sig Off extends State {}

// signatures for different values of devices
sig Color {
    red: one Int,
    green: one Int,
    blue: one Int,
}

abstract sig WindowValue {}
sig Open extends WindowValue {}
sig Closed extends WindowValue {}

abstract sig DoorValue {}
sig Unlocked extends DoorValue {}
sig Locked extends DoorValue {}

abstract sig AlarmValue {}
sig Armed extends AlarmValue {}
sig Disarmed extends AlarmValue {}

// Different states of devices

sig LightbulbDevice extends Device {
    color: one Color,
}

sig AirConditionerDevice extends Device {
    temperature: one Int,
}

sig HeaterDevice extends Device {
    temperature: one Int,
}

sig WindowDevice extends Device {
    closed: one WindowValue,
}

sig DoorLockDevice extends Device {
    locked: one DoorValue,
}

sig AlarmDevice extends Device {
    armed: one AlarmValue,
}

sig TemperatureSensorDevice extends Device {
    temperature: one Int,
}

sig LuxSensorDevice extends Device {
    lux: one Int,
}

abstract sig DeviceType {}
// Different types of devices
sig LightType extends DeviceType {}
sig AirConditionerType extends DeviceType {}
sig HeaterType extends DeviceType {}
sig WindowType extends DeviceType {}
sig DoorLockType extends DeviceType {}
sig AlarmType extends DeviceType {}
sig SensorType extends DeviceType {}

// ******************* Facts
// Basic
fact {Device = LightbulbDevice + AirConditionerDevice + HeaterDevice + WindowDevice + 
               DoorLockDevice + AlarmDevice + TemperatureSensorDevice + LuxSensorDevice}
fact {State = On + Off}
fact {WindowValue = Open + Closed}
fact {DoorValue = Unlocked + Locked}
fact {AlarmValue = Armed + Disarmed}
fact {DeviceType = LightType + AirConditionerType + HeaterType + WindowType + 
                   DoorLockType + AlarmType + SensorType}
// Identification

// Every device has unique ID
fact {all d1: Device, d2: Device | d1.id = d2.id => d1 = d2}
// Every room has unique ID
fact {all r1: Room, r2: Room | r1.id = r2.id => r1 = r2}
// Every home has unique ID
fact {all h1: Home, h2: Home | h1.id = h2.id => h1 = h2}
// Every SmartHub has unique ID
fact {all h1: SmartHub, h2: SmartHub | h1.id = h2.id => h1 = h2}

// Safety checks

// Every room is in some home
fact {all r1: Room | some h1: Home | r1 in h1.rooms}
// Every device is in some room
fact {all d1: Device | some r1: Room | d1 in r1.devices}
// Every device is in some smart hub
fact {all d1: Device | some sh1: SmartHub | d1 in sh1.devices}
// Every smart hub is in some home
fact {all sh1: SmartHub | some h1: Home | sh1 = h1.hub}
// There's no device in two rooms at the same time
fact {all d1: Device, r1: Room, r2: Room | d1 in r1.devices and d1 in r2.devices => r1 = r2}
// There's no device in two smart hubs at the same time
fact {all d1: Device, sh1: SmartHub, sh2: SmartHub | d1 in sh1.devices and d1 in sh2.devices => sh1 = sh2}
// Every state is in some device
fact {all s1: State | some d1: Device | s1 = d1.state}
// Every LightbulbDevice has LightBulbType
fact {all d1: LightbulbDevice | d1.type = LightType}
// Every AirConditionerDevice has AirConditionerType
fact {all d1: AirConditionerDevice | d1.type = AirConditionerType}
// Every HeaterDevice has HeaterType
fact {all d1: HeaterDevice | d1.type = HeaterType}
// Every WindowDevice has WindowType
fact {all d1: WindowDevice | d1.type = WindowType}
// Every DoorLockDevice has DoorLockType
fact {all d1: DoorLockDevice | d1.type = DoorLockType}
// Every AlarmDevice has AlarmType
fact {all d1: AlarmDevice | d1.type = AlarmType}
// Every TemperatureSensorDevice has SensorType
fact {all d1: TemperatureSensorDevice | d1.type = SensorType}
// Every LuxSensorDevice has SensorType
fact {all d1: LuxSensorDevice | d1.type = SensorType}

// ******************* Asserts and checks
// Unique home id
assert uniqueHomeId {
    all h1: Home, h2: Home | h1.id = h2.id => h1 = h2
}
// Unique room id
assert uniqueRoomId {
    all r1: Room, r2: Room | r1.id = r2.id => r1 = r2
}
// Unique device id
assert uniqueDeviceId {
    all d1: Device, d2: Device | d1.id = d2.id => d1 = d2
}
// Unique smart hub id
assert uniqueSmartHubId {
    all sh1: SmartHub, sh2: SmartHub | sh1.id = sh2.id  => sh1 = sh2
}
// One smart hub per home
assert oneSmartHubPerHome {
    all h1: Home | lone h1.hub
}
// Home has at least one room
assert homeHasAtLeastOneRoom {
    all h1: Home | #h1.rooms > 0
}
// Every device has a type
assert everyDeviceHasAType {
    all d1: Device | some d1.type
}
// TemperatureSensorDevice is of type SensorType
assert temperatureSensorDeviceIsOfTypeSensorType {
    all d1: TemperatureSensorDevice | d1.type = SensorType
}
// LuxSensorDevice is of type SensorType
assert luxSensorDeviceIsOfTypeSensorType {
    all d1: LuxSensorDevice | d1.type = SensorType
}
// LightbulbDevice is of type LightType
assert lightbulbDeviceIsOfTypeLightType {
    all d1: LightbulbDevice | d1.type = LightType
}
// AirConditionerDevice is of type AirConditionerType
assert airConditionerDeviceIsOfTypeAirConditionerType {
    all d1: AirConditionerDevice | d1.type = AirConditionerType
}
// HeaterDevice is of type HeaterType
assert heaterDeviceIsOfTypeHeaterType {
    all d1: HeaterDevice | d1.type = HeaterType
}
// WindowDevice is of type WindowType
assert windowDeviceIsOfTypeWindowType {
    all d1: WindowDevice | d1.type = WindowType
}
// DoorLockDevice is of type DoorLockType
assert doorLockDeviceIsOfTypeDoorLockType {
    all d1: DoorLockDevice | d1.type = DoorLockType
}
// AlarmDevice is of type AlarmType
assert alarmDeviceIsOfTypeAlarmType {
    all d1: AlarmDevice | d1.type = AlarmType
}
// Temperature of AirConditionerDevice is in range 16-30
assert temperatureOfAirConditionerDeviceIsInRange16_30 {
    all d1: AirConditionerDevice | d1.temperature >= 16 and d1.temperature <= 30
}
// Temperature of HeaterDevice is in range 16-30
assert temperatureOfHeaterDeviceIsInRange16_30 {
    all d1: HeaterDevice | d1.temperature >= 16 and d1.temperature <= 30
}
// Temperature of TemperatureSensorDevice is in range -50-50
assert temperatureOfTemperatureSensorDeviceIsInRange_50_50 {
    all d1: TemperatureSensorDevice | d1.temperature >= -50 and d1.temperature <= 50
}
// All lux values are > 0
assert allLuxValuesAreGreaterThan0 {
    all d1: LuxSensorDevice | d1.lux > 0
}
// Red, Green, Blue are in range 0-255
assert redGreenBlueAreInRange0_255 {
    all c1: Color | c1.red >= 0 and c1.red <= 255 and c1.green >= 0 and c1.green <= 255 and c1.blue >= 0 and c1.blue <= 255
}
// Every state is in some device
assert everyStateIsInSomeDevice {
    all s1: State | some d1: Device | s1 = d1.state
}
// If there's air conditioner and heater in the same room, they are off
assert ifThereIsAirConditionerAndHeaterInTheSameRoomTheyAreOff {
    all r1: Room, ac1: AirConditionerDevice, h1: HeaterDevice | r1.devices = ac1 and r1.devices = h1 => ac1.state = Off and h1.state = Off
}
// ******************* Predicates

pred addRoom [h1 : Home, r1 : Room] {
    h1.rooms = h1.rooms + r1
}

pred addSmartHub [h1 : Home, sh1: SmartHub] {
    h1.hub = sh1
}

pred addDevice [h1 : Home, r1 : Room, d1 : Device] {
    h1.hub.devices = h1.hub.devices + d1
    r1.devices = r1.devices + d1
}

// If window is open, turn off the air conditioner and heater in the same room
pred windowIsOpen [ac1: AirConditionerDevice, h1: HeaterDevice, w1: WindowDevice, r1: Room] {
    ac1 in r1.devices and h1 in r1.devices and w1 in r1.devices // ac1, h1 and w1 are in the same room
    w1.closed = Open // window is open
    ac1.state = Off // turn off air conditioner
    h1.state = Off // turn off heater
}

// If heater is on, turn off the air conditioner in the same room
pred heaterIsOn [ac1: AirConditionerDevice, h1: HeaterDevice, r1: Room] {
    ac1 in r1.devices and h1 in r1.devices // ac1 and h1 are in the same room
    h1.state = On // heater is on
    ac1.state = Off // turn off air conditioner
}

// If air conditioner is on, turn off the heater in the same room
pred airConditionerIsOn [ac1: AirConditionerDevice, h1: HeaterDevice, r1: Room] {
    ac1 in r1.devices and h1 in r1.devices // ac1 and h1 are in the same room
    ac1.state = On // air conditioner is on
    h1.state = Off // turn off heater
}

// If temperature is too high, turn on the air conditioner in the same room
pred temperatureIsTooHigh [ac1: AirConditionerDevice, t1: TemperatureSensorDevice, r1: Room] {
    // can't set real temperature since Alloy doens't find any solution
    ac1 in r1.devices and t1 in r1.devices // ac1 and t1 are in the same room
    t1.temperature > 1 // temperature is too high
    ac1.state = On // turn on air conditioner
}

// If temperature is too low, turn on the heater in the same room
pred temperatureIsTooLow [h1: HeaterDevice, t1: TemperatureSensorDevice, r1: Room] {
    // can't set real temperature since Alloy doens't find any solution
    t1.temperature < 1 // temperature is too low
    h1 in r1.devices and t1 in r1.devices // h1 and t1 are in the same room
    h1.state = On // turn on heater
}

// If there's alarm and door lock in the same room, arm the alarm
pred alarmAndDoorLockInTheSameRoom [a1: AlarmDevice, d1: DoorLockDevice, r1: Room] {
    a1 in r1.devices and d1 in r1.devices // a1 and d1 are in the same room
    d1.locked = Locked // door is locked
    a1.armed = Armed // alarm is armed
}

// ******************* Checks

// check uniqueHomeId for 3
// check uniqueRoomId for 3
// check uniqueDeviceId for 3
// check temperatureOfHeaterDeviceIsInRange16_30 for 3




// ******************* Runs
// run alarmAndDoorLockInTheSameRoom for 10
// run temperatureIsTooLow for 10
// run temperatureIsTooHigh for 10
// run airConditionerIsOn for 10
// run heaterIsOn for 10
// run windowIsOpen for 10


run {} for 15 but exactly 1 Home, exactly 5 Room, exactly 9 Device
