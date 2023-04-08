import Cartography
import UIKit

public final class QuickAcessView: UIView {
    
    struct Constants {
        static let roundedViewSize: CGFloat = 56
        static let imageViewSize: CGFloat = 36
        static let quickAccessViewHeight: CGFloat = 82
    }
    
//    weak public var delegate: QuickAddCatalogItemViewDelegate?
    
    private let roundedView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .gray
        view.frame = CGRect(x: 0, y: 0, width: Constants.roundedViewSize, height: Constants.roundedViewSize)
        view.layer.cornerRadius = view.frame.size.width / 2
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.textColor = .black
        label.textAlignment = .center
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
        addSubview(roundedView)
        roundedView.addSubview(imageView)
        addSubview(titleLabel)
        titleLabel.text = quickAccessTitle
        imageView.image = quickAccessImage
    }
    
    private func setupConstraints() {
        let labelWidth = titleLabel.intrinsicContentSize.width
        let viewWidth = labelWidth > Constants.roundedViewSize ? labelWidth : Constants.roundedViewSize
        
        constrain(roundedView, titleLabel, self) { image, title, view in
            view.width == viewWidth
            view.height == Constants.quickAccessViewHeight
   
            title.centerX == view.centerX
            title.bottom == view.bottom
        }
        
        constrain(imageView, roundedView, self) { image, container, view in
            image.centerX == container.centerX
            image.centerY == container.centerY
            image.width == Constants.imageViewSize
            image.height == Constants.imageViewSize
            
            container.centerX == view.centerX
            container.top == view.top
            container.width == Constants.roundedViewSize
            container.height == Constants.roundedViewSize
        }
    }
}
