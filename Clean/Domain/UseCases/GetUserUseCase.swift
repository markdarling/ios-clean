import Foundation

// Use Case - Contains business logic
// Demonstrates dependency inversion - depends on abstraction (UserRepository protocol)
protocol GetUserUseCase {
    func execute(userId: String) async throws -> User
}

class GetUserUseCaseImpl: GetUserUseCase {
    private let userRepository: UserRepository
    
    // Dependency injection - depends on abstraction, not concrete implementation
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(userId: String) async throws -> User {
        // Business logic can be added here
        return try await userRepository.getUser(byId: userId)
    }
} 