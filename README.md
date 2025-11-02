# Calculator - Learning Project

**Entrepreneur Calculator**

> ⚠️ **Developer Experience Project**  
> This project was created during my early years as a developer while studying SOLID principles and Clean Architecture. It represents a learning milestone and documents my journey in understanding software architecture patterns. While functional, it may not reflect current best practices or production-ready code.

## About This Project

This calculator app was built as a hands-on exploration of Clean Architecture and SOLID principles in Flutter. It served as a practical playground for experimenting with architectural patterns and understanding how they apply to real-world applications.

### Key Features
* Basic arithmetic operations (+, -, *, /)
* Calculation history
* Product cost calculator
* Clear button to reset calculations
* User-friendly interface with a focus on readability

### Technical Implementation
* **State Management**: ValueNotifier for reactive state updates
* **Persistence**: Hive local storage for calculation history
* **Navigation**: GoRouter for declarative routing
* **Architecture Pattern**: MVVM (Model-View-ViewModel) approach
* **Error Handling**: Result pattern using `result_dart`

### Learning Objectives Explored
* **SOLID Principles**:
  * Single Responsibility: Attempted separation of concerns across layers
  * Open/Closed Principle: Designed for extensibility
  * Interface Segregation: Created focused interfaces
  * Dependency Inversion: Introduced repository abstractions
* **Clean Architecture**: Experimented with layered architecture (Domain, Application, Infrastructure, Presentation)
* **Flutter Best Practices**: Component composition, state management, and reactive programming

### Reflection & Growth Areas

As a learning project, there are architectural improvements that could be made:
* **Dependency Injection**: Currently uses singleton pattern; could benefit from proper DI container
* **Layer Separation**: Some business logic mixed with presentation layer
* **Testing**: Limited test coverage; would benefit from comprehensive unit and integration tests
* **Use Cases**: Business logic could be further extracted into dedicated use case classes
* **Immutability**: Entity classes could be made immutable for better predictability

This project represents an important step in my development journey and understanding of software architecture principles. It serves as a reference point for how my approach to software design has evolved over time.
