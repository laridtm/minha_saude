public struct MedicalRecord: Decodable {
    let id: String
    let date: String
    let hospital: String
    let professional: String
    let observation: String
    let type: MedicalRecordType
    
    public init(
        id: String,
        date: String,
        hospital: String,
        professional: String,
        observation: String,
        type: MedicalRecordType
    ) {
        self.id = id
        self.date = date
        self.hospital = hospital
        self.professional = professional
        self.observation = observation
        self.type = type
    }
}

public enum MedicalRecordType: Decodable {
    case appointment
    case exam
    case vaccine
}
