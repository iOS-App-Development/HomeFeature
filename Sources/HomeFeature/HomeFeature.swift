
import SharedModule
import APIClient
#if !os(macOS)
import UIKit
#endif


public class Settings
{
    public var name:String = "hello world"
    public init()
    {
    }
}
public class UserInfoProvider
{
    public var name:String = "hello world 1"
    public init()
    {
    }
}

public typealias HomeService = HomeServiceProtocol
public typealias AccountService =  AccountServiceProtocol

public class HomeFeature {
    let settings:Settings
    let homeService:HomeService
    let accountService:AccountService
    let userInfoProvider:UserInfoProvider

    public init(settings: Settings,
                homeServices: HomeService,
                accountServices: AccountService,
                userInfoProvider: UserInfoProvider) {
        self.settings = settings
        self.homeService = homeServices
        self.accountService = accountServices
        self.userInfoProvider = userInfoProvider
    }
    public func start(on navigationController: UINavigationController)
    {
        let viewController:SampleViewController = SampleViewController.init(homeService: self.homeService)
        navigationController.pushViewController(viewController, animated: true)
    }

//    public func startLogin(on viewController: UIViewController) -> FlowCoordinator
//    public func startResetPassword(on viewController: UIViewController, token: Token) -> FlowCoordinator
//    public func startAccountInfo(on navigationController: UINavigationController) -> FlowCoordinator
//    public func startAccountCredit(on navigationController: UINavigationController) -> FlowCoordinator
//    public func loginUsingSharedWebCredentials(handler: @escaping (LoginResult) -> Void)
}

/// A dependency collection that provides resolutions for object instances.
public class Dependencies {
    /// Stored object instance factories.
    private var modules = [String: Module]()
    
    /// Construct dependency resolutions.
    public init(@ModuleBuilder _ modules: () -> [Module]) {
        modules().forEach { add(module: $0) }
    }
    
    /// Construct dependency resolution.
    public init(@ModuleBuilder _ module: () -> Module) {
        add(module: module())
    }
    
    /// Assigns the current container to the composition root.
    public func build() {
        Self.root = self
    }
    
    fileprivate init() {}
    deinit { modules.removeAll() }
}

private extension Dependencies {
    /// Composition root container of dependencies.
    static var root = Dependencies()
    
    /// Registers a specific type and its instantiating factory.
    func add(module: Module) {
        modules[module.name] = module
    }

    /// Resolves through inference and returns an instance of the given type from the current default container.
    ///
    /// If the dependency is not found, an exception will occur.
    func resolve<T>(for name: String? = nil) -> T {
        let name = name ?? String(describing: T.self)
        
        guard let component: T = modules[name]?.resolve() as? T else {
            fatalError("Dependency '\(T.self)' not resolved!")
        }
        
        return component
    }
}

// MARK: Public API

public extension Dependencies {
    
    /// DSL for declaring modules within the container dependency initializer.
    @_functionBuilder struct ModuleBuilder {
        public static func buildBlock(_ modules: Module...) -> [Module] { modules }
        public static func buildBlock(_ module: Module) -> Module { module }
    }
}

/// A type that contributes to the object graph.
public struct Module {
    fileprivate let name: String
    fileprivate let resolve: () -> Any
    
    public init<T>(_ name: String? = nil, _ resolve: @escaping () -> T) {
        self.name = name ?? String(describing: T.self)
        self.resolve = resolve
    }
}

/// Resolves an instance from the dependency injection container.
@propertyWrapper
public class Inject<Value> {
    private let name: String?
    private var storage: Value?
    
    public var wrappedValue: Value {
        storage ?? {
            let value: Value = Dependencies.root.resolve(for: name)
            storage = value // Reuse instance for later
            return value
        }()
    }
    
    public init() {
        self.name = nil
    }
    
    public init(_ name: String) {
        self.name = name
    }
}
