protocol ReminderPresentationLogic: AnyObject {
    var viewController: ReminderDisplayLogic? { get set }
    
    func createdReminder()
}

public final class ReminderPresenter: ReminderPresentationLogic {
    weak var viewController: ReminderDisplayLogic?
    
    init() {}
    
    func createdReminder() {
        viewController?.dismissBottomSheet()
    }
}
