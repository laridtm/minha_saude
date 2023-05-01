import Cartography
import UIKit

public protocol HomeHeaderSectionDelegate: AnyObject {
    func didTouchInButton(type: HomeHeaderSectionType)
}

public enum HomeHeaderSectionType: String {
    case reminders = "Meus Lembretes"
    case records = "Meu Histórico"
}

public class HomeHeaderSectionView: UITableViewHeaderFooterView {
    struct Constants {
        static let labelFontSize: CGFloat = 14
        static let buttonFontSize: CGFloat = 12
        static let viewHeight: CGFloat = 28
        static let spacing: CGFloat = 16
    }
    
    private var type: HomeHeaderSectionType?
    private weak var delegate: HomeHeaderSectionDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.labelFontSize)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ver mais", for: .normal)
        button.setTitleColor(Asset.ColorAssets.brandBlue.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(didTouchInButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
    
    private func configureContents() {
        contentView.backgroundColor = Asset.ColorAssets.background.color
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(seeMoreButton)
        
        constrain(titleLabel, seeMoreButton, contentView) { title, button, view in
            view.height == Constants.viewHeight
            view.width == UIScreen.main.bounds.width
            title.centerY == view.centerY
            title.leading == view.leading + Constants.spacing
            
            button.centerY == view.centerY
            button.trailing == view.trailing - Constants.spacing
        }
    }
    
    public func configure(type: HomeHeaderSectionType, delegate: HomeHeaderSectionDelegate) {
        titleLabel.text = type.rawValue
        self.type = type
        self.delegate = delegate
    }
    
    @objc private func didTouchInButton() {
        guard let sectionType = type else { return }
        delegate?.didTouchInButton(type: sectionType)
    }
}
