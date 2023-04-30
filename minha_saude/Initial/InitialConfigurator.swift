import UIKit

public class InitialConfigurator {
    public init() {}

    public func resolve() -> UIViewController {
        let profileWorker = ProfileWorker()
        let router = InitialRouter()
        let interactor = InitialInteractor(profileWorker: profileWorker, router: router)
        let viewController = InitialViewController(interactor: interactor)
        
        router.viewController = viewController
        
        return viewController
    }
}
