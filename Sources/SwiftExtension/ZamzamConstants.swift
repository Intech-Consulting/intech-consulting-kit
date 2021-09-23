import Foundation
#if os(iOS)
    import UIKit
#endif

public struct IntechConsultingConstants {
    
    public struct DateTime {
        public static let JSON_FORMAT = "yyyy-MM-dd'T'HH:mm:ss"
    }
    
    public struct RegEx {
        public static let EMAIL = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        public static let NUMBER = "^[0-9]+?$"
        public static let ALPHA = "^[A-Za-z]+$"
        public static let ALPHANUMERIC = "^[A-Za-z0-9]+$"
    }
    
    public struct Location {
        public static let DEG_TO_RAD = 0.017453292519943295769236907684886
        public static let EARTH_RADIUS_IN_METERS = 6372797.560856
    }
    
    public struct Notification {
        public static let MAIN_CATEGORY = "mainCategory"
    }
    
    public struct Color {
        
        #if os(iOS)
        
        public static func lightOrange() -> UIColor {
            return UIColor(red: 255/255, green: 211/255, blue: 127/255, alpha: 1)
        }
        
        #endif
        
    }
    
}
