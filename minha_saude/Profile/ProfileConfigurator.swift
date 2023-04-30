import UIKit

public class ProfileConfigurator {
    public init() {}

    public func resolve() -> UIViewController {
        let profileWorker = ProfileWorker()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        let interactor = ProfileInteractor(profileWorker: profileWorker, presenter: presenter, router: router)
        let viewController = ProfileViewController(interactor: interactor)
        
        router.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
