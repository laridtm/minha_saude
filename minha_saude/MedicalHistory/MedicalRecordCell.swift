import Cartography
import UIKit

public final class MedicalRecordTableViewCell: UITableViewCell {
    
    struct Constants {
        static let roundedViewSize: CGFloat = 56
        static let imageViewSize: CGFloat = 36
        static let titleSize: CGFloat = 20
        static let subtitleSize: CGFloat = 16
        static let cellSpacing: CGFloat = 16
        static let infoSpacing: CGFloat = 10
        static let imageSpacing: CGFloat = 8
    }
    
    private let roundedView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = Asset.ColorAssets.lightGray.color
        view.frame = CGRect(x: 0, y: 0, width: Constants.roundedViewSize, height: Constants.roundedViewSize)
        view.layer.cornerRadius = view.frame.size.width / 2
        return view
    }()
    
    private let typeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.titleSize)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.subtitleSize)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    private func configure() {
        backgroundColor = Asset.ColorAssets.background.color
        
        contentView.addSubview(roundedView)
        contentView.addSubview(typeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        constrain(typeImageView, roundedView, contentView, titleLabel, subtitleLabel) { image, container, cell, title, subtitle in
            image.centerX == container.centerX
            image.centerY == container.centerY
            image.width == Constants.imageViewSize
            image.height == Constants.imageViewSize
            
            container.top == cell.top + Constants.cellSpacing
            container.bottom == cell.bottom - Constants.cellSpacing
            container.leading == cell.leading + Constants.cellSpacing
            container.width == Constants.roundedViewSize
            container.height == Constants.roundedViewSize
            
            title.leading == container.trailing + Constants.imageSpacing
            title.trailing == cell.trailing - Constants.cellSpacing
            title.top == cell.top + Constants.cellSpacing
            
            subtitle.leading == container.trailing + Constants.imageSpacing
            subtitle.trailing == cell.trailing - Constants.cellSpacing
            subtitle.top == title.bottom + Constants.infoSpacing
        }
    }
    
    func configure(record: MedicalRecord) {
        typeImageView.image = record.type.image
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy - HH:mm"
        let date = dateFormatter.string(from: record.date)
        
        titleLabel.text = "\(date) \(record.name)"
        subtitleLabel.text = "\(record.professional) - \(record.hospital)"
    }
}

extension MedicalRecordType {
    var image: UIImage {
        switch self {
        case .appointment:
            return Asset.Assets.appointment.image
        case .exam:
            return Asset.Assets.exam.image
        case .vaccine:
            return Asset.Assets.vaccine.image
        }
    }
}
