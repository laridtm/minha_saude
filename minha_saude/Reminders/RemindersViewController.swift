import Cartography
import UIKit

class RemindersViewController: UIViewController {
    
    struct Constants {
        static let estimatedRowHeight: CGFloat = 77
    }
    
    private var reminders: [Reminder] = [
        .init(
            id: "1",
            name: "Remédio Pressão",
            time: "12:00",
            repetition: .everyDay
        ),
        .init(
            id: "2",
            name: "Remédio Pressão",
            time: "12:00",
            repetition: .once
        ),
        .init(
            id: "3",
            name: "Remédio Pressão",
            time: "12:00",
            repetition: .weekends
        ),
        .init(
            id: "4",
            name: "Remédio Pressão",
            time: "12:00",
            repetition: .mondayToFriday
        )
    ]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        let identifier = String(describing: ReminderTableViewCell.self)
        tableView.register(ReminderTableViewCell.self, forCellReuseIdentifier: identifier)
        
        setupBackButton()
        
        view.backgroundColor = Asset.ColorAssets.background.color
        view.addSubview(tableView)
        
        constrain(tableView, view) { tableView, view in
            tableView.edges == view.edges
        }
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = "Lembretes"
        backButton.tintColor = .black
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

extension RemindersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: ReminderTableViewCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ReminderTableViewCell else { return UITableViewCell()}
        
        cell.configure(reminder: reminders[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
