#if !os(macOS)
import UIKit

public extension UIView {

    var height: CGFloat {
        get { return frame.height }
        set { frame.size.height = newValue }
    }

    var width: CGFloat {
        get { return frame.width }
        set { frame.size.width = newValue }
    }

    var x: CGFloat {
        get { return frame.minX }
        set { frame.origin.x = newValue }
    }

    var y: CGFloat {
        get { return frame.minY }
        set { frame.origin.y = newValue }
    }

    /// A Boolean value that determines whether the view is visible.
    var isVisible: Bool {
        get { return !isHidden }
        set { isHidden = !newValue }
    }
}

public extension UIView {

    /// First responder.
	var firstResponder: UIView? {
		guard !self.isFirstResponder else { return self }
		for subView in subviews {
			if subView.isFirstResponder {
				return subView
			}
		}
		return nil
	}
	
	/// Get view's parent view controller
	var parentViewController: UIViewController? {
		weak var parentResponder: UIResponder? = self
		while parentResponder != nil {
			parentResponder = parentResponder!.next
			if let viewController = parentResponder as? UIViewController {
				return viewController
			}
		}
		return nil
	}

    /// Loads the XIB based on class name and adds as a subview.
    func loadFromNib(bunde: Bundle? = nil) {
        guard let subView = UINib(nibName: "\(type(of: self))", bundle: bunde)
            .instantiate(withOwner: self, options: nil).first as? UIView
                else { return }
        
        subView.frame = bounds
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(subView)
    }
}

public extension UIView {
	
	/// Add shadow to view.
	///
	/// - Parameters:
	///   - color: shadow color (default is #137992).
	///   - radius: shadow radius (default is 3).
	///   - offset: shadow offset (default is .zero).
	///   - opacity: shadow opacity (default is 0.5).
	func addShadow(ofColor color: UIColor = UIColor(hex: 0x137992),
        radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
            layer.shadowColor = color.cgColor
            layer.shadowOffset = offset
            layer.shadowRadius = radius
            layer.shadowOpacity = opacity
            layer.masksToBounds = true
	}
}

public extension UIView {
    
    /// Fade in view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds (default is 0.35 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    func fadeIn(duration: TimeInterval = 0.35, completion: ((Bool) -> Void)? = nil) {
        guard isHidden || alpha < 1 else { completion?(true); return }
        
        if isHidden {
            alpha = 0
        }
        
        UIView.animate(
            withDuration: duration,
            animations: {
                self.isHidden = false
                self.alpha = 1
            },
            completion: completion
        )
    }
    
    /// Fade out view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds (default is 0.35 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    func fadeOut(duration: TimeInterval = 0.35, completion: ((Bool) -> Void)? = nil) {
        guard !isHidden || alpha > 0 else { completion?(true); return }
        
        UIView.animate(
            withDuration: duration,
            animations: {
                self.alpha = 0
            },
            completion:  {
                self.isHidden = true
                completion?($0)
            }
        )
    }
}

public extension UIView {

    /// Returns the user interface direction.
    var userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        return UIView.userInterfaceLayoutDirection(for: semanticContentAttribute)
    }
}

public extension UIView {
    
    /**
     Adds activity indicator to the center of the view.
     
     - returns: Returns an instance of the activity indicator.
     */
    func makeActivityIndicator(
        style: UIActivityIndicatorView.Style = .whiteLarge,
        color: UIColor = .gray,
        size: CGRect = CGRect(x: 0, y: 0, width: 40, height: 40)) -> UIActivityIndicatorView {
            let activityIndicator = UIActivityIndicatorView(frame: size).with {
                $0.style = style
                $0.color = color
                $0.hidesWhenStopped = true
                $0.center = center
            }
            
            addSubview(activityIndicator)
            
            return activityIndicator
    }
}
#endif
