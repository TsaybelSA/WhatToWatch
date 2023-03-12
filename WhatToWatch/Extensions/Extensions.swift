//
//  Extensions.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 12.03.2023.
//

import UIKit

extension UITableView {
    public func register<T: UITableViewCell>(cell: T.Type) {
        register(T.self, forCellReuseIdentifier: cell.stringSelf)
    }
}

extension UIView {
    static var stringSelf: String {
        String(describing: self)
    }
}

extension UIDevice {
    static var isPad: Bool {
        self.current.userInterfaceIdiom == .pad
    }
}

extension UIWindow {
    static var isLandscape: Bool {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows
                .first?
                .windowScene?
                .interfaceOrientation
                .isLandscape ?? false
        } else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
}
