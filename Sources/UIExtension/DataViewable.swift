#if !os(macOS)
import UIKit

public protocol DataViewable: class {
    var backgroundView: UIView? { get set }
    func reloadData()
}

// Align API's for table and collections views
// http://basememara.com/protocol-oriented-tableview-collectionview/

extension UITableView: DataViewable {}
extension UICollectionView: DataViewable {}
#endif
