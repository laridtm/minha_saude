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
        let profileViewController = ProfileConfigurator().resolve()
        viewController?.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    public func routeToReminders() {
        let remindersViewController = RemindersConfigurator().resolve()
        viewController?.navigationController?.pushViewController(remindersViewController, animated: true)
    }
    
    public func routeToHistory() {
        let medicalHistoryViewController = MedicalHistoryConfigurator().resolve()
        viewController?.navigationController?.pushViewController(medicalHistoryViewController, animated: true)
    }
    
    public func shareHistory() {
        print("Compartilhando histórico")
    }
}
