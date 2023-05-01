import Moya

protocol ProfileBusinessLogic {
    func viewDidLoad()
    func saveProfile(userProfile: UserProfile)
}

public final class ProfileInteractor: ProfileBusinessLogic {
    private let userId: String
    private let profileWorker: ProfileWorkerLogic
    private let router: ProfileRoutingLogic
    private let presenter: ProfilePresentationLogic
    
    public init(
        userId: String,
        profileWorker: ProfileWorkerLogic,
        presenter: ProfilePresentationLogic,
        router: ProfileRoutingLogic
    ) {
        self.userId = userId
        self.profileWorker = profileWorker
        self.presenter = presenter
        self.router = router
    }
    
    private func loadProfile() {
        profileWorker.fetchUserProfile(userId: userId) { result in
            switch result {
            case .success(let profile):
                self.presenter.presentUserProfile(profile: profile)
            case .failure(let error):
                guard let moyaError = error as? MoyaError, let code = moyaError.response?.statusCode else { return }
                if code == 404 {
                    self.presenter.presentUserProfile(profile: .init(cpf: self.userId))
                    return
                }
                self.presenter.presentError("Não foi possível carregar o perfil do usuário")
                print("Error: \(error)")
            }
        }
    }
    
    func viewDidLoad() {
        loadProfile()
    }
    
    func saveProfile(userProfile: UserProfile) {
        profileWorker.saveProfile(profile: userProfile) { result in
            switch result {
            case .success:
                self.router.routeToHome(userId: self.userId)
            case .failure(let error):
                self.presenter.presentError("Não foi possível salvar o perfil do usuário")
                print("Error: \(error)")
            }
        }
    }
}
