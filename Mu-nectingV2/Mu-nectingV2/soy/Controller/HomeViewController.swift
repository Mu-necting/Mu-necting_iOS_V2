//
//  HomeViewController.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 3/7/24.
//

import UIKit
import MapKit
import CoreLocation

/// HomeViewController Class 입니다.
///
/// Example:
/// ```swift
/// let home = HomeViewController()
/// ```
///
/// - Seealso: Map Class도 봐보세요.
class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    var viewBackgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
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
    
    var albumBackgroundImage = UIImageView()
    var albumImage = UIImageView()
    
    var titleLabel = UILabel()
    var artistLabel = UILabel()
    
    //let progressView = UIProgressView(progressViewStyle: .default)
    var musicSlider = UISlider()
    
    var likeButton = UIButton()
    var liked = false
    var likeCountLabel = UILabel()
    
    var youtubeButton = UIButton()
    var commentButton = UIButton()
    var commentCountLabel = UILabel()
    
    var images: [UIImage?] = [
        UIImage(named: "Dummy"),
        UIImage(named: "Dummy2"),
        UIImage(named: "Dummy3")
    ]
    
    var titles: [String] = ["곡제목1", "곡제목2", "곡제목3"]
    var artists: [String] = ["가수1", "가수2", "가수3"]
    
    var coverImageUrls: [String] = []
    var musicURLs: [String] = ["https://www.youtube.com/watch?v=ZxBV5kC4Gcc" ,"https://www.youtube.com/watch?v=IqaH1xQ9Wmg", "https://www.youtube.com/watch?v=-_r_Y5nuHlo" ]
    
    var albumImg: UIImage?
    var titleText: String?
    var artistText: String?
    var currentIndex: Int = 0
    
    var beforeMusicAlbumImg: UIImageView!
    var nextMusicAlbumImg: UIImageView!
    
    
    // 나중에 수정
    private var mapModel = MapModel()
    private var locationManager: CLLocationManager
    var currentLocation: CLLocation?
    
    private var currentLatitude: Double?
    private var currentLongitude: Double?
    private var locationRadius = 100
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackground()
        configureGenreButtons()
        configureAlbumCoverBackgroundImage()
        configureAlbumCoverImage()
        configureDistanceDropdownButton()
        configureDistanceDropdownTableView()
        configureAlbumInfo() //곡 제목 및 가수
        configureMusicSlider() //곡 진행 정도
        configureInteractionButtons()
        
        // UISwipeGestureRecognizer를 추가
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swipeLeftGesture.direction = .left
        view.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swipeRightGesture.direction = .right
        view.addGestureRecognizer(swipeRightGesture)
        
        for index in 0..<5 {
            UserDefaults.standard.set(false, forKey: "liked\(index)")
            likeButton.setImage(UIImage(named: "Like"), for: .normal)
        }
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    init() {
        locationManager = CLLocationManager() // 먼저 초기화
        super.init(nibName: nil, bundle: nil) // 초기화 후 슈퍼 클래스의 이니셜라이저 호출
    }
        
    required init?(coder: NSCoder) {
        locationManager = CLLocationManager() // 이 경우에도 locationManager를 초기화
        super.init(coder: coder) // 부모 클래스의 초기화 메서드 호출
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
        viewBackgroundImage.image = UIImage(named: "Dummy")
        viewBackgroundImage.contentMode = .scaleAspectFill
        view.addSubview(viewBackgroundImage)
        
        //블러효과
        let blurEffect = UIBlurEffect(style: .light) // .dark, .extraLight 등으로 스타일 변경 가능
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewBackgroundImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // 화면 회전 등에 대응하기 위함
        viewBackgroundImage.addSubview(blurEffectView)
    }
    
    //장르버튼및스크롤뷰
    func configureGenreButtons() {
        genreScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genreScrollView)
        
        genreScrollView.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            genreScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            genreScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            genreScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            genreScrollView.heightAnchor.constraint(equalToConstant: 33) // 원하는 높이 설정
        ])
        
        let buttonTitles = ["All", "Rock", "Pop", "Jazz", "Classical", "Hip-hop","Rock", "Pop", "Jazz", "Classical", "Hip-hop"]
        var previousButton: UIButton?
        
        for (index, title) in buttonTitles.enumerated() {
            let genreButton = UIButton()
            genreButton.setTitle(title, for: .normal)
            genreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            genreButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            genreButton.setTitleColor(.white, for: .normal)
            genreButton.layer.cornerRadius = 18.5
            genreButton.translatesAutoresizingMaskIntoConstraints = false
            genreScrollView.addSubview(genreButton)
            genreButtons.append(genreButton)
            
            //그림자 효과
            genreButton.layer.shadowColor = UIColor.black.cgColor //그림자 색
            genreButton.layer.shadowOpacity = 0.1 //투명도
            genreButton.layer.shadowOffset = CGSize(width: 0, height: 4) //가로 및 세로 방향
            genreButton.layer.shadowRadius = 2 //퍼짐 정도
            genreButton.clipsToBounds = false
            
            NSLayoutConstraint.activate([
                genreButton.topAnchor.constraint(equalTo: genreScrollView.topAnchor),
                genreButton.bottomAnchor.constraint(equalTo: genreScrollView.bottomAnchor),
                genreButton.heightAnchor.constraint(equalTo: genreScrollView.heightAnchor),
                genreButton.widthAnchor.constraint(equalToConstant: 80) // 버튼 너비 설정
            ])
            
            if let previous = previousButton {
                //이전 버튼이 있다면, 현재 버튼을 이전 버튼의 오른쪽에 위치
                genreButton.leadingAnchor.constraint(equalTo: previous.trailingAnchor, constant: 10).isActive = true
            } else {
                //첫 번째 버튼 -> 스크롤 뷰의 leading에 위치
                genreButton.leadingAnchor.constraint(equalTo: genreScrollView.contentLayoutGuide.leadingAnchor, constant: 10).isActive = true
            }
            
            //마지막 버튼 -> 스크롤 뷰의 trailing에 위치
            if index == buttonTitles.count - 1 {
                genreButton.trailingAnchor.constraint(equalTo: genreScrollView.contentLayoutGuide.trailingAnchor, constant: -10).isActive = true
            }
            
            //버튼 탭 액션 설정
            genreButton.addTarget(self, action: #selector(genreButtonTapped), for: .touchUpInside)
            
            //이전 버튼을 현재 버튼으로 업데이트
            previousButton = genreButton
        }
    }
    
    //거리드롭다운버튼
    func configureDistanceDropdownButton() {
        distanceDropdownButton.translatesAutoresizingMaskIntoConstraints = false
        distanceDropdownButton.setTitle("100m ▼", for: .normal)
        distanceDropdownButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        distanceDropdownButton.setTitleColor(.white, for: .normal)
        distanceDropdownButton.addTarget(self, action: #selector(distanceDropdownButtonTapped), for: .touchUpInside)
        
        view.addSubview(distanceDropdownButton)
        
        NSLayoutConstraint.activate([
            //distanceDropdownButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -50),
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
    func configureAlbumCoverBackgroundImage() {
        albumBackgroundImage.image = UIImage(named: "Dummy")
        albumBackgroundImage.contentMode = .scaleAspectFill // 이미지가 뷰에 꽉 차게
        albumBackgroundImage.clipsToBounds = true // 이미지 뷰의 경계를 넘어서는 부분을 잘라냄
        
        view.addSubview(albumBackgroundImage)
        
        albumBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            albumBackgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //albumImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            albumBackgroundImage.topAnchor.constraint(equalTo: genreScrollView.bottomAnchor, constant: 104),
            albumBackgroundImage.widthAnchor.constraint(equalToConstant: 312),
            albumBackgroundImage.heightAnchor.constraint(equalToConstant: 312)
        ])
        
        //이미지 원형
        //albumImage.layer.cornerRadius = albumImage.frame.size.width / 2
        albumBackgroundImage.layer.cornerRadius = 320 / 2
        
        //블러효과
        let blurEffect = UIBlurEffect(style: .regular) // .dark, .extraLight 등으로 스타일 변경 가능
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = albumBackgroundImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // 화면 회전 등에 대응하기 위함
        albumBackgroundImage.addSubview(blurEffectView)
        
    }
    
    //앨범커버이미지
    func configureAlbumCoverImage() {
        albumImage.image = UIImage(named: "Dummy")
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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.8) // 폰트 색상에 투명도 설정
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
        artistLabel.font = UIFont.systemFont(ofSize: 20)
        artistLabel.textColor = UIColor.white.withAlphaComponent(0.8) // 폰트 색상에 투명도 설정
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
        
        // 커스텀 thumb 이미지 설정
        /*let thumbImage = UIImage(named: "MainThumb")
         musicSlider.setThumbImage(thumbImage, for: .normal)
         musicSlider.setThumbImage(thumbImage, for: .highlighted)*/
        
        view.addSubview(musicSlider)
        
        NSLayoutConstraint.activate([
            // progressView 이용할 경우 musicSlider -> progressView
            musicSlider.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 40),
            musicSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            musicSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        // 초기 진행 상태 설정 (progressbar 이용시)
        //progressView.progress = 0.0 // 0.0이 시작지점
    }
    
    //좋아요, 유튜브, 코멘트 버튼
    func configureInteractionButtons() {
        likeButton.setImage(UIImage(named: "Like"), for: .normal)
        youtubeButton.setImage(UIImage(named: "Youtube"), for: .normal) // 'Play' 이미지로 교체해주세요.
        commentButton.setImage(UIImage(named: "Comment"), for: .normal) // 'Share' 이미지로 교체해주세요.
        
        likeCountLabel.text = "0"
        likeCountLabel.font = UIFont.systemFont(ofSize: 14)
        likeCountLabel.textColor = UIColor.white.withAlphaComponent(0.5) // 폰트 색상에 투명도 설정
        
        commentCountLabel.text = "0"
        commentCountLabel.font = UIFont.systemFont(ofSize: 14)
        commentCountLabel.textColor = UIColor.white.withAlphaComponent(0.5) // 폰트 색상에 투명도 설정
        
        //눌렸을 때
        //likeButton.setImage(UIImage(named: "LikePressed"), for: .highlighted)
        
        [likeButton, youtubeButton, commentButton, likeCountLabel, commentCountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            likeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            likeButton.topAnchor.constraint(equalTo: musicSlider.bottomAnchor, constant: 40),
            //likeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            
            likeCountLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 3),
            likeCountLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            
            commentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            commentButton.topAnchor.constraint(equalTo: musicSlider.bottomAnchor, constant: 40),
            //commentButton.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 10),
            
            //youtubeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -110),
            
            commentCountLabel.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: 3),
            commentCountLabel.centerYAnchor.constraint(equalTo: commentButton.centerYAnchor),
            
            youtubeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            youtubeButton.topAnchor.constraint(equalTo: musicSlider.bottomAnchor, constant: 40),
            //commentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -110)
        ])
        
        //버튼 탭 액션 설정
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        youtubeButton.addTarget(self, action: #selector(youtubeButtonTapped), for: .touchUpInside)
        
    }
    
    //장르버튼동작함수
    @objc func genreButtonTapped(sender: UIButton) {
        guard let buttonTitle = sender.currentTitle else { return }
        print("\(buttonTitle) 버튼이 탭되었습니다")
        
        // 다른 모든 버튼의 선택 상태를 해제하고 그라데이션 제거
        genreButtons.forEach {
            $0.isSelected = false
            $0.setTitleColor(.white, for: .normal)
            $0.removeGradient()
        }
        
        sender.isSelected.toggle()
        
        if sender.isSelected {
            sender.setTitleColor(.white, for: .normal)
            sender.applyGradient(colors: [
                UIColor(red: 255/255, green: 80/255, blue: 185/255, alpha: 0.5),
                UIColor(red: 255/255, green: 132/255, blue: 177/255, alpha: 0.5),
                UIColor(red: 255/255, green: 184/255, blue: 160/255, alpha: 0.5),
                UIColor(red: 255/255, green: 249/255, blue: 96/255, alpha: 0.5)
            ])
        } else {
            sender.setTitleColor(.white, for: .normal)
            sender.removeGradient()
        }
        
        /*sender.isSelected.toggle() // 탭된 버튼의 선택 상태를 토글합니다.
         var genreTapped = UIImage(named: "ButtonTapped")
         let resizedImage = genreTapped?.resize(targetSize: .init(width: 300, height: 100))
         // 배경 이미지 설정
         var genreTapped = UIImage(named: "ButtonTapped")
         sender.setBackgroundImage(resizedImage, for: .selected)
         sender.setImage(genreTapped, for: .selected)
         sender.contentMode = .scaleAspectFill
         sender.clipsToBounds = true
         sender.setTitleColor(UIColor(named: "MapGenreSelected"), for: .selected)*/
        
        /*if let genreButtonImage = UIImage(named: "ButtonTapped") {
         sender.setImage(genreButtonImage, for: .selected)
         sender.imageView?.contentMode = .scaleAspectFill
         sender.clipsToBounds = true
         }*/
    }
    
    //거리버튼동작함수
    @objc func distanceDropdownButtonTapped(_ sender: UIButton) {
        isDistanceDropdownOpen.toggle()
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        // UserDefaults에서 좋아요 상태를 가져오기
        liked = UserDefaults.standard.bool(forKey: "liked\(currentIndex)")
        
        // 좋아요 상태 토글
        liked.toggle()
        
        if liked { //true
            likeButton.setImage(UIImage(named: "Liked"), for: .normal)
            //print("노래 저장 \(currentIndex)")
            
            /*
             if UserDefaults.standard.string(forKey: imagesURL[currentIndex]) != nil {
             print("노래 저장 실패..")
             print("저장 실패 이유: \(UserDefaults.standard.string(forKey: imagesURL[currentIndex]))")
             } else {
             saveMusic(coverImageUrl: imagesURL[currentIndex], title: titles[currentIndex], singer: artists[currentIndex], youtubeUrl: musicURL[currentIndex])
             print("노래 저장 \(currentIndex)")
             
             }
             */
            
        } else {
            likeButton.setImage(UIImage(named: "Like"), for: .normal)
            
            //deleteMusic(coverImageUrl: imagesURL[currentIndex])
        }
        
        // UserDefaults에 좋아요 상태 저장
        UserDefaults.standard.set(liked, forKey: "liked\(currentIndex)")
    }
    
    @objc func commentButtonTapped(_ sender: UIButton) {
        //let commentVC = CommentModalViewController()
        let commentVC = CommentViewController()
        //songSearchVC.modalPresentationStyle = .popover
        commentVC.modalPresentationStyle = .overFullScreen
        //commentVC.view.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        present(commentVC, animated: true, completion: nil)
    }
    
    @objc func youtubeButtonTapped(_ sender: UIButton) {
        let urlString = musicURLs[currentIndex]
        if let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: encodedURLString) {
            openURL(url)
        } else {
            print("유효하지 않은 URL입니다.")
        }
    }
    
    func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { success in
                    if success {
                        print("URL을 열었습니다.")
                    } else {
                        print("URL을 열 수 없습니다.")
                    }
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                if success {
                    print("URL을 열었습니다.")
                } else {
                    print("URL을 열 수 없습니다.")
                }
            }
        } else {
            print("URL을 열 수 없습니다.")
        }
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
    
    // 스와이프 기능
    @objc func swipeLeft(_ gesture: UISwipeGestureRecognizer) {
        guard !artists.isEmpty else { return }
        currentIndex += 1
        if currentIndex >= artists.count {
            currentIndex = 0
        }
        updateUI(with: currentIndex)
    }
    
    @objc func swipeRight(_ gesture: UISwipeGestureRecognizer) {
        guard !artists.isEmpty else { return }
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = artists.count - 1
        }
        updateUI(with: currentIndex)
    }
    
    // 노래 정보 업데이트 함수
    func updateUI(with index: Int) {
        guard index >= 0 && index < artists.count else { return }
        
        UIView.transition(with: albumImage, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.albumImage.image = self.images[index]
        }, completion: nil)
        
        UIView.transition(with: albumBackgroundImage, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.albumBackgroundImage.image = self.images[index]
        }, completion: nil)
        
        UIView.transition(with: viewBackgroundImage, duration: 0.0, options: .transitionCrossDissolve, animations: {
            self.viewBackgroundImage.image = self.images[index]
        }, completion: nil)
        
        let liked = UserDefaults.standard.bool(forKey: "liked\(currentIndex)")
        likeButton.setImage(UIImage(named: liked ? "Liked" : "Like"), for: .normal)
        
        titleLabel.text = titles[index]
        artistLabel.text = artists[index]
    }
    
    
    
    // 나중에 수정
    // 위치 업데이트 시 호출되는 메서드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        print("현재 위치: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        currentLatitude = location.coordinate.latitude
        currentLongitude = location.coordinate.longitude
        
        // 위치 정보를 사용해 서버 데이터 요청
        fetchData()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 정보 가져오기 실패: \(error.localizedDescription)")
    }
    
    // 서버 데이터를 가져오는 메서드
    private func fetchData() {
        guard let latitude = currentLatitude, let longitude = currentLongitude else { return }
        
        MapService.shared.fetchMapData(latitude: latitude, longitude: longitude, radius: locationRadius) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if response.isSuccess {
                        if ((response.data?.isEmpty) != nil) {
                            // 빈 데이터 처리
                            print("요청한 위치 근처에 데이터가 없습니다.")
                            // UI에 "데이터 없음" 메시지 표시
                        } else {
                            print("데이터 요청 성공:", response.data)
                            
                            // 데이터를 UI에 맞게 변환하여 mapModel에 설정
                            //self?.updateMapModel(with: response.data!)
                        }
                    } else {
                        print("데이터 요청 실패:", response.message)
                    }
                case .failure(let error):
                    print("오류 발생:", error.localizedDescription)
                }
            }
        }
    }
    
    // 데이터로 mapModel을 업데이트하고 UI 갱신
    func updateMapModel(with data: [String: Any]) {
        // 데이터 가공 및 mapModel 업데이트
        if let items = data["items"] as? [[String: Any]] {
            mapModel.images.removeAll()
            mapModel.titles.removeAll()
            mapModel.artists.removeAll()
            
            for item in items {
                if let title = item["title"] as? String,
                   let artist = item["artist"] as? String,
                   let imageUrlString = item["imageURL"] as? String,
                   let imageUrl = URL(string: imageUrlString) {
                    
                    // 비동기로 이미지 로드
                    loadImage(from: imageUrl) { image in
                        if let image = image {
                            self.mapModel.images.append(image)
                            self.mapModel.titles.append(title)
                            self.mapModel.artists.append(artist)
                            
                            // 컬렉션 뷰 갱신
//                            DispatchQueue.main.async {
//                                self.mapView.musicCollectionView.reloadData()
//                            }
                        }
                    }
                }
            }
        }
    }
    
    // URL로부터 이미지 로드
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
    
    func tempLogin() {
        
    }
}

extension UIImage {
    func resize(targetSize: CGSize, opaque: Bool = false) -> UIImage? {
        // 1. context를 획득 (사이즈, 투명도, scale 입력)
        // scale의 값이 0이면 현재 화면 기준으로 scale을 잡고, sclae의 값이 1이면 self(이미지) 크기 기준으로 설정
        UIGraphicsBeginImageContextWithOptions(targetSize, opaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .high
        
        // 2. 그리기
        let newRect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        draw(in: newRect)
        
        // 3. 그려진 이미지 가져오기
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 4. context 종료
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIButton {
    func applyGradient(colors: [UIColor], locations: [NSNumber]? = nil) {
        self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = self.layer.cornerRadius
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeGradient() {
        self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
    }
    
}

 
