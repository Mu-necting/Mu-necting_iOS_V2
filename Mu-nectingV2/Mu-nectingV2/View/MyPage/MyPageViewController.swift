//
//  MyPageViewController.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 3/7/24.
//

import Foundation
import UIKit


class MyPageViewController: UIViewController {
    var tempUserName : String = ""
    var tempProfileImage: UIImage?
    
    var user : User = User(userID: 1, nickName: "닉네임")
    // 테이블 뷰 데이터 소스
    let myPageData = [ "프로필", "최근 탐색한 음악", "내가 업로드한 음악", "포스트말론 플리", "플레이리스트 추가하기"]
    
    // UITableView 인스턴스
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    let searchView : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Page"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    let headerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        
        view.backgroundColor = .systemBackground
        tempUserName = user.nickName
        
        // 커스텀 UITableViewCell 등록
        tableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: "myPageCell")
        tableView.register(HorizontalImageTableViewCell.self, forCellReuseIdentifier: HorizontalImageTableViewCell.identifier)
        
        // 테이블 뷰의 델리게이트와 데이터 소스 설정
        tableView.delegate = self
        tableView.dataSource = self
        
        // 테이블 뷰를 뷰 계층에 추가
        view.addSubview(tableView)
        
        // 테이블 뷰에 대한 제약 조건 설정
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func settingProfile() {
        let profileVC = ProfileViewController(tempUserName: tempUserName) // 프로필 설정 화면으로 이동
        //        profileVC.delegate = self
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func openPlayList() {
        let playListVC = PlaylistViewController()
        navigationController?.pushViewController(playListVC, animated: true)
    }
    
    func openAddPlayList(){
        let playListVC = AddNewPlayListViewController()
        navigationController?.pushViewController(playListVC, animated: true)
    }
        
    func setupHeader(){
        let titleLabel = UILabel()
        titleLabel.text = "My Page"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.black
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black  // 색상 변경
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        // 네비게이션 바의 왼쪽에 타이틀 라벨 배치
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        // 네비게이션 바의 오른쪽 아이템 설정
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        
        searchButton.tintColor = .black
        
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingButtonTapped))
        settingButton.tintColor = .black

        
        // 오른쪽 버튼들을 배열로 만들어 네비게이션 바에 할당
        self.navigationItem.rightBarButtonItems = [settingButton, searchButton]
    }
    
    @objc func backButtonTapped() {
        // 뒤로 가기 버튼이 눌렸을 때 실행되는 메서드
        // UINavigationController의 popViewController 메서드를 사용하여 이전 화면으로 이동할 수 있음
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func searchButtonTapped() {
        // 검색 버튼 액션 구현
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func settingButtonTapped() {
        let settingVC = SettingsViewController()
        navigationController?.pushViewController(settingVC, animated: true)
        
    }
}

extension MyPageViewController : UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource 메서드
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell : UITableViewCell
        
        if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: HorizontalImageTableViewCell.identifier, for: indexPath) as! HorizontalImageTableViewCell
            let item = myPageData[indexPath.row]
            
            cell.textLabel?.text = item
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            cell.images = [UIImage(named: "Demo4")!, UIImage(named: "Demo4")!, UIImage(named: "Demo4")!, UIImage(named: "Demo4")!]
            
            tableCell = cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "myPageCell", for: indexPath) as! MyPageTableViewCell
            let item = myPageData[indexPath.row]
            
            // 프로필인 경우 프로필 띄우기
            if item == "프로필"{
                tempProfileImage = UIImage(named: "Munecting")
                cell.addProfile(user.nickName, image : tempProfileImage)
            }else{
                cell.textLabel?.text = item
                cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
                
            }
            
            tableCell = cell
        }
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if myPageData[section] == "프로필"{
            return nil // 부제목을 표시하지 않음
        }
        return myPageData[section]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = myPageData[indexPath.row]
        if item == "프로필"{
            return 72 // 프로필인 경우 높이
        }else if item == "최근 탐색한 음악"{
            return 250
        }
        else{
            return 60.0
        }
    }
    
    // MARK: - UITableViewDelegate 메서드
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 셀 선택 처리
        let selectedItem = myPageData[indexPath.row]
        
        switch selectedItem {
        case "프로필":
            // 프로필 뷰로 이동
            print("프로필 선택됨")
            // 프로필 설정 화면으로 이동
            settingProfile()
            
        case "최근 탐색한 음악":
            openPlayList()
        case "포스트말론 플리":
            openPlayList()
        case "플레이리스트 추가하기" :
            openAddPlayList()
        default:
            break
        }
    }
}
