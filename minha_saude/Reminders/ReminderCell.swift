import Cartography
import UIKit

public final class ReminderTableViewCell: UITableViewCell {
    
    struct Constants {
        static let timeLabelSize: CGFloat = 32
        static let reminderNameLabelSize: CGFloat = 20
        static let repetitionLabelSize: CGFloat = 16
        static let minSpacing: CGFloat = 4
        static let defaultSpacing: CGFloat = 17
        static let middleSpacing: CGFloat = 20
        static let maxSpacing: CGFloat = 30
    }
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.timeLabelSize)
        label.textColor = Asset.ColorAssets.brandBlue.color
        label.textAlignment = .center
        return label
    }()
    
    private let reminderNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.reminderNameLabelSize)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let repetitionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.repetitionLabelSize)
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
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(reminderNameLabel)
        contentView.addSubview(repetitionLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        constrain(timeLabel, reminderNameLabel, repetitionLabel, contentView) { time, name, repetition, cell in
            time.leading == cell.leading + Constants.maxSpacing
            time.top == cell.top + Constants.middleSpacing
            time.bottom == cell.bottom - Constants.middleSpacing
            
            name.leading == time.trailing + Constants.defaultSpacing
            name.top == cell.top + Constants.defaultSpacing
            
            repetition.leading == time.trailing + Constants.defaultSpacing
            repetition.top == name.bottom - Constants.minSpacing
        }
    }
    
    func configure(reminder: Reminder) {
        timeLabel.text = reminder.time
        reminderNameLabel.text = reminder.name
        repetitionLabel.text = reminder.type.description
    }
}
