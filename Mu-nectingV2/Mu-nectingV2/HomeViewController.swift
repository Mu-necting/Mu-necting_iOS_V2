//
//  HomeViewController.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 3/7/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let albumImage = UIImageView()
    
    let titleLabel = UILabel()
    let artistLabel = UILabel()
    
    let progressView = UIProgressView(progressViewStyle: .default)

    
    let likeButton = UIButton()
    let youtubeButton = UIButton()
    let commentButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        configureAlbumImage()
        configureAlbumInfo()
        configureProgressView()
        configureButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 여기서도 뷰의 레이아웃이 결정된 후에 cornerRadius를 설정할 수 있습니다.
        if let albumImage = view.subviews.compactMap({ $0 as? UIImageView }).first {
            albumImage.layer.cornerRadius = albumImage.frame.size.width / 2
        }
    }
    
    func configureBackground() {
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
    }
    
    func configureAlbumImage() {
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
    
    func configureAlbumInfo() {
        
        titleLabel.text = "곡 제목"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // titleLabel의 제약 조건을 추가합니다.
        NSLayoutConstraint.activate([
            // titleLabel을 albumImage의 바로 아래에 위치시키기
            titleLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 20), // 20은 albumImage와 titleLabel 사이의 간격입니다. 필요에 따라 조정하세요.
            
            // titleLabel을 가로축으로 뷰의 중앙에 맞추기
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            // titleLabel의 너비 제한을 설정할 수도 있습니다(선택 사항).
            // titleLabel.widthAnchor.constraint(equalToConstant: 200) // 필요한 경우
        ])

        // 추가적으로 titleLabel의 텍스트 정렬을 중앙 정렬로 설정
        titleLabel.textAlignment = .center
        
        artistLabel.text = "가수 이름"
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artistLabel)
        
        // titleLabel의 제약 조건을 추가합니다.
        NSLayoutConstraint.activate([
            // titleLabel을 albumImage의 바로 아래에 위치시키기
            artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20), // 20은 albumImage와 titleLabel 사이의 간격입니다. 필요에 따라 조정하세요.
            
            // titleLabel을 가로축으로 뷰의 중앙에 맞추기
            artistLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            // titleLabel의 너비 제한을 설정할 수도 있습니다(선택 사항).
            // titleLabel.widthAnchor.constraint(equalToConstant: 200) // 필요한 경우
        ])

        // 추가적으로 titleLabel의 텍스트 정렬을 중앙 정렬로 설정
        artistLabel.textAlignment = .center
    }
    
    func configureProgressView() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            // progressView를 playButton의 바로 위에 위치시키기
            progressView.bottomAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 20),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        // 초기 진행 상태 설정
        progressView.progress = 0.0 // 0.0은 시작 지점을 의미합니다.
    }
    
    func configureButton() {
        likeButton.setImage(UIImage(named: "Like"), for: .normal)
        youtubeButton.setImage(UIImage(named: "Youtube"), for: .normal) // 'Play' 이미지로 교체해주세요.
        commentButton.setImage(UIImage(named: "Comment"), for: .normal) // 'Share' 이미지로 교체해주세요.
                
        //눌렸을 때
        //likeButton.setImage(UIImage(named: "LikePressed"), for: .highlighted)
        
        [likeButton, youtubeButton, commentButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        
        NSLayoutConstraint.activate([
            // likeButton을 artistLabel 아래 왼쪽에 위치시킵니다.
            likeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            likeButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20),
            
            // playButton을 artistLabel 아래 중앙에 위치시킵니다.
            youtubeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            youtubeButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20),
            
            // shareButton을 artistLabel 아래 오른쪽에 위치시킵니다.
            commentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            commentButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20)
        ])
        
    }
}
