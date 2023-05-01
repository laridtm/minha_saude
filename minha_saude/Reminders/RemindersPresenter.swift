import Foundation

protocol RemindersPresentationLogic: AnyObject {
    var viewController: RemindersDisplayLogic? { get set }
    
    func presentReminders(_ reminders: [Reminder])
    func presentError()
}

public final class RemindersPresenter: RemindersPresentationLogic {
    
    struct Constants {
        static let toastFontSize: CGFloat = 12
    }
    
    weak var viewController: RemindersDisplayLogic?
    
    init() {}
    
    func presentReminders(_ reminders: [Reminder]) {
        viewController?.displayReminders(reminders)
    }
    
    func presentError() {
        viewController?.showToast(message: "Não foi possível carregar os lembretes", font: .systemFont(ofSize: Constants.toastFontSize)) { _ in }
    }
}
