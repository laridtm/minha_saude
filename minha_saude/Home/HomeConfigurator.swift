import UIKit

public class HomeConfigurator {
    public init() {}

    public func resolve() -> UIViewController {
        let router = HomeRouter()
        let interactor = HomeInteractor(router: router)
        let viewController = HomeViewController(interactor: interactor)
        router.viewController = viewController
        
        return viewController
    }
}
