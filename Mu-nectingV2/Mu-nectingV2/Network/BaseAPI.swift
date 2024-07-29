//
//  BaseAPI.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 7/29/24.
//

import Foundation
import Moya

protocol BaseAPI: TargetType {
    
}

extension BaseAPI {
    var baseURL: URL {
        let url = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
        return URL(string: "https://" + url)!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method { .get }
    var sampleData: Data { Data() }
    var task: Task { .requestPlain }
    var headers: [String: String]? { nil }
}
