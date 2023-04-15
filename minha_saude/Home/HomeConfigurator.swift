import UIKit

public class HomeConfigurator {
    public init() {}

    public func resolve() -> UIViewController {
        let router = HomeRouter()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(router: router, presenter: presenter)
        let viewController = HomeViewController(interactor: interactor)
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
