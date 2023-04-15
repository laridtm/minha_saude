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
        loadUserInfo()
    }
    
    private func loadUserInfo() {
        let user = UserInfo(
            fullName: "Alexandre Silveira",
            bloodType: "O+",
            alergies: "Dipirona, Rinite",
            emergencyContact: "(48) 99652-5859"
        )
        presenter.presentUserInfo(info: user)
    }
}
