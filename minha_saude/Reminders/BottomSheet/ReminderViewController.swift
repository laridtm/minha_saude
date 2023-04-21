import Cartography
import UIKit

public enum ReminderViewControllerType {
    case new
    case edit
}

class ReminderViewController: UIViewController {
    private let type: ReminderViewControllerType
    private let reminder: Reminder?
    
    private let reminderView: ReminderView = {
        let view = ReminderView()
        view.clipsToBounds = true
        return view
    }()
    
    public init(type: ReminderViewControllerType, reminder: Reminder? = nil) {
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
        //TODO: Se o type for new -> mandar para a interactor adicionar
        // Se for edit -> mandar para a interactor editar
    }
    
    func didTouchInRemove() {
        //TODO: guard let para ver se o reminder não é nil
        //enviar para a interactor remover o reminder pelo id (reminder.id)
    }
}
