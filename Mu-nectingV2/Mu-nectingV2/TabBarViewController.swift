//
//  TabBarViewController.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 3/7/24.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named:"Home"), tag: 0)

        let mapVC = MapViewController()
        mapVC.tabBarItem = UITabBarItem(title: "지도", image: UIImage(named:"Map"), tag: 1)

        
        let uploadVC = UploadViewController()
        uploadVC.tabBarItem = UITabBarItem(title: "업로드", image: UIImage(named:"Upload"), tag: 2)

        let mypageVC = MyPageViewController()
        mypageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named:"MyPage"), tag: 3)

        let controllers = [homeVC, mapVC, uploadVC, mypageVC].map { UINavigationController(rootViewController: $0) }
        
        self.setViewControllers(controllers, animated: true)
    }
}
