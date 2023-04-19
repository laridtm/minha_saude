protocol MedicalHistoryBusinessLogic {
    func viewDidLoad()
}

public final class MedicalHistoryInteractor: MedicalHistoryBusinessLogic {
    private let worker: MedicalHistoryWorkerLogic
    private let presenter: MedicalHistoryPresentationLogic
    
    init(worker: MedicalHistoryWorkerLogic, presenter: MedicalHistoryPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        loadMedicalHistory()
    }
    
    private func loadMedicalHistory() {
        worker.fetchMedicalHistory(id: "00897314921") { result in
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
