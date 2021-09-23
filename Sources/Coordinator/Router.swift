//
//  Router.swift
//  QuizLearning
//
//  Created by Amine Bensalah on 25/06/2019.
//  Copyright © 2019 Amine Bensalah. All rights reserved.
//

import UIKit

public protocol Showable {
    func toShowable() -> UIViewController
}

extension UIViewController: Showable {
    public func toShowable() -> UIViewController {
        self
    }
}

public protocol Router {
    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController? { get }

    func present(_ module: Showable, animated: Bool, completion: (() -> Void)?)
    func push(_ module: Showable, animated: Bool, completion: (() -> Void)?)
    func pop(animated: Bool)
    func dismiss(_ module: Showable, animated: Bool)
}
