protocol HomeBusinessLogic {
    func didTouchQuickAccess(type: QuickAcessView.QuickAccessType)
    func viewDidLoad()
}

public final class HomeInteractor: HomeBusinessLogic {
    private let router: HomeRoutingLogic
    private let presenter: HomePresentationLogic
    private let worker: HomeWorkerLogic
    
    init(
        router: HomeRoutingLogic,
        presenter: HomePresentationLogic,
        worker: HomeWorkerLogic
    ) {
        self.router = router
        self.presenter = presenter
        self.worker = worker
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
    }
    
    private func loadUserInfo() {
        worker.fetchUserInfo(id: "00897314921") { result in
            switch result {
            case .success(let info):
                self.presenter.presentUserInfo(info: info)
            case .failure(let error):
                //TODO: Enviar um feedback de error para a home view controller
                print(error)
            }
        }
    }
}
