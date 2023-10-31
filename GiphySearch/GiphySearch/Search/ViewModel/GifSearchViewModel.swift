import Combine
import Foundation

public enum State {
    case empty
    case loading
    case ready
}

public protocol GifSearchViewModel {
    var gifs: [Gif] { get }
    var statePublisher: AnyPublisher<State, Never> { get }
    func search(terms: String) async
    func searchWithNextPage() async
}

public class DefaultGifSearchViewModel: GifSearchViewModel {
    
    private lazy var cancellables = Set<AnyCancellable>()
    private let service: GiphyService
    
    @Published private var state: State = .empty
    public var statePublisher: AnyPublisher<State, Never> {
        $state.eraseToAnyPublisher()
    }
    
    private var searchTerms: String = ""
    private var offset: Int = 1
    public var gifs: [Gif] = []
    
    public init(service: GiphyService) {
        self.service = service
    }
    
    /// Performs a basic search with provided search terms. Async operation.
    /// - Parameter terms: The terms to search for.
    public func search(terms: String) async {
        gifs.removeAll()
        
        searchTerms = terms
        state = .loading
        
        do {
            if let gifData: GifData = try await service.fetchData(from: .search(terms, 0)) {
                self.gifs = gifData.data
                self.offset = gifData.pagination.count ?? 0
                state = .ready
            }
        } catch {
            print(error.localizedDescription)
            state = .empty
        }
    }
    
    public func searchWithNextPage() async {
        guard state == .ready else { return }
        
        state = .loading
        
        do {
            if let gifData: GifData = try await service.fetchData(from: .search(searchTerms, self.offset)) {
                self.gifs.append(contentsOf: gifData.data)
                self.offset = gifData.pagination.offset ?? offset //TODO: offset needs to account for limit
                state = .ready
            }
        } catch {
            print(error.localizedDescription)
            state = .ready //TODO - error handling
        }
    }
}

// 0
//
