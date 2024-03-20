//
//  HomeViewController.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 3/7/24.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var distanceDropdownButton = UIButton()
    var distanceDropdownTableView = UITableView()
    let distanceDropdownData = ["100m", "300m", "500m", "1km"]
    var isDistanceDropdownOpen = false {
        didSet {
            distanceDropdownTableView.isHidden = !isDistanceDropdownOpen
        }
    }
    
    let genreScrollView = UIScrollView()
    var genreButtons: [UIButton] = []
    
    let albumImage = UIImageView()
    
    let titleLabel = UILabel()
    let artistLabel = UILabel()
    
    //let progressView = UIProgressView(progressViewStyle: .default)
    let musicSlider = UISlider()
    
    let likeButton = UIButton()
    let youtubeButton = UIButton()
    let commentButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackground()
        configureGenreButtons()
        configureAlbumCoverImage()
        configureDistanceDropdownButton()
        configureDistanceDropdownTableView()
        configureAlbumInfo() //곡 제목 및 가수
        configureMusicSlider() //곡 진행 정도
        configureInterationButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //뷰의 레이아웃이 결정된 후에 cornerRadius 설정
        if let albumImage = view.subviews.compactMap({ $0 as? UIImageView }).first {
            albumImage.layer.cornerRadius = albumImage.frame.size.width / 2
        }
    }
    
    //배경블러효과
    func configureBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Demo")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        
        //블러효과
        let blurEffect = UIBlurEffect(style: .light) // .dark, .extraLight 등으로 스타일 변경 가능
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backgroundImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // 화면 회전 등에 대응하기 위함
        backgroundImage.addSubview(blurEffectView)
    }

    //장르버튼및스크롤뷰
    func configureGenreButtons() {
        genreScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genreScrollView)
        
        genreScrollView.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            //genreScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -50),
            genreScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            genreScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            genreScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            genreScrollView.heightAnchor.constraint(equalToConstant: 33) // 원하는 높이 설정
        ])
        
        let buttonTitles = ["Rock", "Pop", "Jazz", "Classical", "Hip-hop","Rock", "Pop", "Jazz", "Classical", "Hip-hop"]
        var previousButton: UIButton?
        
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 18.5
            button.translatesAutoresizingMaskIntoConstraints = false
            genreScrollView.addSubview(button)
            genreButtons.append(button)
            
            //그림자 효과
            button.layer.shadowColor = UIColor.black.cgColor //그림자 색
            button.layer.shadowOpacity = 0.1 //투명도
            button.layer.shadowOffset = CGSize(width: 0, height: 4) //가로 및 세로 방향
            button.layer.shadowRadius = 2 //퍼짐 정도
            button.clipsToBounds = false

            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: genreScrollView.topAnchor),
                button.bottomAnchor.constraint(equalTo: genreScrollView.bottomAnchor),
                button.heightAnchor.constraint(equalTo: genreScrollView.heightAnchor),
                button.widthAnchor.constraint(equalToConstant: 80) // 버튼 너비 설정
            ])
            
            if let previous = previousButton {
                //이전 버튼이 있다면, 현재 버튼을 이전 버튼의 오른쪽에 위치
                button.leadingAnchor.constraint(equalTo: previous.trailingAnchor, constant: 10).isActive = true
            } else {
                //첫 번째 버튼 -> 스크롤 뷰의 leading에 위치
                button.leadingAnchor.constraint(equalTo: genreScrollView.contentLayoutGuide.leadingAnchor, constant: 10).isActive = true
            }
            
            //마지막 버튼 -> 스크롤 뷰의 trailing에 위치
            if index == buttonTitles.count - 1 {
                button.trailingAnchor.constraint(equalTo: genreScrollView.contentLayoutGuide.trailingAnchor, constant: -10).isActive = true
            }
            
            //버튼 탭 액션 설정
            button.addTarget(self, action: #selector(genreButtonTapped), for: .touchUpInside)
            
            //이전 버튼을 현재 버튼으로 업데이트
            previousButton = button
        }
    }
    
    //거리드롭다운버튼
    func configureDistanceDropdownButton() {
        
        distanceDropdownButton.translatesAutoresizingMaskIntoConstraints = false
        distanceDropdownButton.setTitle("100m ▼", for: .normal)
        distanceDropdownButton.setTitleColor(.white, for: .normal)
        distanceDropdownButton.addTarget(self, action: #selector(distanceDropdownButtonTapped), for: .touchUpInside)
        
        view.addSubview(distanceDropdownButton)
        
        NSLayoutConstraint.activate([
            distanceDropdownButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            distanceDropdownButton.leadingAnchor.constraint(equalTo: genreScrollView.leadingAnchor, constant: -80), // 스크롤뷰 왼쪽 옆에 배치
            distanceDropdownButton.widthAnchor.constraint(equalToConstant: 80),
            distanceDropdownButton.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    //거리드롭다운테이블뷰
    func configureDistanceDropdownTableView() {
        distanceDropdownTableView.translatesAutoresizingMaskIntoConstraints = false
        distanceDropdownTableView.delegate = self
        distanceDropdownTableView.dataSource = self
        distanceDropdownTableView.isHidden = true
        distanceDropdownTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DropdownCell")
        
        distanceDropdownTableView.backgroundColor = UIColor.white.withAlphaComponent(0.2) // 배경색 투명도
        distanceDropdownTableView.layer.cornerRadius = 12
        
        view.addSubview(distanceDropdownTableView)
        
        NSLayoutConstraint.activate([
            distanceDropdownTableView.topAnchor.constraint(equalTo: distanceDropdownButton.bottomAnchor),
            distanceDropdownTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            distanceDropdownTableView.widthAnchor.constraint(equalToConstant: 116),
            distanceDropdownTableView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    //앨범커버이미지
    func configureAlbumCoverImage() {
 
        albumImage.image = UIImage(named: "Demo")
        albumImage.contentMode = .scaleAspectFill // 이미지가 뷰에 꽉 차게
        albumImage.clipsToBounds = true // 이미지 뷰의 경계를 넘어서는 부분을 잘라냄
        
        view.addSubview(albumImage)
        
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            albumImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //albumImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            albumImage.topAnchor.constraint(equalTo: genreScrollView.bottomAnchor, constant: 114),
            albumImage.widthAnchor.constraint(equalToConstant: 292),
            albumImage.heightAnchor.constraint(equalToConstant: 292)
        ])
        
        //이미지 원형
        //albumImage.layer.cornerRadius = albumImage.frame.size.width / 2
        albumImage.layer.cornerRadius = 292 / 2
        
    }
    
    //곡정보: 곡 제목 및 가수
    func configureAlbumInfo() {
        
        titleLabel.text = "곡 제목"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // titleLabel의 제약 조건을 추가합니다.
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            //너비제한
            //titleLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        titleLabel.textAlignment = .center
        
        artistLabel.text = "가수 이름"
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artistLabel)
        
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            artistLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            //너비제한설정
            //titleLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        //중앙정렬
        artistLabel.textAlignment = .center
    }
    
    //음악진행상황슬라이드바
    func configureMusicSlider() {
        musicSlider.minimumTrackTintColor = UIColor.white
        musicSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(musicSlider)
        
        NSLayoutConstraint.activate([
            // progressView 이용할 경우 musicSlider -> progressView
            musicSlider.bottomAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 40),
            musicSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            musicSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        // 초기 진행 상태 설정 (progressbar 이용시)
        //progressView.progress = 0.0 // 0.0이 시작지점
    }
    
    //좋아요, 유튜브, 코멘트 버튼
    func configureInterationButtons() {
        likeButton.setImage(UIImage(named: "Like"), for: .normal)
        youtubeButton.setImage(UIImage(named: "Youtube"), for: .normal) // 'Play' 이미지로 교체해주세요.
        commentButton.setImage(UIImage(named: "Comment"), for: .normal) // 'Share' 이미지로 교체해주세요.
        
        //눌렸을 때
        //likeButton.setImage(UIImage(named: "LikePressed"), for: .highlighted)
        
        [likeButton, youtubeButton, commentButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        
        NSLayoutConstraint.activate([
            likeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            likeButton.topAnchor.constraint(equalTo: musicSlider.bottomAnchor, constant: 40),
            //likeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -110),
            
            youtubeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            youtubeButton.topAnchor.constraint(equalTo: musicSlider.bottomAnchor, constant: 40),
            //youtubeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -110),

            commentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            commentButton.topAnchor.constraint(equalTo: musicSlider.bottomAnchor, constant: 40),
            //commentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -110)

        ])
        
    }

    //장르버튼동작함수
    @objc func genreButtonTapped(sender: UIButton) {
        guard let buttonTitle = sender.currentTitle else { return }
        print("\(buttonTitle) 버튼이 탭되었습니다")
    }
    
    //거리버튼동작함수
    @objc func distanceDropdownButtonTapped(_ sender: UIButton) {
        isDistanceDropdownOpen.toggle()
    }
    
    //Tableview Delegate & Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return distanceDropdownData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath)
        cell.textLabel?.text = distanceDropdownData[indexPath.row]
        cell.textLabel?.textColor = .white  // Set text color to white
        cell.backgroundColor = .clear       // Optionally set background color to clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        distanceDropdownButton.setTitle(distanceDropdownData[indexPath.row] + " ▼", for: .normal)
        isDistanceDropdownOpen = false
    }
}
