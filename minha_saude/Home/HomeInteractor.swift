protocol HomeInteractorBusinessLogic {
    func didTouchQuickAccess(type: QuickAcessView.QuickAccessType)
}

public final class HomeInteractor: HomeInteractorBusinessLogic {
    private let router: HomeRoutingLogic
    
    public init(router: HomeRoutingLogic) {
        self.router = router
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
}
