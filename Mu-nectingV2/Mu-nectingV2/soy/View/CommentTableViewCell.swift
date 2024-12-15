//
//  CommentTableViewCell.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 12/16/24.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    let bubbleBackgroundView = UIView()
    
    let messageLabel = UILabel()
    let nicknameLabel = UILabel()
    let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        // 말풍선 배경 뷰 설정
        bubbleBackgroundView.backgroundColor = .white
        bubbleBackgroundView.layer.cornerRadius = 12
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        //그림자 효과
        bubbleBackgroundView.layer.shadowColor = UIColor.black.cgColor //그림자 색
        bubbleBackgroundView.layer.shadowOpacity = 0.1 //투명도
        bubbleBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 4) //가로 및 세로 방향
        bubbleBackgroundView.layer.shadowRadius = 4 //퍼짐 정도
        bubbleBackgroundView.clipsToBounds = false
        
        // 서브 뷰 추가
        contentView.addSubview(bubbleBackgroundView)
        
        // 닉네임 레이블 설정
        nicknameLabel.font = UIFont.systemFont(ofSize: 12)
        nicknameLabel.textColor = .gray
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 날짜 레이블 설정
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 메시지 레이블 설정
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.textColor = .black
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bubbleBackgroundView.addSubview(nicknameLabel)
        bubbleBackgroundView.addSubview(dateLabel)
        bubbleBackgroundView.addSubview(messageLabel)
        
        // Auto Layout 설정
        NSLayoutConstraint.activate([
            // 말풍선 배경 뷰 제약조건
            
            //왼쪽 정렬
            /*bubbleBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
             bubbleBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
             bubbleBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
             bubbleBackgroundView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10),*/
            
            //오른쪽 정렬
            bubbleBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            bubbleBackgroundView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 50), // 왼쪽 여백을 넉넉히 줍니다.
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10), // 오른쪽에 고정
            
            // 닉네임 레이블 제약조건
            nicknameLabel.topAnchor.constraint(equalTo: bubbleBackgroundView.topAnchor, constant: 10),
            nicknameLabel.leadingAnchor.constraint(equalTo: bubbleBackgroundView.leadingAnchor, constant: 10),
            
            // 날짜 레이블 제약조건
            dateLabel.centerYAnchor.constraint(equalTo: nicknameLabel.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: nicknameLabel.trailingAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: bubbleBackgroundView.trailingAnchor, constant: -10),
            
            // 메시지 레이블 제약조건
            messageLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 5),
            messageLabel.bottomAnchor.constraint(equalTo: bubbleBackgroundView.bottomAnchor, constant: -10),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleBackgroundView.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleBackgroundView.trailingAnchor, constant: -10)
        ])
        
        // 셀 및 컨텐츠의 배경을 투명하게 설정
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    func configure(with message: String, nickname: String, date: Date) {
        messageLabel.text = message
        nicknameLabel.text = nickname
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let formattedDate = dateFormatter.string(from: date)
        dateLabel.text = "| \(formattedDate) "
    }
}
