//
//  MusicUploadView.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 12/16/24.
//

import UIKit

class MusicUploadView: UIView {
    
    let titleLabel = UILabel()
    let backButton = UIButton()
    
    let searchLabel = UILabel()
    let searchBar = UISearchBar()

    var selectedTitle: String?
    var selectedArtist: String?
    var selectedAlbumCover: UIImage?
    
    var musicUploadBackGround = UIImageView()
    var albumCoverImgView = UIImageView()
    var musicTitleLabel = UILabel()
    var artistLabel = UILabel()
    
    let genreLabel = UILabel()
    var genreButtons: [UIButton] = []
    var selectedGenres: [String] = []
    let selectedGenresLabel = UILabel() // 선택된 장르를 표시할 UILabel
    var genreButtonOn = false
    
    let timeLabel = UILabel()
    
    let tooltipButton = UIButton()
    var tooltipLabel: UILabel?

    let uploadStatusLabel = UILabel()
    let uploadStatusToggle = UISwitch()
    
    let maintainTimeLabel = UILabel()
    let maintainTimeSlider = UISlider()
    let thumbLabel = UILabel()
    
    let uploadButton = UIButton()
    var musicInfoOn = false
    
    let userDefaults = UserDefaults.standard

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        configureTextLabel()
        configureBackButton()
        configureSearchLabel()
        configureSearchBar()
        configureSelectedMusic()
        configureGenreLabel()
        configureGenreButtons()
        //configureSelectedGenresLabel()
        configureTimeLabel()
        configureUploadStatus()
        configureMaintainTime()
        configureUploadButton()
    }
    
    private func configureTextLabel() {
        titleLabel.text = "곡 업로드"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        //titleLabel.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        addSubview(titleLabel)
        
        // titleLabel의 제약 조건을 추가합니다.
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func configureBackButton() {
        backButton.setImage(UIImage(named: "Back"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 24), // 버튼 너비를 설정합니다.
            backButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configureSearchLabel() {
        searchLabel.text = "업로드 할 곡"
        searchLabel.textColor = .black
        searchLabel.font = UIFont.boldSystemFont(ofSize: 20)
        searchLabel.textAlignment = .left

        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchLabel)
        
        // titleLabel의 제약 조건을 추가합니다.
        NSLayoutConstraint.activate([
            searchLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            searchLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchLabel.heightAnchor.constraint(equalToConstant: 24) // 원하는 높이 설정
        ])
    }
    
    func configureSearchBar() {
        // UISearchBar 설정
        //searchBar.delegate = self
        searchBar.placeholder = "곡 찾기"
        searchBar.searchBarStyle = .minimal
        searchBar.layer.cornerRadius = 20 // 반경을 원하는 값으로 설정합니다.
        searchBar.clipsToBounds = true
        
        // UISearchBar를 뷰에 추가
        addSubview(searchBar)
        
        // Autolayout 설정
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 12),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureSelectedMusic() {
        setupMusicUploadBackground()
        setupAlbumCoverImageView()
        setupMusicTitleLabel()
        setupArtistLabel()
        loadSelectedAlbumImage()
        loadSelectedMusicInfo()
    }

    private func setupMusicUploadBackground() {
        musicUploadBackGround.image = UIImage(named: "MusicUploadBackGround")
        musicUploadBackGround.contentMode = .scaleAspectFill
        musicUploadBackGround.clipsToBounds = true
        addSubview(musicUploadBackGround)
        
        musicUploadBackGround.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            musicUploadBackGround.centerXAnchor.constraint(equalTo: centerXAnchor),
            musicUploadBackGround.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12),
            musicUploadBackGround.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            musicUploadBackGround.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }

    private func setupAlbumCoverImageView() {
        albumCoverImgView.contentMode = .scaleAspectFill
        albumCoverImgView.clipsToBounds = true
        albumCoverImgView.layer.cornerRadius = 4
        addSubview(albumCoverImgView)
        
        albumCoverImgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumCoverImgView.centerYAnchor.constraint(equalTo: musicUploadBackGround.centerYAnchor),
            albumCoverImgView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            albumCoverImgView.widthAnchor.constraint(equalToConstant: 80),
            albumCoverImgView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setupMusicTitleLabel() {
        musicTitleLabel.textColor = .black
        musicTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        musicTitleLabel.textAlignment = .left
        addSubview(musicTitleLabel)
        
        musicTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            musicTitleLabel.topAnchor.constraint(equalTo: musicUploadBackGround.topAnchor, constant: 22),
            musicTitleLabel.leadingAnchor.constraint(equalTo: albumCoverImgView.trailingAnchor, constant: 15),
            musicTitleLabel.widthAnchor.constraint(equalToConstant: 150),
            musicTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func setupArtistLabel() {
        artistLabel.textColor = .black
        artistLabel.font = UIFont.systemFont(ofSize: 15)
        addSubview(artistLabel)
        
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: musicTitleLabel.bottomAnchor, constant: 5),
            artistLabel.leadingAnchor.constraint(equalTo: albumCoverImgView.trailingAnchor, constant: 15),
            artistLabel.widthAnchor.constraint(equalToConstant: 150),
            artistLabel.heightAnchor.constraint(equalToConstant: 17)
        ])
    }

    private func loadSelectedAlbumImage() {
        if let imageData = userDefaults.data(forKey: "selectedAlbumImage") {
            albumCoverImgView.image = UIImage(data: imageData)
            print("이미지 불러오기 성공")
            musicInfoOn = true
        } else {
            print("이미지 없음")
            musicInfoOn = false
        }
    }

    private func loadSelectedMusicInfo() {
        if let selectedTitle = userDefaults.string(forKey: "selectedSongTitle") {
            musicTitleLabel.text = selectedTitle
        } else {
            musicTitleLabel.text = "곡을 선택해주세요."
            musicTitleLabel.textAlignment = .center
            print("노래 없음")
        }
        
        if let selectedArtist = userDefaults.string(forKey: "selectedArtist") {
            artistLabel.text = selectedArtist
        } else {
            print("가수 없음")
        }
    }
    
    func configureGenreLabel() {
        genreLabel.text = "장르"
        genreLabel.textColor = .black
        genreLabel.font = UIFont.boldSystemFont(ofSize: 20)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(genreLabel)

        // 공통 제약 조건 설정
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: musicUploadBackGround.bottomAnchor, constant: 24),
            genreLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            genreLabel.widthAnchor.constraint(equalToConstant: 35),  // 너비 설정
            genreLabel.heightAnchor.constraint(equalToConstant: 24)  // 높이 설정
        ])
        
        genreLabel.textAlignment = .left
    }
    
    func configureGenreButtons() {
        let buttonTitles = ["전체", "Rock", "Pop", "Jazz", "Classical", "Hip-hop", "Rock", "Pop", "Jazz", "Classical", "Hip-hop"]
        let maxButtonsPerRow = 4 // 한 줄에 표시할 최대 버튼 수
        var previousButton: UIButton? = nil
        var previousButtonBottomAnchor: NSLayoutYAxisAnchor = genreLabel.bottomAnchor // 이전 버튼의 바닥 앵커

        // 화면 크기와 버튼 수를 고려해 동적으로 버튼 너비 계산
        let screenWidth = UIScreen.main.bounds.width
        let totalPadding = CGFloat(maxButtonsPerRow + 1) * 10 // 간격 + 왼쪽 여백
        let buttonWidth = (screenWidth - totalPadding) / CGFloat(maxButtonsPerRow) // 동적 버튼 너비 계산
        
        for (index, title) in buttonTitles.enumerated() {
            let genreButton = UIButton()
            genreButton.setTitle(title, for: .normal)
            genreButton.backgroundColor = .white
            genreButton.setTitleColor(.black, for: .normal)
            genreButton.layer.cornerRadius = 18 // 버튼의 원형을 위해 설정
            genreButton.layer.borderWidth = 1.0 // 테두리 두께 설정
            genreButton.layer.borderColor = UIColor.systemGray4.cgColor
            genreButton.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(genreButton)
            genreButtons.append(genreButton) // 배열에 버튼 추가
            
            // 버튼의 제약조건 설정
            NSLayoutConstraint.activate([
                genreButton.heightAnchor.constraint(equalToConstant: 36),
                genreButton.widthAnchor.constraint(equalToConstant: buttonWidth) // 동적 버튼 너비 설정
            ])
            
            // 이전 버튼과의 관계를 정의하는 변수
            let topConstraint: NSLayoutConstraint

            // 이전 버튼이 존재하고, 현재 버튼이 한 줄에 계속 배치되는 경우
            if let previousButton = previousButton, index % maxButtonsPerRow != 0 {
                // 이전 버튼의 오른쪽에 현재 버튼을 배치
                genreButton.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 10).isActive = true
                // 상단은 이전 버튼과 동일한 위치로 맞춤
                topConstraint = genreButton.topAnchor.constraint(equalTo: previousButton.topAnchor)
            } else {
                // 새로운 줄의 첫 번째 버튼일 경우
                if index % maxButtonsPerRow == 0 {
                    // 왼쪽 여백을 추가하여 새 줄의 첫 번째 버튼을 배치
                    genreButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
                }
                // 새로운 줄에서 첫 번째 버튼의 상단은 이전 줄의 마지막 버튼의 하단에 맞춤
                topConstraint = genreButton.topAnchor.constraint(equalTo: previousButtonBottomAnchor, constant: 12)
                // 다음 줄의 첫 번째 버튼을 위해 이전 버튼의 하단을 업데이트
                previousButtonBottomAnchor = genreButton.bottomAnchor
            }

            // 상단 제약 활성화
            topConstraint.isActive = true

            // 마지막 버튼에 대해 trailing 여백 추가
            if (index + 1) % maxButtonsPerRow == 0 {
                genreButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
            }
            
            // 버튼이 화면 하단을 벗어나지 않도록 하단 제약 설정
            //genreButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16).isActive = true

            // 현재 버튼을 다음 버튼의 기준으로 설정
            previousButton = genreButton
        }
    }


    func configureTimeLabel() {
        timeLabel.text = "업로드 유지 시간 설정"
        timeLabel.textColor = .black
        timeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(timeLabel)
        
        // titleLabel의 제약 조건을 추가합니다.
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: genreButtons.last!.bottomAnchor, constant: 32), //옵셔널 해결하기
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            timeLabel.heightAnchor.constraint(equalToConstant: 24) // 원하는 높이 설정
        ])
        
        timeLabel.textAlignment = .left
        
        // 툴팁 버튼 설정
        configureTooltipButton()
    }
    
    private func configureTooltipButton() {
        tooltipButton.setImage(UIImage(named: "ToolTip"), for: .normal)
        tooltipButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tooltipButton)
        
        NSLayoutConstraint.activate([
            tooltipButton.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            tooltipButton.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 2)
        ])
    }
    
    func showTooltip() {
            tooltipLabel = UILabel()
            tooltipLabel?.text = "유지 시간 설정시, 설정한 시간이 지나면 업로드한 곡이 지도에서 내려갑니다."
            tooltipLabel?.backgroundColor = .white
            tooltipLabel?.textColor = .gray
            tooltipLabel?.font = UIFont.systemFont(ofSize: 14)
            tooltipLabel?.numberOfLines = 2
            tooltipLabel?.textAlignment = .center
            tooltipLabel?.layer.borderColor = UIColor.systemGray4.cgColor
            tooltipLabel?.layer.borderWidth = 1.0
            tooltipLabel?.layer.cornerRadius = 15
            tooltipLabel?.clipsToBounds = true
            tooltipLabel?.translatesAutoresizingMaskIntoConstraints = false

            guard let tooltipLabel = tooltipLabel else { return }
            addSubview(tooltipLabel)

            // 툴팁 위치 설정
            NSLayoutConstraint.activate([
                tooltipLabel.topAnchor.constraint(equalTo: tooltipButton.bottomAnchor, constant: 5),
                tooltipLabel.centerXAnchor.constraint(equalTo: tooltipButton.centerXAnchor),
                tooltipLabel.widthAnchor.constraint(equalToConstant: 250),
                tooltipLabel.heightAnchor.constraint(equalToConstant: 55)
            ])
        }
    
    private func configureUploadStatus() {
        uploadStatusLabel.text = "업로드 상태 계속 유지하기"
        uploadStatusLabel.textColor = .black
        uploadStatusLabel.textAlignment = .left
        uploadStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(uploadStatusLabel)
        
        NSLayoutConstraint.activate([
            uploadStatusLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            uploadStatusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            uploadStatusLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        // 스위치 설정
        uploadStatusToggle.isOn = true
        uploadStatusToggle.onTintColor = .systemPurple
        uploadStatusToggle.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        addSubview(uploadStatusToggle)
        
        uploadStatusToggle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uploadStatusToggle.leadingAnchor.constraint(equalTo: uploadStatusLabel.trailingAnchor, constant: 2),
            uploadStatusToggle.centerYAnchor.constraint(equalTo: uploadStatusLabel.centerYAnchor)
        ])
    }
    
    private func configureMaintainTime() {
        maintainTimeLabel.text = "유지 시간 설정하기"
        maintainTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(maintainTimeLabel)
        
        NSLayoutConstraint.activate([
            maintainTimeLabel.topAnchor.constraint(equalTo: uploadStatusLabel.bottomAnchor, constant: 16),
            maintainTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            maintainTimeLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        maintainTimeLabel.textAlignment = .left
        
        maintainTimeSlider.minimumValue = 0
        maintainTimeSlider.maximumValue = 100
        maintainTimeSlider.value = 0
        maintainTimeSlider.minimumTrackTintColor = UIColor.systemYellow
        maintainTimeSlider.maximumTrackTintColor = UIColor.magenta
        maintainTimeSlider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(maintainTimeSlider)
        
        NSLayoutConstraint.activate([
            maintainTimeSlider.topAnchor.constraint(equalTo: maintainTimeLabel.bottomAnchor, constant: 18),
            maintainTimeSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            maintainTimeSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        thumbLabel.textAlignment = .center
        thumbLabel.backgroundColor = .clear
        thumbLabel.textColor = .black
        thumbLabel.font = UIFont.systemFont(ofSize: 12)
        thumbLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(thumbLabel)
    }
    
    private func configureUploadButton() {
        uploadButton.setTitle("업로드하기", for: .normal)
        uploadButton.backgroundColor = .systemPurple
        uploadButton.setTitleColor(.white, for: .normal)
        uploadButton.layer.cornerRadius = 27
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(uploadButton)
        
        uploadButton.layer.shadowColor = UIColor.black.cgColor
        uploadButton.layer.shadowOpacity = 0.1
        uploadButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        uploadButton.layer.shadowRadius = 2
        uploadButton.clipsToBounds = false
        
        NSLayoutConstraint.activate([
            uploadButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            uploadButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            uploadButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            uploadButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            uploadButton.heightAnchor.constraint(equalToConstant: 54),
            //uploadButton.widthAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    private func configureSelectedGenresLabel() {
        selectedGenresLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedGenresLabel.text = "선택된 장르: 없음"
        selectedGenresLabel.textAlignment = .center
        selectedGenresLabel.textColor = .black
        addSubview(selectedGenresLabel)
        
        NSLayoutConstraint.activate([
            selectedGenresLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            selectedGenresLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            selectedGenresLabel.topAnchor.constraint(equalTo: maintainTimeSlider.bottomAnchor, constant: 20)
        ])
    }
}
