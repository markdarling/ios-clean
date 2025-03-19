import Foundation

// Data Sources - Define contracts for getting data from different sources
protocol UserDataSource {
    func getUser(byId id: String) async throws -> User
    func getAllUsers() async throws -> [User]
    func saveUser(_ user: User) async throws
    func deleteUser(byId id: String) async throws
}

// Remote data source (e.g. API)
protocol UserRemoteDataSource: UserDataSource {}

// Local data source (e.g. database, UserDefaults)
protocol UserLocalDataSource: UserDataSource {} 