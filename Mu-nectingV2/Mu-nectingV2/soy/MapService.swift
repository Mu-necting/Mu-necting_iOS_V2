//
//  MapService.swift
//  MunectingV2_demo
//
//  Created by seohuibaek on 11/23/24.
//

import Alamofire

class MapService {
    static let shared = MapService()
    
//    func fetchMapData(latitude: Double, longitude: Double, radius: Int, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
//        let url = "https://munecting.shop/api/musics" // 실제 URL로 변경하세요
//        // 요청할 쿼리 파라미터 설정
//        let parameters: Parameters = [
//            "latitude": latitude,
//            "longitude": longitude,
//            "radius": radius
//        ]
//
//        // Alamofire 요청 - GET 메서드, 쿼리 파라미터 포함
////        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString)
////            .responseDecodable(of: ResponseModel.self) { response in
////                switch response.result {
////                case .success(let data):
////                    completion(.success(data))
////                case .failure(let error):
////                    completion(.failure(error))
////                }
////            }
//
//
//        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString)
//            .responseData { response in
//                switch response.result {
//                case .success(let data):
//                    if let jsonString = String(data: data, encoding: .utf8) {
//                        print("Received JSON: \(jsonString)")
//                    }
//                case .failure(let error):
//                    print("Request failed with error: \(error)")
//                }
//            }
//    }
    
    func fetchMapData(latitude: Double, longitude: Double, radius: Int, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        let url = "https://munecting.shop/api/musics" // 실제 URL로 변경하세요
        
        // 요청할 쿼리 파라미터 설정
        let parameters: Parameters = [
            "latitude": latitude,
            "longitude": longitude,
            "radius": radius
        ]
        
        // Alamofire 요청 - GET 메서드, 쿼리 파라미터 포함
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString)
            .responseDecodable(of: ResponseModel.self) { response in
                switch response.result {
                case .success(let data):
                    print("데이터 요청 성공:", data)
                    completion(.success(data))
                case .failure(let error):
                    print("오류 발생:", error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }

}

