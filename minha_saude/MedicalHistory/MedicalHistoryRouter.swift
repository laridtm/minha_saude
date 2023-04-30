import UIKit

public protocol MedicalHistoryRoutingLogic {
    func openMedicalRecordBottomSheet(
        userId: String,
        type: MedicalRecordViewControllerType,
        delegate: MedicalRecordDisplayDelegate,
        record: MedicalRecord?
    )
}

public final class MedicalHistoryRouter: MedicalHistoryRoutingLogic {
    weak var viewController: UIViewController?
    
    public init() {}
    
    public func openMedicalRecordBottomSheet(
        userId: String,
        type: MedicalRecordViewControllerType,
        delegate: MedicalRecordDisplayDelegate,
        record: MedicalRecord?
    ) {
        let recordViewController = MedicalRecordConfigurator().resolve(
            userId: userId,
            delegate: delegate,
            type: type,
            record: record
        )

        if let sheet = recordViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.largestUndimmedDetentIdentifier = .medium
        }

        viewController?.present(recordViewController, animated: true)
    }
}
