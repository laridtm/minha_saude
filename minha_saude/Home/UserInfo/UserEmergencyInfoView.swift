import Cartography
import UIKit

public final class UserEmergencyInfoView: UIView {
    
    struct Constants {
        static let borderSize: CGFloat = 10
        static let borderWidth: CGFloat = 1
        static let labelSpacing: CGFloat = 8
        static let valueSpacing: CGFloat = 5
        static let fontSize: CGFloat = 14
    }
    
    private let bloodTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Tipo sanguíneo:"
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        label.textColor = Asset.ColorAssets.brandGreen.color
        label.textAlignment = .center
        return label
    }()
    
    private let bloodTypeValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.textColor = Asset.ColorAssets.brandGreen.color
        label.textAlignment = .center
        return label
    }()
    
    private let allergiesLabel: UILabel = {
        let label = UILabel()
        label.text = "Alergias:"
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        label.textColor = Asset.ColorAssets.brandGreen.color
        label.textAlignment = .center
        return label
    }()
    
    private let allergiesValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.textColor = Asset.ColorAssets.brandGreen.color
        label.textAlignment = .center
        return label
    }()
    
    private let emergencyPhoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Contato de emergência:"
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        label.textColor = Asset.ColorAssets.brandGreen.color
        label.textAlignment = .center
        return label
    }()
    
    private let emergencyPhoneValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.textColor = Asset.ColorAssets.brandGreen.color
        label.textAlignment = .center
        return label
    }()
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
    
    public init() {
        super.init(frame: .zero)
        configureSubviews()
        setupConstraints()
    }
    
    private func configureSubviews() {
        backgroundColor = Asset.ColorAssets.lightGreen.color
        layer.borderColor = Asset.ColorAssets.brandGreen.color.cgColor
        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = Constants.borderSize
        
        addSubview(bloodTypeLabel)
        addSubview(bloodTypeValueLabel)
        addSubview(allergiesLabel)
        addSubview(allergiesValueLabel)
        addSubview(emergencyPhoneLabel)
        addSubview(emergencyPhoneValueLabel)
    }
    
    private func setupConstraints() {
        constrain(
            self,
            bloodTypeLabel,
            bloodTypeValueLabel,
            allergiesLabel,
            allergiesValueLabel,
            emergencyPhoneLabel,
            emergencyPhoneValueLabel
        ) { view, blood, bloodValue, allergies, allergiesValue, emergency, emergencyValue in
            blood.top == view.top + Constants.borderSize
            blood.leading == view.leading + Constants.borderSize
            bloodValue.top == view.top + Constants.borderSize
            bloodValue.leading == blood.trailing + Constants.valueSpacing
            
            allergies.top == blood.bottom + Constants.labelSpacing
            allergies.leading == view.leading + Constants.borderSize
            allergiesValue.top == blood.bottom + Constants.labelSpacing
            allergiesValue.leading == allergies.trailing + Constants.valueSpacing
            
            emergency.top == allergies.bottom + Constants.labelSpacing
            emergency.leading == view.leading + Constants.borderSize
            emergency.bottom == view.bottom - Constants.borderSize
            emergencyValue.top == allergies.bottom + Constants.labelSpacing
            emergencyValue.leading == emergency.trailing + Constants.valueSpacing
        }
    }
    
    public func configure(info: UserInfo) {
        bloodTypeValueLabel.text = info.bloodType
        allergiesValueLabel.text = info.allergies
        emergencyPhoneValueLabel.text = info.emergencyPhone
    }
}
