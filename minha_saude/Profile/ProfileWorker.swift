import Moya

public protocol ProfileWorkerLogic {
    func fetchUserProfile(userId: String, completion: @escaping(Result<UserProfile, Error>) -> Void)
    func saveProfile(profile: UserProfile, completion: @escaping(Result<Bool, Error>) -> Void)
}

public final class ProfileWorker: ProfileWorkerLogic {
    init() { }
    
    public func fetchUserProfile(userId: String, completion: @escaping(Result<UserProfile, Error>) -> Void) {
        let provider = MoyaProvider<ProfileRequest>()

        provider.request(.fetchProfile(userId: userId)) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let profile = try filteredResponse.map(UserProfile.self)

                    completion(.success(profile))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func saveProfile(profile: UserProfile, completion: @escaping (Result<Bool, Error>) -> Void) {
        let provider = MoyaProvider<ProfileRequest>()
        
        provider.request(.saveProfile(profile: profile)) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
