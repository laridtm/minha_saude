import Foundation

protocol MedicalRecordPresentationLogic: AnyObject {
    var viewController: MedicalRecordDisplayLogic? { get set }
    
    func createdRecord()
    func editRecord()
    func deleteRecord()
    func presentError(_ error: String)
}

public final class MedicalRecordPresenter: MedicalRecordPresentationLogic {
    
    struct Constants {
        static let toastFontSize: CGFloat = 12
    }
    
    weak var viewController: MedicalRecordDisplayLogic?
    
    init() {}
    
    func createdRecord() {
        viewController?.showToast(message: "Seu registro foi criado com sucesso", font: .systemFont(ofSize: Constants.toastFontSize)) { _ in
            self.viewController?.dismissBottomSheet()
        }
    }
    
    func editRecord() {
        viewController?.showToast(message: "Seu registro foi editado com sucesso", font: .systemFont(ofSize: Constants.toastFontSize)) { _ in
            self.viewController?.dismissBottomSheet()
        }
    }
    
    func deleteRecord() {
        viewController?.showToast(message: "Seu registro foi deletado com sucesso", font: .systemFont(ofSize: Constants.toastFontSize)) { _ in
            self.viewController?.dismissBottomSheet()
        }
    }
    
    func presentError(_ error: String) {
        viewController?.showToast(message: error, font: .systemFont(ofSize: Constants.toastFontSize)) { _ in }
    }
}
