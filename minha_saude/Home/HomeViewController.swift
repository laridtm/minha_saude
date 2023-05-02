import Cartography
import UIKit

protocol HomeDisplayLogic: UIViewController {
    func displayUserInfo(info: UserInfo)
    func displayRecords(_ records: [MedicalRecord])
    func displayReminders(_ reminders: [Reminder])
}

class HomeViewController: UIViewController {
    
    struct Constants {
        static let layoutMargins: CGFloat = 10
        static let stackViewSpacing: CGFloat = 24
        static let userInfoSpacing: CGFloat = 17
        static let estimatedRowHeight: CGFloat = 77
    }
    
    private let interactor: HomeBusinessLogic
    private var reminders: [Reminder] = []
    private var records: [MedicalRecord] = []
    
    private let userInfoView: UserInfoView = {
        let view = UserInfoView()
        view.clipsToBounds = true
        return view
    }()
    
    private let userEmergencyInfoView: UserEmergencyInfoView = {
        let view = UserEmergencyInfoView()
        view.clipsToBounds = true
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: Constants.layoutMargins, bottom: 0, right: Constants.layoutMargins)
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Asset.ColorAssets.background.color
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()
    
    public init(interactor: HomeBusinessLogic) {
        self.interactor = interactor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Asset.ColorAssets.background.color
        configure()
        interactor.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor.viewDidLoad()
    }
    
    private func configure() {
        view.addSubview(userInfoView)
        view.addSubview(userEmergencyInfoView)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let sectionIdentifier = String(describing: HomeHeaderSectionView.self)
        tableView.register(HomeHeaderSectionView.self, forHeaderFooterViewReuseIdentifier: sectionIdentifier)
        
        let reminderIdentifier = String(describing: ReminderTableViewCell.self)
        tableView.register(ReminderTableViewCell.self, forCellReuseIdentifier: reminderIdentifier)
        
        let recordIdentifier = String(describing: MedicalRecordTableViewCell.self)
        tableView.register(MedicalRecordTableViewCell.self, forCellReuseIdentifier: recordIdentifier)
        
        let emptyStateIdentifier = String(describing: EmptyStateCell.self)
        tableView.register(EmptyStateCell.self, forCellReuseIdentifier: emptyStateIdentifier)
        
        setupStackView()
        setupConstraints()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        
        let shortcuts: [QuickAcessView.QuickAccessType] = [.profile, .reminders, .history, .share]
        shortcuts.forEach {
            let view = QuickAcessView(type: $0)
            view.delegate = self
            stackView.addArrangedSubview(view)
        }
    }
    
    private func setupConstraints() {
        constrain(userInfoView, userEmergencyInfoView, stackView, tableView, view) { userInfo, emergencyInfo, stack, table, view in
            userInfo.top == view.safeAreaLayoutGuide.top
            userInfo.leading == view.leading
            userInfo.trailing == view.trailing
            
            emergencyInfo.top == userInfo.bottom + Constants.userInfoSpacing
            emergencyInfo.leading == view.leading + Constants.stackViewSpacing
            emergencyInfo.trailing == view.trailing - Constants.stackViewSpacing
            
            stack.top == emergencyInfo.bottom + Constants.stackViewSpacing
            stack.leading == view.leading
            stack.trailing == view.trailing
            
            table.top == stack.bottom + Constants.stackViewSpacing
            table.leading == view.leading
            table.trailing == view.trailing
            table.bottom == view.bottom
        }
    }
    
    private func createEmptyState(for index: IndexPath) -> UITableViewCell {
        let identifier = String(describing: EmptyStateCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index) as? EmptyStateCell else { return UITableViewCell()}
        
        cell.configure(emptyStateTitle: index.section == 0 ? "Não há registro de lembretes" : "Não há registro de histórico médico")
        cell.backgroundColor = Asset.ColorAssets.background.color
        
        return cell
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displayRecords(_ records: [MedicalRecord]) {
        self.records = records
        tableView.reloadData()
    }
    
    func displayReminders(_ reminders: [Reminder]) {
        self.reminders = reminders
        tableView.reloadData()
    }
    
    func displayUserInfo(info: UserInfo) {
        userInfoView.configure(info: info)
        userEmergencyInfoView.configure(info: info)
    }
}

extension HomeViewController: QuickAccessViewDelegate {
    func didTouchQuickAccess(type: QuickAcessView.QuickAccessType) {
        interactor.didTouchQuickAccess(type: type)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = section == 0 ? reminders.count : records.count
        
        return count > 0 ? count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = indexPath.section == 0 ? reminders.count : records.count
        
        guard count > 0 else { return createEmptyState(for: indexPath) }
        
        if indexPath.section == 0 {
            let identifier = String(describing: ReminderTableViewCell.self)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ReminderTableViewCell else { return UITableViewCell()}
            
            cell.configure(reminder: reminders[indexPath.row])
            cell.backgroundColor = Asset.ColorAssets.background.color
            
            return cell
        }
        
        let identifier = String(describing: MedicalRecordTableViewCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MedicalRecordTableViewCell else { return UITableViewCell()}
        
        cell.configure(record: records[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = String(describing: HomeHeaderSectionView.self)
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? HomeHeaderSectionView else {
            return nil
        }
        
        let type: HomeHeaderSectionType = section == 0 ? .reminders : .records
        view.configure(type: type, delegate: self)
        
        return view
    }
}

extension HomeViewController: HomeHeaderSectionDelegate {
    func didTouchInButton(type: HomeHeaderSectionType) {
        switch type {
        case .records:
            interactor.didTouchQuickAccess(type: .history)
        case .reminders:
            interactor.didTouchQuickAccess(type: .reminders)
        }
    }
}
