public struct UserProfile: Decodable {
    let fullName: String
    let gender: String
    let birthDate: String
    let cpf: String
    let phoneNumber: String
    let address: String
    let maritalStatus: String
    let bloodType: String
    let emergencyPhone: String
    let allergies: String
    
    init(
        fullName: String,
        gender: String,
        birthDate: String,
        cpf: String,
        phoneNumber: String,
        address: String,
        maritalStatus: String,
        bloodType: String,
        emergencyPhone: String,
        allergies: String
    ) {
        self.fullName = fullName
        self.gender = gender
        self.birthDate = birthDate
        self.cpf = cpf
        self.phoneNumber = phoneNumber
        self.address = address
        self.maritalStatus = maritalStatus
        self.bloodType = bloodType
        self.emergencyPhone = emergencyPhone
        self.allergies = allergies
    }
}

extension UserProfile: Encodable {
    enum CodingKeys: String, CodingKey {
        case fullName
        case gender
        case birthDate
        case cpf
        case phoneNumber
        case address
        case maritalStatus
        case bloodType
        case emergencyPhone
        case allergies
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fullName, forKey: .fullName)
        try container.encode(gender, forKey: .gender)
        try container.encode(birthDate, forKey: .birthDate)
        try container.encode(cpf, forKey: .cpf)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(address, forKey: .address)
        try container.encode(maritalStatus, forKey: .maritalStatus)
        try container.encode(bloodType, forKey: .bloodType)
        try container.encode(emergencyPhone, forKey: .emergencyPhone)
        try container.encode(allergies, forKey: .allergies)
    }
}
