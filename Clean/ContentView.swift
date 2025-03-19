//
//  ContentView.swift
//  Clean
//
//  Created by Mark Darling on 19/03/2025.
//

import SwiftUI

struct ContentView: View {
    // Create a ViewModel instance with dependencies
    // In a real app, this would be handled by a DI container/framework
    private let viewModel: UserViewModel = {
        // Create network service
        let baseURL = URL(string: "https://api.example.com")!
        let networkService = NetworkServiceImpl(baseURL: baseURL)
        
        // Create data sources
        let remoteDataSource = UserRemoteDataSourceImpl(networkService: networkService)
        let localDataSource = UserLocalDataSourceImpl()
        
        // Create repository
        let userRepository = UserRepositoryImpl(
            remoteDataSource: remoteDataSource,
            localDataSource: localDataSource
        )
        
        // Create use cases
        let getUserUseCase = GetUserUseCaseImpl(userRepository: userRepository)
        let getAllUsersUseCase = GetAllUsersUseCaseImpl(userRepository: userRepository)
        
        // Create view model
        return UserViewModel(
            getUserUseCase: getUserUseCase,
            getAllUsersUseCase: getAllUsersUseCase
        )
    }()
    
    var body: some View {
        // Display the user list view
        UserListView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
