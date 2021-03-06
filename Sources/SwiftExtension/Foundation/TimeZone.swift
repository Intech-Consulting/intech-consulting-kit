import Foundation

public extension TimeZone {

    /// Determines if the time zone is the current time zone of the device.
    var isCurrent: Bool {
        return TimeZone.current.secondsFromGMT() == secondsFromGMT()
    }
    
    /// The difference in seconds between the specified time zone and the current time zone of the device.
    var offsetFromCurrent: Int {
        return TimeZone.current.secondsFromGMT() - secondsFromGMT()
    }
}
