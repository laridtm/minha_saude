import UIKit

public class HomeConfigurator {
    public init() {}

    public func resolve() -> UIViewController {
        let router = HomeRouter()
        let presenter = HomePresenter()
        let worker = HomeWorker()
        let interactor = HomeInteractor(router: router, presenter: presenter, worker: worker)
        let viewController = HomeViewController(interactor: interactor)
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
