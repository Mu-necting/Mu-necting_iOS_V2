//
//  MapView.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 12/16/24.
//

import UIKit
import MapKit

class MapView: UIView {
    
    let mapView = MKMapView()
    let locationLabel = UILabel()
    let distanceLabel = UILabel()
    
    let genreScrollView = UIScrollView()
    var genreButtons: [UIButton] = []
    
    var refreshButton = UIButton()
    var musicCollectionView: UICollectionView!
    
    let cellSize = CGSize(width: 320, height: 130) // Set your cell size
    
    var previousIndex = 0

    init(controller: UIViewController) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        configureLocationInfo()
        configureGenreButtons(controller: controller)
        configureMapView()
        configureRefreshButton(controller: controller)
        configureMusicCollectionView(controller: controller)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLocationInfo() {
        locationLabel.text = "위치 주소"
        locationLabel.font = UIFont.boldSystemFont(ofSize: 25)
        locationLabel.textColor = .black
        locationLabel.textAlignment = .right

        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(locationLabel)
        
        distanceLabel.text = "반경 1km, 6개의 음악"
        distanceLabel.font = UIFont.systemFont(ofSize: 12)
        distanceLabel.textColor = .lightGray
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.textAlignment = .right

        addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            //distanceLabel.topAnchor.constraint(equalTo: locationLabel.topAnchor),
            distanceLabel.bottomAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureGenreButtons(controller: UIViewController) {
        genreScrollView.translatesAutoresizingMaskIntoConstraints = false
        genreScrollView.showsHorizontalScrollIndicator = false
        addSubview(genreScrollView)
        
        NSLayoutConstraint.activate([
            genreScrollView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            genreScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            genreScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            genreScrollView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        var previousButton: UIButton?
        for title in MapModel().genres {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            genreScrollView.addSubview(button)
            genreButtons.append(button)
            
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: genreScrollView.topAnchor),
                button.heightAnchor.constraint(equalTo: genreScrollView.heightAnchor),
                button.widthAnchor.constraint(equalToConstant: 80)
            ])
            
            if let previous = previousButton {
                button.leadingAnchor.constraint(equalTo: previous.trailingAnchor, constant: 10).isActive = true
            } else {
                button.leadingAnchor.constraint(equalTo: genreScrollView.contentLayoutGuide.leadingAnchor, constant: 10).isActive = true
            }
            previousButton = button
            button.addTarget(controller, action: #selector(MapViewController.genreButtonTapped(_:)), for: .touchUpInside)
        }
        
        // genreScrollView의 contentSize를 수동으로 업데이트
        genreScrollView.contentSize = CGSize(width: 80 * genreButtons.count + 10 * (genreButtons.count - 1), height: 50)
    }
    
    private func configureMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mapView)
        
        // MapView의 기본 위치 설정 및 화면 크기 설정
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: genreScrollView.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureRefreshButton(controller: UIViewController) {
        refreshButton.setImage(UIImage(named: "Refresh"), for: .normal)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            refreshButton.topAnchor.constraint(equalTo: genreScrollView.bottomAnchor, constant: 10),
            refreshButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        refreshButton.addTarget(controller, action: #selector(MapViewController.refreshButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func configureMusicCollectionView(controller: UIViewController) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = cellSize
        
        musicCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        musicCollectionView.translatesAutoresizingMaskIntoConstraints = false
        musicCollectionView.backgroundColor = .clear
        musicCollectionView.showsHorizontalScrollIndicator = false
        musicCollectionView.delegate = controller as? UICollectionViewDelegate
        musicCollectionView.dataSource = controller as? UICollectionViewDataSource
        
        addSubview(musicCollectionView)
        
        NSLayoutConstraint.activate([
            // 첫 번째 코드와 동일한 배치로 수정
            //musicCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 598),
            musicCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            musicCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            musicCollectionView.heightAnchor.constraint(equalToConstant: cellSize.height), // cellSize.height 적용
            musicCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)  // 탭 바와 겹치지 않도록 설정

        ])
    }
}
