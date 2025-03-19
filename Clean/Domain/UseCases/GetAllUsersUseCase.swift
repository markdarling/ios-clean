import Foundation

// Use Case to get all users
class GetAllUsersUseCaseImpl: GetAllUsersUseCase {
    private let userRepository: UserRepository
    
    // Dependency injection
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute() async throws -> [User] {
        // Business logic can be added here
        return try await userRepository.getAllUsers()
    }
} 