protocol MedicalHistoryBusinessLogic {
    func loadMedicalHistory(filterType: MedicalRecordType?)
    func openMedicalRecord(delegate: MedicalRecordDisplayDelegate, type: MedicalRecordViewControllerType, record: MedicalRecord?)
    func generatePDF()
}

public final class MedicalHistoryInteractor: MedicalHistoryBusinessLogic {
    private let userId: String
    private let router: MedicalHistoryRoutingLogic
    private let worker: MedicalHistoryWorkerLogic
    private let presenter: MedicalHistoryPresentationLogic
    private let pdfRender: PdfRederingLogic
    
    init(
        userId: String,
        router: MedicalHistoryRoutingLogic,
        worker: MedicalHistoryWorkerLogic,
        presenter: MedicalHistoryPresentationLogic,
        pdfRender: PdfRederingLogic
    ) {
        self.userId = userId
        self.router = router
        self.worker = worker
        self.presenter = presenter
        self.pdfRender = pdfRender
    }
    
    func loadMedicalHistory(filterType: MedicalRecordType?) {
        worker.fetchMedicalHistory(id: userId, options: .init(filterType: filterType)) { result in
            switch result {
            case .success(let history):
                self.presenter.presentMedicalHistory(history)
            case .failure(let error):
                //TODO: Enviar um feedback de error para a home view controller
                print(error)
            }
        }
    }
    
    func openMedicalRecord(delegate: MedicalRecordDisplayDelegate, type: MedicalRecordViewControllerType, record: MedicalRecord?) {
        router.openMedicalRecordBottomSheet(userId: userId, type: type, delegate: delegate, record: record)
    }
    
    func generatePDF() {
        pdfRender.renderAndSharePDF()
    }
}
