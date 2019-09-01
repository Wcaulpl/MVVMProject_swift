//
//  XYPlayView.swift
//  XYCopyFM
//
//  Created by Wcaulpl on 2019/5/30.
//  Copyright © 2019 Wcaulpl. All rights reserved.
//

import UIKit

class XYPlayBar: UIView {
    
    static let singlePlay: XYPlayBar = {
        let instance = XYPlayBar()
        instance.setupUI()
        return instance
    }()
    
    public var selectedPlayBlock : (()->Void)?

    func setupUI() {
        self.frame = CGRect(x: kScreenWidth/2.0 - 49.0 / 2.0 - 5.0, y: kScreenHeight - kTabBarHeight-10, width: 49.0 + 10.0, height:  kTabBarHeight+10)
        xy_viewCornerRadius(view: self, radius: (49.0 + 10.0 + 6.0)/2.0, rectCorner: [.topLeft, .topRight])
        self.backgroundColor = UIColor.white
        
        let addBtn = UIButton(type: .custom)
        addBtn.frame = CGRect(x: 0, y: 0, width: 49.0 + 10, height: 49.0 + 10)
        addBtn.setBackgroundImage(UIImage(named: "tabbar_np_normal"), for: .normal)
        addBtn.setImage(UIImage(named: "tabbar_np_playnon"), for: .normal)
        addBtn.addTarget(self, action: #selector(tabBarItemSelected), for: .touchUpInside)
        addBtn.adjustsImageWhenHighlighted = false
        self.addSubview(addBtn)
        
        let imageView = UIImageView(frame: CGRect(x:-3, y: -3, width: 49.0 + 10.0 + 6.0, height:  (49.0 + 10.0 + 6.0) * 13.0 / 15.0))
        imageView.image = UIImage(named: "tabbar_np_shadow")
        addBtn.addSubview(imageView)
    }
    
    @objc func tabBarItemSelected() {
        selectedPlayBlock?()
    }
}
