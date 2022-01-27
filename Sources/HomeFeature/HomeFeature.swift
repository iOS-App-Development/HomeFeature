
import SharedModule
import APIClient
#if !os(macOS)
import UIKit
#endif


public class Settings
{
    public var name:String = "hello world"
}
public class UserInfoProvider
{
    public var name:String = "hello world 1"
}


//public struct HomeFeature {
//
//
//    public init() {
//    }
//}
//public typealias PasswordManagementService = ForgottenPasswordServiceProtocol & ResetPasswordServiceProtocol
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
