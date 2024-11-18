//
//  MyPageTableViewCell.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 3/27/24.
//

import Foundation
import UIKit

class MyPageTableViewCell: UITableViewCell {
    let container : UIView = {
        let view = UIView()
        return view
    }()
    // 셀에 추가할 이미지 뷰
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName:"chevron.forward")
        imageView.tintColor = .black

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userName : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        return label
    }()
    let userImage : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .magenta
        imageView.layer.cornerRadius = 24
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.masksToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.05
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowRadius = 4
        return imageView
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 셀에 이미지 뷰를 추가
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false

        // 이미지 뷰에 대한 제약 조건 설정
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor,constant:-25),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.widthAnchor.constraint(equalToConstant: 89),
        ])
    }
    
    func addProfile (_ name : String, image : UIImage?){
        let blank : UIView = {
            let view = UIView()
            view.backgroundColor = .systemBackground
            return view
        }()
        userName.text = "\(name)"
        userImage.image = image
        
        container.addSubview(userImage)
        container.addSubview(userName)
        container.addSubview(blank)
        container.addSubview(cellImageView)

        userImage.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        blank.translatesAutoresizingMaskIntoConstraints = false
        
        blank.layer.shadowColor = UIColor.black.cgColor
        blank.layer.shadowOffset = CGSize(width: 0, height: 4)
        blank.layer.shadowOpacity = 0.3

        
        NSLayoutConstraint.activate([
            userImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            userImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant:20),
            userImage.widthAnchor.constraint(equalToConstant: 48),
            userImage.heightAnchor.constraint(equalToConstant: 48),

            userName.centerYAnchor.constraint(equalTo: centerYAnchor),
            userName.leadingAnchor.constraint(equalTo:userImage.trailingAnchor,constant:12),
            blank.leadingAnchor.constraint(equalTo: leadingAnchor),
            blank.trailingAnchor.constraint(equalTo: trailingAnchor),
            blank.heightAnchor.constraint(equalToConstant: 1),
            blank.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cellImageView.topAnchor.constraint(equalTo: container.topAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            cellImageView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            cellImageView.heightAnchor.constraint(equalToConstant: 24),
            cellImageView.widthAnchor.constraint(equalToConstant: 24),

        ])
        
    }
    
    func addRecentMusic(music : [Track?]){
        
        NSLayoutConstraint.activate([
            

        ])
    }
    
    
    func setUserName(_ name: String) { // 사용자 이름 업데이트
           userName.text = "\(name)님"
       }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
