//
//  DrasboardViewController.swift
//  MVVM Basic
//
//  Created by NDPhu on 7/10/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit

class DrasboardViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabbar: UITabBar!
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initTabbarItem()
        // Do any additional setup after loading the view.
    }

    override var prefersStatusBarHidden: Bool {
      return true
    }
    
    func initTabbarItem() {
        tabbar.delegate = self
        tabbar.selectedItem = tabbar.items![0]
        let homeController = HomeViewController.init(nibName: "HomeViewController", bundle: nil)
        let searchController = SearchViewController.init(nibName: "SearchViewController", bundle: nil)
        let favoriteController = FavoriteViewController.init(nibName: "FavoriteViewController", bundle: nil)
        let profileController = ProfileViewController.init(nibName: "ProfileViewController", bundle: nil)
        viewControllers = [homeController,searchController,favoriteController,profileController]
        
        let vc = viewControllers[selectedIndex]
        addChild(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
    }

}

extension DrasboardViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let previousIndex = selectedIndex
        selectedIndex = item.tag
        
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        
        let vc = viewControllers[selectedIndex]
        addChild(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
}
