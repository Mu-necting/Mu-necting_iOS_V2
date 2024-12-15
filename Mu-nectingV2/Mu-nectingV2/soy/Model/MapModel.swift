//
//  MapModel.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 12/16/24.
//

import UIKit
import CoreLocation
import MapKit

class MapModel {
    let defaultLocation = CLLocationCoordinate2D(latitude: 37.55080147581, longitude: 126.86686848977)
    let defaultSpanValue = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    var genres = ["전체", "Rock", "Pop", "Jazz", "Classical", "Hip-hop"]
    var images: [UIImage] = [
        UIImage(named: "Dummy")!,
        UIImage(named: "Dummy2")!,
        UIImage(named: "Dummy3")!,
        UIImage(named: "Dummy")!,
        UIImage(named: "Dummy2")!,
        UIImage(named: "Dummy3")!,
        UIImage(named: "Dummy")!,
        UIImage(named: "Dummy2")!,
        UIImage(named: "Dummy3")!,
        UIImage(named: "Dummy")!
    ]
    
    var titles = ["곡제목1", "곡제목2", "곡제목3","곡제목1", "곡제목2", "곡제목3","곡제목1", "곡제목2", "곡제목3","곡제목1"]
    var artists = ["가수1", "가수2", "가수3","가수1", "가수2", "가수3","가수1", "가수2", "가수3","가수1"]
    
    var selectedGenre: String? = nil
    
    func fetchAddress(for location: CLLocation, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placeMarks, error in
            guard let address = placeMarks?.last, error == nil else {
                completion(nil)
                return
            }
            let fullAddress = address.subLocality ?? "알 수 없는 위치"
            completion(fullAddress)
        }
    }
}
