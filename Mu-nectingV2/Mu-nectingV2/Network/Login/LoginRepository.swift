//
//  LoginRepository.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 9/2/24.
//

import Foundation
import Moya


final class LoginRepository : BaseRepository<LoginAPI> {
    
    static let shared = LoginRepository()
    
    func socialLogin(type:String, token : String,  completion: @escaping (Result<LoginResponse?, BaseError>) -> Void){
        provider.request(.loginWithSocial(socialType : type, idToken : token)) { result in
            switch result {
            case let .success(response):
                do {
                    let response = try response.map(BaseResponse<LoginResponse?>.self)
                    
                    if(response.isSuccess!){
                        completion(.success(response.data!))
                    }else{
                        print(response.code)
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
