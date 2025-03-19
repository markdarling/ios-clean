import Foundation

// Concrete implementation of local data source
class UserLocalDataSourceImpl: UserLocalDataSource {
    // In a real app, this would use Core Data, Realm, etc.
    private var users: [String: User] = [:]
    
    func getUser(byId id: String) async throws -> User {
        guard let user = users[id] else {
            throw DataError.userNotFound
        }
        return user
    }
    
    func getAllUsers() async throws -> [User] {
        return Array(users.values)
    }
    
    func saveUser(_ user: User) async throws {
        users[user.id] = user
    }
    
    func deleteUser(byId id: String) async throws {
        users.removeValue(forKey: id)
    }
}

// Data layer specific errors
enum DataError: Error {
    case userNotFound
    case networkError
    case serverError
} 