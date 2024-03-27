//
//  MapViewController.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 3/7/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    //var testImageView = UIImageView()
    var mapView: MKMapView!
    
    let genreScrollView = UIScrollView()
    var genreButtons: [UIButton] = []
    
    let locationLabel = UILabel()
    let distanceLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        configureLocationInfo()
        configureGenreButtons()
        configureMapView()
        
        //testImage()
        
        // Do any additional setup after loading the view.
    }
    
    func configureLocationInfo() {
        locationLabel.text = "서울시 강서구 염창동"
        distanceLabel.textColor = .black
        locationLabel.font = UIFont.boldSystemFont(ofSize: 20)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationLabel)
        
        // titleLabel의 제약 조건을 추가합니다.
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -200),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //locationLabel.trailingAnchor.constraint(equalTo: distanceLabel.leadingAnchor, constant: 20),
            //locationLabel.widthAnchor.constraint(equalToConstant: 150), // 버튼 너비 설정
            locationLabel.heightAnchor.constraint(equalToConstant: 33) // 원하는 높이 설정

            //너비제한
            //titleLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        locationLabel.textAlignment = .right
                
        distanceLabel.text = "반경 1km, 6개의 음악"
        distanceLabel.font = UIFont.systemFont(ofSize: 12)
        distanceLabel.textColor = .lightGray
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            distanceLabel.bottomAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            distanceLabel.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            distanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            //distanceLabel.heightAnchor.constraint(equalTo: genreScrollView.heightAnchor),
            //distanceLabel.widthAnchor.constraint(equalToConstant: 200) // 버튼 너비 설정
        ])
        
        distanceLabel.textAlignment = .right
    }
    
    func configureGenreButtons() {
        genreScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genreScrollView)
        
        genreScrollView.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            genreScrollView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            genreScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            genreScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            genreScrollView.heightAnchor.constraint(equalToConstant: 50) // 원하는 높이 설정
        ])
        
        let buttonTitles = ["전체","Rock", "Pop", "Jazz", "Classical", "Hip-hop","Rock", "Pop", "Jazz", "Classical", "Hip-hop"]
        var previousButton: UIButton?
        
        for (index, title) in buttonTitles.enumerated() {
            let genreButton = UIButton()
            genreButton.setTitle(title, for: .normal)
            genreButton.backgroundColor = UIColor.white
            genreButton.setTitleColor(.lightGray, for: .normal)
            //button.setTitleColor(UIColor(named: "MapGenreSelected"), for: .highlighted)
            //genreButton.setTitleColor(UIColor(named: "MapGenreSelected"), for: .selected)

            genreButton.translatesAutoresizingMaskIntoConstraints = false
            genreScrollView.addSubview(genreButton)
            genreButtons.append(genreButton)
            
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
    
    func configureMapView() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: genreScrollView.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    /*func testImage() {
        testImageView.image = UIImage(named: "Demo")
        testImageView.contentMode = .scaleAspectFill
        testImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(testImageView)
                
        NSLayoutConstraint.activate([
            testImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            testImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            testImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            testImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }*/

    //장르 선택 액션
    @objc func genreButtonTapped(sender: UIButton) {
        guard let buttonTitle = sender.currentTitle else { return }
        print("\(buttonTitle) 버튼이 탭되었습니다")

        // 다른 모든 버튼의 선택 상태를 해제하고 배경색을 흰색으로 설정합니다.
        genreButtons.forEach {
            $0.isSelected = false
        }
        
        sender.isSelected.toggle() // 탭된 버튼의 선택 상태를 토글합니다.
        sender.setTitleColor(UIColor(named: "MapGenreSelected"), for: .selected)
    }
}
