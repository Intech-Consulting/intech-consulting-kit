#if canImport(UIKit)
import UIKit

public extension UIFont {
    
    /// Specify font trait while leaving size intact.
    func with(traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        // https://stackoverflow.com/a/39999497/235334
        let descriptor = fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
}
#endif
