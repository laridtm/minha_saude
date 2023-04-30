import UIKit

public class HomeConfigurator {
    public init() {}

    public func resolve(userId: String) -> UIViewController {
        let router = HomeRouter()
        let presenter = HomePresenter()
        let homeWorker = HomeWorker()
        let medicalHistoryWorker = MedicalHistoryWorker()
        let remindersWorker = RemindersWorker()
        let pdfRender = PdfRender(userId: userId, worker: medicalHistoryWorker)
        let interactor = HomeInteractor(
            userId: userId,
            router: router,
            presenter: presenter,
            homeWorker: homeWorker,
            medicalHistoryWorker: medicalHistoryWorker,
            remindersWorker: remindersWorker,
            pdfRender: pdfRender
        )
        let viewController = HomeViewController(interactor: interactor)
        
        presenter.viewController = viewController
        router.viewController = viewController
        pdfRender.viewController = viewController
        
        return viewController
    }
}
