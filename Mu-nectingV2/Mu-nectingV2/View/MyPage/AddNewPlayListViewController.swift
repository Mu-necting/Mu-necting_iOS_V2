//
//  AddNewPlayListViewController.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 7/15/24.
//

import Foundation
import UIKit


class AddNewPlayListViewController: UIViewController, UITextFieldDelegate {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    var playListTable = PlayListTableView()
    
    let nicknameTextField = UITextField()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("곡 추가하기", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        let plusImage = UIImage(systemName: "plus")
        button.setImage(plusImage, for: .normal)
        button.tintColor = .systemPurple
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // 버튼의 이미지와 타이틀을 위아래로 배치
        button.titleEdgeInsets = UIEdgeInsets(top: 50, left: -plusImage!.size.width, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: -button.titleLabel!.intrinsicContentSize.width)
        
        return button
    }()
    
    lazy var completeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonTapped))
        button.tintColor = UIColor(hexCode: "BB00CB")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupScrollView()
        setupNicknameTextField()
        setUpAddButton()
        setupPlayList()
    }
    
    func setupHeader(){
        title = "플레이리스트 만들기"
        navigationItem.rightBarButtonItem = completeButton
    }
    
    func setupPlayList(){
        playListTable.translatesAutoresizingMaskIntoConstraints = false
        playListTable.isEdit = true
        contentView.addSubview(playListTable)
        
        NSLayoutConstraint.activate(([
            playListTable.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 28),
            playListTable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            playListTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playListTable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            playListTable.heightAnchor.constraint(equalToConstant: 200)
        ]))
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
            nicknameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            nicknameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nicknameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            bottomLine.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 8),
            bottomLine.leadingAnchor.constraint(equalTo: nicknameTextField.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: nicknameTextField.trailingAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setUpAddButton(){
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 50)
        ])
    }
    
    @objc func addButtonTapped() {
           // 버튼이 눌렸을 때의 동작을 여기에 추가
        let vc = AddSongViewController()
        navigationController?.pushViewController(vc, animated: true)
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
