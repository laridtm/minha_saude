import Cartography
import UIKit

class ProfileViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 6
        static let spacing: CGFloat = 20
        static let largeSpacing: CGFloat = 28
    }
    
    private let interactor: ProfileInteractorBusinessLogic
    private let segments = ["Masculino", "Feminino"]
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 28
        return stackView
    }()
    
    private lazy var fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nome completo"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private lazy var genderSegmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: segments)
        segmented.selectedSegmentIndex = 0
        segmented.selectedSegmentTintColor = Asset.ColorAssets.brandGreen.color
    
        return segmented
    }()
    
    private lazy var cpfTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "CPF"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
    
        return textField
    }()
    
    private lazy var birthDateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Data de nascimento"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private lazy var telephoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Número de telefone"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private lazy var addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Endereço"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private lazy var maritalStatusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Estado Civil"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private lazy var bloodTypeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Tipo sanguíneo"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private lazy var emergencyContactTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Contato de emergência"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.contentVerticalAlignment = .center
        
        return textField
    }()
    
    private lazy var alergiesTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Alergias"
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
        button.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
        return button
    }()
    
    public init(interactor: ProfileInteractorBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Asset.ColorAssets.background.color
        setupConstraints()
        setupBackButton()
    }

    @objc private func saveProfile() {
        let userProfile = UserProfile(
            fullName: fullNameTextField.text ?? "",
            gender: segments[genderSegmentedControl.selectedSegmentIndex],
            birthDate: birthDateTextField.text ?? "",
            cpf: cpfTextField.text ?? "",
            telephone: telephoneTextField.text ?? "",
            address: addressTextField.text ?? "",
            maritalStatus: maritalStatusTextField.text ?? "",
            bloodType: bloodTypeTextField.text ?? "",
            emergencyContact: emergencyContactTextField.text ?? "",
            alergies: alergiesTextField.text ?? ""
        )
        interactor.saveProfile(userProfile: userProfile)
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = "Informações Pessoais"
        backButton.tintColor = .black
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func setupConstraints() {
        stackView.addArrangedSubview(fullNameTextField)
        stackView.addArrangedSubview(genderSegmentedControl)
        stackView.addArrangedSubview(birthDateTextField)
        stackView.addArrangedSubview(cpfTextField)
        stackView.addArrangedSubview(telephoneTextField)
        stackView.addArrangedSubview(addressTextField)
        stackView.addArrangedSubview(maritalStatusTextField)
        stackView.addArrangedSubview(bloodTypeTextField)
        stackView.addArrangedSubview(emergencyContactTextField)
        stackView.addArrangedSubview(alergiesTextField)
        
        view.addSubview(stackView)
        view.addSubview(saveButton)
            
        constrain(stackView, saveButton, view) { stack, button, view in
            stack.top == view.safeAreaLayoutGuide.top + Constants.largeSpacing
            stack.leading == view.leading + Constants.spacing
            stack.trailing == view.trailing - Constants.spacing
            
            button.leading == view.leading + Constants.spacing
            button.trailing == view.trailing - Constants.spacing
            button.top == stack.bottom + Constants.largeSpacing
        }
    }
}
