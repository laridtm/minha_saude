public struct UserInfo: Decodable {
    let fullName: String
    let bloodType: String
    let allergies: String
    let emergencyPhone: String
    
    public init(
        fullName: String,
        bloodType: String,
        allergies: String,
        emergencyPhone: String
    ) {
        self.fullName = fullName
        self.bloodType = bloodType
        self.allergies = allergies
        self.emergencyPhone = emergencyPhone
    }
}
