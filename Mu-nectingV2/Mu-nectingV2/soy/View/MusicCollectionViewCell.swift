//
//  MusicCollectionViewCell.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 12/16/24.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    var musicView: UIView!
    
    var titleLabel: UILabel!
    var artistLabel: UILabel!
    var albumImageView: UIImageView!
    
    var musicSlider: UISlider!
    
    var musicControlButton: UIButton!
    // 버튼 상태를 추적할 변수
    var isPlaying: Bool = false {
        didSet {
            // 상태에 따라 이미지 설정
            let imageName = isPlaying ? "MapPause" : "MapPlay"
            musicControlButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    var musicAdditionalButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMusicView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureMusicView() {
        // MusicView 추가
        musicView = UIView()
        musicView.translatesAutoresizingMaskIntoConstraints = false
        musicView.backgroundColor = .white
        musicView.layer.cornerRadius = 20 // radius 설정
        musicView.layer.masksToBounds = true
        contentView.addSubview(musicView)
        
        // musicView의 제약 조건 설정
        NSLayoutConstraint.activate([
            musicView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            musicView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            musicView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            musicView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        
        // 앨범 커버
        albumImageView = UIImageView()
        //albumImageView.image = UIImage(named: "Dummy") // 이미지 설정
        albumImageView.contentMode = .scaleAspectFill // 이미지 비율 유지
        albumImageView.clipsToBounds = true
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        musicView.addSubview(albumImageView)
        
        // 이미지뷰 제약 조건 설정
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: musicView.topAnchor, constant: 24),
            albumImageView.leadingAnchor.constraint(equalTo: musicView.leadingAnchor, constant: 24),
            albumImageView.widthAnchor.constraint(equalToConstant: 84),
            albumImageView.heightAnchor.constraint(equalToConstant: 84)
        ])
        
        //제목 및 가수
        titleLabel = UILabel()
        //titleLabel.text = "곡 제목"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        musicView.addSubview(titleLabel)
        
        // titleLabel의 제약 조건을 추가합니다.
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: musicView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 24)
        ])
        
        artistLabel = UILabel()
        //artistLabel.text = "가수 이름"
        artistLabel.font = UIFont.systemFont(ofSize: 15)
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        musicView.addSubview(artistLabel)
        
        
        //앨범 커버
        /*albumImageView = UIImageView()
         albumImageView.contentMode = .scaleAspectFill // 이미지 비율 유지
         albumImageView.clipsToBounds = true
         albumImageView.translatesAutoresizingMaskIntoConstraints = false
         musicView.addSubview(albumImageView)
         
         //제목 및 가수
         titleLabel = UILabel()
         titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         musicView.addSubview(titleLabel)
         
         artistLabel = UILabel()
         artistLabel.font = UIFont.systemFont(ofSize: 15)
         artistLabel.translatesAutoresizingMaskIntoConstraints = false
         musicView.addSubview(artistLabel)*/
        
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            artistLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 24)
        ])
        
        //재생, 정지 버튼
        musicControlButton = UIButton()
        musicControlButton.setImage(UIImage(named: "MapPlay"), for: .normal)
        musicControlButton.translatesAutoresizingMaskIntoConstraints = false
        musicView.addSubview(musicControlButton)
        
        //눌렸을 때
        //likeButton.setImage(UIImage(named: "LikePressed"), for: .highlighted)
        
        NSLayoutConstraint.activate([
            musicControlButton.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 18),
            musicControlButton.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 24),
            musicControlButton.widthAnchor.constraint(equalToConstant: 20),
            musicControlButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        musicControlButton.addTarget(self, action: #selector(controlButtonTapped), for: .touchUpInside)
        
        //뮤직 슬라이더
        musicSlider = UISlider()
        musicSlider.minimumTrackTintColor = UIColor.purple
        musicSlider.translatesAutoresizingMaskIntoConstraints = false
        
        // 커스텀 thumb 이미지 설정
        let thumbImage = UIImage(named: "MusicThumb")
        musicSlider.setThumbImage(thumbImage, for: .normal)
        musicSlider.setThumbImage(thumbImage, for: .highlighted)
                
        musicView.addSubview(musicSlider)
        
        NSLayoutConstraint.activate([
            // progressView 이용할 경우 musicSlider -> progressView
            musicSlider.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 24),
            musicSlider.leadingAnchor.constraint(equalTo: musicControlButton.trailingAnchor, constant: 24),
            musicSlider.widthAnchor.constraint(equalToConstant: 108),
            musicSlider.heightAnchor.constraint(equalToConstant: 7)
        ])
        
        //더보기 버튼
        //재생, 정지 버튼
        musicAdditionalButton = UIButton()
        musicAdditionalButton.setImage(UIImage(named: "More"), for: .normal)
        musicAdditionalButton.translatesAutoresizingMaskIntoConstraints = false
        musicView.addSubview(musicAdditionalButton)
        
        //눌렸을 때
        //likeButton.setImage(UIImage(named: "LikePressed"), for: .highlighted)
        
        NSLayoutConstraint.activate([
            musicAdditionalButton.topAnchor.constraint(equalTo: musicView.topAnchor, constant: 24),
            musicAdditionalButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 63),
            musicAdditionalButton.widthAnchor.constraint(equalToConstant: 24),
            musicAdditionalButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    // 버튼이 눌렸을 때 호출되는 메서드
    @objc func controlButtonTapped() {
        // 버튼 상태 변경
        isPlaying.toggle()
        // 여기에 음악 재생 또는 정지하는 코드 추가
    }
}
