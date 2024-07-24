//
//  PlayListViewController.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 5/28/24.
//

import Foundation
import UIKit

class PlaylistViewController: UIViewController, PlayListEditModalDelegate {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let albumImageView = AlbumImageView(imageName: "Demo4")
    private let playAllButton = UIButton()
    var playListTable = PlayListTableView()
    
    var countMusic : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(hexCode: "888888")
        return label
    }()
    
    private let stackView = UIStackView()
    
    lazy var headerButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(onTapHeaderButton))
        button.tintColor = .black
        return button
    }()
    
    var musicList : [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let backBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black  // 색상 변경
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        setupHeader()
        setupUI()
        setupConstraints()
    }
    
    private func setupHeader(){
        title = "포스트말론 플리"
        navigationItem.rightBarButtonItem = headerButton
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // ScrollView 설정
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // ContentView 설정
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
    
        // 앨범 이미지 설정
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(albumImageView)
        
        stackView.axis = .horizontal
        
        contentView.addSubview(stackView)
        
        // 전체 재생 버튼 설정
        playAllButton.setTitle("전체 재생", for: .normal)
        playAllButton.setTitleColor(.white, for: .normal)
        playAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        playAllButton.backgroundColor = UIColor(hexCode: "BB00CB")
        playAllButton.layer.cornerRadius = 18
        playAllButton.addTarget(self, action: #selector(playAllButtonTapped), for: .touchUpInside)
        playAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(playAllButton)
        
        countMusic.text = "\(musicList.count)곡"
        stackView.addArrangedSubview(countMusic)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // 테이블 뷰 설정
        playListTable.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(playListTable)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView 제약 조건
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // ContentView 제약 조건
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            // 앨범 이미지 제약 조건
            albumImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor, multiplier: 1),
            albumImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            
            stackView.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 36),
            
            // 전체 재생 버튼 제약 조건
            playAllButton.heightAnchor.constraint(equalToConstant: 36),
            playAllButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            playAllButton.trailingAnchor.constraint(equalTo: countMusic.leadingAnchor, constant: -24),
            playAllButton.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            
            countMusic.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            countMusic.widthAnchor.constraint(equalToConstant: 30),
            countMusic.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0),
            
            // 테이블 뷰 제약 조건
            playListTable.topAnchor.constraint(equalTo: playAllButton.bottomAnchor, constant: 12),
            playListTable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            playListTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playListTable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            playListTable.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    @objc private func playAllButtonTapped() {
        // 전체 재생 버튼 클릭 시 동작
        print("전체 재생 버튼 클릭됨")
    }
    
    func selectPage(index: Int) {
        if(index == 0){
            // 플레이리스트 편집하기
            let vc = PlayListEditViewController(playList: PlayList( playListId: 0, title:"포스트말론 플리", musicList: []))
            navigationController?.pushViewController(vc, animated: true)
        }
        if(index == 1){
            // 플레이리스트 삭제하기
            
            let sheet = UIAlertController(title: "경고", message: "정말로 삭제하시겠습니까?", preferredStyle: .alert)
            
            sheet.addAction(UIAlertAction(title: "삭제", style: .destructive){
                _ in
                // 삭제 api 요청 보내기
                self.navigationController?.popViewController(animated: true)
            })
                    
            sheet.addAction(UIAlertAction(title: "취소", style: .cancel){
                _ in
            })
            
            present(sheet, animated: true)
        }
    }
    
    @objc func onTapHeaderButton(){
        let vc = PlayListEditModalViewController()
        vc.delegate = self
        present(vc,animated: true)
        
    }
}
