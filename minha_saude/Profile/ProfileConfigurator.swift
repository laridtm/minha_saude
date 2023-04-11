import UIKit

public class ProfileConfigurator {
    public init() {}

    public func resolve() -> UIViewController {
//        let router = HomeRouter()
        let interactor = ProfileInteractor()
        let viewController = ProfileViewController(interactor: interactor)
//        router.viewController = viewController
        
        return viewController
    }
}
