//
//  XYNavigationController.swift
//  XYCopyFM
//
//  Created by Wcaulpl on 2019/5/29.
//  Copyright © 2019 Wcaulpl. All rights reserved.
//

import UIKit

class XYNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        interactivePopGestureRecognizer?.delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if children.count > 0 {
            return true
        }
        return false
    }
}
