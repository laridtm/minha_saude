import Foundation

protocol ReminderBusinessLogic {
    func saveNewReminder(name: String?, date: Date, type: ReminderType)
    func saveEditedReminder(id: String, name: String?, date: Date, type: ReminderType)
    func deleteReminder(id: String)
}

public final class ReminderInteractor: ReminderBusinessLogic {
    private let worker: RemindersWorkerLogic
    private let presenter: ReminderPresentationLogic
    
    init(worker: RemindersWorkerLogic, presenter: ReminderPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    public func saveNewReminder(name: String?, date: Date, type: ReminderType) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateFormatted = dateFormatter.string(from: date)
        
        let newReminder: Reminder = .init(name: name ?? "", time: dateFormatted, type: type)
        
        worker.saveReminder(userId: "00897314921", reminder: newReminder) { result in
            switch result {
            case .success:
                self.presenter.createdReminder()
            case.failure(let error):
                print(error)
                //TODO: enviar pra presenter pra mostrar feedback que nao conseguiu criar o reminder
            }
        }
    }
    
    public func saveEditedReminder(id: String, name: String?, date: Date, type: ReminderType) {
        
        
    }
    
    public func deleteReminder(id: String) {
        
    }
}
