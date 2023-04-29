public struct Reminder: Decodable {
    let id: String?
    let name: String
    let time: String
    let type: ReminderType
    
    public init(
        id: String? = nil,
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

public enum ReminderType: String, Decodable, CaseIterable {
    case everyDay
    case once
    case mondayToFriday
    case weekends
}

extension ReminderType {
    var description: String {
        switch self {
        case .everyDay:
            return "Todos os dias"
        case .once:
            return "Uma vez"
        case .mondayToFriday:
            return "Seg. à sexta"
        case .weekends:
            return "Finais de semana"
        }
    }
    
    static func withDescription(text: String) -> ReminderType {
        return self.allCases.first { $0.description == text } ?? .everyDay
    }
}

extension Reminder: Encodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case time
        case type
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let reminderId = id {
            try container.encode(reminderId, forKey: .id)
        }
        try container.encode(name, forKey: .name)
        try container.encode(time, forKey: .time)
        try container.encode(type.rawValue, forKey: .type)
    }
}
