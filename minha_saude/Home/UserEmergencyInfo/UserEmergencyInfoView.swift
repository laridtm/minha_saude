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
    
    private let alergiesLabel: UILabel = {
        let label = UILabel()
        label.text = "Alergias:"
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        label.textColor = Asset.ColorAssets.brandGreen.color
        label.textAlignment = .center
        return label
    }()
    
    private let alergiesValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.textColor = Asset.ColorAssets.brandGreen.color
        label.textAlignment = .center
        return label
    }()
    
    private let emergencyContactLabel: UILabel = {
        let label = UILabel()
        label.text = "Contato de emergência:"
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        label.textColor = Asset.ColorAssets.brandGreen.color
        label.textAlignment = .center
        return label
    }()
    
    private let emergencyContactValueLabel: UILabel = {
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
        configure()
        setupConstraints()
    }
    
    private func configure() {
        backgroundColor = Asset.ColorAssets.lightGreen.color
        layer.borderColor = Asset.ColorAssets.brandGreen.color.cgColor
        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = Constants.borderSize
        
        addSubview(bloodTypeLabel)
        addSubview(bloodTypeValueLabel)
        addSubview(alergiesLabel)
        addSubview(alergiesValueLabel)
        addSubview(emergencyContactLabel)
        addSubview(emergencyContactValueLabel)
    }
    
    private func setupConstraints() {
        constrain(
            self,
            bloodTypeLabel,
            bloodTypeValueLabel,
            alergiesLabel,
            alergiesValueLabel,
            emergencyContactLabel,
            emergencyContactValueLabel
        ) { view, blood, bloodValue, alergies, alergiesValue, emergency, emergencyValue in
            blood.top == view.top + Constants.borderSize
            blood.leading == view.leading + Constants.borderSize
            bloodValue.top == view.top + Constants.borderSize
            bloodValue.leading == blood.trailing + Constants.valueSpacing
            
            alergies.top == blood.bottom + Constants.labelSpacing
            alergies.leading == view.leading + Constants.borderSize
            alergiesValue.top == blood.bottom + Constants.labelSpacing
            alergiesValue.leading == alergies.trailing + Constants.valueSpacing
            
            emergency.top == alergies.bottom + Constants.labelSpacing
            emergency.leading == view.leading + Constants.borderSize
            emergency.bottom == view.bottom - Constants.borderSize
            emergencyValue.top == alergies.bottom + Constants.labelSpacing
            emergencyValue.leading == emergency.trailing + Constants.valueSpacing
        }
    }
    
    public func configure(emergencyInfo: UserEmergencyInfo) {
        bloodTypeValueLabel.text = emergencyInfo.bloodType
        alergiesValueLabel.text = emergencyInfo.alergies
        emergencyContactValueLabel.text = emergencyInfo.emergencyContact
    }
}
