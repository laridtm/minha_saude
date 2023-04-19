import UIKit

public class MedicalHistoryConfigurator {
    public init() {}

    public func resolve() -> UIViewController {
        let worker = MedicalHistoryWorker()
        let presenter = MedicalHistoryPresenter()
        let interactor = MedicalHistoryInteractor(worker: worker, presenter: presenter)
        let viewController = MedicalHistoryViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
