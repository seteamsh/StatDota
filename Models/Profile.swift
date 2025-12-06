import Foundation

struct Profile: Decodable {
    let accountId: Int
    let personaname: String
    let avatar, avatarmedium, avatarfull: String
    let profileurl: String
    let lastLogin: String
    
    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case personaname
        case avatar, avatarmedium, avatarfull
        case profileurl
        case lastLogin = "last_login"
    }
}
struct APIErrorResponse: Decodable {
    let error: String
}
struct Employee: Decodable {
    let profile: Profile
}
