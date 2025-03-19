import Foundation

// Data Layer Implementation - Implements the Repository protocol defined in Domain
class UserRepositoryImpl: UserRepository {
    // Typically would have data sources injected
    private let remoteDataSource: UserRemoteDataSource
    private let localDataSource: UserLocalDataSource
    
    init(remoteDataSource: UserRemoteDataSource, localDataSource: UserLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getUser(byId id: String) async throws -> User {
        // Example implementation strategy - try local first, then remote
        do {
            return try await localDataSource.getUser(byId: id)
        } catch {
            let user = try await remoteDataSource.getUser(byId: id)
            try await localDataSource.saveUser(user)
            return user
        }
    }
    
    func getAllUsers() async throws -> [User] {
        // Implementation would coordinate between data sources
        return try await remoteDataSource.getAllUsers()
    }
    
    func saveUser(_ user: User) async throws {
        try await localDataSource.saveUser(user)
        try await remoteDataSource.saveUser(user)
    }
    
    func deleteUser(byId id: String) async throws {
        try await localDataSource.deleteUser(byId: id)
        try await remoteDataSource.deleteUser(byId: id)
    }
} 