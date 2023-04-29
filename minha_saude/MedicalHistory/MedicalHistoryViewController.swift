import Cartography
import UIKit

protocol MedicalHistoryDisplayLogic: AnyObject {
    func displayMedicalHistory(_ history: [MedicalRecord])
}

class MedicalHistoryViewController: UIViewController {
    
    struct Constants {
        static let estimatedRowHeight: CGFloat = 91
        static let filterSpacing: CGFloat = 16
    }
    
    private let interactor: MedicalHistoryInteractor
    private var records: [MedicalRecord] = []
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var filterView: FilterView = {
        FilterView(filterTitle: "Filtrar por:", filters: ["Todos"] + MedicalRecordType.allCases.map { $0.description })
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Asset.ColorAssets.background.color
        
        return tableView
    }()
    
    public init(interactor: MedicalHistoryInteractor) {
        self.interactor = interactor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        interactor.loadMedicalHistory(filterType: nil)
    }
    
    private func configure() {
        filterView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        let identifier = String(describing: MedicalRecordTableViewCell.self)
        tableView.register(MedicalRecordTableViewCell.self, forCellReuseIdentifier: identifier)
        
        setupBackButton()
        
        view.backgroundColor = Asset.ColorAssets.background.color

        view.addSubview(containerView)
        containerView.addSubview(tableView)
        containerView.addSubview(filterView)
        
        constrain(containerView, view) { container, view in
            container.edges == view.edges
        }
        
        constrain(containerView, filterView, tableView) { container, filter, table in
            filter.leading == container.leading + Constants.filterSpacing
            filter.top == container.safeAreaLayoutGuide.top
            filter.trailing == container.trailing - Constants.filterSpacing
            
            table.leading == container.leading
            table.top == filter.bottom + Constants.filterSpacing
            table.trailing == container.trailing
            table.bottom == container.bottom
        }
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = "Meu Histórico"
        backButton.tintColor = .black
        let rightBarButtonItem = UIBarButtonItem.init(
            image: UIImage(named: Asset.Assets.addButton.name),
            style: .done,
            target: self,
            action: #selector(addRecord)
        )
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @objc func addRecord() {
        //TODO: Passar essa logica para intercator -> router
        let recordViewController = MedicalRecordConfigurator().resolve(delegate: self, type: .new)

        if let sheet = recordViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.largestUndimmedDetentIdentifier = .medium
        }

        self.present(recordViewController, animated: true)
    }
}

extension MedicalHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: MedicalRecordTableViewCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MedicalRecordTableViewCell else { return UITableViewCell()}
        
        cell.configure(record: records[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Passar essa logica para intercator -> route
        let recordViewController = MedicalRecordConfigurator().resolve(delegate: self, type: .edit, record: records[indexPath.row])

        if let sheet = recordViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.largestUndimmedDetentIdentifier = .medium
        }

        self.present(recordViewController, animated: true)
    }
}

extension MedicalHistoryViewController: MedicalHistoryDisplayLogic {
    func displayMedicalHistory(_ history: [MedicalRecord]) {
        records = history
        tableView.reloadData()
    }
}

extension MedicalHistoryViewController: FilterViewDelegate {
    func didSelectedFilter(text: String) {
        var recordType: MedicalRecordType?
        
        if text != "Todos" {
            recordType = MedicalRecordType.withDescription(text: text)
        }
        
        interactor.loadMedicalHistory(filterType: recordType)
    }
}

extension MedicalHistoryViewController: MedicalRecordDisplayDelegate {
    func viewWillDismiss() {
        interactor.loadMedicalHistory(filterType: nil)
    }
}
