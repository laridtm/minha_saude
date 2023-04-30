import UIKit

public class ProfileConfigurator {
    public init() {}

    public func resolve(userId: String) -> UIViewController {
        let profileWorker = ProfileWorker()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        let interactor = ProfileInteractor(userId: userId, profileWorker: profileWorker, presenter: presenter, router: router)
        let viewController = ProfileViewController(interactor: interactor)
        
        router.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
