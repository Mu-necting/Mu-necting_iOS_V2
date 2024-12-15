//
//  MusicUploadViewController.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 12/16/24.
//

import UIKit

class MusicUploadViewController: UIViewController, UISearchBarDelegate {
    var musicUploadView: MusicUploadView!
    var musicUploadModel = MusicUploadModel()
    var selectedGenres = [String]() // 선택된 장르 배열 추가
    var musicInfoOn = false // 음악 정보 여부 변수 추가

    override func loadView() {
        musicUploadView = MusicUploadView()
        view = musicUploadView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 탭 바 숨기기
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.isHidden = true
        }
        
        // 뷰 설정
        musicUploadView.configureGenreButtons()
        
        // 각 버튼에 액션 추가
        for button in musicUploadView.genreButtons {
           button.addTarget(self, action: #selector(genreButtonTapped(_:)), for: .touchUpInside)
        }
        
        // 다른 버튼 및 슬라이더 타겟 설정
        musicUploadView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        musicUploadView.tooltipButton.addTarget(self, action: #selector(showTooltip), for: .touchUpInside)
        musicUploadView.uploadStatusToggle.addTarget(self, action: #selector(uploadStatusChanged(_:)), for: .valueChanged)
        musicUploadView.maintainTimeSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
        // searchBar의 delegate 설정
        musicUploadView.searchBar.delegate = self
    }
    
    // 뷰가 화면에 나타날 때 탭 바 숨기기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.isHidden = true
        }
        musicUploadView.configureSelectedMusic()
    }

        // 뷰가 화면을 벗어날 때 탭 바 복원
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.isHidden = false
        }
    }

    @objc func backButtonTapped(_ sender: UIButton) {
        print("Back button tapped") // 로그 출력
        
        // UserDefaults에서 키 제거
        ["selectedSongTitle", "selectedArtist", "selectedAlbumImage"].forEach {
            UserDefaults.standard.removeObject(forKey: $0)
        }
        
        // 이전 탭으로 이동
        if let tabBarController = self.tabBarController,
           let selectedIndex = tabBarController.viewControllers?.firstIndex(of: self) {
            let previousIndex = 0 // 이전 탭 인덱스 계산
            tabBarController.selectedIndex = previousIndex
        }
        
        //self.dismiss(animated: true, completion: nil)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let songSearchVC = MusicSearchViewController()
        songSearchVC.modalPresentationStyle = .popover
        present(songSearchVC, animated: true, completion: nil)
        return false
    }
    
