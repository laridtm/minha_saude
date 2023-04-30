protocol ProfileBusinessLogic {
    func viewDidLoad()
    func saveProfile(userProfile: UserProfile)
}

public final class ProfileInteractor: ProfileBusinessLogic {
    private let profileWorker: ProfileWorkerLogic
    private let router: ProfileRoutingLogic
    private let presenter: ProfilePresentationLogic
    
    public init(
        profileWorker: ProfileWorkerLogic,
        presenter: ProfilePresentationLogic,
        router: ProfileRoutingLogic
    ) {
        self.profileWorker = profileWorker
        self.presenter = presenter
        self.router = router
    }
    
    private func loadProfile() {
        profileWorker.fetchUserProfile(userId: "00897314921") { result in
            switch result {
            case .success(let profile):
                self.presenter.presentUserProfile(profile: profile)
            case .failure(let error):
                //TODO: Tratar o caso de erro
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
                self.router.routeToHome()
            case .failure(let error):
                //TODO: Tratar o caso de erro
                print("Error: \(error)")
            }
        }
    }
}
