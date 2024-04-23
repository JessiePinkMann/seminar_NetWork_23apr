import Foundation

struct Item: Identifiable, Hashable, Codable {
    let name: String
    let price: String
    let id: Int
    let currency: String
    let lastSold: String

    enum CodingKeys: String, CodingKey {
        case id, name, price, currency
        case lastSold = "last_sold"
    }
}

