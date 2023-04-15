protocol HomeBusinessLogic {
    func didTouchQuickAccess(type: QuickAcessView.QuickAccessType)
    func viewDidLoad()
}

public final class HomeInteractor: HomeBusinessLogic {
    private let router: HomeRoutingLogic
    private let presenter: HomePresentationLogic
    
    init(router: HomeRoutingLogic, presenter: HomePresentationLogic) {
        self.router = router
        self.presenter = presenter
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
        loadUserEmergencyInfo()
        
    }
    
    private func loadUserEmergencyInfo() {
        let emergencyInfo = UserEmergencyInfo(bloodType: "O+", alergies: "Dipirona, Rinite", emergencyContact: "(48) 99652-5859")
        presenter.presentUserEmergencyInfo(info: emergencyInfo)
    }
}
