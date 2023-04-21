public struct Reminder: Decodable {
    let id: String
    let name: String
    let time: String
    let type: ReminderType
    
    public init(
        id: String,
        name: String,
        time: String,
        type: ReminderType
    ) {
        self.id = id
        self.name = name
        self.time = time
        self.type = type
    }
}

public enum ReminderType: String, Decodable {
    case everyDay
    case once
    case mondayToFriday
    case weekends
}
