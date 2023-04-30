import Moya

protocol InitialBusinessLogic {
    func validateUserId(userId: String)
}

public final class InitialInteractor: InitialBusinessLogic {
    private let profileWorker: ProfileWorkerLogic
    private let router: InitialRoutingLogic
    
    public init(
        profileWorker: ProfileWorkerLogic,
        router: InitialRoutingLogic
    ) {
        self.profileWorker = profileWorker
        self.router = router
    }
    
    func validateUserId(userId: String) {
        profileWorker.fetchUserProfile(userId: userId) { result in
            switch result {
            case .success:
                self.router.routeToHome(userId: userId)
            case .failure(let error):
                guard let moyaError = error as? MoyaError, let code = moyaError.response?.statusCode else { return }
                if code == 404 {
                    self.router.routeToUserProfile(userId: userId)
                    return
                }
                //TODO: tratar esse caso de erro
                print(error)
            }
        }
    }
}
