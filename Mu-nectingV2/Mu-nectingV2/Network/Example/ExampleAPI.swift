//
//  ExampleAPI.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 7/29/24.
//

import Foundation
import Moya


// 예시입니다.
enum ExampleAPI  {
    case getHomeNow
    case getCalendarListWithGoal(goalId : Int, yearMonth : String?)
    case getCalendarListWithCategory(goalId : Int, categoryId : Int, yearMonth : String)
}

extension ExampleAPI : BaseAPI {
    
    public var task: Task {
        switch self {
        case .getHomeNow,.getCalendarListWithGoal:
            return .requestPlain
        case .getCalendarListWithCategory(_, _, let yearMonth):
            let parameters: [String: String] = ["yearMonth": yearMonth]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getHomeNow, .getCalendarListWithGoal,.getCalendarListWithCategory:
            return .get
        }
    }
    
    public var path : String {
        switch self {
        case .getHomeNow:
            return "/api/home/now"
        case .getCalendarListWithGoal(let goalId, let yearMonth):
            if(yearMonth == nil){
                return "/api/home/goal/\(goalId)"
            }else{
                return "/api/home/goal/\(goalId)/\(yearMonth!)"
            }
        case .getCalendarListWithCategory(let goalId, let categoryId, let _):
            return "/api/home/goal/\(goalId)/category/\(categoryId)"
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
