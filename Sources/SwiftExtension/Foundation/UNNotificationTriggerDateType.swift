import UserNotifications

public protocol UNNotificationTriggerDateType {
    func nextTriggerDate() -> Date?
}

extension UNCalendarNotificationTrigger: UNNotificationTriggerDateType {}
extension UNTimeIntervalNotificationTrigger: UNNotificationTriggerDateType {}
