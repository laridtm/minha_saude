import UIKit

public class HomeConfigurator {
    public init() {}

    public func resolve() -> UIViewController {
        let router = HomeRouter()
        let presenter = HomePresenter()
        let homeWorker = HomeWorker()
        let medicalHistoryWorker = MedicalHistoryWorker()
        let remindersWorker = RemindersWorker()
        let interactor = HomeInteractor(
            router: router,
            presenter: presenter,
            homeWorker: homeWorker,
            medicalHistoryWorker: medicalHistoryWorker,
            remindersWorker: remindersWorker
        )
        let viewController = HomeViewController(interactor: interactor)
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
