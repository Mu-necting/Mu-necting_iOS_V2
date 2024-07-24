//
//  SearchViewController.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 5/28/24.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    let recentSearchLabel = UILabel()
    let noRecentSearchLabel = UILabel()
    let nowPlayingView = UIView()
    let albumImageView = UIImageView()
    let songTitleLabel = UILabel()
    let artistNameLabel = UILabel()
    let playButton = UIButton()
    let nextButton = UIButton()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Search"
        
        setupSearchController()
        setupRecentSearchLabel()
        setupNoRecentSearchLabel()
        setupNowPlayingView()
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색어를 입력해주세요"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func setupRecentSearchLabel() {
        recentSearchLabel.text = "최근 검색어"
        recentSearchLabel.font = UIFont.systemFont(ofSize: 16)
        recentSearchLabel.textColor = .gray
        recentSearchLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recentSearchLabel)
        
        NSLayoutConstraint.activate([
            recentSearchLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            recentSearchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    func setupNoRecentSearchLabel() {
        noRecentSearchLabel.text = "최근 검색 내역이 없습니다."
        noRecentSearchLabel.font = UIFont.systemFont(ofSize: 16)
        noRecentSearchLabel.textColor = .gray
        noRecentSearchLabel.textAlignment = .center
        noRecentSearchLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noRecentSearchLabel)
        
        NSLayoutConstraint.activate([
            noRecentSearchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noRecentSearchLabel.topAnchor.constraint(equalTo: recentSearchLabel.bottomAnchor, constant: 20)
        ])
    }
    
    func setupNowPlayingView() {
        nowPlayingView.backgroundColor = .white
        nowPlayingView.layer.borderWidth = 0.5
        nowPlayingView.layer.borderColor = UIColor.lightGray.cgColor
        nowPlayingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nowPlayingView)
        
        NSLayoutConstraint.activate([
            nowPlayingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nowPlayingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nowPlayingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nowPlayingView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        configureNowPlayingContent()
    }
    
    func configureNowPlayingContent() {
        albumImageView.image = UIImage(named: "Demo")
        albumImageView.contentMode = .scaleAspectFill
        albumImageView.clipsToBounds = true
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        nowPlayingView.addSubview(albumImageView)
        
        songTitleLabel.text = "곡 제목"
        songTitleLabel.font = UIFont.systemFont(ofSize: 16)
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        nowPlayingView.addSubview(songTitleLabel)
        
        artistNameLabel.text = "가수 이름"
        artistNameLabel.font = UIFont.systemFont(ofSize: 14)
        artistNameLabel.textColor = .gray
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        nowPlayingView.addSubview(artistNameLabel)
        
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        nowPlayingView.addSubview(playButton)
        
        nextButton.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nowPlayingView.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: nowPlayingView.leadingAnchor, constant: 8),
            albumImageView.centerYAnchor.constraint(equalTo: nowPlayingView.centerYAnchor),
            albumImageView.widthAnchor.constraint(equalToConstant: 44),
            albumImageView.heightAnchor.constraint(equalToConstant: 44),
            
            songTitleLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 8),
            songTitleLabel.topAnchor.constraint(equalTo: nowPlayingView.topAnchor, constant: 8),
            
            artistNameLabel.leadingAnchor.constraint(equalTo: songTitleLabel.leadingAnchor),
            artistNameLabel.topAnchor.constraint(equalTo: songTitleLabel.bottomAnchor, constant: 4),
            
            playButton.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -8),
            playButton.centerYAnchor.constraint(equalTo: nowPlayingView.centerYAnchor),
            
            nextButton.trailingAnchor.constraint(equalTo: nowPlayingView.trailingAnchor, constant: -8),
            nextButton.centerYAnchor.constraint(equalTo: nowPlayingView.centerYAnchor)
        ])
    }
    
    // UISearchResultsUpdating 메서드
    func updateSearchResults(for searchController: UISearchController) {
        // 검색 결과 업데이트 로직을 여기에 추가하세요.
    }
}
