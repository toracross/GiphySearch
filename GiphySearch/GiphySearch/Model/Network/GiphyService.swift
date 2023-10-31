import Foundation

public class GiphyService {
    
    private var apiKey: String? {
        Bundle.main.infoDictionary?["GIPHY_API_KEY"] as? String
    }
    
    enum EndPoint {
        case search(String, Int)
        
        var scheme: String {
            "https"
        }
        
        var host: String {
            "api.giphy.com"
        }
        
        var path: String {
            "/v1/gifs/search"
        }
    }
    
    /// Performs a URL request to fetch more data.
    /// - Parameter endPoint: The EndPoint to perform the network request against.
    /// - Returns: The data type to fetch.
    func fetchData<T: Codable>(from endPoint: EndPoint) async throws -> T? {
        do {
            if let url = url(endPoint) {
                let (data, _) = try await URLSession.shared.data(from: url)
                let json = try JSONDecoder().decode(T.self, from: data)
                return json
            } else {
                Error.presentError(error: .network)
                return nil
            }
        } catch {
            print(error.localizedDescription)
            Error.presentError(error: .network)
            return nil
        }
    }
    
    /// Constructs the URL for the given Endpoint.
    /// - Parameter endPoint: The endpoint to perform a search against
    /// - Returns: The URL for the network request.
    private func url(_ endPoint: EndPoint) -> URL? {
        guard let apiKey = apiKey else { return nil }
        
        let components = NSURLComponents()
        components.scheme = endPoint.scheme
        components.host = endPoint.host
        components.path = endPoint.path
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "limit", value: "25"),
            URLQueryItem(name: "rating", value: "G")
        ]
        
        switch endPoint {
        case .search(let searchTerms, let offSet):
            components.queryItems?.append(URLQueryItem(name: "q", value: searchTerms))
            components.queryItems?.append(URLQueryItem(name: "offset", value: "\(offSet)"))
            
            return components.url
        }
    }
}
