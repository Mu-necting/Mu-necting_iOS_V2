//
//  ListeningViewController.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 5/14/24.
//

import Foundation
import UIKit
import AVFoundation

class ListeningViewController: UIViewController {
    
    var musicList : [Track]?
    var selectedIndex : Int = 0 {
        didSet{
            selectedMusic = musicList![selectedIndex]
        }
    }
    var selectedMusic : Track? {
        didSet{
            updateUI()
        }
    }
    
    var artistLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .black.withAlphaComponent(0.3)
        return label
    }()
    
    var shadowView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = false
        view.backgroundColor = .systemBackground
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 14
        return view
    }()
    
    var songTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        //        imageView.layer.borderWidth = 2 // 테두리 두께 설정
        //        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    var currentTimeLabel : UILabel = {
        let currentTimeLabel = UILabel()
        currentTimeLabel.font = UIFont.systemFont(ofSize: 12)
        currentTimeLabel.text = "0:00"
        return currentTimeLabel
    }()
    
    var durationLabel : UILabel = {
        let durationLabel = UILabel()
        durationLabel.font = UIFont.systemFont(ofSize: 12)
        durationLabel.text = "0:00"
        return durationLabel
    }()
    
    var playPauseButton : UIButton = {
        let button = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 36)
        button.setImage(UIImage(systemName: "play.fill", withConfiguration: imageConfig), for: .normal)
        button.tintColor = .black
        return button
    }()
    var previousButton : UIButton = {
        let button = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24)
        button.setImage(UIImage(systemName: "backward.end.fill", withConfiguration: imageConfig), for: .normal)
        button.tintColor = .black
        return button
    }()
    var nextButton : UIButton = {
        let button = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24)
        button.setImage(UIImage(systemName: "forward.end.fill", withConfiguration: imageConfig), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    var ellipsisButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    // 음악 재생 관련 변수
    var audioPlayer: AVAudioPlayer?
    var timer: Timer?
    
    var progressBar: UISlider = {
        let bar = UISlider()
        bar.minimumValue = 0
        bar.maximumValue = 1
        bar.value = 0
        bar.minimumTrackTintColor = .systemPink
        bar.maximumTrackTintColor = .lightGray
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
        //        do {
        //            try audioPlayer = AVAudioPlayer(contentsOf: audioFileURL)
        //            audioPlayer?.delegate = self
        //            audioPlayer?.prepareToPlay()
        //        } catch {
        //            print("Error loading audio file: \(error)")
        //        }
        
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        progressBar.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        setUpMusic()
        selectedIndex = 0
        selectedMusic = musicList![selectedIndex]
        setUpView()
    }
    
    private func setUpMusic(){
        musicList = [
//            Track(trackId: 0, title: "Pink + White", albumImage: "Demo3", musicTime: "3:00:00", singer: "Frank Ocean"),
//            Track(trackId: 1, title: "Believer", albumImage: "Demo2", musicTime: "3:00:00", singer: "Imagine Dragons"),
//            Track(trackId: 2, title: "Myself", albumImage: "Demo4", musicTime: "3:00:00", singer: "Post Malone"),
        ]
    }
    
    private func updateUI(){
        artistLabel.text = selectedMusic?.artists![0].artistName
        songTitleLabel.text = selectedMusic?.trackTitle
        albumImageView.image = UIImage(named: (selectedMusic?.albumImages![0].url)!)
    }
    
    private func setUpView(){
        
        updateUI()
        view.addSubview(shadowView)
        
        shadowView.addSubview(albumImageView)
        
        view.addSubview(artistLabel)
        
        view.addSubview(songTitleLabel)
        
        
        view.addSubview(previousButton)
        view.addSubview(playPauseButton)
        view.addSubview(nextButton)
        
        view.addSubview(progressBar)
        view.addSubview(currentTimeLabel)
        view.addSubview(durationLabel)
        view.addSubview(ellipsisButton)
        
        setUpAutoLayout()
    }
    
    private func setUpAutoLayout(){
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        ellipsisButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            artistLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            ellipsisButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: 24),
            ellipsisButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            shadowView.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 20),
            shadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shadowView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            shadowView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            shadowView.heightAnchor.constraint(equalTo: shadowView.widthAnchor, multiplier: 1),
            
            albumImageView.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 10),
            albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumImageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 10),
            albumImageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -10),
            albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor, multiplier: 1),
            
            
            songTitleLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 54),
            songTitleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            

            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.topAnchor.constraint(equalTo: songTitleLabel.bottomAnchor, constant: 60),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            currentTimeLabel.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
            currentTimeLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 8),
            
            durationLabel.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor),
            durationLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 8),
            
            playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playPauseButton.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 24),
            
            previousButton.trailingAnchor.constraint(equalTo: playPauseButton.leadingAnchor,
                                                    constant: -40),
            previousButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor),
            
            nextButton.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 40),
            nextButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor)
        ])
        
    }
        
    @objc func previousButtonTapped() {
        if(selectedIndex != 0){
            selectedIndex = selectedIndex - 1
        }
    }
    
    @objc func playPauseButtonTapped() {
        //        if player.timeControlStatus == .playing {
        //            player.pause()
        //            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        //        } else {
        //            player.play()
        //            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        //        }
    }
    
    @objc func nextButtonTapped() {
        if(selectedIndex + 1 != musicList?.count){
            selectedIndex = selectedIndex + 1
        }
    }
    
    @objc func sliderValueChanged(_ slider: UISlider) {
        //        guard let duration = player.currentItem?.duration.seconds else {
        //            return
        //        }
        //        let newTime = Double(slider.value) * duration
        //        let time = CMTime(seconds: newTime, preferredTimescale: 600)
        //        player.seek(to: time)
    }
}
