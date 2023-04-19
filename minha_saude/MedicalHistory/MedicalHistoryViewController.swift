import Cartography
import UIKit

protocol MedicalHistoryDisplayLogic: AnyObject {
    func displayMedicalHistory(_ history: [MedicalRecord])
}

class MedicalHistoryViewController: UIViewController {
    
    struct Constants {
        static let estimatedRowHeight: CGFloat = 91
    }
    
    private let interactor: MedicalHistoryInteractor
    private var records: [MedicalRecord] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
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
        interactor.viewDidLoad()
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        let identifier = String(describing: MedicalRecordTableViewCell.self)
        tableView.register(MedicalRecordTableViewCell.self, forCellReuseIdentifier: identifier)
        
        setupBackButton()

        view.addSubview(tableView)
        
        constrain(tableView, view) { tableView, view in
            tableView.edges == view.edges
        }
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = "Meu Histórico"
        backButton.tintColor = .black
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
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
}

extension MedicalHistoryViewController: MedicalHistoryDisplayLogic {
    func displayMedicalHistory(_ history: [MedicalRecord]) {
        records = history
        tableView.reloadData()
    }
}
