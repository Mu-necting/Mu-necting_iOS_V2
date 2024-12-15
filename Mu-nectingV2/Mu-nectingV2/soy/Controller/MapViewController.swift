//
//  MapViewController.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 3/7/24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var mapModel = MapModel()
    private var mapView: MapView!
    private let locationManager = CLLocationManager()
    
    private var currentLatitude: Double?
    private var currentLongitude: Double?
    private var locationRadius = 100
    
    override func loadView() {
        mapView = MapView(controller: self)
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UICollectionView 셀 등록
        mapView.musicCollectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: "MusicCell")
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @objc func genreButtonTapped(_ sender: UIButton) {
        guard let genre = sender.currentTitle else { return }
        mapModel.selectedGenre = genre
        print("\(genre) 장르가 선택되었습니다.")
        
        mapView.genreButtons.forEach {
            $0.isSelected = false
        }
        
        sender.isSelected.toggle()
        sender.setTitleColor(UIColor(named: "MapGenreSelected"), for: .selected)
    }
    
    @objc func refreshButtonTapped(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        mapView.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: mapModel.defaultSpanValue), animated: true)
        
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
    private func updateMapModel(with data: [String: Any]) {
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
                            DispatchQueue.main.async {
                                self.mapView.musicCollectionView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    // URL로부터 이미지 로드
    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }

    // UICollectionView DataSource & Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mapModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCell", for: indexPath) as! MusicCollectionViewCell
        cell.albumImageView.image = mapModel.images[indexPath.item]
        cell.titleLabel.text = mapModel.titles[indexPath.item]
        cell.artistLabel.text = mapModel.artists[indexPath.item]
        return cell
    }
}
