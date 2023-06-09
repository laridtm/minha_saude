import Cartography
import UIKit

public final class UserInfoView: UIView {
    
    struct Constants {
        static let roundedViewSize: CGFloat = 56
        static let borderSpacing: CGFloat = 28
        static let internalSpacing: CGFloat = 15
        static let titleSpacing: CGFloat = 4
        static let logoFontSize: CGFloat = 20
        static let nameFontSize: CGFloat = 16
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        imageView.image = Asset.Assets.defaultUserImage.image
        imageView.frame = CGRect(x: 0, y: 0, width: Constants.roundedViewSize, height: Constants.roundedViewSize)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        return imageView
    }()
    
    private let minhaSaudeLabel: UILabel = {
        let label = UILabel()
        label.text = "MINHA SAÚDE"
        label.font = UIFont.boldSystemFont(ofSize: Constants.logoFontSize)
        label.textColor = Asset.ColorAssets.brandBlue.color
        label.textAlignment = .center
        return label
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.nameFontSize)
        label.textColor = .black
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
        backgroundColor = Asset.ColorAssets.background.color
        
        addSubview(imageView)
        addSubview(minhaSaudeLabel)
        addSubview(fullNameLabel)
    }
    
    private func setupConstraints() {
        constrain(self, imageView, minhaSaudeLabel, fullNameLabel) { view, image, appName, userName in
            image.leading == view.leading + Constants.borderSpacing
            image.top == view.top
            
            image.width == Constants.roundedViewSize
            image.height == Constants.roundedViewSize
            
            appName.leading == image.trailing + Constants.internalSpacing
            appName.top == view.top
            
            userName.leading == image.trailing + Constants.internalSpacing
            userName.top == appName.bottom + Constants.titleSpacing
            
            view.height == Constants.roundedViewSize
        }
    }
    
    public func configure(info: UserInfo) {
        fullNameLabel.text = info.fullName
    }
}
