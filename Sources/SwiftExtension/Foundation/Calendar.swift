import Foundation

public extension Calendar {
    
    /// Normalize date calculations using gregorian calendar with UTC timezone and POSIX.
    static let gregorianUTC: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        calendar.locale = .posix
        return calendar
    }()
}

public extension Calendar.Component {
    static var date: Set<Calendar.Component> = { [.year, .month, .day, .hour, .minute, .second] }()
}
