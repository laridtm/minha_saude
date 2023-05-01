import UIKit

public class InitialConfigurator {
    public init() {}

    public func resolve() -> UIViewController {
        let profileWorker = ProfileWorker()
        let router = InitialRouter()
        let presenter = InitialPresenter()
        let interactor = InitialInteractor(profileWorker: profileWorker, router: router, presenter: presenter)
        let viewController = InitialViewController(interactor: interactor)
        
        router.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
