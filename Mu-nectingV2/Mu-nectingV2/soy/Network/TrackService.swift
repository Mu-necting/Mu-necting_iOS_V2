import Foundation
import Alamofire
import Moya

class TrackService {
    private let provider = MoyaProvider<API>()

    func fetchTracks(completion: @escaping (Result<[Track], Error>) -> Void) {
        provider.request(.getTracks) { result in
            switch result {
            case .success(let response):
                do {
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: response.data)
                    if apiResponse.isSuccess {
                        completion(.success(apiResponse.data))
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: apiResponse.message])
                        completion(.failure(error))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
