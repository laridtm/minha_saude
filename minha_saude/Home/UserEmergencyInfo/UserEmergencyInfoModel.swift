public struct UserEmergencyInfo {
    let bloodType: String
    let alergies: String
    let emergencyContact: String
    
    public init(
        bloodType: String,
        alergies: String,
        emergencyContact: String
    ) {
        self.bloodType = bloodType
        self.alergies = alergies
        self.emergencyContact = emergencyContact
    }
}
