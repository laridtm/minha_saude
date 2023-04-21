import Cartography
import UIKit

public final class ReminderTableViewCell: UITableViewCell {
    
    struct Constants {
        static let timeLabelSize: CGFloat = 32
        static let reminderNameLabelSize: CGFloat = 20
        static let repetitionLabelSize: CGFloat = 16
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
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(reminderNameLabel)
        contentView.addSubview(repetitionLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        constrain(timeLabel, reminderNameLabel, repetitionLabel, contentView) { time, name, repetition, cell in
            time.leading == cell.leading + 30
            time.top == cell.top + 20
            time.bottom == cell.bottom - 20
            
            name.leading == time.trailing + 17
            name.top == cell.top + 17
            
            repetition.leading == time.trailing + 17
            repetition.top == name.bottom - 4
        }
    }
    
    func configure(reminder: Reminder) {
        timeLabel.text = reminder.time
        reminderNameLabel.text = reminder.name
        repetitionLabel.text = reminder.type.repetitionTitle
    }
}

extension ReminderType {
    var repetitionTitle: String {
        switch self {
        case .everyDay:
            return "Todos os dias"
        case .once:
            return "Uma vez"
        case .mondayToFriday:
            return "Segunda à sexta"
        case .weekends:
            return "Finais de semana"
        }
    }
}
