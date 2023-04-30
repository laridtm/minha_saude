import UIKit

public protocol RemindersRoutingLogic {
    func openReminderBottomSheet(
        userId: String,
        type: ReminderViewControllerType,
        delegate: ReminderDisplayDelegate,
        reminder: Reminder?
    )
}

public final class RemindersRouter: RemindersRoutingLogic {
    weak var viewController: UIViewController?
    
    public init() {}
    
    public func openReminderBottomSheet(
        userId: String,
        type: ReminderViewControllerType,
        delegate: ReminderDisplayDelegate,
        reminder: Reminder?
    ) {
        let reminderViewController = ReminderConfigurator().resolve(
            userId: userId,
            delegate: delegate,
            type: type,
            reminder: reminder
        )

        if let sheet = reminderViewController.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.largestUndimmedDetentIdentifier = .medium
            }
        
        viewController?.present(reminderViewController, animated: true)
    }
}
