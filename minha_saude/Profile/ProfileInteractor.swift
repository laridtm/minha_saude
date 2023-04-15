protocol ProfileBusinessLogic {
    func saveProfile(userProfile: UserProfile)
}

public final class ProfileInteractor: ProfileBusinessLogic {
//    private let router: HomeRoutingLogic
    
    public init() {
    }
    
    func saveProfile(userProfile: UserProfile) {
        print(userProfile)
    }
}
