#if !os(macOS)
import UIKit

/// Encapsulate iOS background tasks
open class BackgroundTask {
    private let application: UIApplication
    private var identifier = UIBackgroundTaskIdentifier.invalid
    
    public init(application: UIApplication) {
        self.application = application
    }
    
    /// Execute a process with an indefinite background task.
    /// The handler must call `end()` when it is done.
    open class func run(for application: UIApplication, handler: (BackgroundTask) -> ()) {
        let backgroundTask = BackgroundTask(application: application)
        backgroundTask.begin()
        handler(backgroundTask)
    }
    
    open func begin() {
        self.identifier = application.beginBackgroundTask {
            self.end()
        }
    }
    
    open func end() {
        if identifier != UIBackgroundTaskIdentifier.invalid {
            application.endBackgroundTask(identifier)
        }
        
        identifier = UIBackgroundTaskIdentifier.invalid
    }
}
#endif
