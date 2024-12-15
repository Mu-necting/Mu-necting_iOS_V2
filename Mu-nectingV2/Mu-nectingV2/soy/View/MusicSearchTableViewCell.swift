//
//  MusicSearchTableViewCell.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 12/16/24.
//

import UIKit

class MusicSearchTableViewCell: UITableViewCell {
    
    let albumCoverImageView = UIImageView()
    let songTitleLabel = UILabel()
    let artistNameLabel = UILabel()
    let musicControlButton = UIButton()
    let musicAddButton = UIButton()
    
    let trackService = TrackService()

    // 버튼 상태를 추적할 변수
    var isPlaying: Bool = false {
        didSet {
            // 상태에 따라 이미지 설정
            let imageName = isPlaying ? "UploadPause" : "UploadPlay"
            musicControlButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        albumCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        musicControlButton.translatesAutoresizingMaskIntoConstraints = false
        musicAddButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(songTitleLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(musicControlButton)
        contentView.addSubview(musicAddButton)
        
        // 앨범 커버 이미지 설정
        albumCoverImageView.contentMode = .scaleAspectFill
        albumCoverImageView.clipsToBounds = true
        albumCoverImageView.layer.cornerRadius = 4
        
        songTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        artistNameLabel.font = UIFont.systemFont(ofSize: 15)
        
        // 버튼 타이틀 설정
        let imageName = isPlaying ? "UploadPause" : "UploadPlay"
        musicControlButton.setImage(UIImage(named: imageName), for: .normal)
        musicControlButton.addTarget(self, action: #selector(controlButtonTapped), for: .touchUpInside)
        
        musicAddButton.setImage(UIImage(named: "AddMusic"), for: .normal)
        
        // 오토레이아웃 제약조건 설정
        NSLayoutConstraint.activate([
            albumCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            //albumCoverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            albumCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            albumCoverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            albumCoverImageView.widthAnchor.constraint(equalToConstant: 44),
            albumCoverImageView.heightAnchor.constraint(equalToConstant: 44),
            
            songTitleLabel.leadingAnchor.constraint(equalTo: albumCoverImageView.trailingAnchor, constant: 12),
            //songTitleLabel.trailingAnchor.constraint(equalTo: musicControlButton.leadingAnchor, constant: -168),
            songTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            artistNameLabel.leadingAnchor.constraint(equalTo: albumCoverImageView.trailingAnchor, constant: 12),
            //artistNameLabel.trailingAnchor.constraint(equalTo: musicControlButton.leadingAnchor, constant: -50),
            artistNameLabel.topAnchor.constraint(equalTo: songTitleLabel.bottomAnchor, constant: 4),
            
            musicControlButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            musicControlButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            musicControlButton.widthAnchor.constraint(equalToConstant: 24),
            musicControlButton.heightAnchor.constraint(equalToConstant: 24),
            
            musicAddButton.leadingAnchor.constraint(equalTo: musicControlButton.trailingAnchor, constant: 12),
            musicAddButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            musicAddButton.widthAnchor.constraint(equalToConstant: 24),
            musicAddButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // 버튼이 눌렸을 때 호출되는 메서드
    @objc func controlButtonTapped() {
        // 버튼 상태 변경
        isPlaying.toggle()
        // 여기에 음악 재생 또는 정지하는 코드 추가
        print("Control button tapped, isPlaying: \(isPlaying)")
        
        trackService.fetchTracks { result in
            switch result {
            case .success(let tracks):
                print("Tracks fetched successfully: \(tracks)")
                // 트랙 데이터를 활용하는 로직을 작성하세요.
            case .failure(let error):
                print("Failed to fetch tracks: \(error.localizedDescription)")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
