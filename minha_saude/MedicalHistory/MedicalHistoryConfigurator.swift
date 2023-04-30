import UIKit

public class MedicalHistoryConfigurator {
    public init() {}

    public func resolve(userId: String) -> UIViewController {
        let worker = MedicalHistoryWorker()
        let presenter = MedicalHistoryPresenter()
        let router = MedicalHistoryRouter()
        let pdfRender = PdfRender(userId: userId, worker: worker)
        let interactor = MedicalHistoryInteractor(
            userId: userId,
            router: router,
            worker: worker,
            presenter: presenter,
            pdfRender: pdfRender
        )
        let viewController = MedicalHistoryViewController(interactor: interactor)
        
        pdfRender.viewController = viewController
        router.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
