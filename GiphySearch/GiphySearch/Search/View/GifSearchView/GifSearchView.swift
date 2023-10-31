import Combine
import UIKit

public class GifSearchView: UIView {
    
    private enum Constants {
        static let itemSpacing: CGFloat = 12.0
        static let entryViewHeight: CGFloat = 60.0
    }
    
    private lazy var gifSearchEntryView: GifSearchEntryView = {
        let view = GifSearchEntryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var gifSearchCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = Constants.itemSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GifCollectionViewCell.self, forCellWithReuseIdentifier: GifCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    private let viewModel: GifSearchViewModel
    private lazy var cancellables = Set<AnyCancellable>()

    public init(viewModel: GifSearchViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupView()
        setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(gifSearchEntryView)
        addSubview(gifSearchCollectionView)

        NSLayoutConstraint.activate([
            gifSearchEntryView.topAnchor.constraint(equalTo: topAnchor),
            gifSearchEntryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gifSearchEntryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gifSearchEntryView.heightAnchor.constraint(equalToConstant: Constants.entryViewHeight),
            
            gifSearchCollectionView.topAnchor.constraint(equalTo: gifSearchEntryView.bottomAnchor, constant: Constants.itemSpacing),
            gifSearchCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gifSearchCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gifSearchCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupSubscriptions() {
        viewModel.statePublisher
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .ready, .empty:
                    DispatchQueue.main.async {
                        self.gifSearchCollectionView.reloadData()
                    }
                case .loading:
                    print("loading gifs, present a nice loading view")
                }
            }.store(in: &cancellables)

        gifSearchEntryView.searchTermsPublisher
            .dropFirst()
            .sink { [weak self] terms in
                guard let self = self else { return }
                
                Task {
                    await self.viewModel.search(terms: terms)
                }
            }.store(in: &cancellables)
    }
}

extension GifSearchView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gif = viewModel.gifs[indexPath.item].images?.fixedWidth
        let height = gif?.height ?? 0
        let width = gif?.width ?? 0
        
        return CGSize(width: width, height: height)
    }
}

extension GifSearchView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(viewModel.gifs[indexPath.item])
    }
}

extension GifSearchView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.gifs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? GifCollectionViewCell else { return UICollectionViewCell() }
        
        cell.populate(with: viewModel.gifs[indexPath.item])
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.indexPathsForVisibleItems.last?.row == viewModel.gifs.count - 1 {
            Task {
                await viewModel.searchWithNextPage()
            }
        }
    }
}
