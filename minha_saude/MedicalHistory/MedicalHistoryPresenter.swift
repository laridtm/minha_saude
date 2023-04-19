protocol MedicalHistoryPresentationLogic: AnyObject {
    var viewController: MedicalHistoryDisplayLogic? { get set }
    
    func presentMedicalHistory(_ history: [MedicalRecord])
}

public final class MedicalHistoryPresenter: MedicalHistoryPresentationLogic {
    weak var viewController: MedicalHistoryDisplayLogic?
    
    init() {}
    
    func presentMedicalHistory(_ history: [MedicalRecord]) {
        viewController?.displayMedicalHistory(history)
    }
}
