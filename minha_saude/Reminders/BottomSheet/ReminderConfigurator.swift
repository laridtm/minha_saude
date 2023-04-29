import UIKit

public class ReminderConfigurator {
    public init() {}

    public func resolve(
        delegate: ReminderDisplayDelegate,
        type: ReminderViewControllerType,
        reminder: Reminder? = nil
    ) -> UIViewController {
        let worker = RemindersWorker()
        let presenter = ReminderPresenter()
        let interactor = ReminderInteractor(worker: worker, presenter: presenter)
        let viewController = ReminderViewController(interactor: interactor, type: type, reminder: reminder)
        
        viewController.delegate = delegate
        presenter.viewController = viewController
        
        return viewController
    }
}
