import Foundation

public struct MedicalRecord: Decodable {
    let id: String?
    let date: Date
    let hospital: String
    let professional: String
    let name: String
    let observation: String
    let type: MedicalRecordType
    
    public init(
        id: String? = nil,
        date: Date,
        hospital: String,
        professional: String,
        name: String,
        observation: String,
        type: MedicalRecordType
    ) {
        self.id = id
        self.date = date
        self.hospital = hospital
        self.professional = professional
        self.name = name
        self.observation = observation
        self.type = type
    }
}

public enum MedicalRecordType: String, Decodable, CaseIterable {
    case appointment
    case exam
    case vaccine
}

extension MedicalRecordType {
    var description: String {
        switch self {
        case .appointment:
            return "Consulta"
        case .exam:
            return "Exame"
        case .vaccine:
            return "Vacina"
        }
    }
    
    static func withDescription(text: String) -> MedicalRecordType {
        return self.allCases.first { $0.description == text } ?? .appointment
    }
}


extension MedicalRecord: Encodable {
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case hospital
        case professional
        case name
        case observation
        case type
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let recordId = id {
            try container.encode(recordId, forKey: .id)
        }
        
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        try container.encode(iso8601DateFormatter.string(from: date), forKey: .date)
        try container.encode(hospital, forKey: .hospital)
        try container.encode(professional, forKey: .professional)
        try container.encode(name, forKey: .name)
        try container.encode(observation, forKey: .observation)
        try container.encode(type.rawValue, forKey: .type)
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            id = try values.decode(String.self, forKey: .id)
            
            let dateString = try values.decode(String.self, forKey: .date)
            guard let dateObject = ISO8601DateFormatter().date(from: dateString) else {
                throw NSError(domain: "error to parse date \(dateString)", code: 0)
            }
            
            date = dateObject
            hospital = try values.decode(String.self, forKey: .hospital)
            professional = try values.decode(String.self, forKey: .professional)
            name = try values.decode(String.self, forKey: .name)
            observation = try values.decode(String.self, forKey: .observation)
            type = try values.decode(MedicalRecordType.self, forKey: .type)
            
        } catch let error{
            throw error
        }
    }
}
