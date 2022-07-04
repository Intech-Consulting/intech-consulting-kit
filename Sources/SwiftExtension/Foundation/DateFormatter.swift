import Foundation

public extension DateFormatter {
    
    convenience init(dateFormat: String, timeZone: TimeZone? = nil) {
        self.init()
        self.dateFormat = dateFormat
        
        if let timeZone = timeZone {
            self.timeZone = timeZone
        }
    }
    
}
