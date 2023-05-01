import Foundation

public protocol ProfilePresentationLogic: AnyObject {
    var viewController: ProfileDisplayLogic? { get set }
    
    func presentUserProfile(profile: UserProfile)
    func presentError(_ error: String)
}

public final class ProfilePresenter: ProfilePresentationLogic {
    
    struct Constants {
        static let toastFontSize: CGFloat = 12
    }
    
    public weak var viewController: ProfileDisplayLogic?
    
    init() {}
    
    public func presentUserProfile(profile: UserProfile) {
        viewController?.displayProfile(profile: profile)
    }
    
    public func presentError(_ error: String) {
        viewController?.showToast(message: error, font: .systemFont(ofSize: Constants.toastFontSize)) { _ in }
    }
}
