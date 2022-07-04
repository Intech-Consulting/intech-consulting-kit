#if !os(macOS)
import UIKit

/// The UIView class with a .xib file by the same name wired up.
open class XIBView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    /// Process common code on initialization.
    public func setUp() {
        loadFromNib()
    }
}

// Deprecation notice, will be removed future version
@available(*, unavailable, renamed: "XIBView")
typealias BaseNibView = XIBView
#endif
