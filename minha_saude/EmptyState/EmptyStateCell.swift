import Cartography
import UIKit


public final class EmptyStateCell: UITableViewCell {
    struct Constants {
        static let emptyStateFontSize: CGFloat = 14
        static let spacing: CGFloat = 20
        static let imageSize = CGSize(width: 100.0, height: 100.0)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.emptyStateFontSize)
        label.textColor = Asset.ColorAssets.brandBlue.color
        label.textAlignment = .center
        return label
    }()
    
    private let emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.backgroundColor = .clear
        imageView.image = Asset.Assets.emptyState.image.resized(to: Constants.imageSize)
        return imageView
    }()
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
    }
    
    private func configureSubviews() {
        backgroundColor = .clear
        
        contentView.addSubview(emptyStateImageView)
        contentView.addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        constrain(contentView, emptyStateImageView, titleLabel) { view, image, title in
            image.top == view.top + Constants.spacing
            image.centerX == view.centerX
            
            title.top == image.bottom + Constants.spacing
            title.centerX == view.centerX
            title.bottom == view.bottom - Constants.spacing
        }
    }
    
    public func configure(emptyStateTitle: String) {
        titleLabel.text = emptyStateTitle
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