//    @objc func showTooltip(sender: UIButton) {
//        let tooltipLabel = UILabel()
//        tooltipLabel.text = "유지 시간 설정시, 설정한 시간이 지나면 업로드한 곡이 지도에서 내려갑니다."
//        tooltipLabel.backgroundColor = .white
//        tooltipLabel.textColor = .gray
//        tooltipLabel.font = UIFont.systemFont(ofSize: 14)
//        tooltipLabel.numberOfLines = 2
//        tooltipLabel.textAlignment = .center
//        tooltipLabel.layer.borderColor = UIColor.systemGray4.cgColor
//        tooltipLabel.layer.borderWidth = 1.0
//        tooltipLabel.layer.cornerRadius = 15
//        tooltipLabel.clipsToBounds = true
//        tooltipLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        // musicUploadView에 tooltipLabel 추가
//        musicUploadView.addSubview(tooltipLabel)
//
//        NSLayoutConstraint.activate([
//            tooltipLabel.topAnchor.constraint(equalTo: musicUploadView.tooltipButton.bottomAnchor, constant: 5),
//            tooltipLabel.centerXAnchor.constraint(equalTo: musicUploadView.tooltipButton.centerXAnchor),
//            tooltipLabel.widthAnchor.constraint(equalToConstant: 250),
//            tooltipLabel.heightAnchor.constraint(equalToConstant: 55)
//        ])
//
//        // 툴팁 자동 제거
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            tooltipLabel.removeFromSuperview()
//        }
//    }
    
    @objc private func showTooltip() {
        musicUploadView.showTooltip()

        // 2초 후에 툴팁을 자동으로 숨기는 로직을 이곳에 추가
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.musicUploadView.tooltipLabel?.removeFromSuperview()
        }
    }
    
    @objc func uploadStatusChanged(_ sender: UISwitch) {
        musicUploadModel.uploadStatus = sender.isOn
        [musicUploadView.maintainTimeLabel, musicUploadView.maintainTimeSlider, musicUploadView.thumbLabel].forEach {
            $0.isHidden = sender.isOn
        }
        
        musicUploadView.maintainTimeSlider.isEnabled = !sender.isOn
        musicUploadView.maintainTimeSlider.alpha = sender.isOn ? 0.5 : 1.0
        musicUploadView.maintainTimeLabel.textColor = sender.isOn ? .gray : .black
        
        musicUploadView.layoutIfNeeded()  // 레이아웃 업데이트

    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let sliderValue = sender.value
        let mappedValue = mapSliderValue(sliderValue)
        musicUploadModel.maintainTime = mappedValue
        updateThumbLabel(sliderValue: Int(mappedValue), slider: sender)
        print("Slider Value: \(sliderValue), Mapped Value: \(mappedValue)")
    }

    // 슬라이더 값을 실제 시간 값으로 변환하는 함수
    private func mapSliderValue(_ value: Float) -> Float {
        // 첫 번째 구간: 10분 ~ 59분 (10분 단위)
        if value < 35 {
            let scaledValue = 10 + (value / 33) * 49  // 10 ~ 59 슬라이더 값이 10분 ~ 59분을 커버
            let roundedValue = round(scaledValue / 10) * 10  // 10분 단위로 스냅
            return roundedValue
            
            // 두 번째 구간: 60분 ~ 24시간 (4시간 단위)
        } else if value <= 66 {
            let scaledValue = 60 + ((value - 33) / 33) * 1380  // 33 ~ 66 슬라이더 값이 60분 ~ 1440분을 커버
            let roundedValue = round(scaledValue / (60 * 4)) * (60 * 4)  // 4시간 단위로 스냅 (240분)
            return roundedValue
            
            // 세 번째 구간: 24시간 ~ 72시간 (12시간 단위)
        } else {
            let scaledValue = 1440 + ((value - 66) / 34) * 2880  // 66 ~ 100 슬라이더 값이 1440분 ~ 4320분을 커버
            let roundedValue = round(scaledValue / (60 * 12)) * (60 * 12)  // 12시간 단위로 스냅 (720분)
            return roundedValue
        }
    }

    // 슬라이더 thumb 위에 label 업데이트 함수
    private func updateThumbLabel(sliderValue: Int, slider: UISlider) {
        musicUploadView.thumbLabel.text = formatTime(sliderValue)
        
        let thumbFrame = slider.thumbRect(forBounds: slider.bounds, trackRect: slider.trackRect(forBounds: slider.bounds), value: slider.value)
        musicUploadView.thumbLabel.center = CGPoint(x: thumbFrame.midX, y: slider.frame.minY - 20)
    }

    private func formatTime(_ sliderValue: Int) -> String {
        if sliderValue < 60 {
            return "\(sliderValue)분"
        } else {
            return "\(sliderValue / 60)시간"
        }
    }
    
    @objc func genreButtonTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        
        // 장르 선택 시 UI 변경 및 selectedGenres 업데이트
        if selectedGenres.contains(title) {
            sender.backgroundColor = .white
            sender.layer.borderColor = UIColor.systemGray4.cgColor
            sender.setTitleColor(.black, for: .normal)
            selectedGenres.removeAll { $0 == title }
            print("선택 해제된 장르: \(title)")
        } else {
            sender.backgroundColor = UIColor.systemPurple
            sender.layer.borderColor = UIColor.clear.cgColor
            sender.setTitleColor(.white, for: .normal)
            selectedGenres.append(title)
            print("선택된 장르: \(title)")
        }
        
        // 선택된 장르 레이블 업데이트
        musicUploadView.selectedGenresLabel.text = selectedGenres.isEmpty ? "선택된 장르: 없음" : "선택된 장르: " + selectedGenres.joined(separator: ", ")
        
        // 업로드 버튼 활성화 상태 업데이트
        let isEnabled = !selectedGenres.isEmpty && musicInfoOn
        musicUploadView.uploadButton.isEnabled = isEnabled
        musicUploadView.uploadButton.alpha = isEnabled ? 1.0 : 0.5
    }
}
