import Moya

protocol InitialBusinessLogic {
    func validateUserId(userId: String)
}

public final class InitialInteractor: InitialBusinessLogic {
    private let profileWorker: ProfileWorkerLogic
    private let router: InitialRoutingLogic
    private let presenter: InitialPresentationLogic
    
    init(
        profileWorker: ProfileWorkerLogic,
        router: InitialRoutingLogic,
        presenter: InitialPresentationLogic
    ) {
        self.profileWorker = profileWorker
        self.router = router
        self.presenter = presenter
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
                self.presenter.presentError("Tivemos um problema ao conectar ao servidor")
                print(error)
            }
        }
    }
}
