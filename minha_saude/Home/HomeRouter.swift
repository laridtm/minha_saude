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
        let remindersViewController = RemindersViewController()
        viewController?.navigationController?.pushViewController(remindersViewController, animated: true)
    }
    
    public func routeToHistory() {
        let medicalHistoryViewController = MedicalHistoryViewController()
        viewController?.navigationController?.pushViewController(medicalHistoryViewController, animated: true)
    }
    
    public func shareHistory() {
        print("Compartilhando histórico")
    }
}
