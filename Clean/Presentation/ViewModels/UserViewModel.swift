import Foundation
import Combine

// UI representation of a User
struct UserUIModel: Identifiable {
    let id: String
    let name: String
    let email: String
    
    // Factory method to convert from domain entity
    static func from(domainUser: User) -> UserUIModel {
        return UserUIModel(
            id: domainUser.id,
            name: domainUser.name,
            email: domainUser.email
        )
    }
}

// State that will be observed by views
enum UserViewState {
    case initial
    case loading
    case loaded([UserUIModel])
    case error(String)
}

// ViewModel to connect UI with domain use cases
@MainActor
class UserViewModel: ObservableObject {
    // State that views will observe
    @Published private(set) var state: UserViewState = .initial
    
    // Dependencies from domain layer
    private let getUserUseCase: GetUserUseCase
    private let getAllUsersUseCase: GetAllUsersUseCase
    
    // Dependency injection
    init(getUserUseCase: GetUserUseCase, getAllUsersUseCase: GetAllUsersUseCase) {
        self.getUserUseCase = getUserUseCase
        self.getAllUsersUseCase = getAllUsersUseCase
    }
    
    // Public method called by views
    func loadUsers() async {
        self.state = .loading
        
        do {
            // Call domain use case
            let domainUsers = try await getAllUsersUseCase.execute()
            
            // Map domain models to presentation models
            let userUIModels = domainUsers.map { UserUIModel.from(domainUser: $0) }
            self.state = .loaded(userUIModels)
        } catch {
            self.state = .error("Failed to load users: \(error.localizedDescription)")
        }
    }
    
    // Load a specific user
    func loadUser(id: String) async {
        self.state = .loading
        
        do {
            let domainUser = try await getUserUseCase.execute(userId: id)
            let userUIModel = UserUIModel.from(domainUser: domainUser)
            self.state = .loaded([userUIModel])
        } catch {
            self.state = .error("Failed to load user: \(error.localizedDescription)")
        }
    }
}

// Protocol for getAllUsers use case
protocol GetAllUsersUseCase {
    func execute() async throws -> [User]
} 