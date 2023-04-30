import UIKit

public protocol InitialRoutingLogic {
    func routeToHome(userId: String)
    func routeToUserProfile(userId: String)
}

public final class InitialRouter: InitialRoutingLogic {
    weak var viewController: UIViewController?
    
    public init() {}
    
    public func routeToHome(userId: String) {
        let homeViewController = HomeConfigurator().resolve(userId: userId)
        viewController?.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    public func routeToUserProfile(userId: String) {
        let profileViewController = ProfileConfigurator().resolve(userId: userId)
        viewController?.navigationController?.pushViewController(profileViewController, animated: true)
    }
}
