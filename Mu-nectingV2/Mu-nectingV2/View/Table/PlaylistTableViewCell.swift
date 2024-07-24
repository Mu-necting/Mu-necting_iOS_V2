//
//  PlaylistTableViewCell.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 7/22/24.
//

import Foundation
import UIKit

enum Mode {
    case play
    case edit
}

class PlaylistTableViewCell: UITableViewCell {
    
    private let songImageView = UIImageView()
    private let songTitleLabel = UILabel()
    private let artistNameLabel = UILabel()
    
    private let playButton = UIButton()
    var mode : Mode = Mode.play
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        
        if(mode == Mode.play){
            setupPlayButton()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        songImageView.contentMode = .scaleAspectFill
        songImageView.clipsToBounds = true
        songImageView.layer.cornerRadius = 4
        contentView.addSubview(songImageView)
        
        songTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        contentView.addSubview(songTitleLabel)
        
        artistNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        artistNameLabel.textColor = .gray
        contentView.addSubview(artistNameLabel)
    }
    
    private func setupPlayButton(){
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.tintColor = .black
        contentView.addSubview(playButton)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playButton.centerYAnchor.constraint(equalTo: songImageView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 30),
            playButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupConstraints() {
        songImageView.translatesAutoresizingMaskIntoConstraints = false
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            songImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            songImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            songImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            songImageView.widthAnchor.constraint(equalToConstant: 52),
            songImageView.heightAnchor.constraint(equalToConstant: 52),
            
            songTitleLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 12),
            songTitleLabel.topAnchor.constraint(equalTo: songImageView.topAnchor, constant: 5),
            
            artistNameLabel.leadingAnchor.constraint(equalTo: songTitleLabel.leadingAnchor),
            artistNameLabel.topAnchor.constraint(equalTo: songTitleLabel.bottomAnchor, constant: 4),
        ])
    }
    
    func configure(with title: String, artist: String, imageName: String) {
        songTitleLabel.text = title
        artistNameLabel.text = artist
        songImageView.image = UIImage(named: imageName)
    }
}
