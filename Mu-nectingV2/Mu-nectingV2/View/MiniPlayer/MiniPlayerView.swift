//
//  MiniPlayerView.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 8/12/24.
//

import Foundation
import UIKit
import Kingfisher

class MiniPlayerView : UIView {
    
    var progressTimer : Timer!
    var musicHelper = MusicHelper.shared
    var isPlaying : Bool = false
    
    private let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.tintColor = UIColor.systemPink
        progress.progress = 0.0
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "album_placeholder") // 실제 앨범 이미지로 교체
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = "곡 제목"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "가수 이름"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clickPlayPause), for: .touchUpInside)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextMusic), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        initialize()
    }
    
    func initialize(){
        musicHelper.delegate = self
        setView()
        setupMiniPlayerView()
    }
    
    func setView(){
        backgroundColor = .white
        layer.borderColor = UIColor(hexCode: "F5F5F5").cgColor
        layer.borderWidth = 1.0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupMiniPlayerView() {
        addSubview(progressView)
        addSubview(albumImageView)
        addSubview(titleLabel)
        addSubview(artistLabel)
        addSubview(playPauseButton)
        addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: topAnchor),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 2),
            
            albumImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            albumImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            albumImageView.widthAnchor.constraint(equalToConstant: 52),
            albumImageView.heightAnchor.constraint(equalToConstant: 52),
            
            titleLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: playPauseButton.leadingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: albumImageView.topAnchor, constant: 5),
            
            artistLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 12),
            artistLabel.trailingAnchor.constraint(lessThanOrEqualTo: playPauseButton.leadingAnchor, constant: -8),
            artistLabel.bottomAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: -5),
            
            playPauseButton.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -10),
            playPauseButton.heightAnchor.constraint(equalToConstant: 32),
            playPauseButton.widthAnchor.constraint(equalToConstant: 32),
            playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 32),
            nextButton.widthAnchor.constraint(equalToConstant: 32),
            nextButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func playMusic(){
        musicHelper.playMusic()
        progressTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePlaytime), userInfo: nil, repeats: true)
    }
    
    func pauseMusic() {
        musicHelper.pauseMusic()
        progressTimer?.invalidate()
    }
    
    @objc func nextMusic(){
        musicHelper.nextMusic()
        progressTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePlaytime), userInfo: nil, repeats: true)
    }

    
    @objc func clickPlayPause(){
        isPlaying.toggle()
        
        let buttonImageName = isPlaying ? "pause.fill" : "play.fill"
        playPauseButton.setImage(UIImage(systemName: buttonImageName), for: .normal)
    
        if isPlaying {
            playMusic()
        } else {
            pauseMusic()
        }
    }
    

    @objc func updatePlaytime() {
        if musicHelper.musicPlayer == nil {
            progressView.progress = 0
            return
        }
        
        progressView.progress = Float(musicHelper.musicPlayer.currentTime / musicHelper.musicPlayer.duration)
    }
}

extension MiniPlayerView : MusicHelperDelegate {
    func trackDidChange(track: Track) {
        titleLabel.text = track.trackTitle
        
        artistLabel.text = ""
        for artist in musicHelper.getCurrentTrack().artists!{
            artistLabel.text! +=  artist.artistName! + " "
        }
        
        if let imageURL = URL(string: track.albumImages![0].url) {
            albumImageView.kf.setImage(with : imageURL)
        }
    }
}
