//
//  UITableViewExtensions.swift
//  Extensions
//
//  Created by BENSALA on 25/04/2019.
//  Copyright © 2019 BENSALA. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UITableView {
    public func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: "\(T.self)")
    }

    public func register<T: UITableViewCell>(_ cellClasses: [T.Type]) {
        cellClasses.forEach { register($0) }
    }

    public func dequeueReusableCell<T: UITableViewCell>(withType _: T.Type) -> T? {
        dequeueReusableCell(withIdentifier: "\(T.self)") as? T
    }

    public func dequeueReusableCell<T: UITableViewCell>(withType _: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T
    }

    public func register<T: UITableViewHeaderFooterView>(_ viewHeaderFooterClass: T.Type) {
        register(viewHeaderFooterClass, forHeaderFooterViewReuseIdentifier: "\(T.self)")
    }

    public func register<T: UITableViewHeaderFooterView>(_ viewHeaderFooterClasses: [T.Type]) {
        viewHeaderFooterClasses.forEach { register($0) }
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withType _: T.Type) -> T? {
        dequeueReusableHeaderFooterView(withIdentifier: "\(T.self)") as? T
    }
}

class TableViewDidSelectDelegateManager: NSObject, UITableViewDelegate {
    var closureDidSelectRowAt: ((IndexPath) -> Void)?
    var closureDidDeselectRowAt: ((IndexPath) -> Void)?

    var closureWillSelectRowAt: ((IndexPath) -> IndexPath?)?
    var closureWillDeselectRowAt: ((IndexPath) -> IndexPath?)?

    var closureWillDisplayCellAtIndexPath: ((UITableViewCell, IndexPath) -> Void)?
    var closureWillDisplayHeaderViewAtIndexPath: ((UIView, Int) -> Void)?
    var closureWillDisplayFooterViewAtIndexPath: ((UIView, Int) -> Void)?
    var closureHeightForRowAt: ((IndexPath) -> CGFloat)?
    var closureHeightForHeaderInSection: ((Int) -> CGFloat)?
    var closureHeightForFooterInSection: ((Int) -> CGFloat)?

    var closureEstimateHeightForRowAt: ((IndexPath) -> CGFloat)?
    var closureEstimateHeightForHeaderInSection: ((Int) -> CGFloat)?
    var closureEstimateHeightForFooterInSection: ((Int) -> CGFloat)?

    var closureViewForHeaderInSection: ((Int) -> UIView?)?
    var closureViewForFooterInSection: ((Int) -> UIView?)?

    var closureAccessoryButtonTappedForRowWith: ((IndexPath) -> Void)?
    var closureShouldHighlightRowAt: ((IndexPath) -> Bool)?

    var closureDidHighlightRowAt: ((IndexPath) -> Void)?
    var closureDidUnhighlightRowAt: ((IndexPath) -> Void)?

    var closureDidEndDisplaying: ((UITableViewCell, IndexPath) -> Void)?
    var closureDidEndDisplayingHeaderView: ((UIView, Int) -> Void)?
    var closureDidEndDisplayingFooterView: ((UIView, Int) -> Void)?

    let tableView: UITableView

    init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView.delegate = self
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        closureDidSelectRowAt?(indexPath)
    }

    func tableView(_: UITableView, didDeselectRowAt indexPath: IndexPath) {
        closureDidDeselectRowAt?(indexPath)
    }

    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        closureWillDisplayCellAtIndexPath?(cell, indexPath)
    }

    func tableView(_: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        closureWillDisplayHeaderViewAtIndexPath?(view, section)
    }

    func tableView(_: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        closureWillDisplayFooterViewAtIndexPath?(view, section)
    }

    func tableView(_: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        closureDidEndDisplaying?(cell, indexPath)
    }

    func tableView(_: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        closureDidEndDisplayingHeaderView?(view, section)
    }

    func tableView(_: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        closureDidEndDisplayingFooterView?(view, section)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        closureHeightForRowAt?(indexPath) ?? tableView.rowHeight
    }

    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        closureHeightForHeaderInSection?(section) ?? 0.0
    }

    func tableView(_: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        closureHeightForFooterInSection?(section) ?? 0.0
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        closureEstimateHeightForRowAt?(indexPath) ?? tableView.estimatedRowHeight
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        closureEstimateHeightForHeaderInSection?(section) ?? tableView.estimatedSectionHeaderHeight
    }

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        closureEstimateHeightForFooterInSection?(section) ?? tableView.estimatedSectionFooterHeight
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        closureViewForHeaderInSection?(section)
    }

    func tableView(_: UITableView, viewForFooterInSection section: Int) -> UIView? {
        closureViewForFooterInSection?(section)
    }

    func tableView(_: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        closureAccessoryButtonTappedForRowWith?(indexPath)
    }

    func tableView(_: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        closureShouldHighlightRowAt?(indexPath) ?? true
    }

    func tableView(_: UITableView, didHighlightRowAt indexPath: IndexPath) {
        closureDidHighlightRowAt?(indexPath)
    }

    func tableView(_: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        closureDidUnhighlightRowAt?(indexPath)
    }

    func tableView(_: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        closureWillSelectRowAt?(indexPath)
    }

    func tableView(_: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        closureWillDeselectRowAt?(indexPath)
    }
}

extension UITableView {
    private struct AssociatedKeys {
        static var DelegateManager = "DelegateManager"
    }

    private var delegateManager: TableViewDidSelectDelegateManager {
        if let delegateManager = objc_getAssociatedObject(self, &UITableView.AssociatedKeys.DelegateManager) {
            return delegateManager as! TableViewDidSelectDelegateManager
        } else {
            let delegateManager = TableViewDidSelectDelegateManager(self)
            objc_setAssociatedObject(
                self,
                &UITableView.AssociatedKeys.DelegateManager,
                delegateManager,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            return delegateManager
        }
    }

    public func didSelectRow(_ closure: @escaping ((IndexPath) -> Void)) {
        delegateManager.closureDidSelectRowAt = closure
    }

    public func didDeselectRow(_ closure: @escaping ((IndexPath) -> Void)) {
        delegateManager.closureDidDeselectRowAt = closure
    }
}

class TableViewDataSourceManagerCollection<T: Collection>: NSObject, UITableViewDataSource {
    let closure: (T, IndexPath) -> UITableViewCell
    let collection: T

    init(_ collection: T, closure: @escaping ((T, IndexPath) -> UITableViewCell)) {
        self.collection = collection
        self.closure = closure
    }

    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        collection.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        closure(collection, indexPath)
    }
}

extension UITableView {
    public func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}
#endif
