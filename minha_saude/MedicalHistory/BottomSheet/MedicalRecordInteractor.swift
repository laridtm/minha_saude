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
    private let worker: MedicalHistoryWorkerLogic
    private let presenter: MedicalRecordPresentationLogic
    
    init(worker: MedicalHistoryWorkerLogic, presenter: MedicalRecordPresentationLogic) {
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

        worker.saveRecord(userId: "00897314921", record: newRecord) { result in
            switch result {
            case .success:
                self.presenter.createdRecord()
            case.failure(let error):
                print(error)
                //TODO: enviar pra presenter pra mostrar feedback que nao conseguiu editar o reminder
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

        worker.editRecord(userId: "00897314921", record: editedRecord) { result in
            switch result {
            case .success:
                self.presenter.editRecord()
            case.failure(let error):
                print(error)
                //TODO: enviar pra presenter pra mostrar feedback que nao conseguiu editar o reminder
            }
        }
    }
    
    func deleteRecord(id: String) {
        worker.deleteRecord(id: id) { result in
            switch result {
            case .success:
                self.presenter.deleteRecord()
            case.failure(let error):
                print(error)
                //TODO: enviar pra presenter pra mostrar feedback que nao conseguiu deletar o reminder
            }
        }
    }
}
