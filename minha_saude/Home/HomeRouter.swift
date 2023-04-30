import UIKit

public protocol HomeRoutingLogic {
    func routeToProfile(userId: String)
    func routeToReminders(userId: String)
    func routeToHistory(userId: String)
    func shareHistory()
}

public final class HomeRouter: HomeRoutingLogic {
    
    weak var viewController: UIViewController?
    
    public init() {}
    
    public func routeToProfile(userId: String) {
        let profileViewController = ProfileConfigurator().resolve(userId: userId)
        viewController?.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    public func routeToReminders(userId: String) {
        let remindersViewController = RemindersConfigurator().resolve(userId: userId)
        viewController?.navigationController?.pushViewController(remindersViewController, animated: true)
    }
    
    public func routeToHistory(userId: String) {
        let medicalHistoryViewController = MedicalHistoryConfigurator().resolve(userId: userId)
        viewController?.navigationController?.pushViewController(medicalHistoryViewController, animated: true)
    }
    
    public func shareHistory() {
        print("Compartilhando histórico")
    }
}
