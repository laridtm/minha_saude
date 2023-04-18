public struct Reminder: Decodable {
    let id: String
    let name: String
    let time: String
    let repetition: ReminderRepetition
    
    public init(
        id: String,
        name: String,
        time: String,
        repetition: ReminderRepetition
    ) {
        self.id = id
        self.name = name
        self.time = time
        self.repetition = repetition
    }
}

public enum ReminderRepetition: Decodable {
    case everyDay
    case once
    case mondayToFriday
    case weekends
}
