//
//  XYHeader.swift
//  XYSwiftMVVM
//
//  Created by Wcaulpl on 2019/6/13.
//  Copyright © 2019 Wcaulpl. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import Alamofire

let iPhoneX = kScreenWidth >= 375.0 && kScreenHeight >= 812.0

let kScreenWidth = Double(UIScreen.main.bounds.size.width)  //获取屏幕宽度
let kScreenHeight = Double(UIScreen.main.bounds.size.height) //获取屏幕高度

let kTabBarHeight = iPhoneX ? 83.0 : 49.0

func xy_viewCornerRadius(view :UIView, radius :CGFloat, rectCorner :UIRectCorner) {
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: rectCorner, cornerRadii: CGSize(width: radius, height: radius)).cgPath
    view.layer.mask = shapeLayer
}

func isReachable() -> Bool {
    return NetworkReachabilityManager()!.isReachable
}

var currentVc: UIViewController? {
    var resultVc: UIViewController?
    resultVc = _currentVc(UIApplication.shared.keyWindow?.rootViewController)
    while resultVc?.presentedViewController != nil {
        resultVc = _currentVc(resultVc?.presentedViewController)
    }
    return resultVc
}

private  func _currentVc(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _currentVc((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _currentVc((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}
