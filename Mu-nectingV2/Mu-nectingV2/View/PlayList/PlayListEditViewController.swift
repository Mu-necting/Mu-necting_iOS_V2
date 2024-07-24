//
//  PlayListEditViewController.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 7/22/24.
//

import Foundation
import UIKit

class PlayListEditViewController: UIViewController, UITextFieldDelegate {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let albumImageView = AlbumImageView(imageName: "Demo4")
    var playList : PlayList
    
    let nicknameTextField = UITextField()
    
    lazy var completeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonTapped))
        button.tintColor = UIColor(hexCode: "BB00CB")
        return button
    }()
    
    init(playList: PlayList) {
        self.playList = playList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupScrollView()
        setupAlbumImageView()
        setupNicknameTextField()
    }
    
    func setupHeader(){
        title = "편집"
        navigationItem.rightBarButtonItem = completeButton
    }
    
    private func setupScrollView() {
        view.backgroundColor = .white
        
        // ScrollView 설정
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // ContentView 설정
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)])
    }
    
    func setupNicknameTextField() {
        nicknameTextField.placeholder = "플레이리스트 제목"
        nicknameTextField.text = playList.title
        nicknameTextField.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nicknameTextField.borderStyle = .none
        nicknameTextField.delegate = self
        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nicknameTextField)
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomLine)
        
        NSLayoutConstraint.activate([
            nicknameTextField.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 24),
            nicknameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nicknameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            bottomLine.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 8),
            bottomLine.leadingAnchor.constraint(equalTo: nicknameTextField.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: nicknameTextField.trailingAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupAlbumImageView(){
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(albumImageView)
        
        NSLayoutConstraint.activate([
            albumImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor, multiplier: 1),
            albumImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),])
    }
    
    @objc private func completeButtonTapped(){
        print("프로필 설정이 완료되었습니다..")
        //        if let changedName = nicknameTextField.text{
        //            delegate?.profileNameChanged (changedName, profileImage)
        //            print(changedName)
        //        }
        //
        dismiss(animated: true, completion: nil)
    }
    
}
