import UIKit

public protocol HomeRoutingLogic {
    func routeToProfile()
    func routeToReminders()
    func routeToHistory()
    func shareHistory()
}

public final class HomeRouter: HomeRoutingLogic {
    
    weak var viewController: UIViewController?
    
    public init() {}
    
    public func routeToProfile() {
        print("Roteando para tela de perfil")
    }
    
    public func routeToReminders() {
        print("Roteando para tela de lembretes")
    }
    
    public func routeToHistory() {
        print("Roteando para tela de histórico")
    }
    
    public func shareHistory() {
        print("Compartilhando histórico")
    }
}
