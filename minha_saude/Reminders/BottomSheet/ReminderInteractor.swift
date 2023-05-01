import Foundation

protocol ReminderBusinessLogic {
    func saveNewReminder(name: String?, date: Date, type: ReminderType)
    func saveEditedReminder(id: String, name: String?, date: Date, type: ReminderType)
    func deleteReminder(id: String)
}

public final class ReminderInteractor: ReminderBusinessLogic {
    private let userId: String
    private let worker: RemindersWorkerLogic
    private let presenter: ReminderPresentationLogic
    
    init(userId: String, worker: RemindersWorkerLogic, presenter: ReminderPresentationLogic) {
        self.userId = userId
        self.worker = worker
        self.presenter = presenter
    }
    
    public func saveNewReminder(name: String?, date: Date, type: ReminderType) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateFormatted = dateFormatter.string(from: date)
        
        let newReminder: Reminder = .init(name: name ?? "", time: dateFormatted, type: type)
        
        worker.saveReminder(userId: userId, reminder: newReminder) { result in
            switch result {
            case .success:
                self.presenter.createdReminder()
            case.failure:
                self.presenter.presentError("Não foi possível criar o lembrete")
            }
        }
    }
    
    public func saveEditedReminder(id: String, name: String?, date: Date, type: ReminderType) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateFormatted = dateFormatter.string(from: date)
        
        let editedReminder: Reminder = .init(id: id, name: name ?? "", time: dateFormatted, type: type)
        
        worker.editReminder(userId: userId, reminder: editedReminder) { result in
            switch result {
            case .success:
                self.presenter.editReminder()
            case.failure:
                self.presenter.presentError("Não foi possível editar o lembrete")
            }
        }
    }
    
    public func deleteReminder(id: String) {
        worker.deleteReminder(id: id) { result in
            switch result {
            case .success:
                self.presenter.deleteReminder()
            case.failure:
                self.presenter.presentError("Não foi possível deletar o lembrete")
            }
        }
    }
}
