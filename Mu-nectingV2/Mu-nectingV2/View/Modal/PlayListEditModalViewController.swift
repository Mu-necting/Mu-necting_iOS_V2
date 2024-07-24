//
//  PlayListEditModalViewController.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 7/22/24.
//

import Foundation
import UIKit

protocol PlayListEditModalDelegate : AnyObject {
    func selectPage (index : Int)
}

class PlayListEditModalViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate  {
    weak var delegate: PlayListEditModalDelegate?
    private let pages = [
        "플레이리스트 편집하기",
        "플레이리스트 삭제하기"
    ]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    private let customModal: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var selectedIndexPath: IndexPath?
    private var selectedReason: String?
    
    private var iconViewList : [UIImageView] = []
    
    let pencilIconView : UIImageView = {
        let v = UIImageView()
        v.image = UIImage(systemName: "pencil")
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isUserInteractionEnabled = true
        return v
    }()
    
    let trashIconView : UIImageView = {
        let v = UIImageView()
        v.image = UIImage(systemName: "trash")
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isUserInteractionEnabled = true
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(IconTableViewCell.self, forCellReuseIdentifier: "IconCell")
        
        iconViewList = [
            pencilIconView,
            trashIconView
        ]
        
        view.addSubview(customModal)
        customModal.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            customModal.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customModal.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            customModal.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            customModal.heightAnchor.constraint(equalToConstant: 154),
            
            tableView.topAnchor.constraint(equalTo: customModal.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: customModal.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: customModal.trailingAnchor, constant: -24),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    @objc private func closeModal(index : Int = -1) {
        dismiss(animated: true, completion: nil)
        if(index != -1){
            delegate?.selectPage(index: index)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0 // Change the cell height as needed
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath) as! IconTableViewCell
        
        // 아이콘 및 텍스트 설정
        cell.iconImageView.image = iconViewList[indexPath.row].image
        cell.titleLabel.text = pages[indexPath.row]
            
        if(indexPath.row == 1){
            cell.titleLabel.textColor = .red
            cell.iconImageView.tintColor = .red
        }
        
        cell.selectionStyle = .none
        
     
        cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
   
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Unselect the previously selected cell
        if let selectedIndexPath = selectedIndexPath {
            tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .none
        }
        
        closeModal(index: indexPath.row)
    }
}
