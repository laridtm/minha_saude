protocol RemindersBusinessLogic {
    func viewDidLoad()
    func openReminder(delegate: ReminderDisplayDelegate, type: ReminderViewControllerType, reminder: Reminder?)
}

public final class RemindersInteractor: RemindersBusinessLogic {
    private let userId: String
    private let router: RemindersRoutingLogic
    private let worker: RemindersWorkerLogic
    private let presenter: RemindersPresentationLogic
    
    init(userId: String, router: RemindersRoutingLogic, worker: RemindersWorkerLogic, presenter: RemindersPresentationLogic) {
        self.userId = userId
        self.router = router
        self.worker = worker
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        loadReminders()
    }
    
    private func loadReminders() {
        worker.fetchReminders(id: userId, size: nil) { result in
            switch result {
            case .success(let reminders):
                self.presenter.presentReminders(reminders)
            case .failure(let error):
                //TODO: Enviar um feedback de error para a home view controller
                print(error)
            }
        }
    }
    
    func openReminder(delegate: ReminderDisplayDelegate, type: ReminderViewControllerType, reminder: Reminder?) {
        router.openReminderBottomSheet(userId: userId, type: type, delegate: delegate, reminder: reminder)
    }
}
