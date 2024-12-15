//
//  CommentView.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 12/16/24.
//

import UIKit

class CommentView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var titleLabel = UILabel()
    var musicTitleLabel = UILabel()
    var closeButton = UIButton()
    let tableView = UITableView()
    let messageInputField = UITextField()
    let sendButton = UIButton()
    
    private let controller: CommentViewController // CommentViewController와 연결
    
    // 초기화 시에 controller를 주입받습니다.
    init(controller: CommentViewController) {
        self.controller = controller
        super.init(frame: .zero)
        
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
        configureBlurEffect()
        configureTitle()
        configureCloseButton()
        configureTableView()
        configureSendMessage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
    private func configureTitle() {
        titleLabel.text = "후기"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 18),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        titleLabel.textAlignment = .center
        
        musicTitleLabel.text = "곡 제목"
        musicTitleLabel.font = UIFont.systemFont(ofSize: 12)
        musicTitleLabel.textColor = .lightGray
        musicTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(musicTitleLabel)
        NSLayoutConstraint.activate([
            musicTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            musicTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        musicTitleLabel.textAlignment = .center
    }
    
    private func configureCloseButton() {
        closeButton.setImage(UIImage(named: "Back"), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func closeButtonTapped(sender: UIButton) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: musicTitleLabel.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureSendMessage() {
        messageInputField.placeholder = "노래 후기 남기기"
        messageInputField.layer.backgroundColor = UIColor.white.cgColor
        messageInputField.layer.cornerRadius = 20
        messageInputField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageInputField)
        
        sendButton.setImage(UIImage(named: "Send"), for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            messageInputField.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            messageInputField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageInputField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            messageInputField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),
            messageInputField.heightAnchor.constraint(equalToConstant: 44),
            sendButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sendButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            sendButton.widthAnchor.constraint(equalToConstant: 60),
            sendButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func sendButtonTapped() {
        guard let text = messageInputField.text, !text.isEmpty else { return }
        controller.addMessage(text)
        tableView.reloadData()
        messageInputField.text = ""
        
        let indexPath = IndexPath(row: controller.getMessageCount() - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.getMessageCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentTableViewCell else {
            return UITableViewCell()
        }
        if let message = controller.getMessage(at: indexPath.row) {
            cell.configure(with: message, nickname: "닉네임", date: Date())
        }
        return cell
    }
}
