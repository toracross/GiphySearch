import UIKit

public class GifSearchViewController: UIViewController {
    
    private lazy var gifSearchView: GifSearchView = {
        let gifSearchView = GifSearchView(viewModel: viewModel)
        gifSearchView.translatesAutoresizingMaskIntoConstraints = false
        return gifSearchView
    }()
    
    private let viewModel: GifSearchViewModel
    
    public init(viewModel: GifSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(gifSearchView)
        
        NSLayoutConstraint.activate([
            gifSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gifSearchView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gifSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gifSearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
