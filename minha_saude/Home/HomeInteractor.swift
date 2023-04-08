protocol HomeInteractorBusinessLogic {
    func didTouchQuickAccess(type: QuickAcessView.QuickAccessType)
}

public final class HomeInteractor: HomeInteractorBusinessLogic {
    public init() {}
    
    func didTouchQuickAccess(type: QuickAcessView.QuickAccessType) {
        switch type {
        case .profile:
            print("Roteando para tela de perfil")
        case .reminders:
            print("Roteando para tela de lembretes")
        case .history:
            print("Roteando para tela de histórico")
        case .share:
            print("Roteando para tela de compartilhamento")
        }
    }
}
