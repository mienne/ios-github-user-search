import Foundation

struct Users {

    var items: [User]
    var totalCount: Int?
    var incompleteResults: Bool
}

// MARK: - Decodable
extension Users: Decodable {

    private enum CodingKeys: String, CodingKey {
        case items =  "items"
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
    }
}
