import UIKit

public class MedicalHistoryConfigurator {
    public init() {}

    public func resolve(userId: String) -> UIViewController {
        let worker = MedicalHistoryWorker()
        let presenter = MedicalHistoryPresenter()
        let router = MedicalHistoryRouter()
        let interactor = MedicalHistoryInteractor(userId: userId, router: router, worker: worker, presenter: presenter)
        let viewController = MedicalHistoryViewController(interactor: interactor)
        
        router.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
