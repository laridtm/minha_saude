protocol HomeBusinessLogic {
    func didTouchQuickAccess(type: QuickAcessView.QuickAccessType)
    func viewDidLoad()
}

public final class HomeInteractor: HomeBusinessLogic {
    private let router: HomeRoutingLogic
    private let presenter: HomePresentationLogic
    private let homeWorker: HomeWorkerLogic
    private let medicalHistoryWorker: MedicalHistoryWorkerLogic
    private let remindersWorker: RemindersWorkerLogic
    
    init(
        router: HomeRoutingLogic,
        presenter: HomePresentationLogic,
        homeWorker: HomeWorkerLogic,
        medicalHistoryWorker: MedicalHistoryWorkerLogic,
        remindersWorker: RemindersWorkerLogic
    ) {
        self.router = router
        self.presenter = presenter
        self.homeWorker = homeWorker
        self.medicalHistoryWorker = medicalHistoryWorker
        self.remindersWorker = remindersWorker
    }
    
    func didTouchQuickAccess(type: QuickAcessView.QuickAccessType) {
        switch type {
        case .profile:
            router.routeToProfile()
        case .reminders:
            router.routeToReminders()
        case .history:
            router.routeToHistory()
        case .share:
            router.shareHistory()
        }
    }
    
    func viewDidLoad() {
        loadUserInfo()
        loadTopRecords()
        loadTopReminders()
    }
    
    private func loadUserInfo() {
        homeWorker.fetchUserInfo(id: "00897314921") { result in
            switch result {
            case .success(let info):
                self.presenter.presentUserInfo(info: info)
            case .failure(let error):
                //TODO: Enviar um feedback de error para a home view controller
                print(error)
            }
        }
    }
    
    private func loadTopReminders() {
        remindersWorker.fetchReminders(id: "00897314921", size: 2) { result in
            switch result {
            case .success(let reminders):
                self.presenter.presentReminders(reminders)
            case .failure(let error):
                //TODO: Enviar um feedback de error para a home view controller
                print(error)
            }
        }
    }
    
    private func loadTopRecords() {
        medicalHistoryWorker.fetchMedicalHistory(id: "00897314921", options: .init(size: 3, recent: true)) { result in
            switch result {
            case .success(let records):
                self.presenter.presentRecords(records)
            case .failure(let error):
                //TODO: Enviar um feedback de error para a home view controller
                print(error)
            }
        }
    }
}
