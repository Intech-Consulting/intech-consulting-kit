#if !os(macOS)
import UIKit

public extension UITableViewCell {

    /// The color of the cell when it is selected.
    var selectionColor: UIColor? {
        get { return selectedBackgroundView?.backgroundColor }
        set {
            guard selectionStyle != .none else { return }
            selectedBackgroundView = UIView().with {
                $0.backgroundColor = newValue
            }
        }
    }
}
#endif
