import Cartography
import UIKit

public protocol MedicalRecordViewDelegate: AnyObject {
    func didTouchInSave(
        date: String,
        time: String,
        hospital: String,
        profesional: String,
        speciallity: String,
        observation: String,
        type: MedicalRecordType
    )
    func didTouchInRemove()
}

public final class MedicalRecordView: UIView {
    
    struct Constants {
        static let recordFontSize: CGFloat = 20
        static let cornerRadius: CGFloat = 6
        static let minSpacing: CGFloat = 10
        static let middleSpacing: CGFloat = 12
        static let defaultSpacing: CGFloat = 16
        static let dateSpacing: CGFloat = 5
        static let observationHeight: CGFloat = 50
    }
    
    private var selectedRecordType: MedicalRecordType = .appointment {
        didSet {
            speciallityTextField.placeholder = selectedRecordType.placeholder
        }
    }
    public weak var delegate: MedicalRecordViewDelegate?
    
    private let recordLabel: UILabel = {
        let label = UILabel()
        label.text = "Registro"
        label.font = UIFont.boldSystemFont(ofSize: Constants.recordFontSize)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var filters: FilterView = {
        FilterView(filterTitle: "Compromisso:", filters: MedicalRecordType.allCases.map { $0.description })
    }()
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Data"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private lazy var timeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Horário"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private lazy var placeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Clínica/Hospital"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private lazy var professionalNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nome do profissional"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private lazy var speciallityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Especialidade médica"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private lazy var observationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Observação"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Salvar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Asset.ColorAssets.brandGreen.color
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self, action: #selector(saveRecord), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Excluir", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(deleteRecord), for: .touchUpInside)
        return button
    }()
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
    
    public init() {
        super.init(frame: .zero)
        configureSubviews()
        setupConstraints()
    }
    
    @objc private func saveRecord() {
        delegate?.didTouchInSave(
            date: dateTextField.text ?? "",
            time: timeTextField.text ?? "",
            hospital: placeTextField.text ?? "",
            profesional: professionalNameTextField.text ?? "",
            speciallity: speciallityTextField.text ?? "",
            observation: observationTextField.text ?? "",
            type: selectedRecordType
        )
    }
    
    @objc private func deleteRecord() {
        delegate?.didTouchInRemove()
    }
    
    private func configureSubviews() {
        backgroundColor = .white
        filters.delegate = self
        
        addSubview(recordLabel)
        addSubview(filters)
        addSubview(dateTextField)
        addSubview(timeTextField)
        addSubview(placeTextField)
        addSubview(professionalNameTextField)
        addSubview(speciallityTextField)
        addSubview(observationTextField)
        addSubview(saveButton)
        addSubview(deleteButton)
    }
    
    private func setupConstraints() {
        
        constrain(self, recordLabel, filters) { view, record, filters in
            record.top == view.top + Constants.defaultSpacing
            record.centerX == view.centerX
            
            filters.top == record.bottom + Constants.middleSpacing
            filters.leading == view.leading + Constants.defaultSpacing
            filters.trailing == view.trailing - Constants.defaultSpacing
        }
        
        constrain(
            self,
            dateTextField,
            timeTextField,
            placeTextField,
            professionalNameTextField,
            speciallityTextField,
            observationTextField,
            filters
        ) { view, date, time, place, professional, speciallity, obs, filters in
            date.top == filters.bottom + Constants.middleSpacing
            date.leading == view.leading + Constants.defaultSpacing
            date.trailing == view.centerX - Constants.dateSpacing
            
            time.top == filters.bottom + Constants.middleSpacing
            time.leading == view.centerX + Constants.dateSpacing
            time.trailing == view.trailing - Constants.defaultSpacing
            
            place.top == date.bottom + Constants.middleSpacing
            place.leading == view.leading + Constants.defaultSpacing
            place.trailing == view.trailing - Constants.defaultSpacing
            
            professional.top == place.bottom + Constants.middleSpacing
            professional.leading == view.leading + Constants.defaultSpacing
            professional.trailing == view.trailing - Constants.defaultSpacing
            
            speciallity.top == professional.bottom + Constants.middleSpacing
            speciallity.leading == view.leading + Constants.defaultSpacing
            speciallity.trailing == view.trailing - Constants.defaultSpacing
            
            obs.top == speciallity.bottom + Constants.middleSpacing
            obs.leading == view.leading + Constants.defaultSpacing
            obs.trailing == view.trailing - Constants.defaultSpacing
            obs.height == Constants.observationHeight
        }
        
        constrain(self, saveButton, deleteButton, observationTextField) { view, save, delete, obs in
            save.top == obs.bottom + Constants.middleSpacing
            save.leading == view.leading + Constants.defaultSpacing
            save.trailing == view.trailing - Constants.defaultSpacing
            
            delete.top == save.bottom + Constants.minSpacing
            delete.centerX == view.centerX
        }
    }
    
    public func configure(type: MedicalRecordViewControllerType, record: MedicalRecord?){
        deleteButton.isHidden = type == .new
        guard let rec = record, type != .new else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        dateTextField.text = dateFormatter.string(from: rec.date)
        
        dateFormatter.dateFormat = "HH:mm"
        timeTextField.text = dateFormatter.string(from: rec.date)
        
        selectedRecordType = rec.type
        placeTextField.text = rec.hospital
        professionalNameTextField.text = rec.professional
        speciallityTextField.text = rec.name
        observationTextField.text = rec.observation
        filters.selectFilter(filter: rec.type.description)
    }
}

extension MedicalRecordView: FilterViewDelegate {
    public func didSelectedFilter(text: String) {
        selectedRecordType = MedicalRecordType.withDescription(text: text)
    }
}

extension MedicalRecordType {
    var placeholder: String {
        switch self {
        case .appointment:
            return "Especialidade médica"
        case .exam:
            return "Nome do exame"
        case .vaccine:
            return "Nome da vacina"
        }
    }
}
