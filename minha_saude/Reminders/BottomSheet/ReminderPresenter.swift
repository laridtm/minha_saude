protocol ReminderPresentationLogic: AnyObject {
    var viewController: ReminderDisplayLogic? { get set }
    
    func createdReminder()
    func editReminder()
    func deleteReminder()
}

public final class ReminderPresenter: ReminderPresentationLogic {
    weak var viewController: ReminderDisplayLogic?
    
    init() {}
    
    //TODO: criar feedback de sucesso
    
    func createdReminder() {
        viewController?.dismissBottomSheet()
    }
    
    func editReminder() {
        viewController?.dismissBottomSheet()
    }
    
    func deleteReminder() {
        viewController?.dismissBottomSheet()
    }
}
