import Cartography
import UIKit

public final class FilterCollectionViewCell: UICollectionViewCell {
    
    struct Constants {
        static let filterFontSize: CGFloat = 12
        static let cornerRadius: CGFloat = 4
        static let borderWidth: CGFloat = 1
        static let labelSpacing: CGFloat = 2
    }
    
    public override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected ? Asset.ColorAssets.brandGreen.color.cgColor : Asset.ColorAssets.lightGray.color.cgColor
            filterLabel.textColor = isSelected ? Asset.ColorAssets.brandGreen.color : Asset.ColorAssets.lightGray.color
            backgroundColor = isSelected ? Asset.ColorAssets.lightGreen.color : .white
        }
    }
    
    private lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = Asset.ColorAssets.lightGray.color
        label.font = UIFont.systemFont(ofSize: Constants.filterFontSize)
        return label
    }()
    
    private lazy var containerView : UIView = {
        let view = UIView()
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func configure() {
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Asset.ColorAssets.lightGray.color.cgColor
        
        backgroundColor = .white
        
        contentView.addSubview(containerView)
        containerView.addSubview(filterLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        constrain(contentView, containerView, filterLabel) { cell, container, label in
            container.centerY == cell.centerY
            container.leading == cell.leading
            container.trailing == cell.trailing
            
            label.leading == container.leading + Constants.labelSpacing
            label.trailing == container.trailing - Constants.labelSpacing
            label.top == container.top + Constants.labelSpacing
            label.bottom == container.bottom - Constants.labelSpacing
        }
    }
    
    func configure(text: String) {
        filterLabel.text = text
        
        filterLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        filterLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}
