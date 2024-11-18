//
//  TabBarViewController.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 3/7/24.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private let miniPlayerView = MiniPlayerView()
    
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

        let controllers = [homeVC, mapVC, uploadVC, mypageVC]
        
        self.setViewControllers(controllers, animated: true)
//        setupMiniPlayerView()
    }
    
    private func setupMiniPlayerView() {
        let musicHelper = MusicHelper.shared
        musicHelper.setInit(tracks: [
            Track(trackId: "1mWdTewIgB3gtBM3TOSFhB", trackTitle: "Butter", trackPreview: "https://p.scdn.co/mp3-preview/4d63fe1638aa41592706f835bd076443b09d8afa?cid=345a34f068f243c59debd59a01c2802f", albumImages: [
                SpotifyImage(height: 640, width: 640, url: "https://i.scdn.co/image/ab67616d0000b273240447f2da1433d8f4303596")
            ], artists: [Artist(artistName: "BTS", artistId: "3Nrfpe0tUJi4K4DXYWgMUX", artistUri: "spotify:artist:3Nrfpe0tUJi4K4DXYWgMUX", images: nil)], musicTime: nil),
            
            Track(trackId: "16LATbHXLu0gh8MCw1hUGl", trackTitle: "봄날", trackPreview: "https://p.scdn.co/mp3-preview/e2504a289eb9462a6d08e17ae9ce1fade272ab1f?cid=345a34f068f243c59debd59a01c2802f", albumImages: [
                SpotifyImage(height: 640, width: 640, url: "https://i.scdn.co/image/ab67616d0000b273e23a7fd165b24c517a66a69f")
            ], artists: [Artist(artistName: "BTS", artistId: "3Nrfpe0tUJi4K4DXYWgMUX", artistUri: "spotify:artist:3Nrfpe0tUJi4K4DXYWgMUX", images: nil)], musicTime: nil)
            
            
        ], currentNum: 0)
        
        view.addSubview(miniPlayerView)
        
        NSLayoutConstraint.activate([
            miniPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            miniPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            miniPlayerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor),
            miniPlayerView.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
}
