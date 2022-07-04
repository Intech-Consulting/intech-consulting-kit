#if canImport(UIKit)
import UIKit

/// Queue handlers to process on view appear.
public protocol Restorable: class {
    var restorationHandlers: [() -> Void] { get set }
}

public extension Restorable where Self: UIViewController {

    public func willRestorableAppear() {
        // Execute any awaiting tasks
        restorationHandlers.removeEach {
            handler in handler()
        }
    }
    
    public func performRestoration(_ handler: @escaping () -> Void) {
        // Execute process in the right lifecycle
        if isViewLoaded {
            handler()
        } else {
            // Delay execution until view ready
            restorationHandlers.append(handler)
        }
    }
}
#endif
