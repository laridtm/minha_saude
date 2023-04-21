protocol RemindersPresentationLogic: AnyObject {
    var viewController: RemindersDisplayLogic? { get set }
    
    func presentReminders(_ reminders: [Reminder])
}

public final class RemindersPresenter: RemindersPresentationLogic {
    weak var viewController: RemindersDisplayLogic?
    
    init() {}
    
    func presentReminders(_ reminders: [Reminder]) {
        viewController?.displayReminders(reminders)
    }
}
