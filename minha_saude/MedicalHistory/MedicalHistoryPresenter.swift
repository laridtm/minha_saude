import Foundation

protocol MedicalHistoryPresentationLogic: AnyObject {
    var viewController: MedicalHistoryDisplayLogic? { get set }
    
    func presentMedicalHistory(_ history: [MedicalRecord])
    func presentError()
}

public final class MedicalHistoryPresenter: MedicalHistoryPresentationLogic {
    
    struct Constants {
        static let toastFontSize: CGFloat = 12
    }
    
    weak var viewController: MedicalHistoryDisplayLogic?
    
    init() {}
    
    func presentMedicalHistory(_ history: [MedicalRecord]) {
        viewController?.displayMedicalHistory(history)
    }
    
    func presentError() {
        viewController?.showToast(message: "Não foi possível carregar o histórico", font: .systemFont(ofSize: Constants.toastFontSize)) { _ in }
    }
}
