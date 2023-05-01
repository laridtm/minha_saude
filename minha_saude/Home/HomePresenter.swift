import Foundation

protocol HomePresentationLogic: AnyObject {
    var viewController: HomeDisplayLogic? { get set }
    
    func presentUserInfo(info: UserInfo)
    func presentRecords(_ records: [MedicalRecord])
    func presentReminders(_ reminders: [Reminder])
    func presentError(_ error: String)
}

public final class HomePresenter: HomePresentationLogic {
    
    struct Constants {
        static let toastFontSize: CGFloat = 12
    }
    
    weak var viewController: HomeDisplayLogic?
    
    init() {}
    
    func presentUserInfo(info: UserInfo) {
        viewController?.displayUserInfo(info: info)
    }
    
    func presentRecords(_ records: [MedicalRecord]) {
        viewController?.displayRecords(records)
    }
    
    func presentReminders(_ reminders: [Reminder]) {
        viewController?.displayReminders(reminders)
    }
    
    func presentError(_ error: String) {
        viewController?.showToast(message: error, font: .systemFont(ofSize: Constants.toastFontSize)) { _ in }
    }
}
