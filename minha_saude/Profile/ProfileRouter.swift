import UIKit

public protocol ProfileRoutingLogic {
    func routeToHome()
}

public final class ProfileRouter: ProfileRoutingLogic {
    
    weak var viewController: UIViewController?
    
    public init() {}
    
    public func routeToHome() {
        let profileViewController = HomeConfigurator().resolve()
        viewController?.navigationController?.pushViewController(profileViewController, animated: true)
    }
}
