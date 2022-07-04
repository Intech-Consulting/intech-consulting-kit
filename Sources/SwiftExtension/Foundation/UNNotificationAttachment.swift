import UserNotifications
import Foundation

public enum AppExtensionError: Error {
    case general
    case invalidData
    case notReachable
    case other(Error?)
}


@available(macOS 10.14, *)
public extension UNNotificationAttachment {

    /// Converts a resource from the Internet to a user notification attachment.
    ///
    /// - Parameters:
    ///   - link: The remote HTTP path to the resource.
    ///   - identifier: The identitifer of the user notification attachment.
    ///   - complete: The callback with the constucted user notification attachment.
    static func download(from link: String, identifier: String? = nil, complete: @escaping (Result<UNNotificationAttachment, AppExtensionError>) -> Void) {
        FileManager.default.download(from: link) {
            guard $2 == nil else { return complete(.failure($2 != nil ? .other($2!) : .general)) }
            
            guard let url = $0, let attachment = try? UNNotificationAttachment(identifier: identifier ?? link, url: url)
                else { return complete(.failure(.invalidData)) }
            
            complete(.success(attachment))
        }
    }
}
