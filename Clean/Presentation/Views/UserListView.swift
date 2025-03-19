import SwiftUI

// View to display a list of users
struct UserListView: View {
    @StateObject private var viewModel: UserViewModel
    
    init(viewModel: UserViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Users")
                .task {
                    await viewModel.loadUsers()
                }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .initial, .loading:
            ProgressView()
        case .loaded(let users):
            userList(users)
        case .error(let message):
            errorView(message)
        }
    }
    
    private func userList(_ users: [UserUIModel]) -> some View {
        List(users) { user in
            NavigationLink(destination: UserDetailView(userId: user.id, viewModel: viewModel)) {
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func errorView(_ message: String) -> some View {
        VStack {
            Text("Error")
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            Button("Retry") {
                Task {
                    await viewModel.loadUsers()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

// Simple detail view placeholder
struct UserDetailView: View {
    let userId: String
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loaded(let users) where users.count == 1:
                let user = users[0]
                VStack(alignment: .leading, spacing: 16) {
                    Text(user.name)
                        .font(.title)
                    Text(user.email)
                        .font(.headline)
                }
                .padding()
                Spacer()
            default:
                ProgressView()
                    .task {
                        await viewModel.loadUser(id: userId)
                    }
            }
        }
        .navigationTitle("User Details")
    }
} 