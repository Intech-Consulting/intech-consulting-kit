#if !os(macOS)
import UIKit

public extension UISwitch {
	
	/// Toggle the switch.
	///
	/// - Parameter animated: set true to animate the change (default is true)
	func toggle(animated: Bool = true) {
		setOn(!isOn, animated: animated)
	}
}
#endif
