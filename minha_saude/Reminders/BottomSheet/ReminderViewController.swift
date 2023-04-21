import Cartography
import UIKit

public enum ReminderViewControllerType {
    case new
    case edit
}

class ReminderViewController: UIViewController {
    private let type: ReminderViewControllerType
    
    private let reminderView: ReminderView = {
        let view = ReminderView()
        view.clipsToBounds = true
        return view
    }()
    
    public init(type: ReminderViewControllerType) {
        self.type = type
        
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
        
        constrain(reminderView, view) { reminder, view in
            reminder.edges == view.edges
        }
    }
}
