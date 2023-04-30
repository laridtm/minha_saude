protocol MedicalHistoryBusinessLogic {
    func loadMedicalHistory(filterType: MedicalRecordType?)
}

public final class MedicalHistoryInteractor: MedicalHistoryBusinessLogic {
    private let worker: MedicalHistoryWorkerLogic
    private let presenter: MedicalHistoryPresentationLogic
    
    init(worker: MedicalHistoryWorkerLogic, presenter: MedicalHistoryPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func loadMedicalHistory(filterType: MedicalRecordType?) {
        worker.fetchMedicalHistory(id: "00897314921", options: .init(filterType: filterType)) { result in
            switch result {
            case .success(let history):
                self.presenter.presentMedicalHistory(history)
            case .failure(let error):
                //TODO: Enviar um feedback de error para a home view controller
                print(error)
            }
        }
    }
}
