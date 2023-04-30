import UIKit

public class ReminderConfigurator {
    public init() {}

    public func resolve(
        userId: String,
        delegate: ReminderDisplayDelegate,
        type: ReminderViewControllerType,
        reminder: Reminder? = nil
    ) -> UIViewController {
        let worker = RemindersWorker()
        let presenter = ReminderPresenter()
        let interactor = ReminderInteractor(userId: userId, worker: worker, presenter: presenter)
        let viewController = ReminderViewController(interactor: interactor, type: type, reminder: reminder)
        
        viewController.delegate = delegate
        presenter.viewController = viewController
        
        return viewController
    }
}
