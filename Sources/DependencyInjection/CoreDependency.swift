import Foundation

public class CoreDependency: Dependency {
    /// The current environement
    public private(set) var environement: Environement

    /// The cache of dependency needed for create a singleton
    public private(set) var dependencies: [String: Any] = [:]

    /// Initialize the `CoreDependency`
    /// - Parameter environement: The `Environement` variable by default is `.production`
    public init(environement: Environement = .production) {
        self.environement = environement
    }

    /// Change the environement mode
    /// This function will remove all singleton class you need to recreate this singleton
    public func set(environement: Environement) {
        self.environement = environement
        dependencies.removeAll()
    }

    /// Register class for using with resolve
    public func register<T>(_ type: T.Type, completion: (Dependency) -> T) -> T {
        let object = completion(self)
        dependencies[String(describing: type)] = object
        return object
    }

    /// Register class conform to protocol ```DependencyServiceType``` and use it with resolve
    @discardableResult
    public func register<T>(_ type: T.Type) -> T where T: DependencyServiceType {
        let object = T.makeService(for: self)
        dependencies[String(describing: type)] = object
        return object
    }

    /// Create a new class, this method not register class
    public func create<T>(completion: (Dependency) -> T) -> T {
        completion(self)
    }

    /// Create a new class conform to protocol ```DependencyServiceType```, this method not register class
    public func create<T>(_: T.Type) -> T where T: DependencyServiceType {
        return T.makeService(for: self)
    }

    /// Unregister class
    @discardableResult
    public func unregister<T>(_ type: T.Type) -> T? {
        dependencies.removeValue(forKey: String(describing: type)) as? T
    }

    /// Create a singleton
    @discardableResult
    public func singleton<T>(_ type: T.Type, completion: (Dependency) -> T) -> T {
        if let singleton = dependencies[String(describing: type)] as? T {
            return singleton
        }
        return register(T.self, completion: completion)
    }

    /// Create a singleton with class conform to protocol ```DependencyServiceType```,
    @discardableResult
    public func singleton<T: DependencyServiceType>(_ type: T.Type) -> T {
        if let singleton = dependencies[String(describing: type)] as? T {
            return singleton
        }
        return register(type)
    }

    /// Get a class who was registred or get a singleton
    public func resolve<T>(_ type: T.Type) -> T? {
        dependencies[String(describing: type)] as? T
    }

    /// Get a class who was registred trowly
    public func resolve<T>() throws -> T {
        let key = String(describing: T.self)

        guard let component: T = dependencies[key] as? T else {
            throw DependencyServiceError.unregistred("Dependency '\(T.self)' not resoved!")
        }

        return component
    }

    deinit {
        self.dependencies.removeAll()
    }
}

extension CoreDependency: CustomStringConvertible {
    public var description: String {
        var desc: [String] = []

        desc.append(environement.description)

        desc.append("Services:")
        if dependencies.isEmpty {
            desc.append("<none>")
        } else {
            for (id, _) in dependencies {
                desc.append("- \(id)")
            }
        }

        return desc.joined(separator: "\n")
    }
}
