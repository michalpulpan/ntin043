

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
    currentState: one State,
}




// signatures for different values of devices
sig Color {
    red: one Int,
    green: one Int,
    blue: one Int,
}

abstract sig OnOffValue {}
sig On extends OnOffValue {}
sig Off extends OnOffValue {}

abstract sig WindowValue {}
sig Open extends WindowValue {}
sig Closed extends WindowValue {}

abstract sig DoorValue {}
sig Unlocked extends DoorValue {}
sig Locked extends DoorValue {}

abstract sig AlarmValue {}
sig Armed extends AlarmValue {}
sig Disarmed extends AlarmValue {}


// signature State represents a current state of the device
abstract sig State {}
// Different states of devices
sig LightbulbState extends State {
    value: one OnOffValue,
    color: one Color,
}

sig AirConditionerState extends State {
    temperature: one Int,
    value: one OnOffValue,
}

sig HeaterState extends State {
    temperature: one Int,
    value: one OnOffValue,
}

sig WindowState extends State {
    value: one WindowValue,
}

sig DoorLockState extends State {
    value: one DoorValue,
}

sig AlarmState extends State {
    value: one AlarmValue,
}

sig TemperatureSensorState extends State {
    temperature: one Int,
}

sig LuxSensorState extends State {
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



// Devices

