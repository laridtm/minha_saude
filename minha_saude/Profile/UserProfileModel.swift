struct UserProfile {
    private let fullName: String
    private let gender: String
    private let birthDate: String
    private let cpf: String
    private let telephone: String
    private let address: String
    private let maritalStatus: String
    private let bloodType: String
    private let emergencyPhone: String
    private let allergies: String
    
    init(
        fullName: String,
        gender: String,
        birthDate: String,
        cpf: String,
        telephone: String,
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
        self.telephone = telephone
        self.address = address
        self.maritalStatus = maritalStatus
        self.bloodType = bloodType
        self.emergencyPhone = emergencyPhone
        self.allergies = allergies
    }
}
