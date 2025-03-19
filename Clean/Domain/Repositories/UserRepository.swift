import Foundation

// Repository Protocol - Defines the contract for data operations
// Domain layer defines the interface, Data layer implements it
protocol UserRepository {
    func getUser(byId id: String) async throws -> User
    func getAllUsers() async throws -> [User]
    func saveUser(_ user: User) async throws
    func deleteUser(byId id: String) async throws
} 