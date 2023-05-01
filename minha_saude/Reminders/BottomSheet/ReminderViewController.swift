import Cartography
import UIKit

public enum ReminderViewControllerType {
    case new
    case edit
}

public protocol ReminderDisplayDelegate: AnyObject {
    func viewWillDismiss()
}
                                        
protocol ReminderDisplayLogic: UIViewController {
    func dismissBottomSheet()
}

class ReminderViewController: UIViewController {
    private let interactor: ReminderBusinessLogic
    private let type: ReminderViewControllerType
    private let reminder: Reminder?
    
    public weak var delegate: ReminderDisplayDelegate?
    
    private let reminderView: ReminderView = {
        let view = ReminderView()
        view.clipsToBounds = true
        return view
    }()
    
    public init(
        interactor: ReminderBusinessLogic,
        type: ReminderViewControllerType,
        reminder: Reminder? = nil
    ) {
        self.interactor = interactor
        self.type = type
        self.reminder = reminder
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(reminderView)
        
        reminderView.delegate = self
        reminderView.configure(type: type, reminder: reminder)
        
        constrain(reminderView, view) { reminder, view in
            reminder.edges == view.edges
        }
    }
}

extension ReminderViewController: ReminderViewDelegate {
    func didTouchInSave(name: String?, date: Date, type: ReminderType) {
        if self.type == .new {
            interactor.saveNewReminder(name: name, date: date, type: type)
        } else if self.type == .edit {
            guard let reminderId = self.reminder?.id else { return }
            interactor.saveEditedReminder(id: reminderId, name: name, date: date, type: type)
        }
    }
    
    func didTouchInRemove() {
        guard let reminderId = self.reminder?.id else { return }
        interactor.deleteReminder(id: reminderId)
    }
}

extension ReminderViewController: ReminderDisplayLogic {
    func dismissBottomSheet() {
        delegate?.viewWillDismiss()
        dismiss(animated: true)
    }
}
