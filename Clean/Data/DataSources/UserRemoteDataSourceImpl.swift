import Foundation

// Concrete implementation of remote data source
class UserRemoteDataSourceImpl: UserRemoteDataSource {
    // In a real app, this would use URLSession, Alamofire, etc.
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getUser(byId id: String) async throws -> User {
        // Example of how this would work with a network service
        let endpoint = "/users/\(id)"
        return try await networkService.request(endpoint: endpoint)
    }
    
    func getAllUsers() async throws -> [User] {
        let endpoint = "/users"
        return try await networkService.request(endpoint: endpoint)
    }
    
    func saveUser(_ user: User) async throws {
        let endpoint = "/users"
        try await networkService.post(endpoint: endpoint, data: user)
    }
    
    func deleteUser(byId id: String) async throws {
        let endpoint = "/users/\(id)"
        try await networkService.delete(endpoint: endpoint)
    }
} 