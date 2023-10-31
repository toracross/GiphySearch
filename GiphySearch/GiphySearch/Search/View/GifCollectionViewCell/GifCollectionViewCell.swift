import SDWebImage
import UIKit

public class GifCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: SDAnimatedImageView = {
        let imageView = SDAnimatedImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 2
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    public func populate(with gif: Gif) {
        guard let urlString = gif.images?.fixedWidth?.url,
              let url = URL(string: urlString) else { return }
        
        DispatchQueue.main.async {
            self.imageView.sd_setImage(with: url)
        }
    }
}
