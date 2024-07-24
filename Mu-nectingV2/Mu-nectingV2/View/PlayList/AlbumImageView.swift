//
//  AlbumImageView.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 7/22/24.
//

import Foundation
import UIKit

class AlbumImageView : UIView {
    private let albumImageView: UIImageView
    
    init(imageName: String) {
        albumImageView = UIImageView(image: UIImage(named: imageName))
        albumImageView.contentMode = .scaleAspectFill
        albumImageView.clipsToBounds = true
        albumImageView.layer.cornerRadius = 4
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: .zero)
        setupUI()
    }
    
    private func setupUI(){
        addSubview(albumImageView)
        
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: self.topAnchor),
            albumImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            albumImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            albumImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
