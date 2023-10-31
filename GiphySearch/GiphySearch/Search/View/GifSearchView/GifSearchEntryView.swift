import Combine
import UIKit

public class GifSearchEntryView: UIView {
    
    private enum Constants {
        static let inset: CGFloat = 12.0
    }
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .systemGray5
        textField.keyboardType = .webSearch
        textField.borderStyle = .roundedRect
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.placeholder = "Enter Search Terms"
        return textField
    }()
    
    @Published private var searchTerms: String = ""
    public var searchTermsPublisher: AnyPublisher<String, Never> {
        $searchTerms.eraseToAnyPublisher()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.inset),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.inset)
        ])
    }
}

extension GifSearchEntryView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            searchTerms = text
        }
        
        textField.resignFirstResponder()
        return false
    }
}
