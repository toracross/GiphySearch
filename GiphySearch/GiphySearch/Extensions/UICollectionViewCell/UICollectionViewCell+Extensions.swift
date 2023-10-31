import UIKit

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
    
}
