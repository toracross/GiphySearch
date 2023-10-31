import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initialize()
        return true
    }
    
    private func initialize() {
        let viewModel = DefaultGifSearchViewModel(service: GiphyService())
        let viewController = GifSearchViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.view.backgroundColor = .white
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }


}

