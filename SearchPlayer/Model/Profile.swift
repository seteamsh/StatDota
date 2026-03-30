import Foundation

// MARK: - Wrapper
struct Wrapper: Decodable {
    let profile: Profile
}

// MARK: - Profile
struct Profile {
    let accountId: Int
    let personaname: String
    let avatar, avatarmedium, avatarfull: String
    let profileurl: String
    let lastLogin: String?
}

extension Profile: Decodable {
    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case personaname
        case avatar, avatarmedium, avatarfull
        case profileurl
        case lastLogin = "last_login"
    }
}

extension Profile {
    static let dummyData: Profile =
    Profile(
        accountId: 117124649,
        personaname: "e1",
        avatar: "https://www.dexerto.com/cdn-image/wp-content/uploads/2023/05/26/naruto-itachi-uchiha-mangekyou-sharingan.jpeg",
        avatarmedium: "https://www.dexerto.com/cdn-image/wp-content/uploads/2023/05/26/naruto-itachi-uchiha-mangekyou-sharingan.jpeg",
        avatarfull: "https://www.dexerto.com/cdn-image/wp-content/uploads/2023/05/26/naruto-itachi-uchiha-mangekyou-sharingan.jpeg",
        profileurl: "https://steamcommunity.com/profiles/76561198077390377/",
        lastLogin: "2026-02-17T16:04:02.355Z"
    )
}
