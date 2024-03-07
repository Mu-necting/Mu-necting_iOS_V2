//
//  HomeViewController.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 3/7/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경 이미지를 설정합니다.
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Demo") // 'YourImageName'을 배경 이미지 파일 이름으로 바꿔주세요.
        backgroundImage.contentMode = .scaleAspectFill // 또는 적절한 콘텐츠 모드를 설정
        view.addSubview(backgroundImage)
        
        // 블러 효과를 정의합니다.
        let blurEffect = UIBlurEffect(style: .light) // .dark, .extraLight 등으로 스타일 변경 가능
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backgroundImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // 화면 회전 등에 대응하기 위함
        backgroundImage.addSubview(blurEffectView) // 이미지 뷰 위에 블러 효과 뷰를 추가합니다.
        
        /*
         let AlbumImage = UIImageView(frame: UIScreen.main.bounds)
         AlbumImage.image = UIImage(named: "Demo") // 'YourImageName'을 배경 이미지 파일 이름으로 바꿔주세요.
         AlbumImage.contentMode = .scaleAspectFit // 또는 적절한 콘텐츠 모드를 설정
         view.addSubview(AlbumImage)
         */
        
        // 배경 이미지를 설정합니다.
        /*let albumImage = UIImageView(frame: CGRect(x: 100, y: 100, width: 200, height: 200)) // 위치와 크기는 원하는 대로 조정해주세요.
        albumImage.image = UIImage(named: "Demo") // 'Demo'를 배경 이미지 파일 이름으로 바꿔주세요.
        albumImage.contentMode = .scaleAspectFill // 이미지가 뷰에 꽉 차게
        albumImage.clipsToBounds = true // 이미지 뷰의 경계를 넘어서는 부분을 잘라냄

        // 원형으로 만들기 위해 코너의 반지름을 설정합니다.
        albumImage.layer.cornerRadius = albumImage.frame.size.width / 2

        view.addSubview(albumImage)*/
        
        let albumImage = UIImageView()
        albumImage.image = UIImage(named: "Demo") // 'Demo'를 배경 이미지 파일 이름으로 바꿔주세요.
        albumImage.contentMode = .scaleAspectFill // 이미지가 뷰에 꽉 차게
        albumImage.clipsToBounds = true // 이미지 뷰의 경계를 넘어서는 부분을 잘라냄
        
        // 이미지 뷰를 뷰에 추가합니다.
        view.addSubview(albumImage)
        
        // Auto Layout 제약조건을 활성화합니다.
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        
        // 중앙에 위치하고, 너비와 높이를 200으로 설정합니다.
        NSLayoutConstraint.activate([
            albumImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            albumImage.widthAnchor.constraint(equalToConstant: 200),
            albumImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Auto Layout이 설정된 후에 cornerRadius를 설정합니다.
        // 중요: 이 작업은 레이아웃이 확정된 후에 해야 하므로, 적절한 시점에 호출되어야 합니다.
        //albumImage.layer.cornerRadius = albumImage.frame.size.width / 2
        albumImage.layer.cornerRadius = 100 // 너비와 높이가 200이므로, 반은 100이 됩니다.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 여기서도 뷰의 레이아웃이 결정된 후에 cornerRadius를 설정할 수 있습니다.
        if let albumImage = view.subviews.compactMap({ $0 as? UIImageView }).first {
            albumImage.layer.cornerRadius = albumImage.frame.size.width / 2
        }
    }

}
