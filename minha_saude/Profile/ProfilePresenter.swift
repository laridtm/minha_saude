public protocol ProfilePresentationLogic: AnyObject {
    var viewController: ProfileDisplayLogic? { get set }
    
    func presentUserProfile(profile: UserProfile)
}

public final class ProfilePresenter: ProfilePresentationLogic {
    public weak var viewController: ProfileDisplayLogic?
    
    init() {}
    
    public func presentUserProfile(profile: UserProfile) {
        viewController?.displayProfile(profile: profile)
    }
}
