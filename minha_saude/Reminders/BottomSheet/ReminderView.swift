import Cartography
import UIKit

public final class ReminderView: UIView {
    
    struct Constants {
        static let reminderFontSize: CGFloat = 20
        static let cornerRadius: CGFloat = 6
        static let datePickerHeight: CGFloat = 120
        static let datePickerWidth: CGFloat = 375
    }
    
    private let reminderLabel: UILabel = {
        let label = UILabel()
        label.text = "Lembrete"
        label.font = UIFont.boldSystemFont(ofSize: Constants.reminderFontSize)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    private lazy var reminderNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nome do lembrete"
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
        button.addTarget(self, action: #selector(saveReminder), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Excluir", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(deleteReminder), for: .touchUpInside)
        return button
    }()
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
    
    public init() {
        super.init(frame: .zero)
        configureSubviews()
        setupConstraints()
    }
    
    @objc private func saveReminder() {
//        let reminder = Reminder(id: , name: reminderNameTextField.text, time: , type: )
//        interactor.saveProfile(userProfile: userProfile)
        print("Save reminder")
    }
    
    @objc private func deleteReminder() {
        print("Delete reminder")
    }
    
    private func configureSubviews() {
        backgroundColor = .white
        
        addSubview(reminderLabel)
        addSubview(datePicker)
        addSubview(reminderNameTextField)
        addSubview(saveButton)
        addSubview(deleteButton)
    }
    
    private func setupConstraints() {
        constrain(
            reminderLabel,
            datePicker,
            reminderNameTextField,
            saveButton,
            deleteButton,
            self
        ) { reminder, date, reminderName, save, delete, view in
            
            reminder.top == view.top + 45
            reminder.centerX == view.centerX
            
            date.top == reminder.bottom + 15
            date.leading == view.leading + 25
            date.trailing == view.trailing - 25
            date.height == Constants.datePickerHeight
            date.width == Constants.datePickerWidth
            
            reminderName.top == date.bottom + 20
            reminderName.leading == view.leading + 25
            reminderName.trailing == view.trailing - 25
            
            save.top == reminderName.bottom + 20
            save.leading == view.leading + 25
            save.trailing == view.trailing - 25
            
            delete.top == save.bottom + 10
            delete.centerX == view.centerX
        }
    }
    
//    public func configure(info: UserInfo) {
//        fullNameLabel.text = info.fullName
//    }
}
