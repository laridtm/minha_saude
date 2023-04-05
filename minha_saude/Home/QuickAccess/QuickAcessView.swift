import Cartography
import UIKit

public final class QuickAcessView: UIView {
//    weak public var delegate: QuickAddCatalogItemViewDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 10
        imageView.accessibilityIgnoresInvertColors = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
//        label.font = .subtitle1Medium
//        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .blue
        label.textColor = .black
        label.textAlignment = .center
//        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
    
    public init(quickAccessTitle: String, quickAccessImage: UIImage) {
        super.init(frame: .zero)
        
        backgroundColor = .green
        
        configure(quickAccessTitle: quickAccessTitle, quickAccessImage: quickAccessImage)
        setupConstraints()
    }
    
    private func configure(quickAccessTitle: String, quickAccessImage: UIImage) {
        addSubview(imageView)
        addSubview(titleLabel)
        titleLabel.text = quickAccessTitle
        imageView.image = quickAccessImage
    }
    
    private func setupConstraints() {
        constrain(imageView, titleLabel, self) { image, title, view in
            view.width == title.width
            view.height == 82
            
            image.centerX == view.centerX
            image.top == view.top + 10
            title.centerX == image.centerX
            title.top == image.bottom + 10
        }
    }
}
