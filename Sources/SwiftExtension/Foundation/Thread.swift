import Foundation

public extension Thread {
    typealias Block = @convention(block) () -> Void
    
    /**
     Execute block, used internally for async/sync functions.
     
     - parameter block: Process to be executed.
     */
    @objc private func run(block: Block) {
        block()
    }

//    /**
//     Perform block on current thread asynchronously.
//     
//     - parameter block: Process to be executed.
//     */
//    func async(execute: Block) {
//        guard Thread.current != self else { return execute() }
//        perform(#selector(run(block:)), on: self, with: execute, waitUntilDone: false)
//    }
//
//    /**
//     Perform block on current thread synchronously.
//     
//     - parameter block: Process to be executed.
//     */
//    func sync(execute: Block) {
//        guard Thread.current != self else { return execute() }
//        perform(#selector(run(block:)), on: self, with: execute, waitUntilDone: true)
//    }
}
