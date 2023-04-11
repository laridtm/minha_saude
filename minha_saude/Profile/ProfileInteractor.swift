protocol ProfileInteractorBusinessLogic {
    func saveProfile(userProfile: UserProfile)
}

public final class ProfileInteractor: ProfileInteractorBusinessLogic {
//    private let router: HomeRoutingLogic
    
    public init() {
    }
    
    func saveProfile(userProfile: UserProfile) {
        print(userProfile)
    }
}
