//
//  MapNetworkModel.swift
//  MunectingV2_demo
//
//  Created by seohuibaek on 11/23/24.
//

import Foundation
import UIKit
import MapKit

//// 서버 응답을 매핑할 구조체
//struct ResponseModel: Decodable {
//    let isSuccess: Bool
//    let code: String
//    let message: String
//    let data: [String: Any]
//
//    private enum CodingKeys: String, CodingKey {
//        case isSuccess
//        case code
//        case message
//        case data
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        isSuccess = try container.decode(Bool.self, forKey: .isSuccess)
//        code = try container.decode(String.self, forKey: .code)
//        message = try container.decode(String.self, forKey: .message)
//        data = try container.decodeIfPresent([String: AnyDecodable].self, forKey: .data)?.mapValues { $0.value } ?? [:]
//    }
//}
//
//// Any 타입을 받을 수 있는 구조체
//struct AnyDecodable: Decodable {
//    let value: Any
//
//    init<T>(_ value: T?) {
//        self.value = value ?? ()
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let intValue = try? container.decode(Int.self) {
//            value = intValue
//        } else if let doubleValue = try? container.decode(Double.self) {
//            value = doubleValue
//        } else if let boolValue = try? container.decode(Bool.self) {
//            value = boolValue
//        } else if let stringValue = try? container.decode(String.self) {
//            value = stringValue
//        } else if let nestedArray = try? container.decode([AnyDecodable].self) {
//            value = nestedArray.map { $0.value }
//        } else if let nestedDictionary = try? container.decode([String: AnyDecodable].self) {
//            value = nestedDictionary.mapValues { $0.value }
//        } else {
//            value = ()
//        }
//    }
//}

import Foundation

// 서버 응답을 매핑할 구조체
struct ResponseModel: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: [String: Any]?

    private enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isSuccess = try container.decode(Bool.self, forKey: .isSuccess)
        code = try container.decode(String.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
        
        // data 필드가 없거나 빈 배열일 경우 처리
        if let dataContainer = try? container.decodeIfPresent([String: AnyDecodable].self, forKey: .data) {
            data = dataContainer.mapValues { $0.value }
        } else {
            data = nil // 데이터가 없을 경우 nil 처리
        }
    }
}

// Any 타입을 받을 수 있는 구조체
struct AnyDecodable: Decodable {
    let value: Any

    init<T>(_ value: T?) {
        self.value = value ?? ()
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            value = intValue
        } else if let doubleValue = try? container.decode(Double.self) {
            value = doubleValue
        } else if let boolValue = try? container.decode(Bool.self) {
            value = boolValue
        } else if let stringValue = try? container.decode(String.self) {
            value = stringValue
        } else if let nestedArray = try? container.decode([AnyDecodable].self) {
            value = nestedArray.map { $0.value }
        } else if let nestedDictionary = try? container.decode([String: AnyDecodable].self) {
            value = nestedDictionary.mapValues { $0.value }
        } else {
            value = ()
        }
    }
}

// MapModel 클래스
class MapNetWorkModel {
    var selectedGenre: String?
    var images: [UIImage] = []
    var titles: [String] = []
    var artists: [String] = []
    let defaultSpanValue = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}
