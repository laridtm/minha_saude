import UIKit

public protocol ProfileRoutingLogic {
    func routeToHome(userId: String)
}

public final class ProfileRouter: ProfileRoutingLogic {
    
    weak var viewController: UIViewController?
    
    public init() {}
    
    public func routeToHome(userId: String) {
        let homeViewController = HomeConfigurator().resolve(userId: userId)
        viewController?.navigationController?.pushViewController(homeViewController, animated: true)
    }
}
