//
//  APIService.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 12/16/24.
//

import Foundation
import Moya

enum API {
    case getTracks
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://munecting.shop")!  // 서버의 기본 URL을 설정하세요.
    }

    var path: String {
        switch self {
        case .getTracks:
            return "/tracks"  // 서버의 엔드포인트를 설정하세요.
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
