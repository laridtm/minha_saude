import Cartography
import UIKit

class MedicalHistoryViewController: UIViewController {
    
    struct Constants {
        static let estimatedRowHeight: CGFloat = 91
    }
    
    private var records: [MedicalRecord] = [
        .init(
            id: "6435fd7aa0683320460d5dbc",
            date: "21/02/23",
            hospital: "Clinica dos olhos",
            professional: "Dr. João",
            name: "Clínico Geral",
            observation: "Consulta oftalmologista",
            type: .appointment
        ),
        .init(
            id: "6435fd7aa0683320460d5dbc",
            date: "21/02/23",
            hospital: "Clinica dos olhos",
            professional: "Dr. João",
            name: "Clínico Geral",
            observation: "Consulta oftalmologista",
            type: .exam
        ),
        .init(
            id: "6435fd7aa0683320460d5dbc",
            date: "21/02/23",
            hospital: "Clinica dos olhos",
            professional: "Dr. João",
            name: "Clínico Geral",
            observation: "Consulta oftalmologista",
            type: .vaccine
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
        let identifier = String(describing: MedicalRecordTableViewCell.self)
        tableView.register(MedicalRecordTableViewCell.self, forCellReuseIdentifier: identifier)
        
        setupBackButton()
        
        view.backgroundColor = Asset.ColorAssets.background.color
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
