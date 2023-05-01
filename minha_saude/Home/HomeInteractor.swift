protocol HomeBusinessLogic {
    func didTouchQuickAccess(type: QuickAcessView.QuickAccessType)
    func viewDidLoad()
}

public final class HomeInteractor: HomeBusinessLogic {
    private let userId: String
    private let router: HomeRoutingLogic
    private let presenter: HomePresentationLogic
    private let homeWorker: HomeWorkerLogic
    private let medicalHistoryWorker: MedicalHistoryWorkerLogic
    private let remindersWorker: RemindersWorkerLogic
    private let pdfRender: PdfRederingLogic
    
    init(
        userId: String,
        router: HomeRoutingLogic,
        presenter: HomePresentationLogic,
        homeWorker: HomeWorkerLogic,
        medicalHistoryWorker: MedicalHistoryWorkerLogic,
        remindersWorker: RemindersWorkerLogic,
        pdfRender: PdfRederingLogic
    ) {
        self.userId = userId
        self.router = router
        self.presenter = presenter
        self.homeWorker = homeWorker
        self.medicalHistoryWorker = medicalHistoryWorker
        self.remindersWorker = remindersWorker
        self.pdfRender = pdfRender
    }
    
    func didTouchQuickAccess(type: QuickAcessView.QuickAccessType) {
        switch type {
        case .profile:
            router.routeToProfile(userId: userId)
        case .reminders:
            router.routeToReminders(userId: userId)
        case .history:
            router.routeToHistory(userId: userId)
        case .share:
            pdfRender.renderAndSharePDF()
        }
    }
    
    func viewDidLoad() {
        loadUserInfo()
        loadTopRecords()
        loadTopReminders()
    }
    
    private func loadUserInfo() {
        homeWorker.fetchUserInfo(id: userId) { result in
            switch result {
            case .success(let info):
                self.presenter.presentUserInfo(info: info)
            case .failure:
                self.presenter.presentError("Não foi possível carregar as informações do usuário")
            }
        }
    }
    
    private func loadTopReminders() {
        remindersWorker.fetchReminders(id: userId, size: 2) { result in
            switch result {
            case .success(let reminders):
                self.presenter.presentReminders(reminders)
            case .failure:
                self.presenter.presentError("Não foi possível carregar os lembretes")
            }
        }
    }
    
    private func loadTopRecords() {
        medicalHistoryWorker.fetchMedicalHistory(id: userId, options: .init(size: 3, recent: true)) { result in
            switch result {
            case .success(let records):
                self.presenter.presentRecords(records)
            case .failure:
                self.presenter.presentError("Não foi possível carregar o histórico")
            }
        }
    }
}
