import UIKit

typealias ErrorHandler = ((UIAlertAction) -> Void)?

class Error {

    enum ErrorMessage {
        case custom(title: String, body: String)
        case network

        var details: (title: String, body: String) {
            switch self {
            case .custom(let title, let body):
                return (title: title, body: body)
            case .network:
                return (title: "Network Error", body: "An error occured attempting to load data, please try again later.")
            }
        }
    }
    
    /// Presents a user facing error message in a simple UIAlertController
    /// - Parameters:
    ///   - error: The description of the error.
    ///   - handler: The action to take when the user presses "OK".
    class func presentError(error: ErrorMessage, handler: ErrorHandler = nil) {
        let alert = UIAlertController(title: error.details.title, message: error.details.body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))

        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
    }

}
