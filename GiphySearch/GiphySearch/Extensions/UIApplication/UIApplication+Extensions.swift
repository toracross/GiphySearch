import UIKit

extension UIApplication {
    
    /// Sorts through the available and active UIViewControllers in the active scene for the currently active UIViewController.
    /// - Returns: The currently displayed UIViewController
    class func topViewController() -> UIViewController? {
        guard let window = UIApplication.shared.connectedScenes
                            .filter({ $0.activationState == .foregroundActive })
                            .compactMap({ $0 as? UIWindowScene })
                            .first?.windows
                            .filter({ $0.isKeyWindow }).first,
              let rootViewController = window.rootViewController else { return nil }
        
        var topController = rootViewController
        
        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }
        
        return topController
    }
    
}
