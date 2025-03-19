# Clean Architecture iOS Example

This project demonstrates how to structure an iOS app following Clean Architecture principles. The structure clearly separates concerns into three main layers:

## Project Structure

```
Clean/
├── Domain/              # Business logic and rules (innermost layer)
│   ├── Entities/        # Enterprise business rules
│   ├── UseCases/        # Application specific business rules
│   └── Repositories/    # Abstract interfaces used by use cases
│
├── Data/                # Data layer (implements Domain interfaces)
│   ├── Repositories/    # Implementation of Domain repository interfaces
│   ├── DataSources/     # Interfaces and implementations for data sources
│   └── Network/         # Network-related implementations
│
└── Presentation/        # UI layer (outermost layer)
    ├── Views/           # SwiftUI views
    ├── ViewModels/      # View state management
    └── Utils/           # UI utilities and helpers
```

## Clean Architecture Principles Applied

1. **Dependency Rule**: Dependencies always point inward. Outer layers can depend on inner layers, but never the reverse.

2. **Abstraction**: Domain layer defines abstractions (protocols) that Data layer implements.

3. **Separation of Concerns**: Each layer has a specific responsibility.

4. **Testability**: Business logic is isolated from external concerns, making it easy to test.

## Layer Communication

- **Domain Layer**: Contains business entities, use case interfaces, and repository interfaces. It has no dependencies on outer layers.

- **Data Layer**: Implements repository interfaces from the Domain layer. It's responsible for coordinating data from different sources.

- **Presentation Layer**: Contains UI components and ViewModels that communicate with Use Cases.

## Implementation Details

- **Dependency Injection**: Used throughout the app to follow SOLID principles.

- **Use Cases**: Single-responsibility classes that represent a specific action.

- **Repositories**: Abstract data operations away from the rest of the app.

- **ViewModels**: Manage UI state and translate Domain models to Presentation models.

## Benefits

- Highly maintainable
- Easily testable
- UI and framework-independent business logic
- Scalable architecture that can grow with your application 