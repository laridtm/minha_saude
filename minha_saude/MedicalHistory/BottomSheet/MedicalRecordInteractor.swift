import Foundation

protocol MedicalRecordBusinessLogic {
    func saveNewRecord(
        date: String,
        time: String,
        hospital: String,
        profesional: String,
        speciallity: String,
        observation: String,
        type: MedicalRecordType
    )
    func saveEditedRecord(
        id: String,
        date: String,
        time: String,
        hospital: String,
        profesional: String,
        speciallity: String,
        observation: String,
        type: MedicalRecordType
    )
    func deleteRecord(id: String)
}

public final class MedicalRecordInteractor: MedicalRecordBusinessLogic {
    private let userId: String
    private let worker: MedicalHistoryWorkerLogic
    private let presenter: MedicalRecordPresentationLogic
    
    init(userId: String, worker: MedicalHistoryWorkerLogic, presenter: MedicalRecordPresentationLogic) {
        self.userId = userId
        self.worker = worker
        self.presenter = presenter
    }
    
    func saveNewRecord(
        date: String,
        time: String,
        hospital: String,
        profesional: String,
        speciallity: String,
        observation: String,
        type: MedicalRecordType
    ) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy HH:mm"
        
        let newRecord: MedicalRecord = .init(
            date: dateFormatter.date(from: "\(date) \(time)") ?? Date(),
            hospital: hospital,
            professional: profesional,
            name: speciallity,
            observation: observation,
            type: type
        )

        worker.saveRecord(userId: userId, record: newRecord) { result in
            switch result {
            case .success:
                self.presenter.createdRecord()
            case.failure:
                self.presenter.presentError("Não foi possível criar o lembrete")
            }
        }
    }
    
    func saveEditedRecord(
        id: String,
        date: String,
        time: String,
        hospital: String,
        profesional: String,
        speciallity: String,
        observation: String,
        type: MedicalRecordType
    ) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy HH:mm"
        
        let editedRecord: MedicalRecord = .init(
            id: id,
            date: dateFormatter.date(from: "\(date) \(time)") ?? Date(),
            hospital: hospital,
            professional: profesional,
            name: speciallity,
            observation: observation,
            type: type
        )

        worker.editRecord(userId: userId, record: editedRecord) { result in
            switch result {
            case .success:
                self.presenter.editRecord()
            case.failure:
                self.presenter.presentError("Não foi possível editar o lembrete")
            }
        }
    }
    
    func deleteRecord(id: String) {
        worker.deleteRecord(id: id) { result in
            switch result {
            case .success:
                self.presenter.deleteRecord()
            case.failure:
                self.presenter.presentError("Não foi possível deletar o lembrete")
            }
        }
    }
}
