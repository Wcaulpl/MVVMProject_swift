//
//  XYTabBarController.swift
//  XYCopyFM
//
//  Created by Wcaulpl on 2019/5/27.
//  Copyright © 2019 Wcaulpl. All rights reserved.
//

import UIKit

class XYTabBarController: UITabBarController {
    
    let playBar = XYPlayBar.singlePlay
    
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        tabBar.backgroundImage = UIImage(named: "tabbar_bg")
        loadViewController()
        playBar.selectedPlayBlock = {
            let vc = ViewController()
            self.present(vc, animated: true, completion: nil)
        }
        self.view.addSubview(playBar)
    }

    func loadViewController() {
        self.viewControllers = [childController(normalImage: UIImage(named: "tabbar_find_n"), selectedImage: UIImage(named: "tabbar_find_h"), index: 0),
                                childController(normalImage: UIImage(named: "tabbar_sound_n"), selectedImage: UIImage(named: "tabbar_sound_h"), index: 1),
                                childController(normalImage: UIImage(), selectedImage: UIImage(), index: 2),
                                childController(normalImage: UIImage(named: "tabbar_download_n"), selectedImage: UIImage(named: "tabbar_download_h"), index: 3),
                                childController(normalImage: UIImage(named: "tabbar_me_n"), selectedImage: UIImage(named: "tabbar_me_h"), index: 4)];
    }
    
    func childController(normalImage: UIImage?, selectedImage :UIImage?, index : Int) -> XYNavigationController {
        let vc = ViewController()
        vc.tabBarItem.image = normalImage?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        if index == 2 {
            vc.tabBarItem.isEnabled = false
        }
        return XYNavigationController(rootViewController: vc)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bringSubviewToFront(playBar)
    }
}
