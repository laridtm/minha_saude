import UIKit

public class RemindersConfigurator {
    public init() {}

    public func resolve() -> UIViewController {
        let worker = RemindersWorker()
        let presenter = RemindersPresenter()
        let interactor = RemindersInteractor(worker: worker, presenter: presenter)
        let viewController = RemindersViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
