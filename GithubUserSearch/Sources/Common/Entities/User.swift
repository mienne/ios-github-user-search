import Foundation

struct User {

    let name: String
    let url: String
    let imageUrl: String
}

// MARK: - Decodable
extension User: Decodable {

    private enum CodingKeys: String, CodingKey {
        case name = "login"
        case url = "url"
        case imageUrl =  "avatar_url"
    }
}

extension User: Hashable {

    static func == (_ lhs: User, _ rhs: User) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
