import UIKit

public class MedicalRecordConfigurator {
    public init() {}

    public func resolve(
        userId: String,
        delegate: MedicalRecordDisplayDelegate,
        type: MedicalRecordViewControllerType,
        record: MedicalRecord? = nil
    ) -> UIViewController {
        let worker = MedicalHistoryWorker()
        let presenter = MedicalRecordPresenter()
        let interactor = MedicalRecordInteractor(userId: userId, worker: worker, presenter: presenter)
        let viewController = MedicalRecordViewController(interactor: interactor, type: type, record: record)
        
        viewController.delegate = delegate
        presenter.viewController = viewController
        
        return viewController
    }
}
