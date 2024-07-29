//
//  ExampleRepository.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 7/29/24.
//

import Foundation
import Moya

// 예시입니다.
final class ExampleRepository : BaseRepository<ExampleAPI> {
    
    static let shared = ExampleRepository()
    
    
    func getHomeNow(completion: @escaping (Result<String?, BaseError>) -> Void){
        provider.request(.getHomeNow) { result in
            switch result {
            case let .success(response):
                do {
                    let response = try response.map(BaseResponse<String?>.self)
                    
                    if(response.isSuccess!){
                        completion(.success(response.data!))
                    }else{
                        completion(.failure(.failure(message: response.message!)))
                    }
                    
                } catch {
                    // 디코딩 오류 처리
                    print("Decoding error: \(error)")
                }
            case let .failure(error):
                // 네트워크 요청 실패 처리
                print("Network request failed: \(error)")
                completion(.failure(.networkFail(error: error)))
            }
        }
    }
    
    func getCalendarListWithGoal(goalId : Int, yearMonth : String?, completion: @escaping (Result<String?, BaseError>) -> Void){
        provider.request(.getCalendarListWithGoal(goalId: goalId, yearMonth: yearMonth)) {
            result in
            switch result {
            case let .success(response):
                do {
                    let response = try response.map(BaseResponse<String?>.self)
                    
                    if(response.isSuccess!){
                        completion(.success(response.data!))
                    }else{
                        completion(.failure(.failure(message: response.message!)))
                    }
                    
                } catch {
                    // 디코딩 오류 처리
                    print("Decoding error: \(error)")
                }
            case let .failure(error):
                // 네트워크 요청 실패 처리
                print("Network request failed: \(error)")
                completion(.failure(.networkFail(error: error)))
            }
        }
    }
    
    func getCalendarListWithCategory(goalId : Int, categoryId: Int, yearMonth : String, completion: @escaping (Result<String?, BaseError>) -> Void){
        provider.request(.getCalendarListWithCategory(goalId: goalId, categoryId: categoryId, yearMonth: yearMonth)) {
            result in
            switch result {
            case let .success(response):
                do {
                    let response = try response.map(BaseResponse<String?>.self)
                    if(response.isSuccess!){
                        completion(.success(response.data!))
                    }else{
                        completion(.failure(.failure(message: response.message!)))
                    }
                    
                } catch {
                    // 디코딩 오류 처리
                    print("Decoding error: \(error)")
                }
            case let .failure(error):
                // 네트워크 요청 실패 처리
                print("Network request failed: \(error)")
                completion(.failure(.networkFail(error: error)))
            }
        }
    }
}
