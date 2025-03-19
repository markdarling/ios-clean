import Foundation

// Domain Entity - Independent of any framework
struct User: Codable {
    let id: String
    let name: String
    let email: String
} 