protocol RemindersBusinessLogic {
    func viewDidLoad()
}

public final class RemindersInteractor: RemindersBusinessLogic {
    private let worker: RemindersWorkerLogic
    private let presenter: RemindersPresentationLogic
    
    init(worker: RemindersWorkerLogic, presenter: RemindersPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        loadReminders()
    }
    
    private func loadReminders() {
        worker.fetchReminders(id: "00897314921") { result in
            switch result {
            case .success(let reminders):
                self.presenter.presentReminders(reminders)
            case .failure(let error):
                //TODO: Enviar um feedback de error para a home view controller
                print(error)
            }
        }
    }
}
