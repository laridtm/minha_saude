public struct UserInfo {
    let fullName: String
    let bloodType: String
    let alergies: String
    let emergencyContact: String
    
    public init(
        fullName: String,
        bloodType: String,
        alergies: String,
        emergencyContact: String
    ) {
        self.fullName = fullName
        self.bloodType = bloodType
        self.alergies = alergies
        self.emergencyContact = emergencyContact
    }
}
