import UIKit

public class RemindersConfigurator {
    public init() {}

    public func resolve(userId: String) -> UIViewController {
        let worker = RemindersWorker()
        let presenter = RemindersPresenter()
        let router = RemindersRouter()
        let interactor = RemindersInteractor(userId: userId, router: router, worker: worker, presenter: presenter)
        let viewController = RemindersViewController(interactor: interactor)
        
        router.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
