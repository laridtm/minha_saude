protocol HomePresentationLogic: AnyObject {
    var viewController: HomeDisplayLogic? { get set }
    
    func presentUserInfo(info: UserInfo)
    func presentRecords(_ records: [MedicalRecord])
    func presentReminders(_ reminders: [Reminder])
}

public final class HomePresenter: HomePresentationLogic {
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
}
