//
//  MusicSearchViewController.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 12/16/24.
//

import UIKit

class MusicSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    var images: [UIImage] = [
        UIImage(named: "Demo")!,
        UIImage(named: "Demo2")!,
        UIImage(named: "Demo3")!
    ]
    
    var titles: [String] = ["곡제목1", "곡제목2", "곡제목3"]
    var artists: [String] = ["가수1", "가수2", "가수3"]
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureSearchBar()
        configureTableView()
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "곡 검색"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MusicSearchTableViewCell.self, forCellReuseIdentifier: "MusicCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 검색 로직을 여기에 추가
        // 검색 결과를 반영하도록 데이터 배열 수정
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicSearchTableViewCell
        
        // 데이터 설정
        cell.albumCoverImageView.image = images[indexPath.row]
        cell.songTitleLabel.text = titles[indexPath.row]
        cell.artistNameLabel.text = artists[indexPath.row]
        
        // 재생 버튼 액션 설정
        cell.musicControlButton.tag = indexPath.row
        cell.musicControlButton.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // 셀 높이 설정
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        let songIndex = sender.tag
        let selectedSong = titles[songIndex]
        
        // 재생 로직 추가
        print("Playing song: \(selectedSong)")
    }
    
    //곡선택 시 반응
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     // 곡 선택 로직 추가
     
     guard let uploadVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {return}
     uploadVC.selectedTitle = titles[indexPath.row]
     
     let selectedSong = titles[indexPath.row]
     NotificationCenter.default.post(name: NSNotification.Name("SongSelected"), object: selectedSong)
     dismiss(animated: true, completion: nil)
     }*/
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     // 선택된 제목과 이미지를 가져오기
     let selectedSongTitle = titles[indexPath.row]
     let selectedAlbumImage = images[indexPath.row]
     
     // NotificationCenter에 알림을 보냄
     //NotificationCenter.default.post(name: Notification.Name("SongSelected"), object: selectedSongTitle)
     
     // Segue 실행
     performSegue(withIdentifier: "showUpload", sender: (selectedSongTitle, selectedAlbumImage))
     }
     
     // Segue를 준비할 때 선택한 데이터를 전달
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "showUpload" {
     if let uploadVC = segue.destination as? UploadModalViewController,
     let songInfo = sender as? (String, UIImage) {
     uploadVC.selectedTitle = songInfo.0
     uploadVC.selectedAlbumCover = songInfo.1
     }
     }
     }*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 제목과 이미지를 가져오기
        let selectedSongTitle = titles[indexPath.row]
        let selectedArtist = artists[indexPath.row]
        let selectedAlbumImage = images[indexPath.row]
        
        userDefaults.set(selectedSongTitle, forKey: "selectedSongTitle")
        print(selectedSongTitle)
        
        userDefaults.set(selectedArtist, forKey: "selectedArtist")
        print(selectedArtist)
        
        // 이미지 저장
        if let imageData = selectedAlbumImage.jpegData(compressionQuality: 1.0) {
            userDefaults.set(imageData, forKey: "selectedAlbumImage")
        }
        
        self.dismiss(animated: true, completion: nil)
        
        
        // 이미지 저장
        /*if let albumCoverImage = UIImage(named: "Demo") {
            if let imageData = albumCoverImage.jpegData(compressionQuality: 1.0) {
                userDefaults.set(imageData, forKey: "albumCover")
            }
        }

        // 이미지 불러오기
        if let imageData = userDefaults.data(forKey: "albumCover") {
            let albumCoverImage = UIImage(data: imageData)
            print("이미지 불러오기 성공")
        
        // UploadViewController를 인스턴스화하고 데이터를 전달
        /*let uploadViewController = UploadModalViewController()
        uploadViewController.selectedTitle = selectedSongTitle
        uploadViewController.selectedAlbumCover = selectedAlbumImage
        */
         
        // 화면 전환
        //navigationController?.pushViewController(uploadViewController, animated: true)
        
        // 모달 전환 스타일을 전체 화면으로 설정
        uploadViewController.modalPresentationStyle = .fullScreen
        // 또는 모달 방식으로 표시
        present(uploadViewController, animated:false, completion: nil)
        
        self.dismiss(animated: true, completion: nil)*/
    }
}

