import Moya

protocol HomeWorkerLogic {
    func fetchUserInfo(id: String, completion: @escaping(Result<UserInfo, Error>) -> Void)
}

public final class HomeWorker: HomeWorkerLogic {
    init() { }
    
    func fetchUserInfo(id: String, completion: @escaping(Result<UserInfo, Error>) -> Void) {
        let provider = MoyaProvider<UserInfoRequest>()
        
        provider.request(.fetchUser(id: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let user = try filteredResponse.map(UserInfo.self)
                    
                    completion(.success(user))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
