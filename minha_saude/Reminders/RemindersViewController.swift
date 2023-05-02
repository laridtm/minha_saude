import Cartography
import UIKit

protocol RemindersDisplayLogic: UIViewController {
    func displayReminders(_ reminders: [Reminder])
}

class RemindersViewController: UIViewController {
    
    struct Constants {
        static let estimatedRowHeight: CGFloat = 77
    }
    
    private let interactor: RemindersBusinessLogic
    private var reminders: [Reminder] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Asset.ColorAssets.background.color
        return tableView
    }()
    
    public init(interactor: RemindersBusinessLogic) {
        self.interactor = interactor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        interactor.viewDidLoad()
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let identifier = String(describing: ReminderTableViewCell.self)
        tableView.register(ReminderTableViewCell.self, forCellReuseIdentifier: identifier)
        
        let emptyStateIdentifier = String(describing: EmptyStateCell.self)
        tableView.register(EmptyStateCell.self, forCellReuseIdentifier: emptyStateIdentifier)
        
        setupBackButton()
        
        view.addSubview(tableView)
        
        constrain(tableView, view) { tableView, view in
            tableView.edges == view.edges
        }
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = "Lembretes"
        backButton.tintColor = .black
        let rightBarButtonItem = UIBarButtonItem.init(
            image: UIImage(named: Asset.Assets.addButton.name),
            style: .done,
            target: self,
            action: #selector(addReminder)
        )
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @objc func addReminder() {
        interactor.openReminder(delegate: self, type: .new, reminder: nil)
    }
}

extension RemindersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count > 0 ? reminders.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if reminders.count == 0 {
            let identifier = String(describing: EmptyStateCell.self)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? EmptyStateCell else { return UITableViewCell()}
            
            cell.configure(emptyStateTitle: "Não há registro de lembretes")
            cell.backgroundColor = Asset.ColorAssets.background.color
            
            return cell
        }
        
        let identifier = String(describing: ReminderTableViewCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ReminderTableViewCell else { return UITableViewCell()}
        
        cell.configure(reminder: reminders[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.openReminder(delegate: self, type: .edit, reminder: reminders[indexPath.row])
    }
}

extension RemindersViewController: RemindersDisplayLogic {
    func displayReminders(_ reminders: [Reminder]) {
        self.reminders = reminders
        tableView.reloadData()
    }
}

extension RemindersViewController: ReminderDisplayDelegate {
    func viewWillDismiss() {
        interactor.viewDidLoad()
    }
}
