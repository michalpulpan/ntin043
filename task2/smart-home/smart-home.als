

// ID is unique identifier for each object in the same room
// it's type without internal structure
sig ID {}

abstract sig Device {
    id: one ID,
    type: one DeviceType,
    currentState: one State,
}

// signature SmartHub represents a main controll unit in the home
// contains a set of all devices in the home
sig SmartHub {
    id: one ID,
    devices: set Device,   
}

sig Home {
    id: one ID,
    rooms: set Room,
    hub: one SmartHub,
}