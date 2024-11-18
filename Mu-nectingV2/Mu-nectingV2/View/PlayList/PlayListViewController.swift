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
   
    var playListTable = PlayListTableView()
    var type : PlayListPage
    
    lazy var headerButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(onTapHeaderButton))
        button.tintColor = .black
        return button
    }()
    
    var musicList : [Track] = []
    
    init(type: PlayListPage) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        if type == .like {
            title = "좋아요한 음악"
        }else if type == .recentSearch{
            title = "최근 탐색한 음악"
        }else if type == .upload{
            title = "내가 업로드한 음악"
        }

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

            
            // 테이블 뷰 제약 조건
            playListTable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            playListTable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            playListTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playListTable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            playListTable.heightAnchor.constraint(equalToConstant: 1000)
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
