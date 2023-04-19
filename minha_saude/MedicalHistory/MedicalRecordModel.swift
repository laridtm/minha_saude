import Foundation

public struct MedicalRecord: Decodable {
    let id: String
    let date: Date
    let hospital: String
    let professional: String
    let name: String
    let observation: String
    let type: MedicalRecordType
    
    public init(
        id: String,
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

public enum MedicalRecordType: String, Decodable {
    case appointment
    case exam
    case vaccine
}

extension MedicalRecord {
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case hospital
        case professional
        case name
        case observation
        case type
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
