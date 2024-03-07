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
        
        /*        // Do any additional setup after loading the view.
         let homeVC = HomeViewController()
         let mapVC = MapViewController()
         let uploadVC = UploadViewController()
         let mypageVC = MyPageViewController()
         
         
         //각 tab bar의 viewcontroller 타이틀 설정
         
         homeVC.title = "홈"
         mapVC.title = "지도"
         uploadVC.title = "업로드"
         mypageVC.title = "마이페이지"
         
         //homeVC.tabBarItem.image = UIImage.init(systemName: "house")
         //searchVC.tabBarItem.image = UIImage.init(systemName: "magnifyingglass")
         //libraryVC.tabBarItem.image = UIImage.init(systemName: "book")
         
         //self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
         
         // 위에 타이틀 text를 항상 크게 보이게 설정
         homeVC.navigationItem.largeTitleDisplayMode = .always
         mapVC.navigationItem.largeTitleDisplayMode = .always
         uploadVC.navigationItem.largeTitleDisplayMode = .always
         mypageVC.navigationItem.largeTitleDisplayMode = .always
         
         // navigationController의 root view 설정
         let navigationHome = UINavigationController(rootViewController: homeVC)
         let navigationMap = UINavigationController(rootViewController: mapVC)
         let navigationUpload = UINavigationController(rootViewController: uploadVC)
         let navigationMyPage = UINavigationController(rootViewController: mypageVC)
         
         
         navigationHome.navigationBar.prefersLargeTitles = true
         navigationMap.navigationBar.prefersLargeTitles = true
         navigationUpload.navigationBar.prefersLargeTitles = true
         navigationMyPage.navigationBar.prefersLargeTitles = true
         
         
         setViewControllers([navigationHome, navigationMap, navigationUpload,navigationMyPage], animated: false)
         */
        let homeVC = HomeViewController()
        //homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named:"Home"), tag: 0)

        let mapVC = MapViewController()
        //mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 1)
        mapVC.tabBarItem = UITabBarItem(title: "지도", image: UIImage(named:"Map"), tag: 1)

        
        let uploadVC = UploadViewController()
        //uploadVC.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "square.and.arrow.up"), tag: 2)
        uploadVC.tabBarItem = UITabBarItem(title: "업로드", image: UIImage(named:"Upload"), tag: 2)

        let mypageVC = MyPageViewController()
        //mypageVC.tabBarItem = UITabBarItem(title: "MyPage", image: UIImage(systemName: "person"), tag: 3)
        mypageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named:"MyPage"), tag: 3)

        let controllers = [homeVC, mapVC, uploadVC, mypageVC].map { UINavigationController(rootViewController: $0) }
        
        self.setViewControllers(controllers, animated: false)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

