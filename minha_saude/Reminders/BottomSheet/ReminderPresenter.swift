import Foundation

protocol ReminderPresentationLogic: AnyObject {
    var viewController: ReminderDisplayLogic? { get set }
    
    func createdReminder()
    func editReminder()
    func deleteReminder()
    func presentError(_ error: String)
}

public final class ReminderPresenter: ReminderPresentationLogic {
    struct Constants {
        static let toastFontSize: CGFloat = 12
    }
    
    weak var viewController: ReminderDisplayLogic?
    
    init() {}
    
    func createdReminder() {
        viewController?.showToast(message: "Seu lembrete foi criado com sucesso", font: .systemFont(ofSize: Constants.toastFontSize)) { _ in
            self.viewController?.dismissBottomSheet()
        }
    }
    
    func editReminder() {
        viewController?.showToast(message: "Seu lembrete foi editado com sucesso", font: .systemFont(ofSize: Constants.toastFontSize)) { _ in
            self.viewController?.dismissBottomSheet()
        }
    }
    
    func deleteReminder() {
        viewController?.showToast(message: "Seu lembrete foi deletado com sucesso", font: .systemFont(ofSize: Constants.toastFontSize)) { _ in
            self.viewController?.dismissBottomSheet()
        }
    }
    
    func presentError(_ error: String) {
        viewController?.showToast(message: error, font: .systemFont(ofSize: Constants.toastFontSize)) { _ in }
    }
}
